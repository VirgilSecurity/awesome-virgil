Go SDK Programming Guide
=============================

Creating a Virgil Card
----------------------

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

``appID`` and ``appKey`` parameters are required to create a **Virgil Card** in your app scope.

Collect App Credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~

Collect an ``appID`` and ``appKey`` for your app:

.. code-block:: go
    :linenos:

    appID := "[YOUR_APP_ID_HERE]"
    appKeyPassword := "[YOUR_APP_KEY_PASSWORD_HERE]"
    appKeyData, err := ioutil.ReadFile("[YOUR_APP_KEY_PATH_HERE]")

    appKey, err := crypto.ImportPrivateKey(appKeyData, appKeyPassword)

Generate New Keys
~~~~~~~~~~~~~~~~~~~

Generate a new Public/Private keypair using ``VirgilCrypto`` class:

.. code-block:: go
    :linenos:

    aliceKeys, err := crypto.GenerateKeypair()

Prepare Request
~~~~~~~~~~~~~~~

.. code-block:: go
    :linenos:

    //only the public key will be used from aliceKeys
    createCardRequest, err:= virgil.NewCreateCardRequest("alice", "username", aliceKeys.PublicKey(), enums.CardScope.Application, nil)

then, use ``RequestSigner`` class to sign request with owner's and app's keys:

.. code-block:: go
    :linenos:

    requestSigner := &virgil.RequestSigner{Crypto: crypto}

    err = requestSigner.SelfSign(createCardRequest, aliceKeys.PrivateKey())
    err = requestSigner.AuthoritySign(createCardRequest, appID, appKey)

Publish a Virgil Card
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: go
    :linenos:

    aliceCard, err := virgil.CreateCard(createCardRequest)

Search for Virgil Cards
---------------------------

You can search for **Virgil Cards** by identity value(s) and optional additional parameters can be set:

    - identity type ('email' or any type created by user). You can find more information about :term:`confirmed <Confirmed Card>` and :term:`unconfirmed <Unconfirmed Card>` **Virgil Cards**.
    - scope (by default it is 'application', can be 'global'). You can find more information about :term:`global <Global Virgil Card>` and :term:`application <Application Virgil Card>` **Virgil Cards**.

.. code-block:: go
    :linenos:

    client := virgil.NewClient("[YOUR_ACCESS_TOKEN_HERE]")
     
    cards = await client.SearchCardsAsync(criteria)

Validating a Virgil Card
---------------------------

You might want to make sure that a received **Virgil Card** wasn't changed, Public Key is authentic, or validate any other fields.
This sample uses built-in ``CardValidator`` to validate **Virgil Cards**. By default ``CardValidator`` validates only Cards Service signature.

.. code-block:: go
    :linenos:

    // Initialize crypto API
    crypto := virgil.NewCrypto()

    validator := virgil.NewCardsValidator(crypto)

    // Your can also add another Public Key for verification.
    // validator.AddVerifier("[HERE_VERIFIER_CARD_ID]", [HERE_VERIFIER_PUBLIC_KEY])

    // Initialize service client
        client := virgil.NewClient("[YOUR_ACCESS_TOKEN_HERE]")
        client.SetCardsValidator(validator)

        criteria := search.ByIdentities("alice", "bob")
        cards, err := client.SearchCards(criteria)

Revoking a Virgil Card
---------------------------

You can delete a **Virgil Card** in case the keys were compromised or lost, or for any other reason.

Initialize required components:

.. code-block:: go
    :linenos:

    client := virgil.NewClient("[YOUR_ACCESS_TOKEN_HERE]")
    crypto := virgil.NewCrypto()

    requestSigner := &virgil.RequestSigner{Crypto: crypto}
  
Collect an *App* credentials:

.. code-block:: go
    :linenos:

    appID := "[YOUR_APP_ID_HERE]"
    appKeyPassword := "[YOUR_APP_KEY_PASSWORD_HERE]"
    appKeyData, err := ioutil.ReadFile("[YOUR_APP_KEY_PATH_HERE]")

    appKey, err := crypto.ImportPrivateKey(appKeyData, appKeyPassword)

