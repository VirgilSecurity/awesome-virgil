
## Native Virgil Crypto Library Bindings

- [Requirements](#requirements)
- [Installation](#installation)
- [Keys generation](#keys-generation)
    - [Generate keypair](#generate-keypair)
    - [Generate keypair with encrypted private key](#generate-keypair-with-encrypted-private-key)
- [Encryption](#encryption)
    - [Encrypt and decrypt](#encrypt-and-decrypt)
    - [Decrypt with encrypted private key](#decrypt-with-encrypted-private-key)
    - [Encrypt data for multiple number of recipients](#encrypt-data-for-multiple-number-of-recipients)
- [Sign and verify data](#sign-and-verify-data)

## Requirements

* PHP 5.3+
* virgil_php.so extension

## Installation

```bash
composer require virgil/crypto
```

## Keys generation

### Generate keypair

```php
require_once './vendor/autoload.php';

use Virgil\Crypto\VirgilKeyPair;

$key = new VirgilKeyPair();

file_put_contents('new_public.key', $key->publicKey());
file_put_contents('new_private.key', $key->privateKey());
```

### Generate keypair with encrypted private key

```php
require_once './vendor/autoload.php';

use Virgil\Crypto\VirgilKeyPair;

$key = new VirgilKeyPair('secret password');

file_put_contents('new_public.key', $key->publicKey());
file_put_contents('new_private.key', $key->privateKey());
```
## Encryption

### Encrypt and decrypt

The Virgil library allows to encrypt data using several types of recipients such as password recipient and key transport recipient. The following example shows encryption with only one recipient.

```php

use Virgil\Crypto\VirgilKeyPair,
    Virgil\Crypto\VirgilCipher;

$data = 'Encrypt me please';
$publicKeyId = 'AB82FD88-3DAE-420C-BED0-8D47B7DA497F';

$keyPair = new VirgilKeyPair();
$cipher  = new VirgilCipher;

$cipher->addKeyRecipient($publicKeyId, $keyPair->publicKey());


$encryptedData = $cipher->encrypt(data);
$decryptedData = $cipher->decryptWithKey($encryptedData, $publicKeyId, $keyPair->privateKey());
```

### Decrypt with encrypted private key

```php

use Virgil\Crypto\VirgilKeyPair,
    Virgil\Crypto\VirgilCipher;

$data = 'Encrypt me please';
$publicKeyId = 'AB82FD88-3DAE-420C-BED0-8D47B7DA497F';
$privateKeyPassword = 'password';

$keyPair = new VirgilKeyPair($privateKeyPassword);
$cipher  = new VirgilCipher;

$cipher->addKeyRecipient($publicKeyId, $keyPair->publicKey());

$encryptedData = $cipher->encrypt(data);
$decryptedData =  $cipher->decryptWithKey($encryptedData, $publicKeyId, $privateKey, $privateKeyPassword);
```

### Encrypt data for multiple number of recipients

```php
use Virgil\Crypto\VirgilKeyPair,
    Virgil\Crypto\VirgilCipher;

$keyPair = new VirgilKeyPair();
$cipher  = new VirgilCipher;

$data = 'Encrypt me please';
$publicKeyId = 'AB82FD88-3DAE-420C-BED0-8D47B7DA497F';
$password = 'password';

$cipher->addPasswordRecipient($password);
$cipher->addKeyRecipient($publicKeyId, $keyPair->publicKey());

$encryptedData = $cipher->encrypt($data);

$decryptedData1 = cipher.decryptWithPassword($encryptedData, $password);
$decryptedData2 = cipher.decryptWithKey($encryptedData, $publicKeyId, $keyPair->privateKey());
```

## Sign and verify data

In example below used encrypted data for sign/verify, but it can be done for any data chosen by developer.

```php
<?php

use Virgil\Crypto\VirgilSigner,
    Virgil\Crypto\VirgilKeyPair;

$signer = new VirgilSigner();
$keyPair = new VirgilKeyPair();

$data = 'Sign me please';

$sign = $signer->sign($data, $keyPair->privateKey());
$isVerified = $signer->verify($data, $sign, $keyPair->publicKey());

echo $sign;
echo $isVerified;
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
