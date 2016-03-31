# Tutorial JavaScript Virgil Services SDK 

- [Introduction](#introduction)
- [Install](#installation)
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
- [See Also](#see-also)

## Introduction

This tutorial explains how to use the Public Keys Service with SDK library in JavaScript applications. 

## Installation

### NPM

```sh
npm install virgil-sdk
```

### Bower
```sh
bower install virgil-sdk
```

### CDN
```html
<script src="https://cdn.virgilsecurity.com/packages/javascript/sdk/latest/virgil-sdk.min.js"></script>
```

## Obtaining an Access Token

First you must create a free Virgil Security developer's account by signing up [here](https://developer.virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://developer.virgilsecurity.com/account/signin) and generate an access token for your application.

The access token provides an authenticated secure access to the Public Keys Service and is passed with each API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Simply add your access token to the client constructor.

```javascript
var virgil = new Virgil("%ACCESS_TOKEN%");
``` 

## Identity Check

All the Virgil Security services are strongly interconnected with the Identity Service. It determines the ownership of the identity being checked using particular mechanisms and as a result it generates a temporary token to be used for the operations which require an identity verification. 

#### Request Verification

Initialize the identity verification process.

```javascript
virgil.identity.verify({
    type: 'email',
    value: 'test1@virgilsecurity.com'
});
```

#### Confirm and Get an Identity Token

Confirm the identity and get a temporary token.

```javascript
virgil.identity.confirm({
    action_id: 'action_id field from identity.verify response',
    confirmation_code: 'confirmation code sent to your email',
    token: {
        // How long this token will live
        time_to_live: 3600,

        // How many times it could be used
        count_to_live: 1
    }
});
```

## Cards and Public Keys

A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.

The Virgil Card might be created with a confirmed or unconfirmed Identity. The difference is whether Virgil Services take part in [the Identity verification](#identity-check). With confirmed Cards you can be sure that the account with a particular email has been verified and the email owner is really the Identity owner. Be careful using unconfirmed Cards because they could have been created by any user. 

#### Publish a Virgil Card

An identity token which can be received [here](#identity-check) is used during the registration.

```javascript
var keyPair = new virgil.crypto.generateKeyPair();
virgil.cards.create({
    public_key: keyPair.publicKey,
    private_key: keyPair.privateKey,
    private_key_password: '<your_private_key_password>',
    identity: {
        type: 'email',
        value: 'user@virgilsecurity.com',
        validation_token: 'token from identity.confirm'
    }
});
```

Creating a Card without an Identity verification. Pay attention that you will have to set an additional attribute to include the Cards with unconfirmed Identities into your search, see an [example](#search-for-cards).

```javascript
var keyPair = new virgil.crypto.generateKeyPair();
virgil.cards.create({
    public_key: keyPair.publicKey,
    private_key: keyPair.privateKey,
    private_key_password: '<your_private_key_password>',
    identity: {
        type: 'email',
        value: 'user@virgilsecurity.com'
    }
});
```

#### Search for Cards

Search for the Virgil Card by provided parameters.

```javascript
virgil.cards.search({
    value: "test2@virgilsecurity.com",
    type: 'email'
});
```

Search for the Virgil Card including cards with unconfirmed Identity.

```javascript
virgil.cards.search({
    value: "test2@virgilsecurity.com",
    type: 'email',
    include_unconfirmed: true
});
```

#### Search for Application Cards

Search for the Virgil Cards by a defined pattern. The example below returns a list of applications for Virgil Security company.

```javascript
virgil.cards.searchApp({ value: "com.virgil.*" }).then(...);
```

#### Trust a Virgil Card

Any Virgil Card user can act as a certification center within the Virgil Security ecosystem. Every user can certify another's Virgil Card and build a net of trust based on it.

The example below demonstrates how to certify a user's Virgil Card by signing its hash attribute. 

```javascript
virgil.cards.trust({
    signed_virgil_card_id: 'virgil_card_id you want to give trust to',
    signed_virgil_card_hash: 'hash of virgil card you want to trust',
    private_key: 'your private key',
    private_key_password: '<your_private_key_password>',
    virgil_card_id: 'your virgil_card_id'
});
```

#### Untrust a Virgil Card

Naturally it is possible to stop trusting the Virgil Card owner as in all relations. This is not an exception in Virgil Security system.

```javascript
virgil.cards.untrust({
    signed_virgil_card_id: 'virgil_card_id you want to give trust to',
    private_key: 'your private key',
    private_key_password: '<your_private_key_password>',
    virgil_card_id: 'your virgil_card_id'
});
```
#### Revoke a Virgil Card

This operation is used to delete the Virgil Card from the search and mark it as deleted. 

```javascript
virgil.cards.revoke({
    virgil_card_id: 'your virgil card id',
    private_key: 'your private key',
    private_key_password: '<your_private_key_password>',
    identity: {
        type: 'email',
        value: 'user@virgilsecurity.com',
        validation_token: 'token from identity.confirm'
    }
});
```

`identity` param is optional. It must be specified only for confirmed Virgil Card instances.

#### Get a Public Key

Gets a public key from the Public Keys Service by the specified ID.

```javascript
virgil.publicKeys.get({ public_key_id: 'some public key id' });
```

## Private Keys

The security of private keys is crucial for the public key cryptosystems. Anyone who can obtain a private key can use it to impersonate the rightful owner during all communications and transactions on intranets or on the internet. Therefore, private keys must be in the possession only of authorized users, and they must be protected from unauthorized use.

Virgil Security provides a set of tools and services for storing private keys in a safe storage which lets you synchronize your private keys between the devices and applications.

Usage of this service is optional.

#### Stash a Private Key

Private key can be added for storage only in case you have already registered a public key on the Public Keys Service.

Use the public key identifier on the Public Keys Service to save the private keys. 

The Private Keys Service stores private keys the original way as they were transferred. That's why we strongly recommend  transferring the keys which were generated with a password.

```javascript
virgil.privateKeys.stash({
    virgil_card_id: 'your virgil card id',
    private_key: 'your private key',
    private_key_password: '<your_private_key_password>'
}).then(...);
```

#### Get a Private Key

To get a private key you need to pass a prior verification of the Virgil Card where your public key is used.
  
```javascript
virgi.identity.verify({
    type: 'email',
    value: 'test1@virgilsecurity.com'
}).then(function confirmIdentity (verifyResult) {
    // use confirmation code that has been sent to you email box.
    return virgil.identity.confirm({
        action_id: verifyResult.action_id,
        confirmation_code: 'confirmation code from email',
        token: {
            time_to_live: 3600,
            count_to_live: 1
        }
    });
}).then(function getPrivateKey (confirmResult) {
    return virgil.privateKeys.get({
        virgil_card_id: 'your virgil card id',
        identity: {
            type: 'email',
            value: 'test1@virgilsecurity.com',
            validation_token: confirmResult.validation_token
        }
    });
});
```

#### Destroy a Private Key

This operation deletes the private key from the service without a possibility to be restored. 
  
```javascript
virgil.privateKeys.destroy({
    virgil_card_id: 'your virgil card id',
    private_key: 'your privateKey',
    private_key_password: '<your_private_key_password>'
});
```

## See Also

* [Quickstart](quickstart.md)
* [Tutorial Crypto Library](https://github.com/VirgilSecurity/virgil-crypto-javascript)
