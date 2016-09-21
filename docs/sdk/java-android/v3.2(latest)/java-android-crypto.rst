============
Tutorial Crypto Library Java/Android
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

Gradle
=========

.. code-block:: html

  compile 'com.virgilsecurity.sdk:crypto:3.0'

Or install Virgil SDK with Virgil Crypto (recommended):

.. code-block:: html

  compile 'com.virgilsecurity.sdk:client:3.2.0'
  compile 'com.squareup.retrofit2:retrofit:2.0.0'
  compile 'com.squareup.retrofit2:converter-gson:2.0.0'

Android
=========

.. code-block:: html

  compile 'com.virgilsecurity.sdk:android:3.2.0@aar'
  compile 'com.squareup.retrofit2:retrofit:2.0.0'
  compile 'com.squareup.retrofit2:converter-gson:2.0.0'

Demos
=========

`Virgil and Twilio IP Messaging Demo Code <https://github.com/VirgilSecurity/virgil-demo-twilio>`_ and check out working demo:

`End to End Encrypted IP Messaging with Twilio API + Virgil <http://virgil-twilio-demo.azurewebsites.net/>`_

Quickstart guide for making your own E2E encrypted IP Messaging is: `here <https://github.com/VirgilSecurity/virgil-demo-twilio/tree/master/ip-messaging>`_

*********
Generate Keys
*********

The following code example creates a new public/private key pair.

.. code-block:: java

  KeyPair keyPair = KeyPairGenerator.generate();
  
In the example below you can see a simply generated public/private keypair without a password.

.. code-block:: 

  -----BEGIN PUBLIC KEY-----
  MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApbCIt9IiGAloImV/p0b1
  IvjgYB1oULIQ5LJa9TkJBw54LFndps6a475bx131uSqW0RKT0GG4RdKDt2yCLmkr
  lsp8WVCnu0PuntbbhvopRxUPTSib0i0SIp4aUvQTGKFwi40Q8ZRXBtLc+TlVIF86
  zkOeDyTPHc/FlBfCym+HuWbUptFe941QR8xzP5aFyXTqXGtwu9jKtbY2+9U9y7rK
  1N25YKaGXfUolCzDQJbipJyvOCStUaHEeZdhz7RUuoJ9RrNZXU0VRWmIqA/E2bFs
  zT1zaZlzUfMCYoxxjd9DxQqro7tTTlY2JBTVRVT6Geef6mYi5cA0lHbskFJEkObc
  uQIDAQAB
  -----END PUBLIC KEY-----
  
  Private Key: 
  -----BEGIN RSA PRIVATE KEY-----
  MIIEowIBAAKCAQEApbCIt9IiGAloImV/p0b1IvjgYB1oULIQ5LJa9TkJBw54LFnd
  ps6a475bx131uSqW0RKT0GG4RdKDt2yCLmkrlsp8WVCnu0PuntbbhvopRxUPTSib
  0i0SIp4aUvQTGKFwi40Q8ZRXBtLc+TlVIF86zkOeDyTPHc/FlBfCym+HuWbUptFe
  941QR8xzP5aFyXTqXGtwu9jKtbY2+9U9y7rK1N25YKaGXfUolCzDQJbipJyvOCSt
  UaHEeZdhz7RUuoJ9RrNZXU0VRWmIqA/E2bFszT1zaZlzUfMCYoxxjd9DxQqro7tT
  TlY2JBTVRVT6Geef6mYi5cA0lHbskFJEkObcuQIDAQABAoIBAHV6JIXJHNlUGhyB
  QLBXFEoWkeg0EZldl7K/btR9+xOgw74WfZze0l11w9conKgMNWDJvjo6fxAqga+U
  5PyJHxnMObyN/k89jDvc9UvPpWK74NyBVXIA+OHInbuBSOTm2khn3cKbvdSdv4WJ
  i/zm6GgE81WjcKKfhWRKMJed2mquBROpQmWi6zNHLyNwnfvh7LC1pgD55xvUKGr7
  HmEj/wiySEf6jPC6IfqW5bf5ruZw5fpUpO8IWCbsrCPqfL9dXzwRp/vvMr4K51Tj
  8irYMzD8VHCIorOdpLWqIA5fG9JaiaJumH/uqVuSBCmXycAFgCsMjs54q7V7Qi8J
  48jzFYECgYEA1OwXLdHk98W97quJJZ9hJEu/wuWfiy3P3yMGKKIIf2c/HSop6QFC
  6RltogUn8c1gUrCNInYc3GFel7ACO2hvNXsblKVD88p5CCw5+fxIssOY0X2uIH1Q
  B4VAPTneAI9O1ncvT4wDs9T5Lm6k10Xwa/yzTLjwxUmIoYvxpswFPmkCgYEAxzYd
  7/H9YelLCPwt2b2T7t0HvDwRnSg6xB7B4s0SgJmanbiP2+yMgWZNZPgzilQrxUsA
  vwx6iYETVkmvG/XazpVCyCoZUwjxeZe+X0UJZ6PHbqzIS1HwHRjyl4aOptv8R8iq
  9fHDCkQSI35vX1wMk+y/OlEyTasvCj4nI41MgdECgYA1tROnsCEUSqG9GTGv9sLX
  F/BX5fnXbofXngsIps6D7HQkFCWcK4BIMezQiIJp4MciNHx1K9vdzwXAN1pox8/9
  an8rgIBidzkOUbGSGAvyY5ohhZUths5wBzGMABO6imt1d3zMkOHCM79i8e/MiUy6
  wHQtrxy0dvbq4NTkoOPVuQKBgDoWl6gt4fq48j5OengxhX9zSBwlT+WJo4kohtTB
  g5GoOKOg+6HfWiEpWYwFq9G8NX80HaWX1+tcjeztU3hNul3evDhtvjCuPOt9ye8x
  zEpCQZcOHuGHpQJ3EdYJUHNrVicAZomM05icvMVIyuT9jFVeBWzV3Fs1fWP5N6Rw
  QUzhAoGBALawq3Fi17xrLxqUupOigWa67UJdFo0J5cGZcP6auBdxDTHchnhFFaqs
  7qlVzCTP1/vmPClacdxiEqHPMFB6o5hOHJWN3Gpj8QVHeIiWVRLbZQ6kdhSjPqLw
  TeUhiq+R0YSJXwnKHydlhOMevntLgNXLDsv3SgoozYhIIakTB7TZ
  ----END RSA PRIVATE KEY-----

