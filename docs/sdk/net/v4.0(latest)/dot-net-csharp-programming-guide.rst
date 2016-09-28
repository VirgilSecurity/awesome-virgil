.NET/C# SDK Programming Guide
=============================

-  `Creating a Virgil Card <#creating-a-virgil-card>`__
-  `Collect an App Credentials <#collect-an-app-creadentials>`__
-  `Generate a new Keys <#generate-a-new-keys>`__
-  `Prepare Request <#prepare-request>`__
-  `Publish a Virgil Card <#publish-a-virgil-card>`__
-  `Search for the Virgil Cards <#search-for-the-virgil-cards>`__
-  `Revoking a Virgil Card <#revoking-a-virgil-card>`__
-  `Operations with Crypto Keys <#operations-with-crypto-keys>`__
-  `Keys Generation <#keys_generation>`__
-  `Import and Export Keys <#import-and-export-keys>`__
-  `Encryption and Decryption <#encryption-and-decryption>`__
-  `Encryption <#encryption>`__
-  `Decryption <#decryption>`__
-  `Generating and Verifying Signatures <#generating-and-verifying-signatures>`__
-  `Generating a Signature <#generating-a-signature>`__
-  `Verifying a Signature <#verifying-a-signature>`__
-  `Fingerprint Generation <#fingerprint-generation>`__


Creating a Virgil Card
----------------------

A **Virgil Card** is the main entity of the Virgil services, it includes the information about the user and his public key. The **Virgil Card** identifies the user/device by one of his types.

Collect an App Credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~

Collect an ``appID`` and ``appKey`` for your app. These parametes are required to create a **Virgil Card** in your app scope.

.. code:: csharp

    var appID = "[YOUR_APP_ID_HERE]";
    var appKeyPassword = "[YOUR_APP_KEY_PASSWORD_HERE]";
    var appKeyData = File.ReadAllBytes("[YOUR_APP_KEY_PATH_HERE]");

    var appKey = crypto.ImportPrivateKey(appKeyData, appKeyPassword);

Generate a new Keys
~~~~~~~~~~~~~~~~~~~

Generate a new Public/Private keypair using ``VirgilCrypto`` class.

.. code:: csharp

    var aliceKeys = crypto.GenerateKeys();

Prepare Request
~~~~~~~~~~~~~~~

.. code:: csharp

    var exportedPublicKey = crypto.ExportPublicKey(aliceKeys.PublicKey);
    var creationRequest = CreateCardRequest.Create("alice", "username", exportedPublicKey);

then, you need to calculate fingerprint of request that will be used in the future as Virgil Card ID.

.. code:: csharp

    var fingerprint = crypto.CalculateFingerprint(creationRequest.Snapshot);

then, sign the fingerprint request with both owner's and app's keys.

.. code:: csharp

    var ownerSignature = crypto.Sign(fingerprint, aliceKeys.PrivateKey);
    var appSignature = crypto.Sign(fingerprint, appKey);

    request.AppendSignature(fingerprint, ownerSignature);
    request.AppendSignature(appID, appSignature);

Publish a Virgil Card
~~~~~~~~~~~~~~~~~~~~~

.. code:: csharp

    var aliceCard = await client.RegisterCardAsync(request);

Search for the Virgil Cards
---------------------------

Performs the **Virgil Cards** search by criteria: 

- ``Identities`` request parameter is mandatory; 
- ``IdentityType`` request parameter is optional and specifies the ``IdentityType`` of a **Virgil Cards** to be found; 
- ``Scope`` optional request parameter specifies the scope to perform search on. Either 'global' or 'application'. The default value is 'application'

.. code:: csharp

    var client = new VirgilClient("[YOUR_ACCESS_TOKEN_HERE]");

    var criteria = new SearchCardsCriteria
    {
        Identities = new[] { "alice", "bob" },
        IdentityType = "username",
        Scope = VirgilCardScope.Application
    };

    var cards = await client.SearchCardsAsync(criteria);

