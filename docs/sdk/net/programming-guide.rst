Programming guide
=============================

This guide is a practical introduction to creating Python apps for that make use of Virgil Security services.

In this guide you will find code for every task you need to implement in order to create an application using Virgil Security. It also includes a description of the main objects and methods. The aim of this guide is to get you up and running quickly. You should be able to copy and paste the code provided here into your own apps and use it with minimal changes.

Setting up your project
----------------------

Follow instructions `here <getting-started>`__ to setup your project environment.

User and App Credentials
------------------------

To start using Virgil Services you first have to create an account at `Virgil 
Developer Portal <https://developer.virgilsecurity.com/account/signup>`__.

After you create an account, or if you already have an account, sign in and 
create a new application. Make sure you save the *appKey* that is 
generated for your application at this point as you will need it later. 
After your application is ready, create a *token* that your app will 
use to make authenticated requests to Virgil Services. One more thing that 
you're going to need is your application's *appID* which is an identifier 
of your application's Virgil Card.

Usage
~~~~~~~~~~~~~~~~~~~

Now that you have your account and application in place you can start making 
requests to Virgil Services.

Initializing
------------------------

To initialize the SDK Api, you need the *token* that you created for 
your application on [Virgil Developer Portal](https://developer.virgilsecurity.com/)

This inializes a VirgilApi class without application *token* (works only with global Virgil Cards)

.. code-block:: csharp
    :linenos:

    var virgil = new VirgilApi();

.. code-block:: csharp
    :linenos:

    var virgil = new VirgilApi("[YOUR_ACCESS_TOKEN_HERE]");

Initialize high-level SDK using context class

.. code-block:: csharp
    :linenos:

    var context = new VirgilApiContext
    {
        AccessToken = "[YOUR_ACCESS_TOKEN_HERE]",
        // Credentials are required only in case of publish and revoke local Virgil Cards.
        Credentials = new AppCredentials
        {
            AppId = "[YOUR_APP_ID_HERE]",
            AppKeyData = VirgilBuffer.FromFile("[YOUR_APP_KEY_PATH_HERE]"),
            AppKeyPassword = "[YOUR_APP_KEY_PASSWORD_HERE]"
        },
        CardVerifiers = new [] { 
            new CardVerifierInfo {
                CardId = "[YOUR_CARD_ID_HERE]",
                PublicKeyData = VirgilBuffer.From("[YOUR_PUBLIC_KEY_HERE]", StringEncoding.Base64)
            }
        }
    };

    var virgil = new VirgilApi(context);

At this point you can start creating and publishing *Virgil Cards* for your
users.

> *Virgil Card* is the main entity of Virgil Services, it includes the user's 
> identity and their public key.

There are two ways to create a Virgil Card. 

The first way is to create the Virgil Card in application scope. The cards created this way will only be available to your application (i.e. will only be returned in response to a request presenting your application's *token*). 

The second way is to create the Virgil Card in global scope. The cards created in global scope will be available within all Virgil Services and to find them you doin't need an application *token*.

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil Services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

Registering Virgil Card
--------------------------

Generate user's Key and create a Virgil Card

.. code-block:: csharp
    :linenos:

    // initialize Virgil SDK
    var virgil = new VirgilApi("[YOUR_ACCESS_TOKEN_HERE]");

    // generate and save alice's Key
    var aliceKey = virgil.Keys.Generate().Save("[KEY_NAME]", "[KEY_PASSWORD]");

    // create alice's Card using her Key
    var aliceCard = virgil.Cards.Create("alice", aliceKey);

Transmit alice's Card to the server side where it would be signed, validated and published on the Virgil Services. 

.. code-block:: csharp

    // export alice's Card to string
    var exportedAliceCard = aliceCard.Export();

Publish a Virgil Card on Server-Side

.. code-block:: csharp
    :linenos:

    // initialize Virgil SDK high-level instance.
    var virgil = new VirgilApi(new VirgilApiContext
    {
        AccessToken = "[YOUR_ACCESS_TOKEN_HERE]",
        Credentials = new AppCredentials
        {
            AppId = "[YOUR_APP_ID_HERE]",
            AppKey = VirgilBuffer.FromFile("[YOUR_APP_KEY_FILEPATH_HERE]"),
            AppKeyPassword = "[YOUR_APP_KEY_PASSWORD_HERE]",
        }
    });

    // import Alice's Card from its string representation.
    var aliceCard = virgil.Cards.Import(exportedAliceCard);

    // verify Alice's Card information before publishing it on the Virgil services.

    // aliceCard.Identity
    // aliceCard.IdentityType
    // aliceCard.Data
    // aliceCard.Info

    // publish alice's Card on Virgil Services
    await virgil.Cards.PublishAsync(aliceCard);
    // await aliceCard.PublishAsync();

Revoking Virgil Card
--------------------------

.. code-block:: csharp
    :linenos:

    // initialize Virgil SDK high-level instance.
    var virgil = new VirgilApi(new VirgilApiContext
    {
        AccessToken = "[YOUR_ACCESS_TOKEN_HERE]",
        Credentials = new AppCredentials
        {
            AppId = "[YOUR_APP_ID_HERE]",
            AppKey = VirgilBuffer.FromFile("[YOUR_APP_KEY_PATH_HERE]"),
            AppKeyPassword = "[YOUR_APP_KEY_PASSWORD_HERE]",
        },
    });

    // get Alice's Card by ID
    var aliceCard = await virgil.Cards.GetAsync("[ALICE_CARD_ID]");

    // revoke Alice's Card from Virgil Services.
    await virgil.Cards.RevokeAsync(aliceCard);

Registering Global Virgil Card
--------------------------

.. code-block:: csharp
    :linenos:

    // initialize Virgil's high-level instance.
    var virgil = new VirgilApi("[YOUR_ACCESS_TOKEN_HERE]");

    // generate and save Alice's Key.
    var aliceKey = virgil.Keys.Generate().Save("[KEY_NAME]", "[KEY_PASSWORD]");

    // create Alice's Card using her newly generated Key.
    var aliceCard = virgil.Cards.CreateGlobal(
        identity: "alice@virgilsecurity.com",
        identityType: IdentityType.Email,
        ownerKey: aliceKey
    );

    // initiate an identity verification process.
    var attempt = await aliceCard.CheckIdentityAsync();

    // confirm a Card's identity using confirmation code retrived on the email.
    var token = await attempt.ConfirmAsync(new EmailConfirmation("[CONFIRMATION_CODE]"));

    // publish a Card on the Virgil Security services.
    await virgil.Cards.PublishGlobalAsync(aliceCard, token);
    // await aliceCard.PublishAsGlobalAsync(token); 

Revoking Global Virgil Cards
----------------------------

.. code-block:: csharp
    :linenos:

    // initialize Virgil SDK high-level
    var virgil = new VirgilApi("[YOUR_ACCESS_TOKEN_HERE]");

    // load Alice's Key from secure storage provided by default.
    var aliceKey = virgil.Keys.Load("[KEY_NAME]", "[KEY_PASSWORD]");

    // load Alice's Card from Virgil Security services.
    var aliceCard = virgil.Cards.GetAsync("[ALICE_CARD_ID]");

    // initiate Card's identity verification process.
    var attempt = await aliceCard.CheckIdentityAsync();

    // confirm Card's identity using confirmation code and grub validation token.
    var token = await attempt.ConfirmAsync(new EmailConfirmation("[CONFIRMATION_CODE]"));

    // revoke Virgil Card from Virgil Security services.
    await virgil.Cards.RevokeGlobalAsync(aliceCard, aliceKey, token); 

Export & Import Virgil Cards
-------------------------------
.. code-block:: csharp
    :linenos:

    var virgil = new VirgilApi("[YOUR_ACCESS_TOKEN_HERE]");

    var aliceKey = virgil.Keys.Generate();
    var aliceCard = virgil.Cards.Create("alice", aliceKey);

    // export a Virgil Card to its string representation.
    var exportedCard = aliceCard.Export();

    // import a Virgil Card to from its string representation
    var importedCard = virgil.Cards.Import(exportedCard);


Search for Virgil Cards
-------------------------------
.. code-block:: csharp
    :linenos:

    var virgil = new VirgilApi("[YOUR_ACCESS_TOKEN_HERE]");

    // search for all Alice's Cards.
    var aliceCards = await virgil.Cards.FindAsync("alice");

    // search for all Bob's Cards with type 'member'
    var bobCards = await virgil.Cards.FindAsync("member", new[] { "bob" });

    // search for all Bob's global Cards
    var bobGlobalCards = await virgil.Cards.FindGlobalAsync("bob@virgilsecurity.com");

    // search for application Card registered on Dev Portal.
    var appCards = await virgil.Cards.FindGlobalAsync("com.username.appname");


Encryption
-------------------------------
Initialize Virgil High Level API and generate the Virgil Key.

.. code-block:: csharp

    var virgil = new VirgilApi("[YOUR_ACCESS_TOKEN_HERE]");

Encrypting Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: csharp
    :linenos:

    // search for alice's and bob's Cards
    var bobCards = await virgil.Cards.FindAsync("bob");

    var message = "Hey Bob, are you crazy?";

    // encrypt the message for multiple recipients
    var ciphertext = bobCards.Encrypt(message).ToString(StringEncoding.Base64);
    
Decrypting Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: csharp
    :linenos:

    // load Bob's Key from secure storage provided by default.
    var bobKey = virgil.Keys.Load("[KEY_NAME]", "[KEY_PASSWORD]");

    // decrypt message using Bob's Key.
    var originalMessage = aliceKey.Decrypt(ciphertext).ToString();

Encrypting & Signing Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: csharp
    :linenos:

    // load Bob's Key from secure storage defined by default
    var aliceKey = virgil.Keys.Load("[KEY_NAME]", "[KEY_PASSWORD]");

    // search for Bob's and chris' Cards
    var bobCards = await virgil.Cards.FindAsync("bob");

    var message = "Hey Bob, are you crazy?";

    // encrypt and sign message for multiple recipients
    var ciphertext = aliceKey.SignThenEncrypt(message, bobCards).ToString(StringEncoding.Base64);

Decrypting & Verifying Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: csharp
    :linenos:

    // load Bob's Key from secure storage defined by default
    var bobKey = virgil.Keys.Load("[KEY_NAME]", "[KEY_PASSWORD]");

    // search for Alice's Card
    var aliceCards = await virgil.Cards.FindAsync("alice");
    var aliceCard = aliceCards.Single(c => c.Device == "iPhone 7");

    // decrypt cipher message using Bob's Key and verify it using alice's Card
    var originalMessage = bobKey.DecryptThenVerify(encryptedData, aliceCard).ToString();

Generating and Verifying Signatures
-----------------------------------
This section walks you through the steps necessary to use the VirgilCrypto to generate a digital signature for data and to verify that a signature is authentic.
.. code-block:: csharp

    // initialize Virgil SDK high-level API instance
    var virgil = new VirgilApi("[YOUR_ACCESS_TOKEN_HERE]");

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~~~~~
To generate the signature, simply call one of the sign methods:
.. code-block:: csharp
    :linenos:

    // load Alice's Key from protected storage
    var aliceKey = virgil.Keys.Load("[KEY_NAME]", "[KEY	_PASSWORD]");

    var message = "Hey Bob, hope you are doing well.";

    // generate signature of message using alice's key pair
    var signature = aliceKey.Sign(message);

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~~~~~~
The signature can now be verified by calling the verify method:
.. code-block:: csharp
    :linenos:

    // search for Alice's Card
    var aliceCards = await virgil.Cards.FindAsync("alice");
    var aliceCard = aliceCards.Single(card => card.Device == "iPhone 7");

    if (!aliceCard.Verify(message, signature))
    {
        throw new Exception("Damn Alice it's not you.a"); 
    }

