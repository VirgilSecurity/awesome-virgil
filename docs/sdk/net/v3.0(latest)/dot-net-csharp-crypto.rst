==================================== 
Tutorial Crypto Library .NET/C# 
====================================

-  `Install <#install>`__
-  `Generate Keys <#generate-keys>`__
-  `Encrypt Data <#encrypt-data>`__
-  `Sign Data <#sign-data>`__
-  `Verify Data <#verify-data>`__
-  `Decrypt Data <#decrypt-data>`__

Install
-------

Use NuGet Package Manager (Tools -> Library Package Manager -> Package
Manager Console) to install Virgil.SDK.Keys package, running the
command:

::

    PM> Install-Package Virgil.Crypto

Or install Virgil SDK with Virgil Crypto (recommended):

::

    PM> Install-Package Virgil.SDK

Demos
~~~~~

`Virgil and Twilio IP Messaging Demo
Code <https://github.com/VirgilSecurity/virgil-demo-twilio>`__ and check
out working demo:

`End to End Encrypted IP Messaging with Twilio API +
Virgil <http://virgil-twilio-demo.azurewebsites.net/>`__

Quickstart guide for making your own E2E encrypted IP Messaging is:
`here <https://github.com/VirgilSecurity/virgil-demo-twilio/tree/master/ip-messaging>`__

Generate Keys
-------------

The following code example creates a new public/private key pair.

.. code:: csharp

    var keyPair = VirgilKeyPair.Generate();

In the example below you can see a simply generated public/private
keypair without a password.

::

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

You can also generate a key pair with an encrypted private key just
using one of the overloaded constructors.

.. code:: csharp

    var password = "TafaSuf4";
    var keyPair = VirgilKeyPair.Generate(Encoding.UTF8.GetBytes(password));

Here is what an encrypted private key looks like:

::

    -----BEGIN ENCRYPTED PRIVATE KEY-----
    MIIBKTA0BgoqhkiG9w0BDAEDMCYEIJjDIF2KRj7u86Up1ZB4yHHKhqMg5C/OW2+F
    mG5gpI+3AgIgAASB8F39JXRBTK5hyqEHCLcCTbtLKijdNH3t+gtCrLyMlfSfK49N
    UTREjF/CcojkyDVs9M0y5K2rTKP0S/LwUWeNoO0zCT6L/zp/qIVy9wCSAr+Ptenz
    MR6TLtglpGqpG4bhjqLNR2I96IufFmK+ZrJvJeZkRiMXQSWbPavepnYRUAbXHXGB
    a8HWkrjKPHW6KQxKkotGRLcThbi9cDtH+Cc7FvwT80O7qMyIFQvk8OUJdY3sXWH4
    5tol7pMolbalqtaUc6dGOsw6a4UAIDaZhT6Pt+v65LQqA34PhgiCxQvJt2UOiPdi
    SFMQ8705Y2W1uTexqw==
    -----END ENCRYPTED PRIVATE KEY-----

Generate keys with specific type

.. code:: csharp

    var keyPair = VirgilKeyPair.Generate(VirgilKeyPair.Type.EC_SECP256K1);

In the table below you can see all types.

+-----------------------+----------------------------------+
| Key Type              | Description                      |
+=======================+==================================+
| Type\_Default         | recommended safest type          |
+-----------------------+----------------------------------+
| Type\_RSA\_256        | RSA 1024 bit (not recommended)   |
+-----------------------+----------------------------------+
| Type\_RSA\_512        | RSA 1024 bit (not recommended)   |
+-----------------------+----------------------------------+
| Type\_RSA\_1024       | RSA 1024 bit (not recommended)   |
+-----------------------+----------------------------------+
| Type\_RSA\_2048       | RSA 2048 bit (not recommended)   |
+-----------------------+----------------------------------+
| Type\_RSA\_3072       | RSA 3072 bit                     |
+-----------------------+----------------------------------+
| Type\_RSA\_4096       | RSA 4096 bit                     |
+-----------------------+----------------------------------+
| Type\_RSA\_8192       | RSA 8192 bit                     |
+-----------------------+----------------------------------+
| Type\_EC\_SECP192R1   | 192-bits NIST curve              |
+-----------------------+----------------------------------+
| Type\_EC\_SECP224R1   | 224-bits NIST curve              |
+-----------------------+----------------------------------+
| Type\_EC\_SECP256R1   | 256-bits NIST curve              |
+-----------------------+----------------------------------+
| Type\_EC\_SECP384R1   | 384-bits NIST curve              |
+-----------------------+----------------------------------+
| Type\_EC\_SECP521R1   | 521-bits NIST curve              |
+-----------------------+----------------------------------+
| Type\_EC\_BP256R1     | 256-bits Brainpool curve         |
+-----------------------+----------------------------------+
| Type\_EC\_BP384R1     | 384-bits Brainpool curve         |
+-----------------------+----------------------------------+
| Type\_EC\_BP512R1     | 512-bits Brainpool curve         |
+-----------------------+----------------------------------+
| Type\_EC\_M221        | (not implemented yet)            |
+-----------------------+----------------------------------+
| Type\_EC\_M255        | Curve25519                       |
+-----------------------+----------------------------------+
| Type\_EC\_M383        | (not implemented yet)            |
+-----------------------+----------------------------------+
| Type\_EC\_M511        | (not implemented yet)            |
+-----------------------+----------------------------------+
| Type\_EC\_SECP192K1   | 192-bits "Koblitz" curve         |
+-----------------------+----------------------------------+
| Type\_EC\_SECP224K1   | 224-bits "Koblitz" curve         |
+-----------------------+----------------------------------+
| Type\_EC\_SECP256K1   | 256-bits "Koblitz" curve         |
+-----------------------+----------------------------------+

