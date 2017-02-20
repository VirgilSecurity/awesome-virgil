Programming Guide
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

    requestSigner := virgil.NewRequestSigner()

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
    crypto := virgil.Crypto()

    validator := virgil.NewCardsValidator()

    // Your can also add another Public Key for verification.
    // validator.AddVerifier("[HERE_VERIFIER_CARD_ID]", [HERE_VERIFIER_PUBLIC_KEY])

    // Initialize service client
        client := virgil.NewClient("[YOUR_ACCESS_TOKEN_HERE]")
        client.SetCardsValidator(validator)

        criteria := search.ByIdentities("alice", "bob")
        cards, err := client.SearchCards(criteria)

Get a Virgil Card
---------------------------

Gets a Virgil Card by ID.

.. code-block:: go
    :linenos:

    client := virgil.NewClient("[YOUR_ACCESS_TOKEN_HERE]")
    card, err := client.GetCard("CARD_ID")

Revoking a Virgil Card
---------------------------

You can delete a **Virgil Card** in case the keys were compromised or lost, or for any other reason.

Initialize required components:

.. code-block:: go
    :linenos:

    client := virgil.NewClient("[YOUR_ACCESS_TOKEN_HERE]")
    crypto := virgil.Crypto()

    requestSigner := &virgil.RequestSigner{}
  
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

    crypto := virgil.Crypto()
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

    crypto := virgil.Crypto()

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

    crypto := virgil.Crypto()
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

Authenticated Encryption
------------------------

Authenticated encryption provides both data confidentiality and data integrity assurances that the information is protected.

.. code-block:: go
    :linenos:

    crypto := virgil.Crypto()
    aliceKeys, err := crypto.GenerateKeypair()
    bobKeys, err := crypto.GenerateKeypair()
  
    // The data to be signed with alice's Private key
    data = []byte("Hello Bob, How are you?")

Sign then Encrypt
~~~~~~~~~~~~~~~~~

.. code-block:: go
    :linenos:

    ciphertext, err := crypto.SignThenEncrypt(data, aliceKeys.PrivateKey(), bobKeys.PublicKey())

Decrypt then Verify
~~~~~~~~~~~~~~~~~~~

.. code-block:: go
    :linenos:

    plaintext, err := crypto.DecryptThenVerify(data, bobKeys.PrivateKey(), aliceKeys.PublicKey());

Fingerprint Generation
----------------------

The default Fingerprint algorithm is ``SHA-256``.

.. code-block:: go
    :linenos:

    crypto := virgil.Crypto()
    fingerprint := crypto.CalculateFingerprint(content)

High level API
--------------

This API provides a simple way of managing **Virgil Cards**, encrypting data
and verifying signatures

High Level API Configuration
~~~~~~~~~~~~~~~~~~~~

.. code-block:: go
    :linenos:

    api, err := virgilapi.New("[YOUR_ACCESS_TOKEN_HERE]")

.. code-block:: go
    :linenos

    api, err := virgilapi.NewWithConfig(virgilapi.Config{
        Token: "AT.[YOUR_ACCESS_TOKEN_HERE]",
        Credentials: &virgilapi.AppCredentials{
            AppId:      appCardID,
            PrivateKey: virgilapi.BufferFromString(appPrivateKey),
        },
        CardVerifiers: map[string]virgilapi.Buffer{
            cardServiceID: virgilapi.BufferFromString(cardsServicePublicKey),
        },
    })

That's it.

Register Global Virgil Card using High-Level API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

First, generate a new Key:

.. code-block:: go
    :linenos:

    // generate a new Alice's Key
    aliceKey, err := api.Keys.Generate()

    // save the Key to default storage
    err = aliceKey.Save("[KEY_NAME]", "[KEY_PASSWORD]")

Then, create a new Virgil Card and self-sign it using `aliceKey`:

.. code-block:: go
    :linenos:

    // create Alice's Card using her newly generated Key.
    aliceCard, err := api.Cards.CreateGlobal("alice@virgilsecurity.com", aliceKey)

Verify an identity using method `VerifyIdentity`

.. code-block:: go
    :linenos:

    // initiate an identity verification process.
    attempt, err := aliceCard.VerifyIdentity()

    // confirm a Alice's Card identity using confirmation code retrived on the email.
    token, err := attempt.Confirm("[CONFIRMATION_CODE]")

Publish Alice's Card to Virgil Services using `VirgilApi`

.. code-block:: go
    :linenos:

    // publish a Card on the Virgil Security services.
    aliceCard, err = api.Cards.PublishGlobal(aliceCard, token)

Revoking Global Virgil Card with High level API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: go
    :linenos:

    // initialize Virgil SDK high-level
    api, err := virgilapi.New("[YOUR_ACCESS_TOKEN_HERE]")

    // load alice's Key from secure storage provided by default.
    aliceKey, err = api.Keys.Load("[KEY_NAME]", "[KEY_PASSWORD]")

    // load alice's Card from Virgil Security services.
    aliceCard, err = api.Cards.Get("[ALICE_CARD_ID]")

    // initiate Card's identity verification process.
    attempt, err = aliceCard.VerifyIdentity()

    token, err = attempt.Confirm("[CONFIRMATION_CODE]")

    // revoke Virgil Card from Virgil Security services.
    err = api.Cards.RevokeGlobal(aliceCard, virgil.RevocationReason.Unspecified, aliceKey, token)

Register Virgil Card using High-Level API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

First, generate a new Key:

.. code-block:: go
    :linenos:

    // generate a new Alice's Key
    aliceKey, err := api.Keys.Generate()

    // save the Key to default storage
    err = aliceKey.Save("[KEY_NAME]", "[KEY_PASSWORD]")

Then, create a new Virgil Card and self-sign it using `aliceKey`:

