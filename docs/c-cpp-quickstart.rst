=======
Quickstart C/C++
=======

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
- `Build`_
- `Source code`_

*********
Introduction
*********

In this guide we will get you up and running quickly with a simple IP messaging chat application you can build as you learn more about Virgil Crypto Library and Virgil Keys Services. Sounds like a plan? Then let's get cracking! 

On the diagram below you can see a full picture of how these things interact with each other. 

.. image:: Images/IPMessaging.jpg

*********
Prerequisites
*********

1. To begin with, you'll need a Virgil Access Token, which you can obtain by passing a few steps described here `Obtaining an access token`_.
2. You will also need to install the dependencies Install_.

Obtaining an Access Token
=========

First you must create a free Virgil Security developer's account by signing up `here <https://developer.virgilsecurity.com/account/signup>`_. Once you have your account you can `sign in <https://developer.virgilsecurity.com/account/signin>`_ and generate an access token for your application.

The access token provides authenticated secure access to Virgil Keys Services and is passed with every API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.


Install
=========
Following dependencies are used for work with IPMessaging:

1. `virgil-sdk-cpp <https://github.com/VirgilSecurity/virgil-sdk-cpp>`_
2. `virgil-crypto <https://github.com/VirgilSecurity/virgil-crypto>`_
3. `nlohmann/json <https://github.com/nlohmann/json>`_
4. `restless <https://github.com/VirgilSecurity/restless>`_

They are automatically downloaded by `CMake <https://cmake.org/>`_, `External Project <https://cmake.org/cmake/help/v3.2/module/ExternalProject.html?highlight=externalproject_add#command:externalproject_add>`_ command.
Script can be viewed `here <https://github.com/VirgilSecurity/virgil-sdk-cpp/tree/master/examples/IPMessaging/ext/virgil_sdk>`_.
Move to this step to Build_ an application.

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

Initialize the service Hub instance using access token obtained here `Obtaining an access token`_

.. code-block:: cpp

    virgil::sdk::ServicesHub servicesHub_ = 
     virgil::sdk::ServicesHub(virgil::IPMessaging::VIRGIL_ACCESS_TOKEN);

Step 1. Generate and Publish the Keys
=========
First a simple IP messaging chat application is generating the keys and publishing them to the Public Keys Service where they are available in open access for other users (e.g. recipient) to verify and encrypt the data for the key owner.

The following code example generates a new public/private key pair.

.. code-block:: cpp

    vcrypto::VirgilKeyPair newKeyPair;

The app is registering a Virgil Card which includes a public key and an email address identifier. The Card will be used for the public key identification and searching for it in the Public Keys Service.

.. code-block:: cpp

    std::string actionId = servicesHub_.identity().verify(email, vsdk::dto::VerifiableIdentityType::Email);

    // Confirm an identity using code received to email box.servicesHub_.identity().confirm(actionId, confirmationCode);

    vsdk::models::CardModel card = servicesHub_.card().create(validatedIdentity, newKeyPair.publicKey(), credentials);

Step 2. Encrypt and Sign
=========
The app is searching for all channel members' public keys on the Keys Service to encrypt a message for them. The app is signing the encrypted message with sender’s private key so that the recipient can make sure the message had been sent by the declared sender.

.. code-block:: cpp

    MapCardIdPublicKey channelRecipients = this->getChannelRecipients();
    vcrypto::VirgilCipher cipher;
    for (const auto& channelRecipient : channelRecipients) {
        auto recipientCardId = channelRecipient.first;
        auto recipientPublicKey = channelRecipient.second;
        cipher.addKeyRecipient(recipientCardId, recipientPublicKey);
    }

    vcrypto::VirgilByteArray encryptedMessage = cipher.encrypt(vcrypto::str2bytes(message), true);
    vcrypto::VirgilByteArray signature = signer.sign(encryptedMessage, currentMember_.getPrivateKey());

Step 3. Send a Message
=========
The app merges the message text and the signature into one `structure <https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/master/examples/IPMessaging/include/virgil/IPMessaging/models/EncryptedMessageModel.h>`_ then serializes it to json string and sends the message to the channel using a simple IP messaging client.

.. note::

We will be using our custom IP Messaging Server in our examples, you may need to adjust the code for your favorite IP Messaging Server.

.. code-block:: cpp

    vipm::models::EncryptedMessageModel encryptedModel(encryptedMessage, signature);
    std::string encryptedModelJson = vipm::models::toJson(encryptedModel);

    channel_.sendMessage(encryptedModelJson);

Step 4. Receive a Message
=========
An encrypted message is received on the recipient’s side using an IP messaging client.
In order to decrypt and verify the received data, the app on recipient’s side needs to get sender’s Virgil Card from the Keys Service.

.. code-block:: cpp

    void vipm::SimpleChat::
    onMessageRecived(const std::string& sender, const std::string& message) {
        vipm::models::EncryptedMessageModel encryptedModel = vipm::models::
    fromJson(message);
        if (encryptedModel.isEmpty()) {
            return;
        }
    
        auto foundCards = servicesHub_.card().
    searchGlobal(sender, vsdk::dto::IdentityType::Email);
        if (foundCards.empty()) {
            return;
        }
    
        auto senderCard = foundCards.at(0);
        ...
    }

Step 5. Verify and Decrypt
=========
The application is making sure the message came from the declared sender by getting his card on Virgil Public Keys Service. In case of success, the message is decrypted using the recipient's private key.

.. code-block:: cpp

    vcrypto::VirgilSigner signer;
    bool isValid =
        signer.verify(encryptedModel.getMessage(), encryptedModel.getSignature(), senderCard.getPublicKey().getKey());
    if (!isValid) {
        std::cout << "The message signature is not valid." << std::endl;
        logFile_ += sender + " .The message signature is not valid.";
        std::cout << std::endl;
        return;
    }

    try {
        vcrypto::VirgilCipher cipher;
        vcrypto::VirgilByteArray decryptedMessage =
        	cipher.decryptWithKey(encryptedModel.getMessage(), currentMember_.getCardId(), currentMember_.getPrivateKey(), vcrypto::VirgilByteArray());

        std::cout << vcrypto::bytes2str(decryptedMessage) << std::endl;
        std::cout << std::endl;

    } catch (std::exception& exception) {
        std::cout << std::string("Can't decrypt message.") << std::endl;
        logFile_ += std::string("Can't decrypt message. Error: ") + exception.what() + "\n";
        std::cout << std::endl;
    }

*********
Build
*********

Run one of the following commands in the project's root folder.
  * Build SDK

    * Unix::

            mkdir build && cd build && cmake .. && make -j4

    * Windows::

            mkdir build && cd build && cmake .. && nmake


  * Build Examples

    * Unix::

            mkdir build && cd build && cmake -DENABLE_EXAMPLES=ON .. && make -j4

    * Windows::

            mkdir build && cd build && cmake -DENABLE_EXAMPLES=ON .. && nmake


*********
Source Code
*********

* `Use Case Example <https://github.com/VirgilSecurity/virgil-sdk-cpp/tree/master/examples/IPMessaging>`_
* `IP-Messaging Simple Server <https://github.com/VirgilSecurity/virgil-sdk-javascript/tree/master/examples/ip-messaging/server>`_