See a working example
`here... <https://github.com/VirgilSecurity/virgil-sdk-net/blob/master/Examples/Virgil.Examples/Crypto/GenerateKeyPair.cs>`__

Encrypt Data
------------

The procedure for encrypting and decrypting the data is simple. For
example:

If you want to encrypt the data to Bob, you encrypt it using Bob's
public key (which you can get from the Public Keys Service), and Bob
decrypts it with his private key. If Bob wants to encrypt some data to
you, he encrypts it using your public key, and you decrypt it with your
private key.

Crypto Library allows to encrypt the data for several types of
recipient's user data like public key and password. This means that you
can encrypt the data with some password or with a public key generated
with the Crypto Library.

Encrypt the text with a password:

.. code:: csharp

    var textToEncrypt = "Encrypt me, Please!!!";
    var password = "TafaSuf4";

    var cipherText = CryptoHelper.Encrypt(textToEncrypt, password);

Encrypt the text with a public key:

.. code:: csharp

    var keyPair = CryptoHelper.GenerateKeyPair();
    var cipherText = CryptoHelper.Encrypt(textToEncrypt, 
                                  "RecipientID",
                                  password);

And of course you can mix these types as well, see how it works in the
example below:

.. code:: csharp

    var textToEncrypt = "Encrypt me, Please!!!";
    byte[] cipherData;

    using (var cipher = new VirgilCipher())
    {
        cipher.AddPasswordRecipient(password);
        cipher.AddKeyRecipient(keyRecepinet.Id, keyRecepinet.PublicKey);

        cipherData = cipher.Encrypt(Encoding.UTF8.GetBytes(textToEncrypt), 
                                true);
    }

See a working example
`here... <https://github.com/VirgilSecurity/virgil-sdk-net/blob/master/Examples/Virgil.Examples/Crypto/EncryptWithPublicKey.cs>`__

Sign Data
---------

Cryptographic digital signatures use public key algorithms to provide
data integrity. When you sign the data with a digital signature, someone
else can verify the signature and can prove that the data originated
from you and was not altered after you had signed it.

The following example applies a digital signature to a public key
identifier.

.. code:: csharp

    var originalText = "Sign me, Please!!!";

    var keyPair = CryptoHelper.GenerateKeyPair();
    var signature = CryptoHelper.Sign(originalText, keyPair.PrivateKey());

See a working example
`here... <https://github.com/VirgilSecurity/virgil-sdk-net/blob/master/Examples/Virgil.Examples/Crypto/SingAndVerify.cs>`__

Verify Data
-----------

To verify that the data was signed by a particular party, you need the
following information:

-  the public key of the party that signed the data;
-  the digital signature;
-  the data that was signed.

The following example verifies a digital signature which was signed by
the sender.

.. code:: csharp

    var isValid = CryptoHelper.Verify(originalText, 
                           signature, 
                           keyPair.PublicKey());

See a working example
`here... <https://github.com/VirgilSecurity/virgil-sdk-net/blob/master/Examples/Virgil.Examples/Crypto/SingAndVerify.cs>`__

Decrypt Data
------------

The following example illustrates decryption of the encrypted data with
a recipient's private key.

.. code:: csharp

    var decryptedText = CryptoHelper.Decrypt(cipherText, 
                                        "RecipientId", 
                                        keyPair.PrivateKey());

Use a password to decrypt the data.

.. code:: csharp

    var decryptedText = CryptoHelper.Decrypt(cipherText, password);

See a working example
`here... <https://github.com/VirgilSecurity/virgil-sdk-net/blob/master/Examples/Virgil.Examples/Crypto/DecryptWithPrivateKey.cs>`__
