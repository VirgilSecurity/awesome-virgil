============
Tutorial Crypto Library Javascript/Node.js
============

- `Install`_
- `Generate Keys`_
- `Encrypt/Decrypt Data`_
    - `Using Password`_
    - `Async (using web workers) Using Password`_
    - `Using Key`_
    - `Using Key with Password`_
    - `Using Key with Password for Multiple Recipients`_
    - `Async (using web workers) Using Key with Password`_
    - `Async (using web workers) Using Key with Password for Multiple Recipients`_
    - `Using Key without Password`_
    - `Async (using web workers) Using Key without Password`_
- `Sign and Verify Data Using Key`_
    - `With Password`_
    - `Async (using web workers) with Password`_

*********
Install
*********

NPM
=========

.. code-block:: sh

    npm install virgil-crypto

Or install Virgil SDK with Virgil Crypto (recommended):

.. code-block:: sh

    npm install virgil-sdk

Bower
=========

.. code-block:: sh

    bower install virgil-crypto

Or install Virgil SDK with Virgil Crypto (recommended):

.. code-block:: sh

    bower install virgil-sdk

CDN
=========

.. code-block:: html

    <script 
    src="https://cdn.virgilsecurity.com/packages/javascript/crypto/1.5.5/virgil-crypto.min.js" 
    integrity="sha256-3W5xboDke1qIoYdoIGh3alQWUBMElS+lIyGL2JAjYhE=" 
    crossorigin="anonymous"></script>

Or install Virgil SDK with Virgil Crypto (recommended):

.. code-block:: html

    <script 
    src="https://cdn.virgilsecurity.com/packages/javascript/sdk/1.4.1/virgil-sdk.min.js" 
    integrity="sha256-oa5PdJUfmpmSk0q08WejIusp7epaht49i8NKSf6uoJo="
    crossorigin="anonymous"></script>

Demos 
=========

`Virgil and Twilio IP Messaging Demo Code <https://github.com/VirgilSecurity/virgil-demo-twilio>`_ and check out working demo:

`End to End Encrypted IP Messaging with Twilio API + Virgil <http://virgil-twilio-demo.azurewebsites.net/>`_

Quickstart guide for making your own E2E encrypted IP Messaging is: `here <https://github.com/VirgilSecurity/virgil-demo-twilio/tree/master/ip-messaging>`_

*********
Generate Keys
*********

The following code example creates a new public/private key pair.

.. code-block:: javascript

    var keyPair = virgilCrypto.generateKeyPair();
    console.log('Key pair without password: ', keyPair);

You can also generate a key pair with an encrypted private key just using one of the overloaded constructors.

In the table below you can see all types.

================== ===============================
Key Type            Description
================== ===============================
Type_Default        recommended safest type
Type_RSA_256 RSA    1024 bit (not recommended)
Type_RSA_512        RSA 1024 bit (not recommended)
Type_RSA_1024       RSA 1024 bit (not recommended)
Type_RSA_2048       RSA 2048 bit (not recommended)
Type_RSA_3072       RSA 3072 bit                  
Type_RSA_4096       RSA 4096 bit                   
Type_RSA_8192       RSA 8192 bit                   
Type_EC_SECP192R1   192-bits NIST curve            
Type_EC_SECP224R1   224-bits NIST curve            
Type_EC_SECP256R1   256-bits NIST curve            
Type_EC_SECP384R1   384-bits NIST curve            
Type_EC_SECP521R1   521-bits NIST curve            
Type_EC_BP256R1     256-bits Brainpool curve       
Type_EC_BP384R1     384-bits Brainpool curve       
Type_EC_BP512R1     512-bits Brainpool curve       
Type_EC_M221        (not implemented yet)          
Type_EC_M255        Curve25519                     
Type_EC_M383        (not implemented yet)           
Type_EC_M511        (not implemented yet)          
Type_EC_SECP192K1   192-bits "Koblitz" curve       
Type_EC_SECP224K1   224-bits "Koblitz" curve       
Type_EC_SECP256K1   256-bits "Koblitz" curve       
================== ===============================