You can also generate a key pair with an encrypted private key just using one of the overloaded constructors.

.. code-block:: java

  String password = "MyPwd";
  KeyPair keyPair = KeyPairGenerator.generate(password);

Here is what an encrypted private key looks like:

.. code-block:: 

  -----BEGIN RSA PRIVATE KEY-----
  MIIEpQIBAAKCAQEAtFM3l4A3krq+NRMX/65Eau9eKJ/n9ABy9gZ9LalYrpxMGRUF
  n3y6giIhymeR8Rsv/WpcgJYkGOYnTD7u2e/6IMtJhnockIAq1hmh+bqse1J//p1j
  dYQHCXZryh88uYechtogr62O7mmohtq/uuLhQjmDouGjSoQztKASmUsS+ZJAPbbd
  /VKEORCBfT77uQ3oaoOmC8C+mFSOb2w0FuZikNScwu2Ph56giFOA75W2V7Xj4qJM
  S3+bDbuRwsEEhlA1juSJH0f1WpFe+SWEhtpe7W84G47xbgl3XMSzEwIwWIF/rPtZ
  S2rFF7rxhrTjAXIPxBRfjqa2AFGD1riRAB/AmQIDAQABAoIBAQCweRRZnvBEF5+X
  /3SoE1r/r/xdE4kD4QCgx17wNeAFGg7bKRiUqZM5Ub/x/oP0CqBfiBy49rai63Kg
  CqLkBBesymXNRmn3/IZveyxqYob0NZvviQXR9wCQASWh7AoYo5/K1WPRqa/MoPh9
  6Uxj0C+VCQZLfDi670BOz60D+lW6iQHEbxcy5oYaFE10ubcyNXoXTp6VQ8rZbK7W
  0P3uQPU4Mz2FCGfMvjXTulDtEoq+Vd0PhCmWXSnd7GHppAjhNllGAnCko3yZ4FO0
  H7aAVP90OpDiaTPLcB4rjf8+OG2JZIdIBQTjt0GGvPiSH1msBP4a60LGzN8987mk
  VHhO6w0BAoGBAOdsLJvfjUU4cfzFRCziTGscnt44XXUBUy/9NPKS8f3KqGPdp0m2
  YnY/7u4hDYcswUIr+lgqltTkzQfDWKM71aJ1XElKJUqaR/V2OCh83+Theyc4KffX
  aVoSecqSTN5edFnuwwyWoEnuYljL+lQeLJkWhXTbxqmF2Gm/HPD4JTJhAoGBAMd5
  0wxEgTMjLPWZ1ec9LIPiD8jyoqzhZV6r8u1c062DhovH9SKUhVy5Gl+ppigltl8T
  GvN3xbdX39K9642cbziRbsX1BtFRsRmRmiOgp2U7/Y+qO4HELSFPl7RirYmwsjUY
  ksQu+xWG741ejeslEmNvfVsItXe8zZ5ebILshik5AoGBALnCzTP5iC5uFqFtv0HA
  DNNVz/hUikAnZhz5RQ0KAxFTIUO4YlX6/qIow6OGCJPeyupQ3szysswFNMbseTPe
  DagwSHnT+IcfvG8+C+oEArx4eiCLJrT4xmo0tmpycR11+DNQQmTSa6usnGjmovPu
  nKHtwAaDe74L4CFR9OtAZKtBAoGBAIHXf5PVp4/EzsgTWZPKUwaJiKLRpSgJEzXb
  kSYGLVcdbN/hyWO371MavdsVD63EVoBubDWcedtM3MlNjF1CPXdB2ywJwWVQ2ol9
  KCsWsL+JnBP+x/tA2et75pCpRrKAjI9ZLnd66T7q9VU8/f3YxK5q7NrrwUtuXx09
  8z4JfY6pAoGAGbxdRkPWdF/69C7Z3+RO3M//XoTqzMrkcN//Ip9/v9wOXhexJuN0
  U1PeHQTYbdh6cAMONuS7lO3u1SlOPI+KABApcen9M5YH1Al5NqY0B+EilLlq8JiA
  ffVzLLEGgeI44jugUP9epUGkRpCJwyzBslOPaXlo/g84hYFHRrHQzq0=
  -----END RSA PRIVATE KEY-----

