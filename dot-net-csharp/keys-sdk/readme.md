- [Introduction](#introduction)
- [Install](#install)
- [Obtaining an Access Token](#obtaining-an-access-token)
- [Identity Check](#identity-check)
  - [Request Verification](#request-verification)
  - [Confirm and Get an Identity Token](#confirm-and-get-an-identity-token)
- [Cards and Public Keys](#cards-and-public-keys)
  - [Publish a Virgil Card](#publish-a-virgil-card)
  - [Search for Cards](#search-for-cards)
  - [Search for Application Cards](#search-for-application-cards)
  - [Trust a Virgil Card](#trust-a-virgil-card)
  - [Untrust a Virgil Card](#untrust-a-virgil-card)
  - [Revoke a Virgil Card](#revoke-a-virgil-card)
  - [Get a Public Key](#get-a-public-key)
- [Private Keys](#private-keys)
  - [Stash a Private Key](#stash-a-private-key)
  - [Get a Private Key](#get-a-private-key)
  - [Destroy a Private Key](#destroy-a-private-key)

##Introduction

This tutorial explains how to use the Public Keys Service with SDK library in .NET applications. 

##Install

Use NuGet Package Manager (Tools -> Library Package Manager -> Package Manager Console) to install Virgil.SDK package running the command:

```
PM> Install-Package Virgil.SDK
```

##Obtaining an Access Token

First you must create a free Virgil Security developer's account by signing up [here](https://developer.virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://developer.virgilsecurity.com/account/signin) and generate an access token for your application.

The access token provides an authenticated secure access to the Public Keys Service and is passed with each API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Simply add your access token to the client constructor.

```csharp
var serviceHub = ServiceHub.Create("%ACCESS_TOKEN%");
``` 

## Identity Check

All the Virgil Security services are strongly interconnected with the Identity Service. It determines the ownership of the Identity being checked using particular mechanisms and as a result it generates a temporary token to be used for the operations which require an Identity verification. 

#### Request Verification

Initialize the Identity verification process.

```csharp
var emailVerifier = await virgilHub.Identity.VerifyEmail("test1@virgilsecurity.com");
```

#### Confirm and Get an Validation Token

Confirm the Identity and get a temporary validation token.

```csharp
// parameter is used to restrict the number of token 
var countToLive = 1;

// parameter is used to limit the lifetime of the token in seconds.
var timeToLive = 3600; 

var confirmedIdentity = await emailVerifier.Confirm("%CONFIRMATION_CODE%", timeToLive, countToLive);
```

## Cards and Public Keys

A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.

The Virgil Card might be created with a confirmed or unconfirmed Identity. The difference is whether Virgil Services take part in [the Identity verification](#identity-check). With confirmed Cards you can be sure that the account with a particular email has been verified and the email owner is really the Identity owner. Be careful using unconfirmed Cards because they could have been created by any user.   

#### Publish a Virgil Card

An Identity token which can be received [here](#identity-check) is used during the confirmation.

```csharp
var keyPair = CryptoHelper.GenerateKeyPair();
var myCard = await virgilHub.Cards.Create(identityToken, keyPair.PublicKey(), keyPair.PrivateKey());
```

Creating a Card without an Identity verification. Pay attention that you will have to set an additional attribute to include the Cards with unconfirmed Identities into your search, see an [example](#search-for-cards).

```csharp
var myCard = await virgilHub.Cards.Create("test@virgilsecurity.com", IdentityType.Email, 
  keyPair.PublicKey(), keyPair.PrivateKey());
```

#### Search for Cards

Search for the Virgil Cards by provided parameters.

```csharp
var foundCards = await virgilHub.Cards.Search("test2@virgilsecurity.com", IdentityType.Email);
```

Search for the Virgil Cards including the cards with unconfirmed Identities.

```csharp
var foundCards = await virgilHub.Cards.Search("test2@virgilsecurity.com", includeUnconfirmed: true);
```

#### Search for Application Cards

Search for the Virgil Cards by a defined pattern. The example below returns a list of applications for Virgil Security company.

```csharp
var foundAppCards = await virgilHub.Cards.SearchAppAsync("com.virgilsecurity.*");
```

#### Trust a Virgil Card

Any Virgil Card user can act as a certification center within the Virgil Security ecosystem. Every user can certify another's Virgil Card and build a net of trust based on it.

The example below demonstrates how to certify a user's Virgil Card by signing its hash attribute. 

 
```csharp
var trustedCard = foundCards.First();
await virgilHub.Cards.Trust(trustedCard.Id, trustedCard.Hash, myCard.Id, keyPair.PrivateKey());
```

#### Untrust a Virgil Card

Naturally it is possible to stop trusting the Virgil Card owner as in all relations. This is not an exception in Virgil Security system.

```csharp
await virgilHub.Cards.Untrust(trustedCard.Id, myCard.Id, keyPair.PrivateKey());
```
#### Revoke a Virgil Card

This operation is used to delete the Virgil Card from the search and mark it as deleted. 

```csharp
await virgilHub.Cards.Revoke(myCard.Id, keyPair.PrivateKey());
```

#### Get a Public Key

Gets a public key from the Public Keys Service by the specified ID.

```csharp
await virgilHub.PublicKeys.Get(myCard.PublicKey.Id);
```

## Private Keys

The security of private keys is crucial for the public key cryptosystems. Anyone who can obtain a private key can use it to impersonate the rightful owner during all communications and transactions on intranets or on the internet. Therefore, private keys must be in the possession only of authorized users, and they must be protected from unauthorized use.

Virgil Security provides a set of tools and services for storing private keys in a safe storage which lets you synchronize your private keys between the devices and applications.

Usage of this service is optional.

#### Stash a Private Key

Private key can be added for storage only in case you have already registered a public key on the Public Keys Service.

Use the public key identifier on the Public Keys Service to save the private keys. 

The Private Keys Service stores private keys the original way as they were transferred. That's why we strongly recommend transferring the keys which were generated with a password.

```csharp
await virgilHub.PrivateKeys.Stash(myCard.Id, keyPair.PrivateKey());
```

#### Get a Private Key

To get a private key you need to pass a prior verification of the Virgil Card where your public key is used.
  
```csharp
var identityRequest = await virgilHub.Identity.Verify("test1@virgilsecurity.com", IdentityType.Email);
// use confirmation code that has been sent to you email box.
var identityToken = await virgilHub.Identity.Confirm(identityRequest.Id, "%CONFIRMATION_CODE%");

var privateKey = await virgilHub.PrivateKeys.Get(myCard.Id, identityToken);
```

#### Destroy a Private Key

This operation deletes the private key from the service without a possibility to be restored. 
  
```csharp
await virgilHub.PrivateKeys.Destroy(myCard.Id, keyPair.PrivateKey());
```
