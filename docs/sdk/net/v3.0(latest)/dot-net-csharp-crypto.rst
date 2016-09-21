============
Tutorial Crypto Library .NET/C#
============

-  `Install`_
-  `Generate Keys`_
-  `Encrypt Data`_
-  `Sign Data`_
-  `Verify Data`_
-  `Decrypt Data`_

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

`Virgil and Twilio IP Messaging Demo Code`_ and check out working demo:

`End to End Encrypted IP Messaging with Twilio API + Virgil`_

Quickstart guide for making your own E2E encrypted IP Messaging is:
`here`_

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

+------------------+----------------------------------+
| Key Type         | Description                      |
+==================+==================================+
| Type\_Default    | recommended safest type          |
+------------------+----------------------------------+
| Type\_RSA\_256   | RSA 1024 bit (not recommended)   |
+------------------+----------------------------------+
| Type\_RSA\_512   |
+------------------+----------------------------------+

.. _Install: #install
.. _Generate Keys: #generate-keys
.. _Encrypt Data: #encrypt-data
.. _Sign Data: #sign-data
.. _Verify Data: #verify-data
.. _Decrypt Data: #decrypt-data
.. _Virgil and Twilio IP Messaging Demo Code: https://github.com/VirgilSecurity/virgil-demo-twilio
.. _End to End Encrypted IP Messaging with Twilio API + Virgil: http://virgil-twilio-demo.azurewebsites.net/
.. _here: https://github.com/VirgilSecurity/virgil-demo-twilio/tree/master/ip-messaging
