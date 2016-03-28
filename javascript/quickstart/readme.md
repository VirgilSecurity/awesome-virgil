- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
	- [Obtaining an Access Token](#obtaining-an-access-token)
	- [Install](#install)
- [Use case](#use-case)
    - [Step 0. Initialization](#step-0-initialization)
    - [Step 1. Generate and Publish the Keys](#step-1-generate-and-publish-the-keys)
    - [Step 2. Encrypt and Sign](#step-2-encrypt-and-sign)
    - [Step 3. Send a Message](#step-3-send-a-message)
    - [Step 4. Receive a Message](#step-4-receive-a-message)
	- [Step 5. Verify and Decrypt](#step-5-verify-and-decrypt)
- [Source code](#source-code)
- [See also](#see-also)

## Introduction

In this guide we will get you up and running quickly with a simple IP messaging chat application you can build as you learn more about Virgil Crypto Library and Virgil Keys Services. Sounds like a plan? Then let's get cracking!

On the diagram below you can see a full picture of how these things interact with each other.
![Use case mail](https://raw.githubusercontent.com/VirgilSecurity/virgil/master/images/IPMessaging.jpg)

##Prerequisites

### Obtaining an Access Token

First you must create a free Virgil Security developer's account by signing up [here](https://developer.virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://developer.virgilsecurity.com/account/signin) and generate an access token for your application.

The access token provides authenticated secure access to Virgil Keys Services and is passed with each API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Use this token to initialize the SDK client [here](#step-0-initialization).

### Install

You can easily add SDK dependency to your project, just follow the examples below:

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

## Use Case
**Secure any data end to end**: users need to securely exchange information (text messages, files, audio, video etc) while enabling both in transit and at rest protection. 

- Application generates public and private key pairs using Virgil Crypto library and uses Virgil Keys service to enable secure end to end communications:
    - public key on Virgil Public Keys Service;
    - private key on Virgil Private Keys Service or locally.
- Sender’s information is encrypted in Virgil Crypto Library with the recipient’s public key.
- Sender’s encrypted information is signed with his private key in Virgil Crypto Library.
- Application securely transfers the encrypted data, sender’s digital signature and UDID to the recipient without any risk to be revealed.
- Application on the recipient’s side verifies that the signature of transferred data is valid using the signature and sender’s public key in Virgil Crypto Library.
- The received information is decrypted with the recipient’s private key using Virgil Crypto Library.
- Decrypted data is provided to the recipient.

## Step 0. Initialization

### Node

```javascript
var Virgil = require('virgil-sdk');
var virgil = new Virgil("%ACCESS_TOKEN%");
```

### Browsers

```javascript
var Virgil = window.VirgilSDK;
var virgil = new Virgil("%ACCESS_TOKEN%");
```

## Step 1. Generate and Publish the Keys
First a mail exchange application is generating the keys and publishing them to the Public Keys Service where they are available in an open access for other users (e.g. recipient) to verify and encrypt the data for the key owner.

The following code example creates a new public/private key pair.

```javascript
var password = "jUfreBR7";
// the private key's password is optional 
var keyPair = virgil.crypto.generateKeyPair(password); 
```

- [virgil.crypto.generateKeyPair] (https://github.com/VirgilSecurity/virgil-crypto-javascript/#generate-keys)

The app is verifying whether the user really owns the provided email address and getting a temporary token for public key registration on the Public Keys Service.

```javascript
virgil.identity.verify({
	type: 'email',
	value: 'user@virgilsecurity.com'
}).then(function confirmIdentity (verifyResult) {
	// use confirmation code that has been sent to you email box.
	return virgil.identity.confirm({
		action_id: verifyResult.action_id,
		confirmation_code: 'CONFIRMATION_CODE',
		token: {
			time_to_live: 60, // Seconds token will live
			count_to_live: 1  // How much times token could be used
		}
	});
});
```

- [virgil.identity.verify] (https://github.com/VirgilSecurity/virgil-sdk-javascript/blob/master/keys.md#request-verification)
- [virgil.identity.confirm] (https://github.com/VirgilSecurity/virgil-sdk-javascript/blob/master/keys.md#confirm-and-get-an-identity-token)

The app is registering a Virgil Card which includes a public key and an email address identifier. The card will be used for the public key identification and searching for it in the Public Keys Service.

```javascript
virgil.cards.create({
	public_key: keyPair.publicKey,
	private_key: keyPair.privateKey,
	private_key_password: 'YOUR_PRIVATE_KEY_PASSWORD',
	identity: {
		type: 'email',
		value: 'user@virgilsecurity.com',
		validation_token: 'TOKEN_FROM_IDENTITY.CONFIRM'
	}
}).then(function (recipientCard) {

});
```

- [virgil.cards.create] (https://github.com/VirgilSecurity/virgil-sdk-javascript/blob/master/keys.md#publish-a-virgil-card)

## Step 2. Encrypt and Sign

The app is searching for the recipient’s public key on the Public Keys Service to encrypt a message for him. The app is signing the encrypted message with sender’s private key so that the recipient can make sure the message had been sent from the declared sender.

```javascript
getChannelRecipients()
	.then(function encryptMessageForAllMembersAndSend (recipients) {
		const encryptedMessage = virgil.crypto.encrypt(message, recipients);
		const sign = virgil.crypto.sign(encryptedMessage, privateKey);
		//...
	})
		
```

- [virgil.crypto.encrypt] (https://github.com/VirgilSecurity/virgil-crypto-javascript/#encryptdecrypt-data)
- [virgil.crypto.sign] (https://github.com/VirgilSecurity/virgil-crypto-javascript#sign-and-verify-data-using-key)

## Step 3. Send a Message
The app is merging the message text and the signature into one structure and sending the message to the recipient using a simple IP messaging client.

```javascript
messagingService.sendMessageToChannel({
	channel_name: 'some channel name',
	identity_token: 'messaging service user identity token',
	message: JSON.stringify({
		message: encryptedMessage.toString('base64'),
		sign: sign.toString('base64')
	})
})
```

## Step 4. Receive a Message

An encrypted message is received on the recipient’s side using an IP messaging client. In order to decrypt and verify the received data, the app on recipient’s side needs to get sender’s Virgil Card from the Keys Service.

```javascript
messagingService.getChannelMessages({ channel_name: 'some channel name' })
	.map(function (messagePayload) {
		return virgil.cards.search({ value: messagePayload.sender_identifier, type: 'email' })
			.then(function (cards) {
				var senderCard = cards[0];
				// ...
			});
	})
```

- [virgil.cards.search] (https://github.com/VirgilSecurity/virgil-sdk-javascript/blob/master/keys.md#search-for-cards)

## Step 5. Verify and Decrypt

The application is making sure the message came from the declared sender by getting his card on Virgil Public Keys Service. In case of success, the message is decrypted using the recipient's private key.

```javascript
var payload = JSON.parse(message.message);
var encryptedMessage = new virgil.crypto.Buffer(payload.message, 'base64');
var sign = new virgil.crypto.Buffer(payload.sign, 'base64');

var isVerified = virgil.crypto.verify(encryptedMessage, senderCard.public_key.public_key, sign);

if (!isVerified) {
	throw new Error('The message signature is not valid');
}

var decryptedMessage = virgil.crypto.decrypt(encryptedMessage, recipientCard.id, privateKey);
// Decrypt returns decrypted content as buffer in order to get original text content
// toString method should be used
var originalMessage = decryptedMessage.toString('utf8');
```

- [virgil.crypto.verify](https://github.com/VirgilSecurity/virgil-crypto-javascript#sign-and-verify-data-using-key)
- [virgil.crypto.decrypt](https://github.com/VirgilSecurity/virgil-crypto-javascript#using-key-with-password-for-multiple-recipients)

## Source code

* [Use Case Example](https://github.com/VirgilSecurity/virgil-sdk-javascript/tree/master/examples/ip-messaging/client)
* [IP-Messaging Simple Server](https://github.com/VirgilSecurity/virgil-sdk-javascript/tree/master/examples/ip-messaging/server)


## See Also

* [Tutorial Crypto Library](/api-docs/javascript/crypto-library)
* [Tutorial Keys SDK](/api-docs/javascript/keys-sdk)