# Tutorial Java Keys SDK for Android 

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
compile 'com.virgilsecurity.sdk:android:3.0.1@aar'
compile 'com.squareup.retrofit2:retrofit:2.0.0'
compile 'com.squareup.retrofit2:converter-gson:2.0.0'
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
String email = "{EMAIL}";

try {
  factory.getIdentityClient().verify(IdentityType.EMAIL, email,
      new ResponseCallback<Action>() {

    @Override
    public void onSuccess(Action action) {
      // Obtain action identifier
      ...
    }
    
    @Override
    public void onFailure(APIError apiError) {
      // Process failure
      ...
    }
  });
} catch (IOException e) {
  // Handle exception
  ...
}
```

#### Confirm and Get an Identity Token

Confirm the Identity and get a temporary token.

```java
String actionId = "{ACTION_ID}";
String confirmationCode = {CONFIRMATION_CODE};

try {
  factory.getIdentityClient().confirm(actionId, confirmationCode,
      new ResponseCallback<ValidatedIdentity>() {

    @Override
    public void onSuccess(ValidatedIdentity validatedIdentity) {
      // Obtain validation token
      ...
    }
    
    @Override
    public void onFailure(APIError apiError) {
      // Process failure
      ...
    }
  });
} catch (IOException e) {
  // Handle exception
  ...
}
```

## Cards and Public Keys

A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.

The Virgil Card might be created with a confirmed or unconfirmed Identity. The difference is whether Virgil Services take part in [the Identity verification](#identity-check). With confirmed Cards you can be sure that the account with a particular email has been verified and the email owner is really the Identity owner. Be careful using unconfirmed Cards because they could have been created by any user.   

#### Publish a Virgil Card

An Identity token which can be received [here](#identity-check) is used during the confirmation.

```java
KeyPair keyPair = KeyPairGenerator.generate();
PublicKey publicKey = keyPair.getPublicKey();
PrivateKey privateKey = keyPair.getPrivateKey();

VirgilCardTemplate.Builder vcBuilder = new VirgilCardTemplate.Builder()
    .setIdentity(identity).setPublicKey(publicKey);

ResponseCallback<VirgilCard> callback = new ResponseCallback<VirgilCard>() {
  @Override
  public void onSuccess(VirgilCard virgilCard) {
    // Virgil Card created
    ...
  }
  
  @Override
  public void onFailure(APIError apiError) {
      // Process failure
      ...
  }
};

clientFactory.getPublicKeyClient()
    .createCard(vcBuilder.build(), privateKey, callback);
```

Creating a Card without an Identity verification. Pay attention that you will have to set an additional attribute to include the Cards with unconfirmed Identities into your search, see an [example](#search-for-cards).

```java
KeyPair keyPair = KeyPairGenerator.generate();
PublicKey publicKey = keyPair.getPublicKey();
PrivateKey privateKey = keyPair.getPrivateKey();

ValidatedIdentity identity = new ValidatedIdentity(IdentityType.EMAIL, "{EMAIL}");

VirgilCardTemplate.Builder vcBuilder = new VirgilCardTemplate.Builder()
    .setIdentity(identity).setPublicKey(publicKey);

ResponseCallback<VirgilCard> callback = new ResponseCallback<VirgilCard>() {
  @Override
  public void onSuccess(VirgilCard virgilCard) {
    // Virgil Card created
    ...
  }
  
  @Override
  public void onFailure(APIError apiError) {
      // Process failure
      ...
  }
};

clientFactory.getPublicKeyClient()
    .createCard(vcBuilder.build(), privateKey, callback);
```

#### Search for Cards

Search for the Virgil Cards by provided parameters.

```java
ResponseCallback<List<VirgilCard>> callback =
    new ResponseCallback<List<VirgilCard>>() {

  @Override
  public void onSuccess(List<VirgilCard> virgilCards) {
    // Process list of Virgil Cards
    ...
  }
  
  @Override
  public void onFailure(APIError apiError) {
    // Process failure
    ...
  }
};

Builder criteriaBuilder = new Builder().setValue("EMAIL ADDRESS");
clientFactory.getPublicKeyClient()
    .search(criteriaBuilder.build(), privateKey, callback);
```

Search for the Virgil Cards including the cards with unconfirmed Identities.

```java
ResponseCallback<List<VirgilCard>> callback =
    new ResponseCallback<List<VirgilCard>>() {

  @Override
  public void onSuccess(List<VirgilCard> virgilCards) {
    // Process list of Virgil Cards
    ...
  }
  
  @Override
  public void onFailure(APIError apiError) {
    // Process failure
    ...
  }
};

Builder criteriaBuilder = new Builder().setValue("EMAIL ADDRESS")
    .setIncludeUnconfirmed(true);
clientFactory.getPublicKeyClient()
    .search(criteriaBuilder.build(), privateKey, callback);
```

#### Search for Application Cards

Search for the Virgil Cards by a defined pattern. The example below returns a list of applications for Virgil Security company.

```java
ResponseCallback<List<VirgilCard>> callback = 
    new ResponseCallback<List<VirgilCard>>() {

  @Override
  public void onSuccess(List<VirgilCard> virgilCards) {
    // Process list of Virgil Cards
    ...
  }
  
  @Override
  public void onFailure(APIError apiError) {
    // Process failure
    ...
  }
};

