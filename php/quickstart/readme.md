
## Quickstart

- [Introduction](#introduction)
- [Obtaining an Application Token](#obtaining-an-application-token)
- [Installation](#installation)
- [Package Management Systems](#package-management-systems)
- [Generate keys](#generate-keys)
- [Register User](#register-user)
- [Store Private Key](#store-private-key)
- [Get Public Key](#get-public-key)
- [Encrypt Data](#encrypt-data)
- [Decrypt Data](#decrypt-data)
- [Sign Data](#sign-data)
- [Verify Data](#verify-data)

## Introduction

This guide will help you get started using the Crypto Library and Virgil Keys Service, for the most popular platforms and languages.

## Obtaining an Application Token

First you must create a free Virgil Security developer account by signing up [here](https://virgilsecurity.com/signup). Once you have your account you can [sign in](https://virgilsecurity.com/signin) and generate an app token for your application.

The app token provides authenticated secure access to Virgil’s Keys Service and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

Simply add your app token to the HTTP header for each request:
```http
X-VIRGIL-APPLICATION-TOKEN: { YOUR_APPLICATION_TOKEN }
```

## Installation

There are several ways to install and use the Crypto Library and Virgil’s SDK in your environment.

1. Install with [Package Management System](#package-management-systems)
2. [Download](https://virgilsecurity.com/developers/php/downloads) from our web site

##Package Management Systems

Virgil Security supports most of popular package management systems. You can easily add the Crypto Library dependency to your project, just follow the examples below.

Download latest composer PHP package manager into your project:

```bash
curl -sS https://getcomposer.org/installer | php
```

Create empty composer.json file inside your project:

```bash
touch composer.json
```

Add Virgil dependencies into composer.json file:

```json
{
    "require": {
        "virgil/crypto": "dev-master",
        "virgil/keys-sdk": "dev-master"
     }
}
```

Update composer dependencies:

```bash
php composer.phar update
```

## Generate Keys

Working with Virgil Security Services it is requires the creation of both a public key and a private key. The public key can be made public to anyone using the Virgil Public Keys Service while the private key must be known only to the party or parties who will decrypt the data encrypted with the public key.
> Private keys should never be stored verbatim or in plain text on a local computer.
> If you need to store a private key, you should use a secure key container depending on your platform. You also can use Virgil Keys Service to store and synchronize private keys. This will allows you to easily synchronize private keys between clients’ devices and their applications. Please read more about [Virgil Private Keys Service](https://virgilsecurity.com/documents/php/keys-private-service).

The following code example creates a new public/private key pair.

```php
require_once './vendor/autoload.php';

use Virgil\Crypto\VirgilKeyPair;

$key = new VirgilKeyPair();

file_get_contents('new_public.key', $key->publicKey());
file_get_contents('new_private.key', $key->privateKey());
```

## Register User

Once you've created a public key you may push it to Virgil’s Keys Service. This will allow other users to send you encrypted data using your public key.

This example shows how to upload a public key and register a new account on Virgil’s Keys Service.

Full source code examples are available on GitHub in public access.

```php
require_once '../vendor/autoload.php';

use Virgil\SDK\Keys\Models\UserData,
    Virgil\SDK\Keys\Models\UserDataCollection,
    Virgil\SDK\Keys\Client as KeysClient;


    const VIRGIL_APPLICATION_TOKEN      = '17da4b6d03fad06954b5dccd82439b10';
    const VIRGIL_USER_DATA_CLASS        = 'user_id';
    const VIRGIL_USER_DATA_TYPE         = 'email';
    const VIRGIL_USER_DATA_VALUE        = 'example.email@gmail.com';

    try {

    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $userData = new UserData();
    $userData->class = VIRGIL_USER_DATA_CLASS;
    $userData->type  = VIRGIL_USER_DATA_TYPE;
    $userData->value = VIRGIL_USER_DATA_VALUE;

    $userDataCollection = new UserDataCollection();
    $userDataCollection->add(
        $userData
    );

    $publicKey = file_get_contents(
        'new_public.key'
    );

    $privateKey = file_get_contents(
        'new_private.key'
    );

    $publicKey = $keysClient->getPublicKeysClient()->createKey(
        $publicKey,
        $userDataCollection,
        $privateKey
    );

    } catch (Exception $e) {
        echo 'Error:' . $e->getMessage();
    }
```

Confirm User Data using your user data type (Currently supported only Email).

```php
require_once '../vendor/autoload.php';

use Virgil\SDK\Keys\Client as KeysClient;


const VIRGIL_APPLICATION_TOKEN = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_CONFIRMATION_CODE = 'J9Y0D5';


try {

    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $keysClient->getUserDataClient()->persistUserData(
        $publicKey->userData->get(0)->id->userDataId,
        VIRGIL_CONFIRMATION_CODE
    );

} catch (Exception $e) {
    echo 'Error:' . $e->getMessage();
}
```

## Store Private Key

This example shows how to store private keys on Virgil Private Keys service using SDK, this step is optional and you can use your own secure storage.

```php
require_once '../vendor/autoload.php';

use Virgil\SDK\PrivateKeys\Client as PrivateKeysClient;

const VIRGIL_APPLICATION_TOKEN    = '17da4b6d03fad06954b5dccd82439b10';

const VIRGIL_CONTAINER_TYPE       = 'normal';

const VIRGIL_USER_NAME            = 'example.email@gmail.com';
const VIRGIL_CONTAINER_PASSWORD   = 'password';


try {

    $privateKeysClient = new PrivateKeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $privateKeysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => $publicKey->publicKeyId
    ));

    $privateKey = file_get_contents(
        'new_private.key'
    );

    $privateKeysClient->getContainerClient()->createContainer(
        VIRGIL_CONTAINER_TYPE,
        VIRGIL_CONTAINER_PASSWORD,
        $privateKey
    );

    $privateKeysClient->setAuthCredentials(
        VIRGIL_USER_NAME,
        VIRGIL_CONTAINER_PASSWORD
    );

    $privateKeysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => $publicKey->publicKeyId
    ));

    $privateKeysClient->getPrivateKeysClient()->createPrivateKey(
        $publicKey->publicKeyId,
        $privateKey
    );

} catch (Exception $e) {
    echo 'Error:' . $e->getMessage();
}
```

## Get Public Key

Get public key from Public Keys Service.

```php
require_once '../vendor/autoload.php';

use Virgil\SDK\Keys\Client as KeysClient;

const VIRGIL_APPLICATION_TOKEN  = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_DATA_VALUE    = 'example.email@gmail.com';

try {

    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $recipientPublicKey = $keysClient->getPublicKeysClient()->grabKey(
        VIRGIL_USER_DATA_VALUE
    );

} catch (Exception $e) {
    echo 'Error:' . $e->getMessage();
}
```

## Encrypt Data

The procedure for encrypting and decrypting documents is simple. For example:

If you want to encrypt the data to Bob, you encrypt it using Bobs's public key (which you can get from Public Keys Service), and Bob decrypts it with his private key. If Bob wants to encrypt data to you, he encrypts it using your public key, and you decrypt it with your private key.

In the example below, we encrypt data using a public key from Virgil’s Public Keys Service.

```php
require_once './vendor/autoload.php';

use Virgil\Crypto\VirgilCipher;

$virgilCipher = new VirgilCipher()

$cipher = new VirgilCipher();
$cipher->addKeyRecipient(
    $recipientPublicKey->publicKeyId,
    $recipientPublicKey->publicKey
);

$encryptedData = $cipher->encrypt(
    "Some data to be encrypted",
    true
);
```

## Decrypt Data

The following example illustrates the decryption of encrypted data.

```php
require_once '../vendor/autoload.php';

use Virgil\SDK\PrivateKeys\Client as PrivateKeysClient,
    Virgil\Crypto\VirgilCipher;

const VIRGIL_APPLICATION_TOKEN  = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_NAME          = 'example.email@gmail.com';
const VIRGIL_CONTAINER_PASSWORD = 'password';

try {

    // Create Keys Service HTTP Client
    $privateKeysClient = new PrivateKeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $privateKeysClient->setAuthCredentials(
        VIRGIL_USER_NAME,
        VIRGIL_CONTAINER_PASSWORD
    );

    $privateKey = $privateKeysClient->getPrivateKeysClient()->getPrivateKey(
        $recipientPublicKey->publicKeyId
    );

    $cipher = new VirgilCipher();
    $decryptedMessage = $cipher->decryptWithKey(
        $encryptedData,
        $recipientPublicKey->publicKeyId,
        $privateKey
    );

} catch (Exception $e) {
    echo 'Error:' . $e->getMessage();
}
```

## Sign Data

Cryptographic digital signatures use public key algorithms to provide data integrity. When you sign data with a digital signature, someone else can verify the signature, and can prove that the data originated from you and was not altered after you signed it.

The following example applies a digital signature to a public key identifier.

```php
require_once './vendor/autoload.php';

use Virgil\Crypto\VirgilSigner;

$virgilSigner = new VirgilSigner();
$sign = $virgilSigner->sign(
    $encryptedData,
    $privateKey
);
```

## Verify Data

To verify that data was signed by a particular party, you must have the following information:

*   The public key of the party that signed the data.
*   The digital signature.
*   The data that was signed.

The following example verifies a digital signature which was signed by the sender.

```javascript
require_once './vendor/autoload.php';

use Virgil\Crypto\VirgilSigner;

$virgilSigner = new VirgilSigner();
$isValid = $virgilSigner->verify(
    $encryptedData,
    $sign,
    $publicKey
);
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
