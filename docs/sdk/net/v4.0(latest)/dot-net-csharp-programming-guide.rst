.NET/C# SDK Programming Guide
=============================

Creating a Virgil Card
----------------------

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

``appID`` and ``appKey`` parameters are required to create a **Virgil Card** in your app scope.

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

.. code-block:: csharp
    :linenos:

    var aliceKeys = crypto.GenerateKeys();

Prepare Request
~~~~~~~~~~~~~~~

.. code-block:: csharp
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

.. code-block:: csharp
    :linenos:

    var aliceCard = await client.CreateCardAsync(createCardRequest);


Search for Virgil Cards
---------------------------

You can search for **Virgil Cards** by identity value(s) and optional additional parameters can be set:

    - identity type ('email' or any type created by user). You can find more information about :term:`confirmed <Confirmed Identity>` and :term:`uncofirmed <Unconfirmed Identity>` **Virgil Cards**.
    - scope (by default it is 'application', can be 'global'). You can find more information about :term:`global <Global Virgil Card>` and :term:`application <Application Virgil Card>` **Virgil Cards**.

.. code-block:: csharp
    :linenos:

    var client = new VirgilClient("[YOUR_ACCESS_TOKEN_HERE]");

    var criteria = SearchCriteria.ByIdentities("alice", "bob");

    var cards = await client.SearchCardsAsync(criteria);

Validating a Virgil Card
---------------------------

You might want to make sure that a received **Virgil Card** wasn't changed, Public Key is authentic, or validate any other fields.
This sample uses built-in ``CardValidator`` to validate **Virgil Cards**. By default ``CardValidator`` validates only Cards Service signature.

.. code-block:: csharp
    :linenos:

    // Initialize crypto API
    var crypto = new VirgilCrypto();

    var validator = new CardValidator(crypto);

    // Your can also add another Public Key for verification.
    // validator.AddVerifier("[HERE_VERIFIER_CARD_ID]", [HERE_VERIFIER_PUBLIC_KEY]);

    // Initialize service client
    var client = new VirgilClient("[YOUR_ACCESS_TOKEN_HERE]");
    client.SetCardValidator(validator);

    try
    {
        var criteria = SearchCriteria.ByIdentities("alice", "bob");
        var cards = await client.SearchCardsAsync(criteria);
    }
    catch (CardValidationException ex)
    {
        // ex.InvalidCards
    }

Revoking a Virgil Card
---------------------------

You can delete a **Virgil Card** in case the keys were compromised or lost, or for any other reason.

Initialize required components:

.. code-block:: csharp
    :linenos:

    var client = new VirgilClient("[YOUR_ACCESS_TOKEN_HERE]");
    var crypto = new VirgilCrypto();
    
    var requestSigner = new RequestSigner(crypto);
  
Collect an *App* credentials:

.. code-block:: csharp
    :linenos:

    var appID = "[YOUR_APP_ID_HERE]";
    var appKeyPassword = "[YOUR_APP_KEY_PASSWORD_HERE]";
    var appKeyData = File.ReadAllBytes("[YOUR_APP_KEY_PATH_HERE]");
     
    var appKey = crypto.ImportPrivateKey(appKeyData, appKeyPassword);

Prepare revocation request:

.. code-block:: csharp
    :linenos:

    var cardId = "[YOUR_CARD_ID_HERE]";
 
    var revokeRequest = new RevokeCardRequest(cardId, RevocationReason.Unspecified);
    requestSigner.AuthoritySign(revokeRequest, appID, appKey);
     
    await client.RevokeCardAsync(revokeRequest);


Operations with Crypto Keys
---------------------------

Generate Keys
~~~~~~~~~~~~~

You can generate a keypair using ``VirgilCrypto`` class. The default algorithm is ``ed25519``. 

.. code-block:: csharp
    :linenos:

     var aliceKeys = crypto.GenerateKeys();

Import and Export Keys
~~~~~~~~~~~~~~~~~~~~~~

If you need to import or export your Public/Private keys you can easily do it.
Simply call one of the Export methods:

.. code-block:: csharp
    :linenos:

     var exportedPrivateKey = crypto.ExportPrivateKey(aliceKeys.PrivateKey);
     var exportedPublicKey = crypto.ExportPublicKey(aliceKeys.PublicKey);