.. code-block:: javascript

    var keyPairRsa2048 = virgilCrypto.generateKeyPair(
                        virgilCrypto.KeysTypesEnum.RSA_2048);
    console.log('Key pair RSA_2048 without password: ', keyPairRsa2048);
    
    var KEY_PASSWORD = 'password';
    var keyPairWithPassword = virgilCrypto.generateKeyPair(KEY_PASSWORD);
    console.log('Key pair with password: ', keyPairWithPassword);
    
    
    var KEY_PASSWORD = 'password';
    var keyPairWithPasswordAndSpecificType = virgilCrypto.generateKeyPair(
                                KEY_PASSWORD, 
                                virgilCrypto.KeysTypesEnum.RSA_2048);
    console.log('Key pair RSA_2048 with password: ', 
            keyPairWithPasswordAndSpecificType);

In the example below you can see a simply generated public/private keypair without a password.

.. code-block::

    -----BEGIN PUBLIC KEY-----
    MIGbMBQGByqGSM49AgEGCSskAwMCCAEBDQOBggAEWIH2SohavmLdRwEJ/VWbFcWr
    rU+g7Z/BkI+E1L5JF7Jlvi1T1ed5P0/JCs+K0ZBM/0hip5ThhUBKK2IMbeFjS3Oz
    zEsWKgDn8j3WqTb8uaKIFWWG2jEEnU/8S81Bgpw6CyxbCTWoB+0+eDYO1pZesaIS
    Tv6dTclx3GljHpFRdZQ=
    -----END PUBLIC KEY-----
    
    -----BEGIN EC PRIVATE KEY-----
    MIHaAgEBBEAaKrInIcjTeBI6B0mX+W4gMpu84iJtlPxksCQ1Dv+8iM/lEwx3nWWf
    ol6OvLkmG/qP9RqyXkTSCW+QONiN9JCEoAsGCSskAwMCCAEBDaGBhQOBggAEWIH2
    SohavmLdRwEJ/VWbFcWrrU+g7Z/BkI+E1L5JF7Jlvi1T1ed5P0/JCs+K0ZBM/0hi
    p5ThhUBKK2IMbeFjS3OzzEsWKgDn8j3WqTb8uaKIFWWG2jEEnU/8S81Bgpw6Cyxb
    CTWoB+0+eDYO1pZesaISTv6dTclx3GljHpFRdZQ=
    -----END EC PRIVATE KEY-----

Here is what an encrypted private key looks like:

.. code-block::

    -----BEGIN ENCRYPTED PRIVATE KEY-----
    MIIBKTA0BgoqhkiG9w0BDAEDMCYEIJjDIF2KRj7u86Up1ZB4yHHKhqMg5C/OW2+F
    mG5gpI+3AgIgAASB8F39JXRBTK5hyqEHCLcCTbtLKijdNH3t+gtCrLyMlfSfK49N
    UTREjF/CcojkyDVs9M0y5K2rTKP0S/LwUWeNoO0zCT6L/zp/qIVy9wCSAr+Ptenz
    MR6TLtglpGqpG4bhjqLNR2I96IufFmK+ZrJvJeZkRiMXQSWbPavepnYRUAbXHXGB
    a8HWkrjKPHW6KQxKkotGRLcThbi9cDtH+Cc7FvwT80O7qMyIFQvk8OUJdY3sXWH4
    5tol7pMolbalqtaUc6dGOsw6a4UAIDaZhT6Pt+v65LQqA34PhgiCxQvJt2UOiPdi
    SFMQ8705Y2W1uTexqw==
    -----END ENCRYPTED PRIVATE KEY-----

*********
Encrypt/Decrypt data
*********

The procedure for encrypting and decrypting the data is simple. For example:

If you want to encrypt the data to Bob, you encrypt it using Bob's public key (which you can get from the Public Keys Service), and Bob decrypts it with his private key. If Bob wants to encrypt some data to you, he encrypts it using your public key, and you decrypt it with your private key.

Crypto Library allows to encrypt the data for several types of recipient's user data like public key and password. This means that you can encrypt the data with some password or with a public key generated with the Crypto Library.

Using Password
=========

> Initial data must be passed as a String or `Buffer <https://github.com/feross/buffer>`_.

> Encrypted data will be returned as a `Buffer <https://github.com/feross/buffer>`_.

> The `Buffer <https://github.com/feross/buffer>`_ constructor is available by ```virgilCrypto.Buffer```

.. code-block:: javascript

    var INITIAL_DATA = 'data to be encrypted';
    var PASSWORD = 'password';
    
    var encryptedData = virgilCrypto.encrypt(INITIAL_DATA, PASSWORD);
    var decryptedData = virgilCrypto.decrypt(encryptedData, PASSWORD);
    
    console.log('Encrypted data: ' + encryptedData);
    console.log('Decrypted data: ' + decryptedData.toString());

