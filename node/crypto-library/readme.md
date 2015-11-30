
# Native Virgil Crypto Library Bindings

- [Installation](#installation)
- [Keys generation](#keys-generation)
    - [Generate keypair](#generate-keypair)
    - [Generate keypair with encrypted private key](#generate-keypair-with-encrypted-private-key)
- [Encryption](#encryption)
    - [Encrypt and decrypt](#encrypt-and-decrypt)
    - [Decrypt with encrypted private key](#decrypt-with-encrypted-private-key)
    - [Encrypt data for multiple number of recipients](#encrypt-data-for-multiple-number-of-recipients)
- [Sign and verify data](#sign-and-verify-data)
- [License](#license)
- [Contacts](#contacts)

## Installation

```
npm install virgil-crypto
```

> **Note:**
> Windows users may experience issues with this module, please let us know about any problems.

## Keys generation

### Generate keypair

```javascript
var Virgil = require('virgil-crypto');
var keyPair = new Virgil.KeyPair();

console.log(keyPair.publicKey);
console.log(keyPair.privateKey);
```

results:

```
-----BEGIN PUBLIC KEY-----
MIGbMBQGByqGSM49AgEGCSskAwMCCAEBDQOBggAEAtB9KG6urPNpm4+m6CeF8JIx
6mTHYayz91Fu9Tm2NokNZ/N6tP7QgCIR3A9XMwxfGqrh8PrZZJdWjpEPmLIJ1kxD
2oPm6kGKX29kwAZyJYHktKutTychZYWLo3T87iRh+ZrJSvF9cpNLYU2uVeBrc/lz
4jbY1h1vKw0cjNsPzvw=
-----END PUBLIC KEY-----

-----BEGIN EC PRIVATE KEY-----
MIHaAgEBBEAc6T6FWG6dNA0b3ZnyzQNuOab2jCt5XS2CTahA5YIpv+k6exZgy7vr
DF5Puq7blCM3pHsXegkerRAnPYjRKP4yoAsGCSskAwMCCAEBDaGBhQOBggAEAtB9
KG6urPNpm4+m6CeF8JIx6mTHYayz91Fu9Tm2NokNZ/N6tP7QgCIR3A9XMwxfGqrh
8PrZZJdWjpEPmLIJ1kxD2oPm6kGKX29kwAZyJYHktKutTychZYWLo3T87iRh+ZrJ
SvF9cpNLYU2uVeBrc/lz4jbY1h1vKw0cjNsPzvw=
-----END EC PRIVATE KEY-----
```

### Generate keypair with encrypted private key

```javascript
var Virgil = require('virgil-crypto');
var keyPair = new Virgil.KeyPair('secret password');

console.log(keyPair.publicKey);
console.log(keyPair.privateKey);
```

results:

```
-----BEGIN PUBLIC KEY-----
MIGbMBQGByqGSM49AgEGCSskAwMCCAEBDQOBggAENYD+S2og9EapynW2FR7zZ69B
foOJ3SwlIVs6kX6i62ZNa3DrlVJ+YLY7gZI0aHnaiaolaVxyHyJ8fY5lYq/yd2I4
Z2CcFAW3MCgJZZtRH/Hrv6BXQpr5ntQwygjdPCKMz8Zg3+SHWu0zwk4Hgf44FZ8J
S550U4Pp4SHKRHxKYeQ=
-----END PUBLIC KEY-----

-----BEGIN ENCRYPTED PRIVATE KEY-----
MIIBMTA0BgoqhkiG9w0BDAEDMCYEIE/2Xs3NPnbamJbHol3Qg+pRsOQ493KyQGYZ
RY5vbJRSAgIgAASB+DDO582Ui+veMUF3NmxkJfCJc2Y9FgcAgkDbjzJ0cChuDvul
OPupAJHP1cY0n9cw+Azq87SteWz6fsrmA+ZSMSdoEfpC3H5ZtdHjrlL9/GQUWLh6
yG9q+Hl802QTZhmCESoZAg5J1nn8qGN8HGyHiHOcgepStIJEeegRcl3w+R+P0BsR
wShWPne9Pgrts+tICRgwo3i7Z8dBWRGH/8xTTdusyNRK+s5y1YB1pFX/EDo/Y7dC
MCTNkpTeHynl9FEStgGK9sPMJF3W92VxbOmcAnhW4HG8FKjre2ABWha6+umLikQ/
Qv8I5DLbip6RJ3xijNT2t0CCRdc7
-----END ENCRYPTED PRIVATE KEY-----
```

## Encryption

### Encrypt and decrypt

The Virgil library allows to encrypt data using several types of recipients such as password recipient and key transport recipient. The following example shows encryption with only one recipient.

```javascript
var Virgil = require('virgil-crypto');
var keyPair = new Virgil.KeyPair();
var cipher = new Virgil.Cipher();

var data = 'Encrypt me please';
var publicKeyId = 'AB82FD88-3DAE-420C-BED0-8D47B7DA497F';

cipher.addKeyRecipient(publicKeyId, keyPair.publicKey);

var encryptedData = cipher.encrypt(data);
var decryptedData = cipher.decryptWithKey(encryptedData, publicKeyId, keyPair.privateKey);

console.log(decryptedData.toString('utf8') === data);
```

### Decrypt with encrypted private key

```javascript
var decryptedData = cipher.decryptWithKey(encryptedData, publicKeyId, privateKey, privateKeyPassword);
```

### Encrypt data for multiple number of recipients

```javascript
var Virgil = require('virgil-crypto');
var keyPair = new Virgil.KeyPair();
var cipher = new Virgil.Cipher();

var data = 'Encrypt me';
var password = 'uS8wsWvc77';
var publicKeyId = 'AB82FD88-3DAE-420C-BED0-8D47B7DA497F';

cipher.addPasswordRecipient(password);
cipher.addKeyRecipient(publicKeyId, keyPair.publicKey);

var encryptedData = cipher.encrypt(data);

var decryptedData1 = cipher.decryptWithPassword(encryptedData, password);
var decryptedData2 = cipher.decryptWithKey(encryptedData, publicKeyId, keyPair.privateKey);

console.log(decryptedData1.toString('utf8') === decryptedData2.toString('utf8'));
console.log(decryptedData1.toString('utf8') === data);
```

## Sign and verify data

In example below used encrypted data for sign/verify, but it can be done for any data chosen by developer.

```javascript
var Virgil = require('../');

var signer = new Virgil.Signer();
var keyPair = new Virgil.KeyPair();
var data = 'Sign me please';

var sign = signer.sign(data, keyPair.privateKey);
console.log(sign);

var isVerified = signer.verify(data, sign, keyPair.publicKey);
console.log('Is verified =', isVerified);
```

results

```
<Buffer 30 81 99 30 0d 06 09 60 86 48 ...> 
Is verified =  true
```
</div>
</div>

<div class="col-md-12 col-md-offset-2 hidden-md hidden-xs hidden-sm">
<div class="docs-menu" data-ui="affix-docs">
<div class="title">Quick Navigation</div>

<div class="menu-items-wrapper" data-ui="menu-items-wrapper"></div>
</div>
</div>
</div>
</div>
</section>
