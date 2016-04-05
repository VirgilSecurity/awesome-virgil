# Tutorial Java Keys SDK 

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
  - [Obtain key for the Private Keys Service](#obtain-a-service-key)
  - [Stash a Private Key](#stash-a-private-key)
  - [Get a Private Key](#get-a-private-key)
  - [Destroy a Private Key](#destroy-a-private-key)

##Introduction

This tutorial explains how to use the Public Keys Service with SDK library in Java applications. 

##Install

###Gradle

```
compile 'com.virgilsecurity.sdk:client:3.0.1'
```

###Maven

```xml
<dependencies>
  <dependency>
    <groupId>com.virgilsecurity.sdk</groupId>
    <artifactId>client</artifactId>
    <version>3.0.1</version>
  </dependency>
</dependencies>
```

##Obtaining an Access Token

First you must create a free Virgil Security developer's account by signing up [here](https://virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://virgilsecurity.com/account/signin) and generate an access token for your application.

The access token provides an authenticated secure access to the Public Keys Service and is passed with each API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Simply add your access token to the client factory.

```java
ClientFactory factory = new ClientFactory("{ACCESS_TOKEN}");
``` 

## Identity Check

All the Virgil Security services are strongly interconnected with the Identity Service. It determines the ownership of the Identity being checked using particular mechanisms and as a result it generates a temporary token to be used for the operations which require an Identity verification. 

#### Request Verification

Initialize the Identity verification process.

```java
String actionId = factory.getIdentityClient()
    .verify(IdentityType.EMAIL, "{YOU EMAIL}");
```

#### Confirm and Get an Identity Token

Confirm the Identity and get a temporary token.

```java
ValidatedIdentity identity = 
    factory.getIdentityClient().confirm(actionId, "{CONFIRMATION CODE}");
```

## Cards and Public Keys

A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.

The Virgil Card might be created with a confirmed or unconfirmed Identity. The difference is whether Virgil Services take part in [the Identity verification](#identity-check). With confirmed Cards you can be sure that the account with a particular email has been verified and the email owner is really the Identity owner. Be careful using unconfirmed Cards because they could have been created by any user.   

#### Publish a Virgil Card

An Identity token which can be received [here](#identity-check) is used during the confirmation.

```java
KeyPair keyPair = KeyPairGenerator.generate();
VirgilCard card = factory.getPublicKeyClient().createCard(identity,
    keyPair.getPublic(), keyPair.getPrivate());
```

Creating a Card without an Identity verification. Pay attention that you will have to set an additional attribute to include the Cards with unconfirmed Identities into your search, see an [example](#search-for-cards).

```java
ValidatedIdentity identity = new ValidatedIdentity(IdentityType.EMAIL, "{EMAIL}");

KeyPair keyPair = KeyPairGenerator.generate();
VirgilCard card = factory.getPublicKeyClient().createCard(identity,
    keyPair.getPublic(), keyPair.getPrivate());
```

#### Search for Cards

Search for the Virgil Cards by provided parameters.

```java
Builder criteriaBuilder = new Builder().setValue("EMAIL ADDRESS");
List<VirgilCard> cards = factory.getPublicKeyClient()
    .search(criteriaBuilder.build(), keyPair.getPrivate());
```

Search for the Virgil Cards including the cards with unconfirmed Identities.

```java
Builder criteriaBuilder = new Builder().setValue("EMAIL ADDRESS")
    .setIncludeUnconfirmed(true);
List<VirgilCard> cards = factory.getPublicKeyClient()
    .search(criteriaBuilder.build(), keyPair.getPrivate());
```

#### Search for Application Cards

Search for the Virgil Cards by a defined pattern. The example below returns a list of applications for Virgil Security company.

```java
SearchCriteria criteria = new SearchCriteria().setValue(appId);

List<VirgilCard> appCards = factory.getPublicKeyClient()
    .searchApp(criteriaBuilder.build(), keyPair.getPrivate());
```

#### Trust a Virgil Card

Any Virgil Card user can act as a certification center within the Virgil Security ecosystem. Every user can certify another's Virgil Card and build a net of trust based on it.

The example below demonstrates how to certify a user's Virgil Card by signing its hash attribute. 

```java
String signedCardId = "VIRGIL CARD ID";
String signedCardHash = "VIRGIL CARD HASH";

SignResponse signData = factory.getPublicKeyClient().signCard(signedCardId,
    signedCardHash, cardInfo.getId(), keyPair.getPrivate());
```

#### Untrust a Virgil Card

Naturally it is possible to stop trusting the Virgil Card owner as in all relations. This is not an exception in Virgil Security system.

```java
factory.getPublicKeyClient().unsignCard(signedCardId, cardInfo.getId(), keyPair.getPrivate());
```
#### Revoke a Virgil Card

This operation is used to delete the Virgil Card from the search and mark it as deleted. 

```java
factory.getPublicKeyClient().deleteCard(identity, cardInfo.getId(),
    keyPair.getPrivate());
```

#### Get a Public Key

Gets a public key from the Public Keys Service by the specified ID.

```java
PublicKeyInfo publicKey = factory.getPublicKeyClient()
    .getKey(cardInfo.getPublicKey().getId());
```

## Private Keys

The security of private keys is crucial for the public key cryptosystems. Anyone who can obtain a private key can use it to impersonate the rightful owner during all communications and transactions on intranets or on the internet. Therefore, private keys must be in the possession only of authorized users, and they must be protected from unauthorized use.

Virgil Security provides a set of tools and services for storing private keys in a safe storage which lets you synchronize your private keys between the devices and applications.

Usage of this service is optional.

####Obtain key for the Private Keys Service

```java
criteria = new SearchCriteria();
criteria.setValue("com.virgilsecurity.private-keys");

VirgilCard serviceCard = factory.getPublicKeyClient()
    .searchApp(criteria, keyPair.getPrivate()).get(0);
```

#### Stash a Private Key

Private key can be added for storage only in case you have already registered a public key on the Public Keys Service.

Use the public key identifier on the Public Keys Service to save the private keys. 

The Private Keys Service stores private keys the original way as they were transferred. That's why we strongly recommend transferring the keys which were generated with a password.

```java
factory.getPrivateKeyClient(serviceCard)
    .stash(cardInfo.getId(), keyPair.getPrivate());
```

#### Get a Private Key

To get a private key you need to pass a prior verification of the Virgil Card where your public key is used.
  
```java
actionId = factory.getIdentityClient().verify(IdentityType.EMAIL, email);
// use confirmation code that has been sent to you email box.
identity = factory.getIdentityClient().confirm(actionId, "{CONFIRMATION_CODE}");
		
PrivateKeyInfo privateKey = factory.getPrivateKeyClient(serviceCard)
    .get(cardInfo.getId(), identity);
```

#### Destroy a Private Key

This operation deletes the private key from the service without a possibility to be restored. 
  
```java
factory.getPrivateKeyClient(serviceCard)
    .destroy(cardInfo.getId(), keyPair.getPrivate());
```

## See Also

* [Quickstart](quickstart.md)
* [Android tutorial](keys-android.md)
