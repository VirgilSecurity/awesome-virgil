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
- [Build](#build)
- [Source code](#source-code)


## Introduction

In this guide we will get you up and running quickly with a simple IP messaging chat application you can build as you learn more about Virgil Crypto Library and Virgil Keys Services. Sounds like a plan? Then let's get cracking!

On the diagram below you can see a full picture of how these things interact with each other. ![Use case mail](https://raw.githubusercontent.com/VirgilSecurity/virgil/master/images/IPMessaging.jpg)

## Prerequisites

1. To begin with, you'll need a Virgil Access Token, which you can obtain by passing a few steps described [here](#obtaining-an-access-token).
2. You will also need to [install the dependencies](#install).

### Obtaining an Access Token

First you must create a free Virgil Security developer's account by signing up [here](https://developer.virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://developer.virgilsecurity.com/account/signin) and generate an access token for your application.

The access token provides authenticated secure access to Virgil Keys Services and is passed with every API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Use this token to initialize the SDK client [here](#step-0-initialization).

### Install
Following dependencies are used for work with IPMessaging:

1. [virgil-sdk-cpp](https://github.com/VirgilSecurity/virgil-sdk-cpp/tree/master)
1. [virgil-crypto](https://github.com/VirgilSecurity/virgil-crypto)
1. [nlohmann/json](https://github.com/nlohmann/json)
1. [restless](https://github.com/VirgilSecurity/restless)

They are automatically downloaded by [CMake](https://cmake.org/), [ExternalProject](https://cmake.org/cmake/help/v3.2/module/ExternalProject.html?highlight=externalproject_add#command:externalproject_add) command.
Scripts can be viewed [here](https://github.com/VirgilSecurity/virgil-sdk-cpp/tree/master/examples/IPMessaging/cmake).
Move to this step to [build](#build) an application.


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

### Step 0. Initialization

Initialize the service Hub instance using access token obtained [here...](#obtaining-an-access-token)

``` {.cpp}
ServicesHub servicesHub(%ACCESS_TOKEN%);
```

### Step 1. Generate and Publish the Keys
First a simple IP messaging chat application is generating the keys and publishing them to the Public Keys Service where they are available in open access for other users (e.g. recipient) to verify and encrypt the data for the key owner.

The following code example generates a new public/private key pair.

``` {.cpp}
VirgilKeyPair keyPair;
```

The app is registering a Virgil Card which includes a public key and an email address identifier. The Card will be used for the public key identification and searching for it in the Public Keys Service. You can create a Virgil Card with or without identity verification, see both examples [here...](/api-docs/c-cpp/keys-sdk#publish-a-virgil-card)

``` {.cpp}
std::string senderEmailAddress = "sender@virgilsecurity.com";
Identity identity(senderEmailAddress, IdentityModel::Type::Email);
Credentials credentials(keyPair.privateKey());
CardModel card;
card = servicesHub.card().create(identity, keyPair.publicKey(), credentials);
```

### Step 2. Encrypt and Sign
The app is searching for all channel members' public keys on the Keys Service to encrypt a message for them. The app is signing the encrypted message with sender’s private key so that the recipient can make sure the message had been sent by the declared sender.

``` {.cpp}
auto messageBytes = str2bytes("Encrypt me, Please!!!");

auto channelRecipients = this->getChannelRecipients();

vcrypto::VirgilCipher cipher;
for (const auto& channelRecipient : channelRecipients) {
    auto recipientCardId = channelRecipient.first;
    auto recipientPublicKey = channelRecipient.second;
    cipher.addKeyRecipient(recipientCardId, recipientPublicKey);
}

vcrypto::VirgilByteArray encryptedMessage = cipher.
                encrypt(messageBytes, true);

vcrypto::VirgilSigner signer;
vcrypto::VirgilByteArray signature = signer.
                sign(encryptedMessage, currentMember_.getPrivateKey());
```


### Step 3. Send a Message
The app merges the message text and the signature into one [structure](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/master/examples/IPMessaging/include/models/EncryptedMessageModel.h) then serializes it to json string and sends the message to the channel using a simple IP messaging client.

> We will be using our custom IP Messaging Server in our examples, you may need to adjust the code for your favorite IP Messaging Server.

``` {.cpp}
EncryptedMessageModel encryptedModel(encryptedMessage, signature);
std::string encryptedModelJson = vipm::models::toJson(encryptedModel);

channel_.sendMessage(encryptedModelJson);
```

### Step 4. Receive a Message
An encrypted message is received on the recipient’s side using an IP messaging client.
In order to decrypt and verify the received data, the app on recipient’s side needs to get sender’s Virgil Card from the Keys Service.

``` {.cpp}
void vipm::SimpleChat::onMessageRecived(const std::string& sender, 
         const std::string& message) {
                    vipm::models::EncryptedMessageModel 
                             encryptedModel = vipm::models::fromJson(message);

                    bool includeUnconfirmed = false;
                    vsdk::dto::Identity senderIdentity(sender, 
                             vsdk::models::IdentityModel::Type::Email);
                    auto foundCards = servicesHub_.card().search(senderIdentity, 
                             includeUnconfirmed);

                    auto senderCard = foundCards.at(0);
    ...
}
```


### Step 5. Verify and Decrypt
The application is making sure the message came from the declared sender by getting his card on Virgil Public Keys Service. In case of success, the message is decrypted using the recipient's private key.

``` {.cpp}
bool isValid =
    signer.verify(encryptedModel.getMessage(), encryptedModel.getSignature(),
    senderCard.getPublicKey().getKey());
if (!isValid) {
    std::cout << "The message signature is not valid." << std::endl;
    return;
}

vcrypto::VirgilCipher cipher;
vcrypto::VirgilByteArray decryptedMessage =
    cipher.decryptWithKey(encryptedModel.getMessage(), 
                          currentMember_.getCardId(),
                          currentMember_.getPrivateKey(), 
                          vcrypto::VirgilByteArray());
```


## Build

Run one of the following commands in the project's root folder.
  * Build SDK

    * Unix:

            mkdir build && cd build && cmake .. && make -j4

    * Windows:

            mkdir build && cd build && cmake .. && nmake


  * Build Examples

    * Unix:

            mkdir build && cd build && cmake -DENABLE_EXAMPLES=ON .. && make -j4

    * Windows:

            mkdir build && cd build && cmake -DENABLE_EXAMPLES=ON .. && nmake

## Source Code

* [Use Case Example](https://github.com/VirgilSecurity/virgil-sdk-cpp/tree/master/examples/IPMessaging)
* [IP-Messaging Simple Server](https://github.com/VirgilSecurity/virgil-sdk-javascript/tree/master/examples/ip-messaging/server)