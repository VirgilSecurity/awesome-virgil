
# Tutorial C#/.NET Keys SDK 

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
  - [Push a Private Key](#push-a-private-key)
  - [Get a Private Key](#get-a-private-key)
  - [Delete a Private Key](#delete-a-private-key)
- [See Also](#see-also)

##Introduction

This tutorial explains how to use the Public Keys Service with SDK library in .NET applications. 

##Install

Use NuGet Package Manager (Tools -> Library Package Manager -> Package Manager Console) to install Virgil.SDK.Keys package running the command:

```
PM> Install-Package Virgil.SDK.Keys
```

##Obtaining an Access Token

First you must create a free Virgil Security developer's account by signing up [here](https://virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://virgilsecurity.com/account/signin) and generate an access token for your application.

The access token provides an authenticated secure access to the Public Keys Service and is passed with each API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Simply add your access token to the client constuctor.

```csharp
var keysService = new KeysClient("{ YOUR_APPLICATION_TOKEN }");
``` 

## Identity Check

All the Virgil Security services are strongly interconnected with the Identity Service. It determines the ownership of the identity being checked using particular mechanisms and as a result it generates a temporary token to be used for the operations which require an identity verification. 

#### Request Verification

Initialize the identity verification process.

```csharp
var identityRequest = await Identity.VerifyAsync("test1@virgilsecurity.com", IdentityType.Email);
```

#### Confirm and Get an Identity Token

Confirm the identity and get a temporary token.

```csharp
var identityToken = await identityRequest.ConfirmAsync("%CONFIRMATION_CODE%");
```

## Cards and Public Keys

A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.

#### Publish a Virgil Card

An identity token which can be received [here](#identity-check) is used during the registration.

```csharp
var keyPair = CryptoHelper.GenerateKeyPair();
var myCard = await keysClient.Cards.CreateAsync(identityToken, keyPair.PublicKey(), keyPair.PrivateKey());
```

#### Search for Cards

Search for the Virgil Card by provided parameters.

```csharp
var foundCards = await keysClient.Cards.SearchAsync("test2@virgilsecurity.com", IdentityType.Email);
```

#### Search for Application Cards

Search for the Virgil Cards by a defined pattern. The example below returns a list of applications for Virgil Security company.

```csharp
var foundAppCards = await keysClient.Cards.SearchAppAsync("com.virgil.*");
```

#### Trust a Virgil Card

Any Virgil Card user can act as a certification center within the Virgil Security ecosystem. Every user can certify another's Virgil Card and build a net of trust based on it.

The example below demonstrates how to certify a user's Virgil Card by signing its hash attribute. 

<!--В рамках экосистемы Virgil Security любой пользователь карты может выступать в качестве центра сертификации. Каждый пользователь может заверить карту другого, и построить на основе этого сеть доверия. 
В приведенном примере ниже показанно как заверить карту пользователя, путем подписи ее hash атирибута.  -->
 
```csharp
var trustedCard = foundCards.First();
await keysClient.Cards.TrustAsync(trustedCard.Id, trustedCard.Hash, myCard.Id, keyPair.PrivateKey());
```

#### Untrust a Virgil Card

Naturally it is possible to stop trusting the Virgil Card owner as in all relations. This is not an exception in Virgil Security system.

```csharp
await keysClient.Cards.Untrust(trustedCard.Id, myCard.Id, keyPair.PrivateKey());
```
#### Revoke a Virgil Card

This operation is used to delete the Virgil Card from the search and mark it as deleted. 

```csharp
await keysClient.Cards.Revoke(myCard.Id, keyPair.PrivateKey());
```

#### Get a Public Key

Gets a public key from the Public Keys Service by the specified ID.

```csharp
await keysClient.PublicKey(myCard.PublicKey.Id);
```

## Private Keys

The security of private keys is crucial for the public key cryptosystems. Anyone who can obtain a private key can use it to impersonate the rightful owner during all communications and transactions on intranets or on the internet. Therefore, private keys must be in the possession only of authorized users, and they must be protected from unauthorized use.

Virgil Security provides a set of tools and services for storing private keys in a safe storage which lets you synchronize your private keys between the devices and applications.

Usage of this service is optional.

#### Push a Private Key

Private key can be added for storage only in case you have already registered a public key on the Public Keys Service.

Use the public key identifier on the Public Keys Service to save the private keys. 

The Private Keys Service stores private keys the original way as they were transferred. That's why we strongly recommend to trasfer the keys which were generated with a password.

```csharp
await keysClient.PrivateKeys.Push(myCard.PublicKey.Id, keyPair.PrivateKey());
```

#### Get a Private Key

To get a private key you need to pass a prior verification of the Virgil Card where your public key is used.
  
```csharp
var identityRequest = await Identity.VerifyAsync("test1@virgilsecurity.com", IdentityType.Email);
// use confirmation code that has been sent to you email box.
var identityToken = await identityRequest.ConfirmAsync("%CONFIRMATION_CODE%");
var privateKey = await keysClient.PrivateKeys.Get(identityToken, myCard.PublicKey.Id);
```

#### Delete a Private Key

This operation deletes the private key from the service without a possibility to be restored. 
  
```csharp
var privateKey = await keysClient.PrivateKeys.Delete(myCard.PublicKey.Id, keyPair.PrivateKey());
```

## See Also

* [Quickstart](https://virgilsecurity.com/developers/dot-net-csharp/quickstart)
* [Crypto Library](https://virgilsecurity.com/developers/dot-net-csharp/crypto-library)

</div>
</div>

<div class="col-md-12 col-md-offset-2 hidden-md hidden-xs hidden-sm">
<div class="docs-menu" data-ui="affix-docs">

<div class="menu-items-wrapper" data-ui="menu-items-wrapper"></div>
</div>
</div>
</div>
</div>
</section>