Async (using web workers) Using Password
=========

.. note :: Only for browsers.

.. code-block:: javascript

    var INITIAL_DATA = 'data to be encrypted';
    var PASSWORD = 'password';
    
    virgilCrypto.encryptAsync(INITIAL_DATA, PASSWORD)
      .then(function(encryptedData) {
        console.log('Encrypted data: ' + encryptedData);
    
        virgilCrypto.decryptAsync(encryptedData, PASSWORD)
          .then(function(decryptedData) {
            console.log('Decrypted data: ' + decryptedData.toString());
          });
      });

Using Key
=========

> Initial data must be passed as a String or `Buffer <https://github.com/feross/buffer>`_.

> Encrypted data will be returned as a `Buffer <https://github.com/feross/buffer>`_.

> The `Buffer <https://github.com/feross/buffer>`_ constructor is available by ```virgilCrypto.Buffer```

Using Key with Password
=========

.. code-block:: javascript

    var KEY_PASSWORD = 'password';
    var INITIAL_DATA = 'data to be encrypted';
    var RECIPIENT_ID = '<SOME_RECIPIENT_ID>';
    
    var keyPair = virgilCrypto.generateKeyPair(KEY_PASSWORD);
    var encryptedData = virgilCrypto.encrypt(
                                         INITIAL_DATA, 
                                         RECIPIENT_ID, 
                                         keyPair.publicKey);
    var decryptedData = virgilCrypto.decrypt(
                                        encryptedData, 
                                        RECIPIENT_ID, 
                                        keyPair.privateKey, 
                                        KEY_PASSWORD);
    
    console.log('Encrypted data: ' + encryptedData);
    console.log('Decrypted data: ' + decryptedData.toString());

Using Key with Password for Multiple Recipients
=========

.. code-block:: javascript

    var KEY_PASSWORD = 'password';
    var INITIAL_DATA = 'data to be encrypted';
    var RECIPIENT_ID = '<SOME_RECIPIENT_ID>';
    
    var keyPair = virgilCrypto.generateKeyPair(KEY_PASSWORD);
    var recipientsList = [{ recipientId: RECIPIENT_ID, 
                     publicKey: keyPair.publicKey }];
    var encryptedData = virgilCrypto.encrypt(INITIAL_DATA, recipientsList);
    var decryptedData = virgilCrypto.decrypt(
                                     encryptedData, 
                                     RECIPIENT_ID, 
                                     keyPair.privateKey, 
                                     KEY_PASSWORD);
    
    console.log('Encrypted data: ' + encryptedData);
    console.log('Decrypted data: ' + decryptedData.toString());

Async (using web workers) Using Key with Password
=========

.. note :: Only for browsers.

.. code-block:: javascript

    var KEY_PASSWORD = 'password';
    var INITIAL_DATA = 'data to be encrypted';
    var RECIPIENT_ID = '<SOME_RECIPIENT_ID>';
    
    virgilCrypto.generateKeyPairAsync(KEY_PASSWORD)
      .then(function(keyPair) {
        virgilCrypto.encryptAsync(INITIAL_DATA, RECIPIENT_ID, keyPair.publicKey)
          .then(function(encryptedData) {
            console.log('Encrypted data: ' + encryptedData);
    
            virgilCrypto.decryptAsync(
                        encryptedData, 
                        RECIPIENT_ID, 
                        keyPair.privateKey, 
                        KEY_PASSWORD)
              .then(function(decryptedData) {
                console.log('Decrypted data: ' + decryptedData.toString());
              });
          });
      });

Async (using web workers) Using Key with Password for Multiple Recipients
=========

.. note :: Only for browsers.

.. code-block:: javascript

    var KEY_PASSWORD = 'password';
    var INITIAL_DATA = 'data to be encrypted';
    var RECIPIENT_ID = '<SOME_RECIPIENT_ID>';
    
    virgilCrypto.generateKeyPairAsync(KEY_PASSWORD)
      .then(function(keyPair) {
        var recipientsList = [{ recipientId: RECIPIENT_ID, 
                                publicKey: keyPair.publicKey }];
    
        virgilCrypto.encryptAsync(INITIAL_DATA, recipientsList)
          .then(function(encryptedData) {
            console.log('Encrypted data: ' + encryptedData);
    
            virgilCrypto.decryptAsync(
                        encryptedData, 
                        RECIPIENT_ID, 
                        keyPair.privateKey, 
                        KEY_PASSWORD)
              .then(function(decryptedData) {
                console.log('Decrypted data: ' + decryptedData.toString());
              });
          });
      });