SearchCriteria criteria = new SearchCriteria();
criteria.setValue("APPLICATION_ID");
clientFactory.getPublicKeyClient().searchApp(criteria, privateKey,callback);
```

#### Trust a Virgil Card

Any Virgil Card user can act as a certification center within the Virgil Security ecosystem. Every user can certify another's Virgil Card and build a net of trust based on it.

The example below demonstrates how to certify a user's Virgil Card by signing its hash attribute. 

```java
String signedCardId = "VIRGIL CARD ID";
String signedCardHash = "VIRGIL CARD HASH";

clientFactory.getPublicKeyClient().signCard(signedCardId, signedCardHash,
    signerCardId, privateKey, new ResponseCallback<SignResponse>() {

  @Override
  public void onSuccess(SignResponse signResponse) {
    // Virgil Card trusted
    ...
  }
  
  @Override
  public void onFailure(APIError apiError) {
    // Process failure
    ...
  }
});
```

#### Untrust a Virgil Card

Naturally it is possible to stop trusting the Virgil Card owner as in all relations. This is not an exception in Virgil Security system.

```java
clientFactory.getPublicKeyClient().unsignCard(signedCardId, signerCardId, 
    privateKey, new VoidResponseCallback() {

  @Override
  public void onSuccess(boolean b) {
    // Process unsign result
    ...
  }
  
  @Override
  public void onFailure(APIError apiError) {
    // Process failure
    ...
  }
});
```
#### Revoke a Virgil Card

This operation is used to delete the Virgil Card from the search and mark it as deleted. 

```java
ValidatedIdentity identity = new ValidatedIdentity();
identity.setType(IdentityType.EMAIL);
identity.setValue(email);

clientFactory.getPublicKeyClient().deleteCard(identity, cardId, privateKey, 
    password, new VoidResponseCallback() {

  @Override
  public void onSuccess(boolean b) {
    // Process result
    ...
  }
  
  @Override
  public void onFailure(APIError apiError) {
    // Process failure
    ...
  }
});
```

#### Get a Public Key

Gets a public key from the Public Keys Service by the specified ID.

```java
String publicKeyId = "{PUBLIC_KEY_ID}";
clientFactory.getPublicKeyClient().getKey(publicKeyId,
    new ResponseCallback<PublicKeyInfo>() {

  @Override
  public void onSuccess(PublicKeyInfo keyInfo) {
    // Process result
    ...
  }
  
  @Override
  public void onFailure(APIError apiError) {
    // Process failure
    ...
  }
});
```

## Private Keys

The security of private keys is crucial for the public key cryptosystems. Anyone who can obtain a private key can use it to impersonate the rightful owner during all communications and transactions on intranets or on the internet. Therefore, private keys must be in the possession only of authorized users, and they must be protected from unauthorized use.

Virgil Security provides a set of tools and services for storing private keys in a safe storage which lets you synchronize your private keys between the devices and applications.

Usage of this service is optional.

####Obtain key for the Private Keys Service

```java
ResponseCallback<List<VirgilCard>> callback = 
    new ResponseCallback<List<VirgilCard>>() {

  @Override
  public void onSuccess(List<VirgilCard> virgilCards) {
    VirgilCard serviceCard = virgilCards.get(0);
    // Store Service Card
    ...
  }
  
  @Override
  public void onFailure(APIError apiError) {
    // Process failure
    ...
  }
};

SearchCriteria criteria = new SearchCriteria();
criteria.setValue("com.virgilsecurity.private-keys");
clientFactory.getPublicKeyClient().searchApp(criteria, privateKey,callback);
```

#### Stash a Private Key

Private key can be added for storage only in case you have already registered a public key on the Public Keys Service.

Use the public key identifier on the Public Keys Service to save the private keys. 

The Private Keys Service stores private keys the original way as they were transferred. That's why we strongly recommend transferring the keys which were generated with a password.

```java
factory.getPrivateKeyClient(serviceCard).stash(cardInfo.getId(), 
    keyPair.getPrivate(), new VoidResponseCallback() {

  @Override
  public void onSuccess(boolean result) {
    // Process operation result
    ...
  }
  
  @Override
  public void onFailure(APIError error) {
    // Process failure
    ...
  }
});
```

#### Get a Private Key

To get a private key you need to pass a prior verification of the Virgil Card where your public key is used.
  
```java
// Obtain verified identity first
factory.getPrivateKeyClient(serviceCard).get(cardInfo.getId(), identity, 
    new ResponseCallback<PrivateKeyInfo>() {

  
  @Override
  public void onSuccess(PrivateKeyInfo keyInfo) {
    // Process private key
    ...
  }
  
  @Override
  public void onFailure(APIError error) {
    // Process failure
    ...
  }
});
```

#### Destroy a Private Key

This operation deletes the private key from the service without a possibility to be restored. 
  
```java
factory.getPrivateKeyClient(serviceCard).destroy(cardInfo.getId(), 
    keyPair.getPrivate(), new VoidResponseCallback() {

  
  @Override
  public void onSuccess(boolean result) {
    // Process operation result
    ...
  }
  
  @Override
  public void onFailure(APIError error) {
    // Process failure
    ...
  }
});
```
