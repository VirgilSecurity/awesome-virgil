
# Node.js Quick Start

- [Introduction](#introduction)
- [Obtaining an Application Token](#obtaining-an-application-token)
- [Installation](#installation)
- [Generate keys](#generate-keys)
- [Register User](#register-user)
- [Store Private Key](#store-private-key)
- [Get a Public Key](#get-a-public-key)
- [Encrypt Data](#encrypt-data)
- [Decrypt Data](#decrypt-data)
- [Sign Data](#sign-data)
- [Verify Data](#verify-data)

## Introduction

This guide will help you get started using the Crypto Library and Virgil Keys Service, for the most popular platforms and languages

## Obtaining an Application Token

First you must create a free Virgil Security developer account by signing up [here](https://virgilsecurity.com/signup). Once you have your account you can [sign in](https://virgilsecurity.com/signin) and generate an app token for your application.

The app token provides authenticated secure access to Virgil’s Keys Service and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

## Installation

**Virgil Security** supports most of popular package management systems. You can easily add the Crypto Library dependency to your project, just follow the examples below.

```
npm install virgil-crypto
```

Virgil Public Keys SDK:

```
npm install virgil-public-keys
```

Virgil Private Keys SDK:

```
npm install virgil-private-keys
```

## Generate Keys

Working with Virgil Security Services it is requires the creation of both a public key and a private key. The public key can be made public to anyone using the Virgil Public Keys Service while the private key must be known only to the party or parties who will decrypt the data encrypted with the public key.

> Private keys should never be stored verbatim or in plain text on a local computer.
> If you need to store a private key, you should use a secure key container depending on your platform. You also can use Virgil Private Keys Service to store and synchronize private keys. This will allows you to easily synchronize private keys between clients’ devices and their applications. Please read more about [Virgil Private Keys Service](https://github.com/VirgilSecurity/virgil/wiki/Virgil-Private-Keys-Service).

The following code example creates a new public/private key pair.

```javascript
var Virgil = require('virgil-crypto');
var keyPair = new Virgil.KeyPair();

var publicKey = keyPair.publicKey;
var privateKey = keyPair.privateKey;
```

## Register User

Once you've created a public key you may push it to Virgil’s Keys Service. This will allow other users to send you encrypted data using your public key.

This example shows how to upload a public key and register a new account on Virgil’s Keys Service.


```javascript
var VirgilPublicKeys = require('virgil-public-keys');

var applicationToken = '1b79865e30978ec2ec9a83a44916b0a5';
var userData = {
	'class': VirgilPublicKeys.USER_DATA_CLASSES.USER_ID,
	'type': VirgilPublicKeys.USER_DATA_TYPES.EMAIL,
	'value': 'your.email.@server.hz'
};

var publicKeysService = new VirgilPublicKeys(applicationToken);

publicKeysService.createPublicKey({
	public_key: publicKey,
	private_key: privateKey,
	user_data: userData
}).then(function confirmUserData (publicKeyData) {
	// Confirm **User Data** using your user data type (Currently supported only Email).
	// Wait for confirmation email and then confirm user data

	var confirmationCode = 'E4T0A2';

	publicKeysService.confirmUserData({
		user_data_id: publicKeyData.user_data.id,
		confirmation_code: confirmationCode
	}).then(function afterUserDataConfirmed () {
		// ...
	});
});
```

## Store Private Key

This example shows how to store private keys on Virgil Private Keys service using SDK, this step is optional and you can use your own secure storage.

```javascript
var VirgilPrivateKeys = require('virgil-private-keys');

var privateKeysService = new VirgilPrivateKeys(applicationToken);

// You can choose between few types of container. Easy and Normal
//   Easy   - service keeps your private keys encrypted with container password, all keys should be sent 
//            encrypted with container password, before sent to the service.
//   Normal - responsibility for the security of the private keys at your own risk. 

var containerType = VirgilPrivateKeys.CONTAINER_TYPES.EASY
var containerPassword = '123456789';
var userData = {
	'class': VirgilPublicKeys.USER_DATA_CLASSES.USER_ID,
	'type': VirgilPublicKeys.USER_DATA_TYPES.EMAIL,
	'value': 'your.email.@server.hz'
};

// Create container for private keys storage.
privateKeysService.createContainer({
	container_type: containerType,
	password: containerPassword,
	private_key: privateKey,
	public_key_id: publicKeyData.id.public_key_id
}).then(function getAuthToken () {
	return privateKeysService.getAuthToken({
		password: containerPassword,
		user_data: userData
	});
}).then(function createPrivateKey (authToken) {
	return privateKeysService.createPrivateKey({
		private_key: privateKey,
		private_key_encrypt_password: containerPassword, // Use same password as for container
		public_key_id: publicKeyId,
		auth_token: authToken
	});
});

```

## Get a Public Key

Get public key from Public Keys Service.

```javascript
publicKeysService.findPublicKey({
	value: 'some-email@example.com'
}).then(function (publicKeyData) {
	// ...
});
```

## Encrypt Data

The procedure for encrypting and decrypting documents is simple. For example:

If you want to encrypt the data to Bob, you encrypt it using Bobs's public key (which you can get from Public Keys Service), and Bob decrypts it with his private key. If Bob wants to encrypt data to you, he encrypts it using your public key, and you decrypt it with your private key.

In the example below, we encrypt data using a public key from Virgil’s Public Keys Service.

```javascript
publicKeysService.findPublicKey({
	value: 'bob@bob.com'
}).then(function (recipientPublicKeyData) {
	var cipher = new Virgil.Cipher();
	var data = 'data to be encrypted';

	cipher.addKeyRecipient(recipientPublicKeyData.public_key_id);
	var encryptedData = cipher.encrypt(data);
});
```

## Decrypt Data

The following example illustrates the decryption of encrypted data.

```javascript
var recipientContainerPassword = 'UhFC36DAtrpKjPCE';
var recipientUserData = {
	'class': VirgilPrivateKeys.USER_DATA_CLASSES.USER_ID,
	'type': VirgilPrivateKeys.USER_DATA_TYPES.EMAIL,
	'value': 'recepient.email@server.hz'
};

privateKeysService.getAuthToken({
	password: recipientContainerPassword,
	user_data: recipientUserData
}).then(function getPrivateKey (recipientAuthToken) {
	return privateKeysService.getPrivateKey({
		public_key_id: recipientPublicKeyData.public_key_id,
		auth_token: recipientAuthToken,
		private_key_decrypt_password: recipientContainerPassword
	});
}).then(function decryptRecipientData (recipientPrivateKeyData) {
	var decryptedData = cipher.decryptWithKey(
		encryptedData,
		recipientPublicKeyData.public_key_id,
		recipientPrivateKeyData.private_key
	);
});
```

## Sign Data

Cryptographic digital signatures use public key algorithms to provide data integrity. When you sign data with a digital signature, someone else can verify the signature, and can prove that the data originated from you and was not altered after you signed it.

The following example applies a digital signature to a public key identifier.

```javascript
var signer = new Virgil.Signer();
var sign = signer.sign(encryptedData, privateKey);
```

## Verify Data

To verify that data was signed by a particular party, you must have the following information:

*   The public key of the party that signed the data.
*   The digital signature.
*   The data that was signed.

The following example verifies a digital signature which was signed by the sender.

```javascript
var isValid = signer.verify(encryptedData, sign, publicKey);
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
