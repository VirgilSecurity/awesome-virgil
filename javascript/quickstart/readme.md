
# Virgil Security JavaScript SDK - Quick Start

- [Introduction](#introduction)
- [Prerequisite](#prerequisite)
- [Installation](#installation)
  - [Installation using bower](#installation-using-bower)
  - [Installation using npm](#installation-using-npm)
  - [Direct download](#direct-download)
- [Virgil namespace](#virgil-namespace)
  - [Global Virgil](#global-virgil)
  - [AMD module](#amd-module)
  - [CommonJS module](#commonjs-module)
  - [ES6 module](#es6-module)
- [Additional builds of Virgil JavaScript libraries](#additional-builds-of-virgil-javascript-libraries)
  - [Crypto library standalone](#crypto-library-standalone)
    - [Global](#global)
    - [AMD module](#amd-module-1)
    - [CommonJS module](#commonjs-module-1)
    - [ES6 module](#es6-module-1)
- [Private/Public keys services standalone](#privatepublic-keys-services-standalone)
- [Virgil Services](#virgil-services)
  - [Obtaining an Application Token](#obtaining-an-application-token)
  - [Generate Keys](#generate-keys)
  - [Register User](#register-user)
  - [Store a Private Key](#store-a-private-key)
  - [Get a Public Key](#get-a-public-key)
  - [Encrypt Data](#encrypt-data)
  - [Sign Data](#sign-data)
  - [Verify Data](#verify-data)
  - [Decrypt Data](#decrypt-data)

## Introduction

This guide will help you get started using the Crypto Library and Virgil Keys Services in the modern browsers.

This repository focuses on the JavaScript ([asm.js](http://asmjs.org/faq.html) subset of JavaScript) library implementation for a modern browsers and covers it's usage.

## Prerequisite

1. [nodejs](https://nodejs.org/) with [npm](https://www.npmjs.com/) or [bower](http://bower.io/)
2. Modern browser which supports the [asm.js](http://asmjs.org/faq.html) subset of JavaScript
  - [Google Chrome](http://www.google.by/chrome/) - tested in [Chrome 45.0](http://www.google.by/chrome/) 
  - [Mozilla Firefox](https://www.mozilla.org/en-US/firefox/new/) - tested in [Firefox 40.0.3](https://www.mozilla.org/en-US/firefox/new/) 
  - [Apple Safari](https://support.apple.com/downloads/safari) - tested in [Safari 7+](https://support.apple.com/downloads/safari)
  - [Microsoft Edge](https://www.microsoft.com/en-us/windows/microsoft-edge), for more information about [asm.js](http://asmjs.org/faq.html) support, please check the next link [https://blogs.windows.com/msedgedev/2015/05/07/bringing-asm-js-to-chakra-microsoft-edge/](https://blogs.windows.com/msedgedev/2015/05/07/bringing-asm-js-to-chakra-microsoft-edge/). Tested in Microsoft Internet Explorer 11 and latest version of [Microsoft Edge](https://www.microsoft.com/en-us/windows/microsoft-edge)  

## Installation

There are several ways to install and use the Crypto Library and Virgil’s SDK in your environment.

1. Installation using [bower](http://bower.io/)
2. Installation using [npm](https://www.npmjs.com/)
3. Direct download of the latest version as [zipped package](https://github.com/VirgilSecurity/virgil-browsers/archive/master.zip)

### Installation using bower

```sh
bower install virgil-browsers
```

### Installation using npm

```sh
npm install virgil-browsers
```

### Direct download

Latest version of library can be downloaded [here](https://github.com/VirgilSecurity/virgil-browsers/archive/master.zip)

## Virgil namespace

The Virgil SDK can be included into your project in several ways: 

###### Global Virgil
 
Add the ```script``` tag into your HTML file as below:

```html
<script charset="utf-8" src="<path_to_target_folder>/virgil-sdk-full.min.js"></script>
```

and the Virgil's SDK will be available in global scope by ```window.Virgil```:

```javascript 
var virgil = window.Virgil;

console.log(virgil);
```

###### AMD module 

```javascript 
define(['<path_to_target_folder>/virgil-browsers'], function(Virgil) {
  console.log(Virgil);
});
```

or

```javascript 
define(function() {
  var Virgil = require('<path_to_target_folder>/virgil-browsers');
  
  console.log(Virgil);
});
```

###### CommonJS module

```javascript 
var Virgil = require('<path_to_target_folder>/virgil-browsers');

console.log(Virgil);
```

###### ES6 module

```javascript 
import Virgil from '<path_to_target_folder>/virgil-browsers';

console.log(Virgil);
```

## Additional builds of Virgil JavaScript libraries

Additional builds you may find in the ```dist``` folder. After installation the ```virgil-javascript``` package using the any methods described above, you will be able to include needed library into your project. 

### Crypto library standalone

###### Global
 
Add the ```script``` tag into your HTML file as below:

```html
<script charset="utf-8" src="<path_to_target_folder>/virgil-crypto.min.js"></script>
```

and the Virgil's Crypto library will be available in global scope by ```window.VirgilCrypto```:

```javascript 
var VirgilCrypto = window.VirgilCrypto;

console.log(VirgilCrypto);
```

###### AMD module 

```javascript 
define(['<path_to_target_folder>/virgil-browsers/dist/virgil-crypto.min'], function(VirgilCrypto) {
  console.log(VirgilCrypto);
});
```

or

```javascript 
define(function() {
  var VirgilCrypto = require('<path_to_target_folder>/virgil-browsers/dist/virgil-crypto.min');
  
  console.log(VirgilCrypto);
});
```

###### CommonJS module

```javascript 
var VirgilCrypto = require('<path_to_target_folder>/virgil-browsers/dist/virgil-crypto.min');

console.log(VirgilCrypto);
```

###### ES6 module

```javascript 
import VirgilCrypto from '<path_to_target_folder>/virgil-browsers/dist/virgil-crypto.min';

console.log(VirgilCrypto);
```

## Private/Public keys services standalone

Use the same steps as described above in the section [Crypto library standalone](#crypto-library-standalone) but include the next files: ```virgil-sdk-keys-private.min.js``` and ```virgil-sdk-keys-public.min.js```

## Virgil Services

### Obtaining an Application Token

First you must create a free Virgil Security developer account by signing up [here](https://virgilsecurity.com/signup). Once you have your account you can [sign in](https://virgilsecurity.com/signin) and generate an app token for your application.

The app token provides authenticated secure access to Virgil’s Keys Service and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

Simply add your app token to the HTTP header for each request:

```
X-VIRGIL-APPLICATION-TOKEN: <YOUR_APPLICATION_TOKEN>
```

### Generate Keys

Working with Virgil Security Services it is requires the creation of both a public key and a private key. The public key can be made public to anyone using the Virgil Public Keys Service while the private key must be known only to the party or parties who will decrypt the data encrypted with the public key.

> Private keys should never be stored verbatim or in plain text on a local computer.

> If you need to store a private key, you should use a secure key container depending on your platform. You also can use Virgil Keys Service to store and synchronize private keys. This will allows you to easily synchronize private keys between clients’ devices and their applications. Please read more about [Virgil Private Keys Service](/documents/javascript/keys-private-service).

The following code example creates a new public/private key pair.

```javascript
var Virgil = window.Virgil;
var virgilCrypto = Virgil.Crypto;
var _ = Virgil.Utils;
var PRIVATE_KEY_PASSWORD = '<PRIVATE_KEY_PASSWORD_HERE>';
var keys = virgilCrypto.generateKeys(PRIVATE_KEY_PASSWORD);

console.log('Keys with password: ', keys);
```

### Register User

Once you've created a public key you may push it to Virgil’s Keys Service. This will allow other users to send you encrypted data using your public key.

This example shows how to upload a public key and register a new account on Virgil’s Keys Service.

```javascript
var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var USER_DATA_ITEMS = [
  {
    'class': Virgil.UserDataClassEnum.UserId,
    type: Virgil.UserDataTypeEnum.Email,
    value: 'example@domain.com'
  }
];

// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);
var virgilPublicKey = new Virgil.PublicKey(keys.publicKey, USER_DATA_ITEMS);
var virgilPrivateKey = new Virgil.PrivateKey(keys.privateKey);

publicKeysService.addKey(virgilPublicKey, virgilPrivateKey.KeyBase64, PRIVATE_KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);

    // update the Virgil public key using response from server
    virgilPublicKey = Virgil.PublicKey.fromJS(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

Confirm **User Data** using your user data type (Currently supported only Email)

```javascript
var virgilUserData = _.first(virgilPublicKey.UserDataItems);
var CONFIRMATION_CODE = '<YOUR_CONFIRMATION_CODE_HERE>';

publicKeysService.persistUserData(virgilUserData.Id, CONFIRMATION_CODE).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

### Store a Private Key

This example shows how to store private keys on Virgil Private Keys service using SDK, this step is optional and you can use your own secure storage.

```javascript
var CONTAINER_PASSWORD = '<CONTAINER_PASSWORD_HERE>';

// You can choose between two types of container. Easy and Normal.

// Easy   - Virgil’s Keys Service will keep your private keys encrypted with
//          a container password. All keys should be sent to the service
//          encrypted with this container password.
// Normal - Storage of the private keys is your responsibility and security
//          of those passwords and data will be at your own risk.

var CONTAINER_TYPE = Virgil.PrivateKeysContainerTypeEnum.Easy; // Virgil.PrivateKeysContainerTypeEnum.Normal

var container = new Virgil.PrivateKeysContainer(CONTAINER_TYPE, CONTAINER_PASSWORD);

// application token must be passed into the service's constructor
var privateKeysService = new Virgil.PrivateKeysService(APP_TOKEN);

// PRIVATE_KEY_PASSWORD an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
privateKeysService.addContainer(container, virgilPublicKey.Id, virgilPrivateKey.KeyBase64, PRIVATE_KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);

// Authenticate requests to Virgil’s Private Keys service
privateKeysService.setAuthCredentials(virgilUserData, CONTAINER_PASSWORD);

// Set the cipher strategy for the private keys service.
// This strategy function will be used for getting the encrypted or not encrypted version of key.
// In this function you are able to describe specific serializer algorithm for private key,
// which will be applied before pushing to server.
// Always will be called with the private key as the first argument
// and all other given arguments will be passed into `strategy` function as additional arguments
privateKeysService.setKeyCipherStrategy(function(pKey, contType, keysPassword, contPassword) {
  var base64PrivateKey = pKey.Key;
  // return the not encrypted version by default
  var resultKey = base64PrivateKey;
  // the shorthand for container types enum
  var contTypes = Virgil.PrivateKeysContainerTypeEnum;

  // if the container has the `Easy` type, then we have to use the container password here,
  // because the privateKeys will be encrypted using that password
  if (contTypes.Easy === contType) {
    resultKey = virgilCrypto.encrypt(base64PrivateKey, contPassword);
  }
  // for the `Normal` container type, the private keys will be encrypted using the special password,
  // which was provided by owner of the private key
  else if (contTypes.Normal === contType) {
    resultKey = virgilCrypto.encrypt(base64PrivateKey, keysPassword);
  }

  return resultKey;
}, container.Type, privateKeysService.authPassword, CONTAINER_PASSWORD);

// PRIVATE_KEY_PASSWORD an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
privateKeysService.addKey(virgilPublicKey.Id, virgilPrivateKey.KeyBase64, PRIVATE_KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

### Get a Public Key

Get public key from Public Keys Service.

```javascript
var recipientPublicKey;

publicKeysService.searchKey(virgilUserData.Value).then(
  function(resData) {
    console.log(resData);

    recipientPublicKey = new Virgil.PublicKey.fromJS(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

### Encrypt Data

The procedure for encrypting and decrypting documents is simple. For example:

If you want to encrypt the data to Bob, you encrypt it using Bobs's public key (which you can get from Public Keys Service), and Bob decrypts it with his private key. If Bob wants to encrypt data to you, he encrypts it using your public key, and you decrypt it with your private key.

In the example below, we encrypt data using a public key from Virgil’s Public Keys Service.

```javascript
var INITIAL_DATA = 'Some data to be encrypted';
var INITIAL_DATA_BASE64 = btoa(INITIAL_DATA);

var encryptedData = virgilCrypto.encrypt(INITIAL_DATA_BASE64, recipientPublicKey.Id, recipientPublicKey.Key);
```

### Sign Data

Cryptographic digital signatures use public key algorithms to provide data integrity. When you sign data with a digital signature, someone else can verify the signature, and can prove that the data originated from you and was not altered after you signed it.

The following example applies a digital signature to a public key identifier.

```javascript
var sign = virgilCrypto.sign(encryptedData, virgilPrivateKey.KeyBase64, PRIVATE_KEY_PASSWORD);

console.log('Sign: ' + sign);
```

### Verify Data

To verify that data was signed by a particular party, you must have the following information:

*   The public key of the party that signed the data.
*   The digital signature.
*   The data that was signed.

The following example verifies a digital signature which was signed by the sender.

```javascript
var isDataVerified = virgilCrypto.verify(encryptedData, recipientPublicKey.Key, sign);

console.log('Is data verified: ' + isDataVerified);
```

### Decrypt Data

```javascript
var decryptedData = virgilCrypto.decrypt(encryptedData, recipientPublicKey.Id, virgilPrivateKey.KeyBase64, PRIVATE_KEY_PASSWORD);

console.log('Decrypted data: ' + decryptedData);
```
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