Operations with Crypto Keys
---------------------------

Generate Keys
~~~~~~~~~~~~~

The following code sample illustrates keypair generation. The default algorithm is ``ed25519``

.. code:: csharp

     var aliceKeys = crypto.GenerateKeys();

Import/Export Keys
~~~~~~~~~~~~~~~~~~

You can export and import your Public/Private keys to/from supported wire representation.

To export Public/Private keys, simply call one of the Export methods:

.. code:: csharp

     var exportedPrivateKey = crypto.ExportPrivateKey(aliceKeys.PrivateKey);
     var exportedPublicKey = crypto.ExportPublicKey(aliceKeys.PublicKey);

To import Public/Private keys, simply call one of the Import methods:

.. code:: csharp

      var privateKey = crypto.ImportPrivateKey(exportedPrivateKey);  
      var publicKey = crypto.ImportPublicKey(exportedPublicKey);

Encrypt Data
~~~~~~~~~~~~

Data encryption using ECIES scheme with ``AES-GCM``. You can encrypt either stream or a byte array. There also can be more than one recipient

.. code:: csharp

     var plaintext = new byte[100]
     var ciphertext = crypto.Encrypt(plaintext, alice.PublicKey, bob.PublicKey)
     
      using (FileStream in = File.Open(path, FileMode.Open, FileAccess.Read, FileShare.None))
      using (FileStream out = File.Open(path, FileMode.Open, FileAccess.Write, FileShare.None)) 
            {
             crypto.Encrypt(in, out, alice.PublicKey, bob.PublicKey)
            }
     

Decrypt Data
~~~~~~~~~~~~

You can decrypt either stream or a byte array using your private key

.. code:: csharp

     var ciphertext = new byte[100]{...}
     var plaintext = crypto.Decrypt(ciphertext, alice.PrivateKey)
     
      using (FileStream in = File.Open(path, FileMode.Open, FileAccess.Read, FileShare.None))
      using (FileStream out = File.Open(path, FileMode.Open, FileAccess.Write, FileShare.None)) 
            {
             crypto.Decrypt(in, out, alice.PrivateKey)
            }
     

Generating and Verifying Signatures
-----------------------------------

This section walks you through the steps necessary to use the **VirgilCrypto** to generate a digital signature for data and to verify that a signature is authentic.

Generate a new Public/Private keypair and ``data`` to be signed.

.. code:: csharp

    var alice = crypto.GenerateKeys();

    // The data to be signed with alice's Private key
    var data = Encoding.UTF8.GetBytes("Hello Bob, How are you?");

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~

Sign the ``SHA-384`` fingerprint of either stream or a byte array using your private key. To generate the signature, simply call one of the sign method:

*Byte Array*

.. code:: csharp

    var signature = crypto.Sign(data, alice.PrivateKey);

*Stream*

.. code:: csharp

    var fileStream = File.Open("[YOUR_FILE_PATH_HERE]", FileMode.Open, FileAccess.Read, FileShare.None);
    using (fileStream)
    {
        var signature = crypto.Sign(inputStream, alice.PrivateKey);
    }

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~

Verify the signature of the ``SHA-384`` fingerprint of either stream or a byte array using Public key. The signature can now be verified by calling the verify method:

*Byte Array*

.. code:: csharp

     var isValid = crypto.Verify(data, signature, alice.PublicKey);
     ```
     
     *Stream*
     
     ```csharp
    var fileStream = File.Open("[YOUR_FILE_PATH_HERE]", FileMode.Open, FileAccess.Read, FileShare.None);
    using (fileStream)
    {
        var isValid = crypto.Verify(fileStream, signature, alice.PublicKey);
    }

Fingerprint Generation
----------------------

The default Fingerprint algorithm is ``SHA-256``. The hash is then converted to HEX

.. code:: csharp

    var fingerprint = crypto.CalculateFingerprint(content);