.. code-block:: go
    :linenos:

    // create Alice's Card using her newly generated Key.
    aliceCard, err := api.Cards.Create("alice@virgilsecurity.com", aliceKey)

Transmit alice's Card to the server side where it will be signed, validated and published on the Virgil Services.

.. code-block:: go
    :linenos:
   
    // export alice's Card to string
    exportedAliceCard, err := aliceCard.Export()

Publish Alice's Card on server side:

.. code-block:: go
    :linenos:

    // initialize Virgil SDK high-level instance.
    api, err := virgilapi.NewWithConfig(virgilapi.Config{
            Token: "AT.[YOUR_ACCESS_TOKEN_HERE]",
            Credentials: &virgilapi.AppCredentials{
                AppId:      appCardID,
                PrivateKey: virgilapi.BufferFromString(appPrivateKey),
            },
        })

    // import alice's Card from its string representation.
    aliceCard, err := api.Cards.Import(exportedAliceCard)

    // verify alice's Card information before publishing it on the Virgil services.

    // aliceCard.Identity
    // aliceCard.IdentityType
    // aliceCard.Data
    // aliceCard.Info

    // publish alice's Card on Virgil Services
    publishedCard, err := api.Cards.Publish(aliceCard)

Revoking Virgil Card with High level API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You will need card's ID and Application's credentials.

.. code-block:: go
    :linenos:

    // initialize Virgil SDK high-level instance.
    api, err := virgilapi.NewWithConfig(virgilapi.Config{
        Token: "AT.[YOUR_ACCESS_TOKEN_HERE]",
        Credentials: &virgilapi.AppCredentials{
            AppId:      appCardID,
            PrivateKey: virgilapi.BufferFromString(appPrivateKey),
        },
    })

    // get alice's Card by ID
    aliceCard, err := api.Cards.Get("[ALICE_CARD_ID]")

    // revoke alice's Card from Virgil Security services.
    err = api.Cards.Revoke(aliceCard)

Encrypting with High level API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Initialize

.. code-block:: go
    :linenos:

    // initialize Virgil SDK
    api, err := virgilapi.New("[YOUR_ACCESS_TOKEN_HERE]")

Encrypt Data

.. code-block:: go
    :linenos:

    api, err := virgilapi.New("[YOUR_ACCESS_TOKEN_HERE]")

    // search for alice's and bob's Cards
    recipients, err := api.Cards.Find("alice", "bob")

    message := virgilapi.BufferFromString("Hello Guys, let's get outta here.")

    // encrypt message for multiple recipients
    cipherData, err := recipients.Encrypt(message)

    transferData := cipherData.ToBase64String()
    // transferData := cipherData.ToHEXString()

Decrypt Data

.. code-block:: go
    :linenos:

    // load alice's Key from secure storage provided by default.
    aliceKey, err := api.Keys.Load("[KEY_NAME]", "[KEY_PASSWORD]")

    // get buffer from base64 encoded string
    encryptedData, err := virgilapi.BufferFromBase64String(transferData)

    // decrypt message using alice's Private key.
    originalData, err := aliceKey.Decrypt(encryptedData)
    // originalData = aliceKey.Decrypt(encryptedData)

    originalMessage := originalData.ToString()
    // originalMessage := originalData.ToHEXString()
    // originalMessage := originalData.ToBase64String()

Authenticated Encryption with High Level API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Initialization

.. code-block:: go
    :linenos:
    
    // initialize Virgil SDK
    api, err := virgilapi.New("[YOUR_ACCESS_TOKEN_HERE]")

Sign then Encrypt

.. code-block:: go
    :linenos:

    // load alice's key pair from secure storage defined by default
    aliceKey, err  := api.Keys.Load("[KEY_NAME]", "[KEY_PASSWORD]")

    // search for bob's and chris' Cards
    recipients, err := api.Cards.Find("bob", "chris")

    message := virgilapi.BufferFromString("Hello Guys, let's get outta here.")

    // encrypt and sign message for multiple recipients
    cipherData, err := aliceKey.SignThenEncrypt(message, recipients...)

    transferData := cipherData.ToString()

Decrypt then Verify

.. code-block:: go
    :linenos:

    // load bob's Key from secure storage defined by default
    bobKey, err := api.Keys.Load("[KEY_NAME]", "[KEY_PASSWORD]")

    // search for alice's Card
    aliceCards, err := api.Cards.Find("alice")
    aliceCard := aliceCards[0] //or whatever filter you like

    // get buffer from base64 encoded string
    encryptedData, err := virgilapi.BufferFromBase64String(transferData)

    // decrypt cipher message bob's key pair and verify it using alice's Card
    originalData, err := bobKey.DecryptThenVerify(encryptedData, aliceCard)

    originalMessage := originalData.ToString()

Generating and Verifying Signatures with High Level API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Initialization

.. code-block:: go
    :linenos:

    // initialize Virgil SDK high-level instance
    api, err := virgilapi.New("[YOUR_ACCESS_TOKEN_HERE]")

Generate Digital Signature

.. code-block:: go
    :linenos:

    // load alice's Key from protected storage
    aliceKey, err := api.Keys.Load("[KEY_NAME]", "[KEY_PASSWORD]")

    message := virgilapi.BufferFromString("Hey Bob, hope you are doing well.")

    // generate signature of message using alice's key pair
    signature, err := aliceKey.Sign(message)
    transferData := signature.ToBase64String()

Validate Digital Signature

.. code-block:: go
    :linenos:

    // search for alice's Card
    aliceCards, err := api.Cards.Find("alice")
    aliceCard := aliceCards[0] //or whatever filter you like

    res, err := aliceCard.Verify(message, signature)
    if !res {
        ...
    }