Prepare revocation request:

.. code-block:: go
    :linenos:

    cardId := "[YOUR_CARD_ID_HERE]"

    revokeRequest := virgil.NewRevokeCardRequest(cardId, enums.RevocationReason.Unspecified)
    requestSigner.AuthoritySign(revokeRequest, appID, appKey)

    err = client.RevokeCard(revokeRequest)


Operations with Crypto Keys
---------------------------

Generate Keys
~~~~~~~~~~~~~

You can generate a keypair using ``VirgilCrypto`` class. The default algorithm is ``ed25519``. 

.. code-block:: go
    :linenos:

    aliceKeys, err := crypto.GenerateKeypair()

Import and Export Keys
~~~~~~~~~~~~~~~~~~~~~~

If you need to import or export your Public/Private keys you can easily do it.
Simply call one of the Export methods:

.. code-block:: go
    :linenos:

    exportedPrivateKey, err := crypto.ExportPrivateKey(aliceKeys.PrivateKey(), "[YOUR_PASSWORD]")
    exportedPublicKey, err := crypto.ExportPublicKey(aliceKeys.PublicKey())

To import Public/Private keys, simply call one of the Import methods:

.. code-block:: go
    :linenos:
    
    privateKey, err := crypto.ImportPrivateKey(exportedPrivateKey, "[YOUR_PASSWORD]")  
    publicKey, err := crypto.ImportPublicKey(exportedPublicKey)

Encryption and Decryption
---------------------------

Initialize Crypto API and generate keypair.

.. code-block:: go
    :linenos:

    crypto := virgil.NewCrypto()
    aliceKeys, err := crypto.GenerateKeypair()

Encrypt Data
~~~~~~~~~~~~

You can enrypt some data, ECIES scheme with ``AES-GCM`` is used in **Virgil Security**. You have several options for encryption:

    - stream encryption;
    - byte array encryption;
    - one recipient;
    - multiple recipients (public keys of every user are used for encryption).

*Byte Array*

.. code-block:: go
    :linenos:

    plaintext := []byte("Hello Bob!")
    cipherData, err := crypto.Encrypt(plaintext, aliceKeys.PublicKey())

*Stream*

.. code-block:: go
    :linenos:

    inputStream, err := os.Open(`[YOUR_FILE_PATH_HERE]`)

    if(err != nil){
        panic(err)
    }
    defer inputStream.Close()

    cipherStream, err := os.Create(`[YOUR_FILE_PATH_HERE]`)

    if(err != nil){
        panic(err)
    }
    defer cipherStream.Close()
        
    err = crypto.EncryptStream(inputStream, cipherStream, aliceKeys.PublicKey())
     
Decrypt Data
~~~~~~~~~~~~

You can decrypt data using your private key. You have such options for decryption: 

    - stream;
    - byte array.

*Byte Array*

.. code-block:: go
    :linenos:

    //aliceKeys must contain private key
     crypto.Decrypt(cipherData, aliceKeys.PrivateKey())

*Stream*

.. code-block:: go
    :linenos:

    crypto := virgil.NewCrypto()

    cipherStream, err := os.Open(`[YOUR_FILE_PATH_HERE]`)

    if(err != nil){
        panic(err)
    }
    defer cipherStream.Close()

    resultStream, err := os.Create(`[YOUR_FILE_PATH_HERE]`)

    if(err != nil){
        panic(err)
    }
    defer resultStream.Close()
        
    err = crypto.DecryptStream(cipherStream, resultStream, aliceKeys.PrivateKey())


Generating and Verifying Signatures
-----------------------------------

Generate a new Public/Private keypair and ``data`` to be signed.

.. code-block:: go
    :linenos:

    crypto := virgil.NewCrypto()
    aliceKeys, err := crypto.GenerateKeypair()

    // The data to be signed with alice's Private key
    data = []byte("Hello Bob, How are you?")

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~

