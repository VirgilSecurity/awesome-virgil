Programming guide
=============================

This guide is a practical introduction to creating JavaScript apps that make use of Virgil Security services.

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

To initialize the SDK API, you need the *token* that you created for 
your application on [Virgil Developer Portal](https://developer.virgilsecurity.com/)

This inializes a VirgilApi class without application *token* (works only with global Virgil Cards)

.. code-block:: javascript
    :linenos:
    
    // var virgil = require("virgil-sdk");
    // or just use virgil if you added virgil-sdk via <script> tag

    var virgilAPI = virgil.API();

.. code-block:: javascript
    :linenos:

    // var virgil = require("virgil-sdk");
    // or just use virgil if you added virgil-sdk via <script> tag

    var virgilAPI = virgil.API("[YOUR_ACCESS_TOKEN_HERE]");

Initialize high-level SDK using context class

.. code-block:: javascript
    :linenos:

    var appKeyData = require("fs").readFileSync("[YOUR_APP_KEY_PATH_HERE]");
    var config = {
        accessToken: "[YOUR_ACCESS_TOKEN_HERE]",
        // Credentials are required only in case of publish and revoke local Virgil Cards.
        appCredentials: {
            appId: "[YOUR_APP_ID_HERE]",
            appKeyData: appKeyData,
            appKeyPassword: "[YOUR_APP_KEY_PASSWORD_HERE]"
        },
        cardVerifiers: [{ 
            cardId: "[YOUR_CARD_ID_HERE]",
            publicKeyData: Buffer.from("[YOUR_PUBLIC_KEY_HERE]", "base64")
        }]
    };

    var virgilAPI = virgil.API(config);

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

.. code-block:: javascript
    :linenos:

    // initialize Virgil SDK
    var virgilAPI = virgil.API("[YOUR_ACCESS_TOKEN_HERE]");

    // generate and save key for Alice
    var aliceKey = virgilAPI.keys.generate();
    aliceKey.save("[KEY_NAME]", "[KEY_PASSWORD]")
        .then(function () {
            // create Card for Alice using her Key
            var aliceCard = virgilAPI.cards.create("alice", aliceKey);
        });

Transmit Alice's Card to the server side where it would be signed, validated and published on the Virgil Services. 

.. code-block:: javascript

    // export alice's Card to string
    var exportedAliceCard = aliceCard.export();

Publish a Virgil Card on Server-Side

.. code-block:: javascript
    :linenos:

    // load application's private key from file
    var appKeyData = require('fs').readFileSync("[YOUR_APP_KEY_FILEPATH_HERE]");

    // initialize Virgil SDK high-level instance.
    var virgilAPI = virgil.API({
        accessToken: "[YOUR_ACCESS_TOKEN_HERE]",
        appCredentials: {
            appId: "[YOUR_APP_ID_HERE]",
            appKeyData: appKeyData,
            appKeyPassword: "[YOUR_APP_KEY_PASSWORD_HERE]",
        }
    });

    // import Alice's Card from its string representation.
    var aliceCard = virgilAPI.cards.import(exportedAliceCard);

    // verify Alice's Card information before publishing it on the Virgil services.

    // aliceCard.identity
    // aliceCard.identityType
    // aliceCard.customFields
    // aliceCard.info

    // publish Alice's Card on Virgil Services
    virgilAPI.cards.publish(aliceCard)
        .then(function () {
            // Card is published
        })
    // aliceCard.publish().then(...);

Revoking Virgil Card
--------------------------

.. code-block:: javascript
    :linenos:

    // load application's private key from file
    var appKeyData = require('fs').readFileSync("[YOUR_APP_KEY_FILEPATH_HERE]");

    // initialize Virgil SDK high-level instance.
    var virgilAPI = virgil.API({
        accessToken: "[YOUR_ACCESS_TOKEN_HERE]",
        appCredentials: {
            appId: "[YOUR_APP_ID_HERE]",
            appKeyData: fs.readFileSync("[YOUR_APP_KEY_FILEPATH_HERE]"),
            appKeyPassword: "[YOUR_APP_KEY_PASSWORD_HERE]",
        }
    });

    // get Alice's Card by ID
    virgilAPI.cards.get("[ALICE_CARD_ID]")
        .then(function (aliceCard) {
            // revoke Alice's Card from Virgil Security services.
            return virgilAPI.cards.revoke(aliceCard);
        })
        .then(function () {
            // Card revoked
        });

Registering Global Virgil Card
--------------------------

.. code-block:: javascript
    :linenos:

    // initialize Virgil API
    var virgilAPI = virgil.API("[YOUR_ACCESS_TOKEN_HERE]");

    // generate and save the private key for Alice.
    var aliceKey = virgilAPI.keys.generate();
    aliceKey.save("[KEY_NAME]", "[KEY_PASSWORD]")
        .then(function () {
            // create Card for Alice using her newly generated Key.
            var aliceCard = virgilAPI.cards.createGlobal(
                "alice@virgilsecurity.com", 
                aliceKey
                virgil.IdentityType.EMAIL
            );

            // initiate an identity verification process.
            return aliceCard.checkIdentity();
        })
        .then(function (confirmIdentity) {
            // confirm Card's identity using confirmation code received in email
            // and get identity validation token
            return confirmIdentity("[CONFIRMATION_CODE]");
        })
        .then(function (token) {
            // publish the Card on the Virgil Security services.
            return virgilAPI.cards.publishGlobal(aliceCard, token);
            // return aliceCard.publishAsGlobalAsync(token); 
        })
        .then(function () {
            // Card is published
        });

Revoking Global Virgil Cards
----------------------------

.. code-block:: javascript
    :linenos:

    // initialize Virgil API
    var virgilAPI = virgil.API("[YOUR_ACCESS_TOKEN_HERE]");

    // load Alice's Key from storage.
    virgilAPI.keys.load("[KEY_NAME]", "[KEY_PASSWORD]")
        .then(function (aliceKey) {
            // load Alice's Card from Virgil Security services.
            return virgilAPI.cards.get("[ALICE_CARD_ID]");
        })
        .then(function (aliceCard) {
            // initiate Card's identity verification process.
            return aliceCard.checkIdentity();
        })
        .then(function (confirmIdentity) {
            // confirm Card's identity using confirmation code received in email
            // and get identity validation token
            return confirmIdentity("[CONFIRMATION_CODE]");
        })
        .then(function (token) {
            // revoke Virgil Card from Virgil Security services.
            return virgilAPI.cards.revokeGlobal(aliceCard, aliceKey, token);
        })
        .then(function () {
            // Card revoked
        });

Export & Import Virgil Cards
-------------------------------
.. code-block:: javascript
    :linenos:

    var virgilAPI = virgil.API("[YOUR_ACCESS_TOKEN_HERE]");

    // generate a key for Alice
    var aliceKey = virgilAPI.keys.generate();
    
    // create Card for Alice using her Key
    var aliceCard = virgilAPI.cards.create("alice", aliceKey);

    // export the Card into a string representation.
    var exportedCard = aliceCard.export();

    // import the Card to from its string representation
    var importedCard = virgilAPI.cards.import(exportedCard);


Search for Virgil Cards
-------------------------------
.. code-block:: javascript
    :linenos:

    var virgilAPI = virgil.API("[YOUR_ACCESS_TOKEN_HERE]");

    // search for all Alice's Cards.
    virgilAPI.cards.find("alice")
        .then(function(aliceCards) {
            // do something with Alice's cards
        });

    // search for all Bob's Cards with type 'member'
    virgilAPI.cards.find(["bob"], "member")
        .then(function(bobCards) {
            // do something with Bob's cards
        });

    // search for all Bob's global Cards
    virgilAPI.cards.findGlobal("bob@virgilsecurity.com")
        .then(function(bobGlobalCards) {
            // do something with Bob's global cards
        });

    // search for Cards of the application registered on Dev Portal.
    virgilAPI.cards.findGlobal("com.username.appname", virgil.IdentityType.APPLICATION)
        .then(function(appCards) {
            // do something with app's cards
        });

Generating Virgil Keys
-------------------------------

Generate a new Virgil Key using the algorithm recommended by Virgil.

.. code-block:: javascript
    :linenos:

    // initialize a High Level API
    var virgilAPI = virgil.API();

    // generate a new private key
    var key = virgilAPI.keys.generate();

Export & Import Virgil Keys
---------------------------

Export the Virgil Key to base64-encoded string.

.. code-block:: javascript
    :linenos:

    // initialize the High Level API
    var virgilAPI = virgil.API();
    
    // generate a new Virgil Key
    var key = virgil.keys.generate();

    // export the Virgil Key to base64-encoded string
    var exportedKey = key.export("[OPTIONAL_KEY_PASSWORD]").toString("base64");

Import the Virgil Key from Base64 encoded string.

.. code-block:: javascript
    :linenos:

    // initialize a High Level API class
    var virgilAPI = virgil.API();

    // import the Virgil Key from base64-encoded string
    var key = virgilAPI.keys.import("[BASE64_ENCODED_VIRGIL_KEY]", "[OPTIONAL_KEY_PASSWORD]");

    // OR
    // var keyBuffer = virgil.Buffer.from("[BASE64_ENCODED_VIRGIL_KEY]", "base64"); // Browsers
    //// var keyBuffer = new Buffer("[BASE64_ENCODED_VIRGIL_KEY]", "base64"); // node.js
    //// var keyBuffer = Buffer.from("[BASE64_ENCODED_VIRGIL_KEY]", "base64"); // node.js > 5.10.0

    //// import the Virgil Key from Buffer    
    // var key = virgilAPI.keys.import(keyBuffer, "[OPTIONAL_KEY_PASSWORD]");

Encryption
-------------------------------
Initialize Virgil High Level API and generate the Virgil Key.

.. code-block:: javascript

    var virgilAPI = virgil.API("[YOUR_ACCESS_TOKEN_HERE]");

Encrypting Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: javascript
    :linenos:

    // search for all Bob's Cards
    virgilAPI.cards.find(["bob"])
        .then(function(bobCards) {
            var message = "Hey Bob, are you alright?";

            // encrypt the message for multiple recipients
            var ciphertext = virgilAPI.encryptFor(message, bobCards).toString("base64");
        });
    
Decrypting Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: javascript
    :linenos:

    // load Bob's Key from storage
    virgilAPI.keys.load("[KEY_NAME]", "[KEY_PASSWORD]")
        .then(function (bobsKey) {
            // decrypt the message using Bob's Key.
            var message = bobsKey.decrypt(ciphertext).toString();
        });

Encrypting & Signing Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: javascript
    :linenos:

    Promise.all([
        // load Alice's key from storage
        virgilAPI.keys.load("[KEY_NAME]", "[KEY_PASSWORD]"),
        // search for Bob's cards
        virgilAPI.cards.find("bob")
    ]).then(function(results) {
        var alicesKey = results[0];
        var bobsCards = results[1];

        var message = "Hey Bob, are you alright?";

        // encrypt and sign message for multiple recipients
        var encryptedData = alicesKey.signThenEncrypt(message, bobsCards).toString("base64");
    });

Decrypting & Verifying Data
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: javascript
    :linenos:

    Promise.all([
        // load Bob's key from storage
        virgilAPI.keys.load("[KEY_NAME]", "[KEY_PASSWORD]"),
        // search for Alice's cards
        virgilAPI.cards.find("alice")
    ]).then(function(results) {
        var bobsKey = results[0];
        var alicesCards = results[1];
        var alicesPhoneCard = aliceCards.find(function (card) {
            return card.device === "iPhone7";
        });

        // decrypt enciphered message using Bob's Key and verify it using Alice's Card
        var originalMessage = bobsKey.decryptThenVerify(encryptedData, alicesPhoneCard).toString();
    });

Generating and Verifying Signatures
-----------------------------------

.. code-block:: javascript

    // initialize Virgil SDK API instance
    var virgilAPI = virgil.API("[YOUR_ACCESS_TOKEN_HERE]");

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~~~~~
To generate the signature, simply call one of the sign methods:

.. code-block:: javascript
    :linenos:

    // load Alice's Key from storage
    virgilAPI.keys.load("[KEY_NAME]", "[KEY_PASSWORD]")
        .then(function (alicesKey) {
            var message = "Hey Bob, hope you are doing well.";

            // calculate message signature using Alice's key
            var signature = aliceKey.sign(message).toString("base64");
        });

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~~~~~~
The signature can now be verified by calling the verify method:

.. code-block:: javascript
    :linenos:

    // get for Alice's Card by id
    virgilAPI.cards.get("ALICE_CARD_ID")
        .then(function(alicesCard) {
            if (!alicesCard.verify(message, signature)) {
                throw new Error("The message is not from Alice."); 
            }
        })
