============
Quickstart Java/Android
============

- `Introduction`_
- `Prerequisites`_
    - `Obtaining an Access Token`_
    - `Install`_
- `Use case`_ 
    - `Step 0. Initialization`_
    - `Step 1. Generate and Publish the Keys`_
    - `Step 2. Encrypt and Sign`_
    - `Step 3. Send a Message`_
    - `Step 4. Receive a Message`_
    - `Step 5. Verify and Decrypt`_
- `Source code`_

*********
Introduction
*********

In this guide we will get you up and running quickly with a simple IP messaging chat application you can build as you learn more about Virgil Crypto Library and Virgil Keys Services. Sounds like a plan? Then let's get cracking! 

On the diagram below you can see a full picture of how these things interact with each other. 

.. image:: ../../../images/IPMessaging.png

*********
Prerequisites
*********

1. To begin with, you'll need a Virgil Access Token, which you can obtain by passing a few steps described here `Obtaining an Access Token`_.
2. You will also need to add java libraries Install_.

Obtaining an Access Token
=========

First you must create a free Virgil Security developer's account by signing up `here <https://developer.virgilsecurity.com/account/signup>`_. Once you have your account you can `sign in <https://developer.virgilsecurity.com/account/signin>`_ and generate an access token for your application.

The access token provides authenticated secure access to Virgil Keys Services and is passed with every API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Use this token to initialize the SDK client here `Step 0. Initialization`_.

Install
=========

You can easily add SDK dependency to your project, just follow the examples below:

Maven
------------

.. code-block:: html

    <dependencies>
      <dependency>
        <groupId>com.virgilsecurity.sdk</groupId>
        <artifactId>client</artifactId>
        <version>3.2.0</version>
      </dependency>
    </dependencies>


Gradle
-----------

.. code-block:: html

    compile 'com.virgilsecurity.sdk:android:3.2.0@aar'
    compile 'com.squareup.retrofit2:retrofit:2.0.0'
    compile 'com.squareup.retrofit2:converter-gson:2.0.0'

*********
Use Case
*********
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

Step 0. Initialization
=========

Initialize the service Hub instance using access token obtained here... `Obtaining an Access Token`_

.. code-block:: java

    ClientFactory factory = new ClientFactory(accesToken);

Step 1. Generate and Publish the Keys
=========
First a simple IP messaging chat application is generating the keys and publishing them to the Public Keys Service where they are available in open access for other users (e.g. recipient) to verify and encrypt the data for the key owner.

The following code example generates a new public/private key pair.

.. code-block:: java

    KeyPair keyPair = KeyPairGenerator.generate();

The app is registering a Virgil Card which includes a public key and an email address identifier. The Card will be used for the public key identification and searching for it in the Public Keys Service.   

.. code-block:: java

    String senderEmail = "sender-test@virgilsecurity.com";
    
    Identity identity = new ValidatedIdentity(IdentityType.EMAIL, senderEmail);
    
    VirgilCardTemplate.Builder vcBuilder = new VirgilCardTemplate.Builder()
        .setIdentity(identity)
        .setPublicKey(keyPair.getPublic());
    VirgilCard card = factory.getPublicKeyClient().createCard(vcBuilder.build(), keyPair.getPrivate());

Step 2. Encrypt and Sign
=========
The app is searching for all channel members' public keys on the Keys Service to encrypt a message for them. The app is signing the encrypted message with sender’s private key so that the recipient can make sure the message had been sent by the declared sender.

.. code-block:: java

    String message = "Encrypt me, Please!!!";
    
    Builder criteriaBuilder = new Builder()
    .setValue("recipient-test@virgilsecurity.com");
    List<VirgilCard> recipientCards = factory.getPublicKeyClient()
    .search(criteriaBuilder.build());
    
    Map<String, PublicKey> recipients = new HashMap<>();
    for (VirgilCard recipientCard : recipientCards) {
        recipients.put(recipientCard.getId(), 
        new PublicKey(recipientCard.getPublicKey().getKey()));
    }
    
    String encryptedMessage = CryptoHelper.encrypt(message, recipients);
    String signature = CryptoHelper
    .sign(encryptedMessage, keyPair.getPrivate());

Step 3. Send a Message
=========
The app merges the message text and the signature into one `structure <https://github.com/VirgilSecurity/virgil-sdk-net/blob/master/Examples/Virgil.Examples.IPMessaging/EncryptedMessageModel.cs>`_ then serializes it to json string and sends the message to the channel using a simple IP messaging client.

.. note::

    We will be using our custom IP Messaging Server in our examples, you may need to adjust the code for your favorite IP Messaging Server.

.. code-block:: java

    JsonObject encryptedBody = new JsonObject();
    encryptedBody.addProperty("Content", encryptedMessage);
    encryptedBody.addProperty("Signature", signature);

Step 4. Receive a Message
=========
An encrypted message is received on the recipient’s side using an IP messaging client. 
In order to decrypt and verify the received data, the app on recipient’s side needs to get sender’s Virgil Card from the Keys Service.

Step 5. Verify and Decrypt
=========
The application is making sure the message came from the declared sender by getting his card on Virgil Public Keys Service. In case of success, the message is decrypted using the recipient's private key.

.. code-block:: java

    PrivateKey recipientPrivateKey = new PrivateKey("{RECIPIENT_KEY}");
    
    String encryptedContent = encryptedBody.get("Content").getAsString();
    String encryptedContentSignature = encryptedBody.get("Signature")
    .getAsString();
    
    boolean isValid = CryptoHelper.verify(encryptedContent, 
        encryptedContentSignature,
        new PublicKey(card.getPublicKey().getKey()));
        
    if (!isValid) {
        throw new Exception("Signature is not valid.");
    }
    
    String originalMessage = CryptoHelper.decrypt(encryptedContent, 
    "{RECIPIENT_CARD_ID}", recipientPrivateKey);

*********
Source Code
*********

* `Use Case Example <https://github.com/VirgilSecurity/virgil-sdk-net/tree/master/Examples/Virgil.Examples.IPMessaging>`_
* `IP-Messaging Simple Server <https://github.com/VirgilSecurity/virgil-sdk-javascript/tree/master/examples/ip-messaging/server>`_