Generate keys with specific type

.. code-block:: java

  KeyPair keyPair = KeyPairGenerator.generate(KeyType.EC_SECP521R1);

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

See a working example `here... <https://github.com/VirgilSecurity/virgil-sdk-java-android/blob/master/samples/crypto/src/main/java/GenerateKeyPairs.java>`_

*********
Encrypt Data
*********

The procedure for encrypting and decrypting the data is simple. For example:

If you want to encrypt the data to Bob, you encrypt it using Bob's public key (which you can get from the Public Keys Service), and Bob decrypts it with his private key. If Bob wants to encrypt some data to you, he encrypts it using your public key, and you decrypt it with your private key.

Crypto Library allows to encrypt the data for several types of recipient's user data like public key and password. This means that you can encrypt the data with some password or with a public key generated with the Crypto Library. 

Encrypt the text with a password:

.. code-block:: java

  String text = "Encrypt me, Please!!!";
  String password = "TafaSuf4";
  
  String encryptedText = CryptoHelper.encrypt(text, password);

Encrypt the text with a public key:

.. code-block:: java
  String text = "Encrypt me, Please!!!";
  KeyPair keyPair = KeyPairGenerator.generate();
  PublicKey publicKey = keyPair.getPublic();
  
  String encryptedText = CryptoHelper.encrypt(text, "RecipientId", publicKey);

See a working example `here... <https://github.com/VirgilSecurity/virgil-sdk-java-android/blob/master/samples/crypto/src/main/java/EncryptionWithPublicKey.java>`_

And of course you can mix these types as well, see how it works in the example below:

.. code-block:: java

  String text = "Encrypt me, Please!!!";
  
  KeyPair keyPair = KeyPairGenerator.generate();
  PublicKey publicKey = keyPair.getPublic();
  String password = "TafaSuf4";
  
  byte[] encryptedData = null;
  try (Cipher cipher = new Cipher()) {
    cipher.addKeyRecipient(recipientId, publicKey);
    cipher.addPasswordRecipient(password);
    
    // Encrypt data with private key
    encryptedData = cipher.encrypt(text.getBytes(), true);
  } catch (Exception e) {
    // Log exception
  }

See a working example `here... <https://github.com/VirgilSecurity/virgil-sdk-java-android/blob/master/samples/crypto/src/main/java/Encryption.java>`_

*********
Sign Data
*********

Cryptographic digital signatures use public key algorithms to provide data integrity. When you sign the data with a digital signature, someone else can verify the signature and can prove that the data originated from you and was not altered after you had signed it.

The following example applies a digital signature to a public key identifier.

.. code-block:: java

  String text = "Sign me, Please!!!";
  KeyPair keyPair = KeyPairGenerator.generate();
  String signature = CryptoHelper.sign(text, keyPair.getPrivate());

See a working example `here... <https://github.com/VirgilSecurity/virgil-sdk-java-android/blob/master/samples/crypto/src/main/java/SignAndVerifyText.java>`_

*********
Verify Data
*********

To verify that the data was signed by a particular party, you need the following information:

*   the public key of the party that signed the data;
*   the digital signature;
*   the data that was signed.

The following example verifies a digital signature which was signed by the sender.

.. code-block:: java
  var isValid = CryptoHelper.Verify(originalText, signature, 
         keyPair.PublicKey());

See a working example `here... <https://github.com/VirgilSecurity/virgil-sdk-java-android/blob/master/samples/crypto/src/main/java/SignAndVerifyText.java>`_

*********
Decrypt Data
*********

The following example illustrates decryption of the encrypted data with a recipient's private key.

.. code-block:: java

  boolean isValid = CryptoHelper.verify(text, signature, keyPair.getPublic());

Use a password to decrypt the data.

.. code-block:: java

  String decryptedText = CryptoHelper.decrypt(encryptedText, password);

See a working example `here... <https://github.com/VirgilSecurity/virgil-sdk-java-android/blob/master/samples/crypto/src/main/java/EncryptionWithPassword.java>`_
