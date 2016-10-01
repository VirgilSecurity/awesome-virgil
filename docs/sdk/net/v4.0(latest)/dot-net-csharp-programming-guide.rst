.NET/C# SDK Programming Guide
=============================
..    -  `Creating a Virgil Card <#creating-a-virgil-card>`__
..        -  `Collect App Credentials <#collect-app-creadentials>`__
..        -  `Generate New Keys <#generate-new-keys>`__
..        -  `Prepare Request <#prepare-request>`__
..        -  `Publish a Virgil Card <#publish-a-virgil-card>`__
..    -  `Search for Virgil Cards <#search-for-virgil-cards>`__
..    -  `Revoking a Virgil Card <#revoking-a-virgil-card>`__
..    -  `Operations with Crypto Keys <#operations-with-crypto-keys>`__
..        -  `Generate Keys <#generate-keys>`__
..        -  `Import and Export Keys <#import-and-export-keys>`__
..    -  `Encryption and Decryption <#encryption-and-decryption>`__
..        -  `Encrypt Data <#encrypt-data>`__
..        -  `Decrypt Data <#decrypt-data>`__
..    -  `Generating and Verifying Signatures <#generating-and-verifying-signatures>`__
..        -  `Generating a Signature <#generating-a-signature>`__
..        -  `Verifying a Signature <#verifying-a-signature>`__
..    -  `Fingerprint Generation <#fingerprint-generation>`__
..    -  `See Also <#see-also>`__


Creating a Virgil Card
----------------------

Collect App Credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~

Collect an ``appID`` and ``appKey`` for your app:

.. code-block:: csharp
    :linenos:

    var appID = "[YOUR_APP_ID_HERE]";
    var appKeyPassword = "[YOUR_APP_KEY_PASSWORD_HERE]";
    var appKeyData = File.ReadAllBytes("[YOUR_APP_KEY_PATH_HERE]");

    var appKey = crypto.ImportPrivateKey(appKeyData, appKeyPassword);

Generate New Keys
~~~~~~~~~~~~~~~~~~~

Generate a new Public/Private keypair using ``VirgilCrypto`` class:

.. code:: csharp
:linenos:

    var aliceKeys = crypto.GenerateKeys();

Prepare Request
~~~~~~~~~~~~~~~

.. code:: csharp
    :linenos:

    var exportedPublicKey = crypto.ExportPublicKey(aliceKeys.PublicKey);
    var createCardRequest = new CreateCardRequest("alice", "username", exportedPublicKey);

then, use ``RequestSigner`` class to sign request with owner's and app's keys:

.. code-block:: csharp
:linenos:

    var requestSigner = new RequestSigner(crypto);

    requestSigner.SelfSign(createCardRequest, aliceKeys.PrivateKey);
    requestSigner.AuthoritySign(createCardRequest, appID, appKey);

Publish a Virgil Card
~~~~~~~~~~~~~~~~~~~~~

.. code:: csharp

    var aliceCard = await client.CreateCardAsync(createCardRequest);


Search for Virgil Cards
---------------------------

.. code:: csharp

    var client = new VirgilClient("[YOUR_ACCESS_TOKEN_HERE]");

    var criteria = new SearchCardsCriteria
    {
        Identities = new[] { "alice", "bob" },
        IdentityType = "username",
        Scope = VirgilCardScope.Application
    };

    var cards = await client.SearchCardsAsync(criteria);


Revoking a Virgil Card
---------------------------

Initialize required components:

.. code:: csharp

    var client = new VirgilClient("[YOUR_ACCESS_TOKEN_HERE]");
    var crypto = new VirgilCrypto();
    
    var requestSigner = new RequestSigner(crypto);
  
Collect an *App* credentials:

.. code:: csharp

    var appID = "[YOUR_APP_ID_HERE]";
    var appKeyPassword = "[YOUR_APP_KEY_PASSWORD_HERE]";
    var appKeyData = File.ReadAllBytes("[YOUR_APP_KEY_PATH_HERE]");
     
    var appKey = crypto.ImportPrivateKey(appKeyData, appKeyPassword);

Prepare revocation request:

.. code:: csharp

    var cardId = "[YOUR_CARD_ID_HERE]";
 
    var revokeRequest = new RevokeCardRequest(cardId, RevocationReason.Unspecified);
    requestSigner.AuthoritySign(revokeRequest, appID, appKey);
     
    await client.RevokeCardAsync(revokeRequest);


Operations with Crypto Keys
---------------------------

Generate Keys
~~~~~~~~~~~~~

The following code sample illustrates keypair generation (default algorithm is ``ed25519``):

.. code:: csharp

     var aliceKeys = crypto.GenerateKeys();

Import and Export Keys
~~~~~~~~~~~~~~~~~~~~~~

To export Public/Private keys, simply call one of the Export methods:

.. code:: csharp

     var exportedPrivateKey = crypto.ExportPrivateKey(aliceKeys.PrivateKey);
     var exportedPublicKey = crypto.ExportPublicKey(aliceKeys.PublicKey);

To import Public/Private keys, simply call one of the Import methods:

.. code:: csharp

      var privateKey = crypto.ImportPrivateKey(exportedPrivateKey);  
      var publicKey = crypto.ImportPublicKey(exportedPublicKey);


Encryption and Decryption
---------------------------

Encrypt Data
~~~~~~~~~~~~

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

Generate a new Public/Private keypair and ``data`` to be signed.

.. code:: csharp

    var alice = crypto.GenerateKeys();

    // The data to be signed with alice's Private key
    var data = Encoding.UTF8.GetBytes("Hello Bob, How are you?");

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~

To generate the signature, simply call one of the sign methods:

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

The signature can now be verified by calling the verify method:

*Byte Array*

.. code:: csharp

     var isValid = crypto.Verify(data, signature, alice.PublicKey);
     
*Stream*
     
.. code:: csharp     

    var fileStream = File.Open("[YOUR_FILE_PATH_HERE]", FileMode.Open, FileAccess.Read, FileShare.None);
    using (fileStream)
    {
        var isValid = crypto.Verify(fileStream, signature, alice.PublicKey);
    }


Fingerprint Generation
----------------------

.. code:: csharp

    var fingerprint = crypto.CalculateFingerprint(content);

See Also: 
---------
`Source code <https://github.com/VirgilSecurity/virgil-sdk-net>`__