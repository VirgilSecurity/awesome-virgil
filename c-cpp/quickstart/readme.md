
# Virgil Security C++ SDKs

- [Introduction](#introduction)
- [Obtain Application Token](#obtain-application-token)
- [Usage examples](#usage-examples)
  - [Generate keys](#generate-keys)
  - [Register user](#register-user)
  - [Get public key](#get-public-key)
  - [Store private key](#store-private-key)
  - [Get private key](#get-private-key)
  - [Encrypt data](#encrypt-data)
  - [Sign data](#sign-data)
  - [Verify data](#verify-data)
  - [Decrypt data](#decrypt-data)
- [Build](#build)
- [More examples](#more-examples)
- [See also](#see-also)

## Introduction

This is quickstart guide that helps to start using C++ implementation of:

  * [Virgil Crypto Library](https://github.com/VirgilSecurity/virgil-crypto.git)
  * [Virgil Public Keys Service](https://virgilsecurity.com/documents/cpp/keys-service) and it's [SDK](https://github.com/VirgilSecurity/virgil-sdk-cpp/tree/release/virgil.sdk.keys)
  * [Virgil Private Keys Service](https://virgilsecurity.com/documents/cpp/keys-private-service) and it's [SDK](https://github.com/VirgilSecurity/virgil-sdk-cpp/tree/release/virgil.sdk.private-keys).

## Obtain Application Token

First you must create a free Virgil Security developer account by [sign up](https://developer.virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://developer.virgilsecurity.com/account/signin) and generate an app token for your application.

The app token provides authenticated secure access to Virgil’s Keys Service and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

Simply add your app token to the HTTP header for each request:

```
X-VIRGIL-APPLICATION-TOKEN: <YOUR_APPLICATION_TOKEN>
```

## Usage examples

This section describes common case library usage scenarios.
Full source code examples are available on [GitHub](https://github.com/VirgilSecurity/virgil-sdk-cpp/tree/release/examples/src) in public access, also see section [More examples](#more-examples).

### Generate keys

To use Virgil Security Services it is required to create public key and a private key. The public key can be made public to anyone using the [Virgil Public Keys Service] while the private key must be known only to the party or parties who will decrypt the data encrypted with the public key.

> **Private keys should never be stored verbatim or in plain text on the local computer.**<br>
> \- If you need to store a private key, you should use a secure key container depending on your platform. You also can use Virgil Security Services. This will allows you to easily synchronize private keys between clients devices and applications. Please read more about [Virgil Private Keys Service](https://virgilsecurity.com/documents/cpp/keys-private-service).

The following code example creates a new public/private key pair.
``` {.cpp}
// Specify password in the constructor to store private key encrypted.
VirgilKeyPair newKeyPair;
VirgilByteArray publicKey = newKeyPair.publicKey();
VirgilByteArray privateKey = newKeyPair.privateKey();
```
### Register user

Once you've created a public key you may push it to Virgil’s Keys Service. This will allow other users to send you encrypted data using your public key.

This example shows how to upload a public key and register a new account on Virgil’s Keys Service.

``` {.cpp}
UserData userData = UserData::email("mail@server.com");
Credentials credentials(privateKey);
KeysClient keysClient("{Application Token}");
PublicKey virgilPublicKey = keysClient.publicKey().add(publicKey, {userData}, credentials);
```

Then Confirm User Data using your user data type (Currently supported only Email).

``` {.cpp}
auto userDataId = virgilPublicKey.userData().front().userDataId();
// Confirmation code you received on your email box.
auto confirmationCode = "";
KeysClient keysClient("{Application Token}");
keysClient.userData().confirm(userDataId, confirmationCode);
```

### Get public key

Get public key from Public Keys Service.

``` {.cpp}
KeysClient keysClient("{Application Token}");
PublicKey publicKey = keysClient.publicKey().grab("mail@server.com");
```


### Store private key

This example shows how to store private keys on Virgil Private Keys service using SDK, this step is optional and you can use your own secure storage.

``` {.cpp}
// Create client
PrivateKeysClient privateKeysClient("{Application Token}");

// Prepare parameters
CredentialsExt credentialsExt(publicKey.publicKeyId(), privateKey);
// ContainerType::Easy or ContainerType::Normal
auto containerType = ContainerType::Easy;
auto containerPassword = "123456789";

// Create container for private keys storage.
privateKeysClient.container().create(credentialsExt, containerType, containerPassword);

// Authenticate user with email and password
UserData userData = UserData::email("{User's email}");
privateKeysClient.auth().authenticate(userData, containerPassword);

// Push private key to the container.
privateKeysClient.privateKey().add(credentialsExt, containerPassword);
```

### Get private key

Get user's Private Key from the Virgil Private Keys service.

```cpp
PrivateKeysClient privateKeysClient("{Application Token}");
UserData userData = UserData::email("mail@server.com");
privateKeysClient.authenticate(userData, containerPassword);

// if the token has been received
// std::string authenticationToken = "";
// privateKeysClient.authenticate(authenticationToken);

PrivateKey privateKey = privateKeysClient.privateKey().get(publicKeyId, containerPassword);
```


### Encrypt data

The procedure for encrypting and decrypting documents is straightforward with this mental model. For example: if you want to encrypt the data to Bob, you encrypt it using Bobs's public key which you can get from Public Keys Service, and he decrypts it with his private key. If Bob wants to encrypt data to you, he encrypts it using your public key, and you decrypt it with your private key.

In code example below data encrypted with public key previously loaded from Virgil's Public Keys Service.

``` {.cpp}
VirgilCipher cipher;
cipher.addKeyRecipient(virgil::crypto::str2bytes(publicKey.publicKeyId()), publicKey.key());
VirgilByteArray encryptedData = cipher.encrypt(virgil::crypto::str2bytes("Data to be encrypted."), true);
```

### Sign data

Cryptographic digital signatures use public key algorithms to provide data integrity. When you sign data with a digital signature, someone else can verify the signature, and can prove that the data originated from you and was not altered after you signed it.

The following example applies a digital signature to public key identifier.

``` {.cpp}
VirgilSigner signer;
VirgilByteArray data = virgil::crypto::str2bytes("some data");
VirgilByteArray sign = signer.sign(data, privateKey);
```

### Verify data

To verify that data was signed by a particular party, you must have the following information:

* The public key of the party that signed the data.
* The digital signature.
* The data that was signed.

The following example verifies a digital signature which was signed by sender.

``` {.cpp}
bool verified = signer.verify(data, sign, publicKey.key());
```

### Decrypt data

The following example illustrates the decryption of encrypted data by public key.

``` {.cpp}
VirgilByteArray decryptedData = cipher.decrypt(encryptedData, publicKey.publicKeyId(), privateKey);
```
## Build

Run one of the following commands in the project's root folder.

  * Build Public Keys SDK

    * Unix:

            mkdir build && cd build && cmake -DVIRGIL_SDK_KEYS=ON .. && make -j4

    * Windows:

            mkdir build && cd build && cmake -DVIRGIL_SDK_KEYS=ON .. && nmake

  * Build Private Keys SDK

    * Unix:

            mkdir build && cd build && cmake -DVIRGIL_SDK_PRIVATE_KEYS=ON .. && make -j4

    * Windows:

            mkdir build && cd build && cmake -DVIRGIL_SDK_PRIVATE_KEYS=ON .. && nmake

  * Build Examples

    * Unix:

            mkdir build && cd build && cmake -DVIRGIL_EXAMPLES=ON .. && make -j4

    * Windows:

            mkdir build && cd build && cmake -DVIRGIL_EXAMPLES=ON .. && nmake


## More examples

* [Examples list](https://github.com/VirgilSecurity/virgil-sdk-cpp/tree/release/examples)

## See also

* [Virgil Security SDKs API](http://virgilsecurity.github.io/virgil-sdk-cpp)

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