Using Key without Password
=========

.. code-block:: javascript

    var INITIAL_DATA = 'data to be encrypted';
    var RECIPIENT_ID = '<SOME_RECIPIENT_ID>';
    
    var keyPair = virgilCrypto.generateKeyPair();
    var encryptedData = virgilCrypto.encrypt(
                                     INITIAL_DATA, 
                                     RECIPIENT_ID, 
                                     keyPair.publicKey);
    var decryptedData = virgilCrypto.decrypt(
                                     encryptedData, 
                                     RECIPIENT_ID, 
                                     keyPair.privateKey);
    
    console.log('Encrypted data: ' + encryptedData);
    console.log('Decrypted data: ' + decryptedData.toString());

Async (using web workers) Using Key without Password
=========

.. note :: Only for browsers.

.. code-block:: javascript

    var INITIAL_DATA = 'data to be encrypted';
    var RECIPIENT_ID = '<SOME_RECIPIENT_ID>';
    
    virgilCrypto.generateKeyPairAsync()
      .then(function(keyPair) {
        virgilCrypto.encryptAsync(INITIAL_DATA, RECIPIENT_ID, keyPair.publicKey)
          .then(function(encryptedData) {
            console.log('Encrypted data: ' + encryptedData);
    
            virgilCrypto.decryptAsync(
                       encryptedData, 
                       RECIPIENT_ID, 
                       keyPair.privateKey)
              .then(function(decryptedData) {
                console.log('Decrypted data: ' + decryptedData.toString());
              });
          });
      });

*********
Sign and Verify Data Using Key
*********

Cryptographic digital signatures use public key algorithms to provide data integrity. When you sign the data with a digital signature, someone else can verify the signature and can prove that the data originated from you and was not altered after you had signed it.

The following example applies a digital signature to a public key identifier.

> Initial data must be passed as a String or `Buffer <https://github.com/feross/buffer>`_.

> Encrypted data will be returned as a `Buffer <https://github.com/feross/buffer>`_.

> The `Buffer <https://github.com/feross/buffer>`_ constructor is available by ```virgilCrypto.Buffer```

With Password
=========

.. code-block:: javascript

    var KEY_PASSWORD = 'password';
    var INITIAL_DATA = 'data to be encrypted';
    var RECIPIENT_ID = '<SOME_RECIPIENT_ID>';
    
    var keyPair = virgilCrypto.generateKeyPair(KEY_PASSWORD);
    var encryptedData = virgilCrypto.encrypt(
                                     INITIAL_DATA, 
                                     RECIPIENT_ID, 
                                     keyPair.publicKey);
    var sign = virgilCrypto.sign(
                   encryptedData, 
                   keyPair.privateKey, 
                   KEY_PASSWORD);

To verify that the data was signed by a particular party, you need the following information:

*   the public key of the party that signed the data;
*   the digital signature;
*   the data that was signed.

The following example verifies a digital signature which was signed by the sender.

.. code-block:: javascript

    var isDataVerified = virgilCrypto.verify(
                                   encryptedData, 
                                   keyPair.publicKey, 
                                   sign);
    
    console.log('Encrypted data: ' + encryptedData);
    console.log('Sign: ' + sign.toString('base64'));
    console.log('Is data verified: ' + isDataVerified);

Async (using web workers) With Password
=========

.. note :: Only for browsers.

.. code-block:: javascript

    var KEY_PASSWORD = 'password';
    var INITIAL_DATA = 'data to be encrypted';
    var RECIPIENT_ID = '<SOME_RECIPIENT_ID>';
    
    virgilCrypto.generateKeyPairAsync(KEY_PASSWORD)
      .then(function(keyPair) {
        virgilCrypto.encryptAsync(INITIAL_DATA, RECIPIENT_ID, keyPair.publicKey)
          .then(function(encryptedData) {
            console.log('Encrypted data: ' + encryptedData);
    
            virgilCrypto.signAsync(
                       encryptedData, 
                       keyPair.privateKey, 
                       KEY_PASSWORD)
              .then(function(sign) {
                console.log('Sign: ' + sign.toString('base64'));
    
                virgilCrypto.verifyAsync(encryptedData, keyPair.publicKey, sign)
                  .then(function(isDataVerified) {
                    console.log('Is data verified: ' + isDataVerified);
                  });
              });
          });
      });