You can generate a digital signature for data. Options for signing data:

    - stream;
    - byte array.

*Byte Array*

.. code-block:: go
    :linenos:

    signature, err := crypto.Sign(data, aliceKeys.PrivateKey())

*Stream*

.. code-block:: go
    :linenos:

    inputStream, err := os.Open(`[YOUR_FILE_PATH_HERE]`)

        if(err != nil){
            panic(err)
        }
        defer inputStream.Close()
        
        signature, err := crypto.Sign(inputStream, aliceKeys.PrivateKey())

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~

You can verify that a signature is authentic. You will verify the signature of the ``SHA-384`` fingerprint using the public key. Options for verification:

    - stream;
    - byte array.

*Byte Array*

.. code-block:: go
    :linenos:

    isValid, err := crypto.Verify(data, signature, aliceKeys.PublicKey())

*Stream*
     
.. code-block:: go
    :linenos:

    inputStream, err := os.Open(`[YOUR_FILE_PATH_HERE]`)

    if(err != nil){
        panic(err)
    }
    defer inputStream.Close()
        
    isValid, err := crypto.VerifyStream(inputStream, signature, aliceKeys.PublicKey())


Fingerprint Generation
----------------------

The default Fingerprint algorithm is ``SHA-256``.

.. code-block:: go
    :linenos:

    crypto := virgil.NewCrypto()
    fingerprint := crypto.CalculateFingerprint(content)

High level API
--------------

This API provides a simple way of managing **Virgil Cards**, encrypting data
and verifying signatures

Global configuration
~~~~~~~~~~~~~~~~~~~~

.. code-block:: go
    :linenos:

    virgil.InitConfig("[YOUR_TOKEN_HERE]")

That's it.

Creating a Virgil Card with High level API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

First, generate a new keypair:

.. code-block:: go
    :linenos:

    crypto := virgil.NewCrypto()
    aliceKeypair, _ := crypto.GenerateKeypair()

Then, create a new card request and self-sign it:

.. code-block:: go
    :linenos:

    req, _ := virgil.NewCreateCardRequest("username", "Alice", aliceKeypair.PublicKey(), enums.CardScope.Application, nil)
    signer := virgil.Config.Signer
    signer.SelfSign(req, aliceKeypair.PrivateKey())

You will need to also sign the ``card create request`` with your
application's private key:

.. code-block:: go
    :linenos:

    signer.AuthoritySign(req, appCardID, appPrivateKey)

After you have yours and application signatures you can push the request
to server and create a **Virgil Card**.

.. code-block:: go
    :linenos:

    card, _ := virgil.CreateCard(req)

Searching for a Virgil Card with High level API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can get a **Virgil Card** by its ID:

.. code-block:: go
    :linenos:

    card, err := virgil.GetCard(c.ID)

Or search your application cards using identities:

.. code-block:: go
    :linenos:

    cards, err := virgil.FindCards("username", "Alice")

You may also search for other **Global Virgil Cards**, for example other
Application card:

.. code-block:: go
    :linenos:

    cards, err := virgil.FindGlobalCards("application", "com.virgil.security")

Revoking a Virgil Card with High level API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You will need card's ID and Application's signature.

.. code-block:: go
    :linenos:

    revreq := virgil.NewRevokeCardRequest(card.ID, enums.RevocationReason.Unspecified)
    signer.AuthoritySign(revreq, appCard.ID, appPrivateKey)
    err := virgil.RevokeCard(revreq)

Encrypting data with High level API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All you need is a receiver's Virgil Card.

.. code-block:: go
    :linenos:

    plaintext := []byte("Hello, Bob!")
    encryptedData, err := bobCard.Encrypt(plaintext)

Verifying data signature with High level API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: go
    :linenos:

    plaintext := []byte("Hello, Bob!")
    verifyResult, err := bobCard.Verify(plaintext, signature)

See Also: 
---------
`Source code <https://github.com/VirgilSecurity/virgil-sdk-go>`__