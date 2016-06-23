========
Quickstart JavaScript
========

- `Introduction`_
- `Obtaining an Access Token`_
- `Install`_
- `Use Case`_
	- `Initialization`_
	- `Step 1. Create and Publish the Keys`_
	- `Step 2. Encrypt and Sign`_
	- `Step 3. Send an Email`_
	- `Step 4. Receive an Email`_
	- `Step 5. Get Sender's Card`_
	- `Step 6. Verify and Decrypt`_

Introduction
--------------------

This guide will help you get started using the Crypto Library and Virgil Keys Services.

Let's build an encrypted mail exchange system as one of the possible [use cases](#use-case) of Virgil Security Services.

.. image:: Images/IPMessaging.jpg

Obtaining an Access Token
--------------------

First you must create a free Virgil Security developer's account by signing up `here <https://developer.virgilsecurity.com/account/signup>`_. Once you have your account you can `sign in <https://developer.virgilsecurity.com/account/signin>`_ and generate an access token for your application.

The access token provides authenticated secure access to Virgil Keys Services and is passed with each API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Use this token to initialize the SDK client here `Initialization`_.

Install
------------------

NPM
^^^^^^^^^^

.. code-block:: sh

	npm install virgil-sdk

Bower
^^^^^^^^^^

.. code-block:: sh

	bower install virgil-sdk

CDN
^^^^^^^^^^

.. code-block:: html

	<script src="https://cdn.virgilsecurity.com/packages/javascript/sdk/latest/virgil-sdk.min.js"></script>


Use Case
--------------------
**Secure any data end to end**: users need to securely exchange information (text messages, files, audio, video etc) while enabling both in transit and at rest protection.

- Application generates public and private key pairs using Virgil Crypto library and use Virgil Keys service to enable secure end to end communications:
	- public key on Virgil Public Keys Service;
	- private key on Virgil Private Keys Service or locally.
- Sender's information is encrypted in Virgil Crypto Library with the recipient’s public key.
- Sender's encrypted information is signed with his private key in Virgil Crypto Library.
- Application securely transfers the encrypted data, sender's digital signature and UDID to the recipient without any risk to be revealed.
- Application on the recipient's side verifies that the signature of transferred data is valid using the signature and sender’s public key in Virgil Crypto Library.
- Received information is decrypted with the recepient's private key using Virgil Crypto Library.
- Decrypted data is provided to the recipient.

Initialization
--------------------

Node
^^^^^^^^^^

.. code-block:: javascript

	var Virgil = require('virgil-sdk');
	var virgil = new Virgil("%ACCESS_TOKEN%");

Browsers
^^^^^^^^^^

.. code-block:: javascript

	var Virgil = window.VirgilSDK;
	var virgil = new Virgil("%ACCESS_TOKEN%");


Step 1. Create and Publish the Keys
--------------------

First a mail exchange application is generating the keys and publishing them to the Public Keys Service where they are available in an open access for other users (e.g. recipient) to verify and encrypt the data for the key owner.

The following code example creates a new public/private key pair.

.. code-block:: javascript

	var password = "jUfreBR7";
	// the private key's password is optional 
	var keyPair = virgil.crypto.generateKeyPair(password); 


The app is verifying whether the user really owns the provided email address and getting a temporary token for public key registration on the Public Keys Service.

.. code-block:: javascript

	virgil.identity.verify({
		type: 'email',
		value: 'user@virgilsecurity.com'
	}).then(function confirmIdentity (verifyResult) {
		// use confirmation code that has been sent to you email box.
		return virgil.identity.confirm({
			action_id: verifyResult.action_id,
			confirmation_code: '%CONFIRMATION_CODE%'
		});
	});
	
The app is registering a Virgil Card which includes a public key and an email address identifier. The card will be used for the public key identification and searching for it in the Public Keys Service.

.. code-block:: javascript

	virgil.cards.create({
		public_key: keyPair.publicKey,
		private_key: keyPair.privateKey,
		identity: {
			type: 'email',
			value: 'user@virgilsecurity.com',
			validation_token: 'token from identity.confirm'
		}
	});


Step 2. Encrypt and Sign
--------------------

The app is searching for the recipient's public key on the Public Keys Service to encrypt a message for him. The app is signing the encrypted message with sender's private key so that the recipient can make sure the message had been sent from the declared sender.

.. code-block:: javascript

	var message = "Encrypt me, Please!!!";
	
	virgil.cards.search({ value: 'recipient-test@virgilsecurity.com', type: 'email' })
		.then(function (recipientCards) {
			var cards = recipientCards.map(function (card) {
				return {
					recipientId: card.identity.id,
					publicKey: card.public_key.public_key
				};
			});
	
			var encryptedMessage = virgil.cards.encrypt(message, cards);
			var sign = virgil.crypto.sign(encryptedMessage, keyPair.privateKey);
	
			// ...
		});

Step 3. Send an Email
--------------------

The app is merging the message and the signature into one structure and sending the letter to the recipient using a simple mail client.

.. code-block:: javascript

	var body = JSON.stringify({
		content: encryptedMessage.toString('base64'),
		sign: sign.toString('base64')
	});

	mailClient.send({
		to: "recipient-test@virgilsecurity.com",
		subject: "Secure the Future",
		body: body
	});

Step 4. Receive an Email
--------------------

An encrypted letter is received on the recipient's side using a simple mail client.

.. code-block:: javascript

	// get first email with specified subject using simple mail client
	var email = mailClient.getByEmailAndSubject('recipient-test@virgilsecurity.com', 'Secure the Future');
	var body = JSON.parse(email.body);


Step 5. Get Sender's Card
--------------------

In order to decrypt the received data the app on recipient's side needs to get sender's Virgil Card from the Public Keys Service.

Step 6. Verify and Decrypt
--------------------

The app is making sure the letter came from the declared sender by getting his card on Public Keys Service. In case of success the app is decrypting the letter using the recipient's private key.

.. code-block:: javascript

	virgil.cards.search({
		value: email.from,
		type: 'email'
	}).then(function (cards) {
		var senderPublicKey = cards[0].public_key.public_key;
		var contentBuffer = new Buffer(encryptedBody.content, 'base64');
		var signBuffer = new Buffer(encryptedBody.sign, 'base64');
	
		var isValid = virgil.crypto.verify(contentBuffer, senderPublicKey, signBuffer);
		if (!isValid) {
			throw new Error('Signature is not valid');
		}
	
		var originalMessage = virgil.crypto.decrypt(contentBuffer, recipientKeyPair.privateKey);
	});

