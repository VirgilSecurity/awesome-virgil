
# Virgil Security C++ SDK - Quick Start

- [Introduction](#introduction)
- [Build](#build)
- [Obtaining an Application Token](#obtaining-an-application-token)
- [Usage examples](#usage-examples)
    - [General statements](#general-statements)
    - [Example 1: Generate keys](#example-1)
    - [Example 2: Register user](#example-2)
    - [Example 3: Store private key](#example-3)
    - [Example 4: Get user's public key](#example-4)
    - [Example 5: Encrypt data](#example-5)
    - [Example 6: Sign data](#example-6)
    - [Example 7: Verify data](#example-7)
    - [Example 8: Decrypt data](#example-8)

## Introduction
This guide will help you get started using the Crypto Library and Virgil Keys Service, for the most popular platforms and languages.

This branch focuses on the C++ library implementation and covers it's usage.

## Build

### Build prerequisite:

1. [CMake](http://www.cmake.org/).
1. [Git](http://git-scm.com/).
1. [Python](http://python.org/).
1. [Python YAML](http://pyyaml.org/).
1. C/C++ compiler:
    * [gcc](https://gcc.gnu.org/)
    * [clang](http://clang.llvm.org/)
    * [MinGW](http://www.mingw.org/)
    * [Microsoft Visual Studio](http://www.visualstudio.com/), or other.
1. [libcurl](http://curl.haxx.se/libcurl/).

### Build steps:

1. `mkdir build`
1. `cd build`
1.   Virgil Public Keys SDK + Virgil Private Keys SDK + examples:\
`cmake -DVIRGIL_EXAMPLES=ON -DENABLE_TESTING=ON ..`\
Only Virgil Public Keys SDK:\
`cmake -VIRGIL_SDK_KEYS=ON -DENABLE_TESTING=ON ..`\
Only Virgil Private Keys SDK:\
`cmake -VIRGIL_SDK_PRIVATE_KEYS=ON -DENABLE_TESTING=ON ..`
1. `make`


## Obtaining an Application Token
First you must create a free Virgil Security developer account by signing up [here](https://virgilsecurity.com/signup). Once you have your account you can [sign in](https://virgilsecurity.com/signin) and generate an app token for your application.

The application token provides authenticated secure access to Virgil’s Keys Service and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

Simply add your application token to the HTTP header for each request:
```
X-VIRGIL-APPLICATION-TOKEN: { YOUR_APPLICATION_TOKEN }
```

## Usage examples

This section describes common case library usage scenarios, like

- generate new keys;
- register user's public key on the Virgil PKI service;
- encrypt data for user identified by email, phone, etc;
- decrypt data with private key;
- sign data with private key;
- verify data with signer identified by email, phone, etc.

Full source code examples are available on [GitHub](https://github.com/VirgilSecurity/virgil-cpp/tree/master/examples) in public access.

### <a name="example-1"></a> Example 1: Generate keys

Working with Virgil Security Services it is requires the creation of both a public key and a private key. The public key can be made public to anyone using the Virgil Public Keys Service while the private key must be known only to the party or parties who will decrypt the data encrypted with the public key.

> __Private keys should never be stored verbatim or in plain text on the local computer.__<br>
> \- If you need to store a private key, you should use a secure key container depending on your platform. You also can use Virgil Security Services. This will allows you to easily synchronize private keys between clients devices and applications. Please read more about [Virgil Private Keys Service](https://virgilsecurity.com/documents/cpp/keys-service).

The following code example creates a new public/private key pair.
``` {.cpp}
VirgilKeyPair newKeyPair; // Specify password in the constructor to store private key encrypted.
VirgilByteArray publicKey = newKeyPair.publicKey();
VirgilByteArray privateKey = newKeyPair.privateKey();
```
### <a name="example-2"></a> Example 2: Register user

Once you've created a public key you may push it to Virgil’s Keys Service. This will allow other users to send you encrypted data using your public key.

This example shows how to upload a public key and register a new account on Virgil’s Keys Service.

``` {.cpp}
UserData userData = UserData::email("mail@server.com");
Credentials credentials(privateKey);
std::string uuid = "{random generated UUID}";
KeysClient keysClient("{Application Token}");
PublicKey virgilPublicKey = keysClient.publicKey().add(publicKey, {userData}, credentials, uuid);
```

Then Confirm User Data using your user data type (Currently supported only Email).

``` {.cpp}
auto userDataId = virgilPublicKey.userData().front().userDataId();
auto confirmationCode = ""; // Confirmation code you received on your email box.
std::string uuid = "{random generated UUID}";
KeysClient keysClient("{Application Token}");
keysClient.userData().confirm(userDataId, confirmationCode, uuid);
```

### <a name="example-3"></a> Example 3: Store private key

This example shows how to store private keys on Virgil Private Keys service using SDK, this step is optional and you can use your own secure storage.

``` {.cpp}
// Create client
PrivateKeysClient privateKeysClient("{Application Token}");

// Prepare parameters
Credentials credentials(publicKey.publicKeyId(), privateKey);
auto containerType = ContainerType::Easy; // ContainerType::Normal
auto containerPassword = "12345678";

// Create container for private keys storage.
privateKeysClient.container().create(credentials, containerType, containerPassword, "{random generated UUID}");

// Authenticate user with email and password
UserData userData = UserData::email("{User's email}");
privateKeysClient.auth().authenticate(userData, containerPassword);

// Push private key to the container.
privateKeysClient.privateKey().add(credentials, "{random generated UUID}");
```

### <a name="example-4"></a> Example 4: Get user's public key

Get public key from Public Keys Service.

``` {.cpp}
std::string uuid = "{random generated UUID}";
KeysClient keysClient("{Application Token}");
PublicKey publicKey = keysClient.publicKey().grab("mail@server.com", uuid);
```

### <a name="example-5"></a> Example 5: Encrypt data

The procedure for encrypting and decrypting documents is straightforward with this mental model. For example: if you want to encrypt the data to Bob, you encrypt it using Bobs's public key which you can get from Public Keys Service, and he decrypts it with his private key. If Bob wants to encrypt data to you, he encrypts it using your public key, and you decrypt it with your private key.

In code example below data encrypted with public key previously loaded from Virgil's Public Keys Service.

``` {.cpp}
VirgilCipher cipher;
cipher.addKeyRecipient(virgil::crypto::str2bytes(publicKey.publicKeyId()), publicKey.key());
VirgilByteArray encryptedData = cipher.encrypt(virgil::crypto::str2bytes("Data to be encrypted."), true);
```

### <a name="example-6"></a> Example 6: Sign data

Cryptographic digital signatures use public key algorithms to provide data integrity. When you sign data with a digital signature, someone else can verify the signature, and can prove that the data originated from you and was not altered after you signed it.

The following example applies a digital signature to public key identifier.

``` {.cpp}
VirgilSigner signer;
VirgilByteArray data = virgil::crypto::str2bytes("some data");
VirgilByteArray sign = signer.sign(data, privateKey);
```

### <a name="example-7"></a> Example 7: Verify data

To verify that data was signed by a particular party, you must have the following information:

* The public key of the party that signed the data.
* The digital signature.
* The data that was signed.

The following example verifies a digital signature which was signed by sender.

``` {.cpp}
bool verified = signer.verify(data, sign, publicKey.key());
```

### <a name="example-8"></a> Example 8: Decrypt data

The following example illustrates the decryption of encrypted data by public key.

``` {.cpp}
VirgilByteArray decryptedData = cipher.decrypt(encryptedData, publicKey.publicKeyId(), privateKey);
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