To import Public/Private keys, simply call one of the Import methods:

.. code-block:: csharp
    :linenos:

      var privateKey = crypto.ImportPrivateKey(exportedPrivateKey);  
      var publicKey = crypto.ImportPublicKey(exportedPublicKey);


Encryption and Decryption
---------------------------

Initialize Crypto API and generate keypair.

.. code-block:: csharp
    :linenos:

    var crypto = new VirgilCrypto();
    var aliceKeys = crypto.GenerateKeys();

Encrypt Data
~~~~~~~~~~~~

You can enrypt some data, ECIES scheme with ``AES-GCM`` is used in **Virgil Security**. You have several options for encryption:

    - stream encryption;
    - byte array encryption;
    - one recipient;
    - multiple recipients (public keys of every user are used for encryption).

*Byte Array*

.. code-block:: csharp
    :linenos:

    var plaintext = Encoding.UTF8.GetBytes("Hello Bob!");
    var cipherData = crypto.Encrypt(plaintext, aliceKeys.PublicKey);

*Stream*

.. code-block:: csharp
    :linenos:

    using (var inputStream = new FileStream("[YOUR_FILE_PATH_HERE]", FileMode.Open))
    using (var cipherStream = new FileStream("[YOUR_ENCRYPTED_FILE_PATH_HERE]", FileMode.Create))
    {
        crypto.Encrypt(inputStream, cipherStream, aliceKeys.PublicKey);
    }
     
Decrypt Data
~~~~~~~~~~~~

You can decrypt data using your private key. You have such options for decryption: 

    - stream;
    - byte array.

*Byte Array*

.. code-block:: csharp
    :linenos:

    crypto.Decrypt(cipherData, aliceKeys.PrivateKey);

*Stream*

.. code-block:: csharp
    :linenos:

    using (var cipherStream = new FileStream("[YOUR_ENCRYPTED_FILE_PATH_HERE]", FileMode.Open))
    using (var resultStream = new FileStream("[YOUR_DECRYPTED_FILE_PATH_HERE]", FileMode.Create))
    {
        crypto.Decrypt(cipherStream, resultStream, aliceKeys.PrivateKey);
    }

Generating and Verifying Signatures
-----------------------------------

Generate a new Public/Private keypair and ``data`` to be signed.

.. code-block:: csharp
    :linenos:

    var crypto = new VirgilCrypto();
    var alice = crypto.GenerateKeys();

    // The data to be signed with alice's Private key
    var data = Encoding.UTF8.GetBytes("Hello Bob, How are you?");

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~

You can generate a digital signature for data. Options for signing data:

    - stream;
    - byte array.

*Byte Array*

.. code-block:: csharp
    :linenos:

    var signature = crypto.Sign(data, alice.PrivateKey);

*Stream*

.. code-block:: csharp
    :linenos:

    var fileStream = File.Open("[YOUR_FILE_PATH_HERE]", FileMode.Open, FileAccess.Read, FileShare.None);
    using (fileStream)
    {
        var signature = crypto.Sign(inputStream, alice.PrivateKey);
    }

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~

You can verify that a signature is authentic. You will verify the signature of the ``SHA-384`` fingerprint using the public key. Options for verification:

    - stream;
    - byte array.

*Byte Array*

.. code-block:: csharp
    :linenos:

     var isValid = crypto.Verify(data, signature, alice.PublicKey);
     
*Stream*
     
.. code-block:: csharp
    :linenos:    

    var fileStream = File.Open("[YOUR_FILE_PATH_HERE]", FileMode.Open, FileAccess.Read, FileShare.None);
    using (fileStream)
    {
        var isValid = crypto.Verify(fileStream, signature, alice.PublicKey);
    }


Fingerprint Generation
----------------------

The default Fingerprint algorithm is ``SHA-256``.

.. code-block:: csharp
    :linenos:

    var crypto = new VirgilCrypto();

    var fingerprint = crypto.CalculateFingerprint(content);

See Also: 
---------
`Source code <https://github.com/VirgilSecurity/virgil-sdk-net>`__