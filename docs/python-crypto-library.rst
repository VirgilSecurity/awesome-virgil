============
Tutorial Crypto Library Python
============

- `Install`_
- `Generate Keys`_
- `Encrypt Data`_
- `Sign Data`_
- `Verify Data`_
- `Decrypt Data`_

*********
Install
*********

Use command line to install `Virgil crypto package <https://cdn.virgilsecurity.com/virgil-crypto/python/>`_:

.. code-block:: html

  python setup.py install

To import module write:

.. code-block:: python

  import VirgilSDK.virgil_crypto.cryptolib as cryptolib

Or install Virgil SDK with Virgil Crypto (recommended):

.. code-block:: html

  from VirgilSDK import virgilhub
  import VirgilSDK.virgil_crypto.cryptolib as cryptolib

Demos
=========

`Virgil and Twilio IP Messaging Demo Code <https://github.com/VirgilSecurity/virgil-demo-twilio>`_ and check out working demo:

`End to End Encrypted IP Messaging with Twilio API + Virgil <http://virgil-twilio-demo.azurewebsites.net/>`_

Quickstart guide for making your own E2E encrypted IP Messaging is: `here <https://github.com/VirgilSecurity/virgil-demo-twilio/tree/master/ip-messaging>`_

*********
Generate Keys
*********

The following code example creates a new public/private key pair with a specific type.

.. code-block:: python

  keys = cryptolib.CryptoWrapper.generate_keys(cryptolib.crypto_helper.VirgilKeyPair.Type_EC_SECP224R1, "%PASSWORD%")

In the example below you can see a simply generated public/private keypair.

.. code-block:: 

  -----BEGIN PUBLIC KEY-----
  MIGbMBQGByqGSM49AgEGCSskAwMCCAEBDQOBggAEWIH2SohavmLdRwEJ/VWbFcWr
  rU+g7Z/BkI+E1L5JF7Jlvi1T1ed5P0/JCs+K0ZBM/0hip5ThhUBKK2IMbeFjS3Oz
  zEsWKgDn8j3WqTb8uaKIFWWG2jEEnU/8S81Bgpw6CyxbCTWoB+0+eDYO1pZesaIS
  Tv6dTclx3GljHpFRdZQ=
  -----END PUBLIC KEY-----

  -----BEGIN ENCRYPTED PRIVATE KEY-----
  MIIBKTA0BgoqhkiG9w0BDAEDMCYEIJjDIF2KRj7u86Up1ZB4yHHKhqMg5C/OW2+F
  mG5gpI+3AgIgAASB8F39JXRBTK5hyqEHCLcCTbtLKijdNH3t+gtCrLyMlfSfK49N
  UTREjF/CcojkyDVs9M0y5K2rTKP0S/LwUWeNoO0zCT6L/zp/qIVy9wCSAr+Ptenz
  MR6TLtglpGqpG4bhjqLNR2I96IufFmK+ZrJvJeZkRiMXQSWbPavepnYRUAbXHXGB
  a8HWkrjKPHW6KQxKkotGRLcThbi9cDtH+Cc7FvwT80O7qMyIFQvk8OUJdY3sXWH4
  5tol7pMolbalqtaUc6dGOsw6a4UAIDaZhT6Pt+v65LQqA34PhgiCxQvJt2UOiPdi
  SFMQ8705Y2W1uTexqw==
  -----END ENCRYPTED PRIVATE KEY-----

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

*********
Encrypt Data
*********

The procedure for encrypting and decrypting the data is simple. For example:

If you want to encrypt the data to Bob, you encrypt it using Bob's public key (which you can get from the Public Keys Service), and Bob decrypts it with his private key. If Bob wants to encrypt some data to you, he encrypts it using your public key, and you decrypt it with your private key.

Encrypt the text with a public key:

.. code-block:: python

  enc = cryptolib.CryptoWrapper.encrypt('%To be encrypted%', '%Recipient id%', '%Recipient public key%')

*********
Sign Data
*********

Cryptographic digital signatures use public key algorithms to provide data integrity. When you sign the data with a digital signature, someone else can verify the signature and can prove that the data originated from you and was not altered after you had signed it.

The following example applies a digital signature to a public key identifier.

.. code-block:: python

  originalText = "Sign me, Please!!!"
  keys = cryptolib.CryptoWrapper.generate_keys(cryptolib.crypto_helper.VirgilKeyPair.Type_EC_SECP224R1, "%PASSWORD%")
  sign = cryptolib.CryptoWrapper.sign(originalText, keys['private_key'], '%PASSWORD%')

*********
Verify Data
*********

To verify that the data was signed by a particular party, you need the following information:

*   the public key of the party that signed the data;
*   the digital signature;
*   the data that was signed.

The following example verifies a digital signature which was signed by the sender.

.. code-block:: python

  verify = cryptolib.CryptoWrapper.verify(originalText, sign, '%PUBLIC_KEY%')

*********
Decrypt Data
*********

The following example illustrates decryption of the encrypted data with a recipient's private key.

.. code-block:: python

  data = cryptolib.CryptoWrapper.decrypt('%ENCRYPTED_TEXT%%', '%RECIPIENT_ID%', keys['private_key'])

Use a password to decrypt the data.

.. code-block:: python

  data = cryptolib.CryptoWrapper.decrypt_with_password('%ENCRYPTED_DATA%', '%PASSWORD%')
