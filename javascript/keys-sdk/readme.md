- [Introduction](#introduction)
- [Install](#install)
- [Obtaining an Access Token](#obtaining-an-access-token)
- [Cards and Public Keys](#cards-and-public-keys)
  - [Publish a Virgil Card](#publish-a-virgil-card)
  - [Search for Cards](#search-for-cards)
  - [Revoke a Virgil Card](#revoke-a-virgil-card)
  - [Get a Public Key](#get-a-public-key)
- [Private Keys](#private-keys)
  - [Stash a Private Key](#stash-a-private-key)
  - [Get a Private Key](#get-a-private-key)
  - [Destroy a Private Key](#destroy-a-private-key)
- [Identities](#identities)
  - [Obtaining a global ValidationToken](#obtaining-a-global-validationtoken)
  - [Obtaining a private ValidationToken](#obtaining-a-private-validationtoken)

##Introduction

This tutorial explains how to use the Public Keys Service with SDK library in JavaScript applications. 

## Install

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
<script src="https://cdn.virgilsecurity.com/packages
/javascript/sdk/1.3.1/virgil-sdk.min.js"></script>
```

##Obtaining an Access Token

First you must create a Virgil Security developer's account by signing up [here](https://developer.virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://developer.virgilsecurity.com/account/signin) and generate an access token for your application.

The access token provides an authenticated secure access to the Public Keys Service and is passed with each API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Simply add your access token to the class builder.

```javascript
var virgil = new VirgilSDK("%ACCESS_TOKEN%");
``` 

## Cards and Public Keys

A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.

The Virgil Card might be *global* and *private*. The difference is whether Virgil Services take part in [the Identity verification](#identities). 

*Global Cards* are created with the validation token received after verification in Virgil Identity Service. Any developer with Virgil account can create a global Virgil Card and you can be sure that the account with a particular email has been verified and the email owner is really the Identity owner.

*Private Cards* are created when a developer is using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app's Private Key created on our [Developer portal](https://developer.virgilsecurity.com/dashboard/).   

#### Publish a Virgil Card

Creating a *private* Virgil Card with a newly generated key pair and **ValidationToken**. See how to obtain a **ValidationToken** [here...](#obtaining-a-private-validationtoken)


```javascript
var keyPair = virgil.crypto.generateKeyPair();

virgil.cards.create({
    public_key: keyPair.publicKey,
    private_key: keyPair.privateKey,
    identity: {
        type: 'username',
        value: 'demo_virgil',
        validation_token: '%VALIDATION_TOKEN%'
    }
});
```

Creating an unauthorized *private* Virgil Card without **ValidationToken**. Pay attention that you will have to set an additional attribute to include the private Cards without verification into your search, see an [example](#search-for-cards).

```javascript
var keyPair = virgil.crypto.generateKeyPair();
virgil.cards.create({
    public_key: keyPair.publicKey,
    private_key: keyPair.privateKey,
    identity: {
        type: 'username',
        value: 'demo_virgil'
    }
});
```

Creating a *global* Virgil Card. See how to obtain a **ValidationToken** [here...](#obtaining-a-global-validationtoken)

```javascript
var keyPair = virgil.crypto.generateKeyPair();

virgil.identity.verify({
    type: 'email',
    value: 'demo@virgilsecurity.com'
}).then(function (result) {
    return virgil.identity.confirm({
        action_id: result.action_id,
        confirmation_code: 'confirmation code sent to your email',
        token: {
            // How long this token will live
            time_to_live: 3600,

            // How many times it could be used
            count_to_live: 1
        }
    });
}).then(function (confirmResult) {
    return virgil.cards.create({
        public_key: keyPair.publicKey,
        private_key: keyPair.privateKey,
        identity: {
            type: 'email',
            value: 'demo@virgilsecurity.com',
            validation_token: confirmResult.validation_token
        }
    });
});
```

#### Search for Cards

Search for a *global* Virgil Card.

```javascript
// search for email card.

virgil.cards.searchGlobal({
    value: 'demo@virgilsecurity.com',
    type: VirgilSDK.IdentityTypes.email
});

// search for application card.

virgil.cards.searchGlobal({
    value: 'demo@virgilsecurity.com',
    type: VirgilSDK.IdentityTypes.application
});
```

Search for a *private* Virgil Card.

```javascript
virgil.cards.search({ value: 'demo@virgilsecurity.com' });

// or search for Virgil Cards including unauthorized ones.

virgil.cards.search({
    value: 'demo@virgilsecurity.com',
    include_unauthorized: true
});
```

#### Revoke a Virgil Card

This operation is used to delete the Virgil Card from the search and mark it as deleted. 

```javascript
virgil.cards.revoke({
    virgil_card_id: 'your virgil card id',
    private_key: 'your private key',
    identity: {
        type: 'email',
        value: 'demo@virgilsecurity.com',
        validation_token: 'token from identity.confirm'
    }
});
```

#### Get a Public Key

This operation gets a public key from the Public Keys Service by the specified ID.

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

The Private Keys Service stores private keys the original way as they were transferred. That's why we strongly recommend transferring the keys which were generated with a password.

```javascript
virgil.privateKeys.stash({
    virgil_card_id: 'your virgil card id',
    private_key: 'your private key'
});
```

#### Get a Private Key

This operation is used to get a private key you need to pass a prior verification of the Virgil Card where your public key is used. And to obtain a **ValidationToken** depending on your Virgil Card ([global](#obtaining-a-global-validationtoken) or [private](#obtaining-a-private-validationtoken)).
  
```javascript
virgi.identity.verify({
    type: 'email',
    value: 'demo@virgilsecurity.com'
}).then(function confirmIdentity (verifyResult) {
    // use confirmation code that has been sent to you email.
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
            value: 'demo@virgilsecurity.com',
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

## Identities

#### Obtaining a global ValidationToken

The *global* **ValidationToken** is used for creating *global Cards*. The *global* **ValidationToken** can be obtained only by checking the ownership of the Identity on Virgil Identity Service.

In the example below you can see how to obtain a **ValidationToken** for creating a *global* Virgil Card.

```javascript
virgil.identity.verify({
    type: 'email',
    value: 'demo@virgilsecurity.com'
}).then(function (verifyResult) {
    return virgil.identity.confirm({
        action_id: verifyResult.action_id,
        confirmation_code: 'confirmation code sent to your email',
        token: {
            // How long this token will live
            time_to_live: 3600,

            // How many times it could be used
            count_to_live: 1
        }
    });
});
```

#### Obtaining a private ValidationToken

The *private* **ValidationToken** is used for creating *Private Cards*. The *private* **ValidationToken** can be generated on developer's side using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app's Private Key created on our [Developer portal](https://developer.virgilsecurity.com/dashboard/).   

In the example below you can see, how to generate a **ValidationToken** using the SDK library.

```javascript
virgil.utils.generateValidationToken('demo_virgil', 
     'username', applicationPrivateKey);
```