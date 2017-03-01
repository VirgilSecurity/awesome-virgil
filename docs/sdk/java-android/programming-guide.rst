Programming guide
=============================

This guide is a practical introduction to creating Java/Android apps for that make use of Virgil Security services.

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

.. code-block:: java
    :linenos:

    VirgilApi virgil = new VirgilApiImpl();

.. code-block:: java
    :linenos:

    VirgilApi virgil = new VirgilApiImpl("[YOUR_ACCESS_TOKEN_HERE]");

Initialize high-level SDK using context class

.. code-block:: java
    :linenos:

    AppCredentials credentials = new AppCredentials();
    credentials.setAppId("[YOUR_APP_ID_HERE]");
    credentials.setAppKey(VirgilBuffer.from("[YOUR_APP_KEY_HERE]"));
    credentials.setAppKeyPassword("[YOUR_APP_KEY_PASSWORD_HERE]");

    VirgilApiContext context = new VirgilApiContext("[YOUR_ACCESS_TOKEN_HERE]");
    context.setCredentials(credentials);

    VirgilApi virgil = new VirgilApiImpl(context);

At this point you can start creating and publishing *Virgil Cards* for your
users.

> *Virgil Card* is the main entity of Virgil Services, it includes the user's 
> identity and their public key.

There are two ways to create a Virgil Card. 

The first way is to create the Virgil Card in application scope. The cards created this way will only be available to your application (i.e. will only be returned in response to a request presenting your application's *token*). 

The second way is to create the Virgil Card in global scope. The cards created in global scope will be available within all Virgil Services and to find them you doin't need an application *token*.

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil Services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

Registering Virgil Cards
--------------------------

Generate user's Key and create a Virgil Card

.. code-block:: java
    :linenos:

    // initialize Virgil SDK
    VirgilApi virgil = new VirgilApiImpl(ACCESS_TOKEN);

    // generate and save alice's Key
    VirgilKey aliceKey = virgil.getKeys().generate().save(ALICE_KEY_NAME, ALICE_KEY_PWD);

    // create alice's Card using her Key
    VirgilCard aliceCard = virgil.getCards().create("alice", aliceKey);

Transmit alice's Card to the server side where it would be signed, validated and published on the Virgil Services. 

.. code-block:: java

    // export alice's Card to string
    String exportedAliceCard = aliceCard.export();

Publish a Virgil Card on Server-Side

.. code-block:: java
    :linenos:

    // initialize Virgil SDK high-level instance.
    AppCredentials credentials = new AppCredentials();
    credentials.setAppId("[YOUR_APP_ID_HERE]");
    credentials.setAppKey(VirgilBuffer.from("[YOUR_APP_KEY_HERE]"));
    credentials.setAppKeyPassword("[YOUR_APP_KEY_PASSWORD_HERE]");

    VirgilApiContext context = new VirgilApiContext("[YOUR_ACCESS_TOKEN_HERE]");
    context.setCredentials(credentials);

    VirgilApi virgil = new VirgilApiImpl(context);

    // import Alice's Card from its string representation.
    VirgilCard aliceCard = virgil.getCards().importCard(exportedAliceCard);

    // verify Alice's Card information before publishing it on the Virgil services.

    // aliceCard.getIdentity()
    // aliceCard.getIdentityType()
    // aliceCard.getCustomFields()

    // publish alice's Card on Virgil Services
    virgil.getCards().publish(aliceCard);
    // aliceCard.publish();

Revoking Virgil Cards
--------------------------

.. code-block:: java
    :linenos:

    AppCredentials credentials = new AppCredentials();
    credentials.setAppId("[YOUR_APP_ID_HERE]");
    credentials.setAppKey(VirgilBuffer.from("[YOUR_APP_KEY_HERE]"));
    credentials.setAppKeyPassword("[YOUR_APP_KEY_PASSWORD_HERE]");

    VirgilApiContext context = new VirgilApiContext("[YOUR_ACCESS_TOKEN_HERE]");
    context.setCredentials(credentials);

    VirgilApi virgil = new VirgilApiImpl(context);

    // get Alice's Card by ID
    VirgilCard aliceCard = virgil.getCards().get(aliceCardId);

    // revoke Alice's Card from Virgil Services.
    virgil.getCards().revoke(aliceCard);

Registering Global Virgil Cards
--------------------------

.. code-block:: java
    :linenos:

    // initialize Virgil's high-level instance.
    VirgilApi virgil = new VirgilApiImpl("[YOUR_ACCESS_TOKEN_HERE]");

    // generate and save Alice's Key.
    VirgilKey aliceKey = virgil.getKeys().generate().save("[KEY_NAME]", "[KEY_PASSWORD]");

    // create Alice's Card using her newly generated Key.
    VirgilCard aliceCard = virgil.getCards().createGlobal("alice@virgilsecurity.com", aliceKey, IdentityType.EMAIL);

    // initiate an identity verification process.
    IdentityVerificationAttempt attempt = aliceCard.checkIdentity();

    // confirm a Card's identity using confirmation code retrived on the email.
    IdentityValidationToken token = attempt.confirm(new EmailConfirmation("[CONFIRMATION_CODE]"));

    // publish a Card on the Virgil Security services.
    virgil.getCards().publishGlobal(aliceCard, token);
    //aliceCard.publishAsGlobal(token);

Revoking Global Virgil Cards
----------------------------

.. code-block:: java
    :linenos:

    // initialize Virgil SDK high-level
    VirgilApi virgil = new VirgilApiImpl("[YOUR_ACCESS_TOKEN_HERE]");

    // load Alice's Key from secure storage provided by default.
    VirgilKey aliceKey = virgil.getKeys().load("[KEY_NAME]", "[KEY_PASSWORD]");

    // load Alice's Card from Virgil Security services.
    VirgilCard aliceCard = virgil.getCards().get("[ALICE_CARD_ID]");

    // initiate Card's identity verification process.
    IdentityVerificationAttempt attempt = aliceCard.checkIdentity();

    // confirm Card's identity using confirmation code and grub validation token.
    IdentityValidationToken token = attempt.confirm(new EmailConfirmation("[CONFIRMATION_CODE]"));

    // revoke Virgil Card from Virgil Security services.
    virgil.getCards().revokeGlobal(aliceCard, aliceKey, token);

Export & Import Virgil Cards
-------------------------------
.. code-block:: java
    :linenos:

    VirgilApi virgil = new VirgilApiImpl("[YOUR_ACCESS_TOKEN_HERE]");

    VirgilKey aliceKey = virgil.getKeys().generate();
    VirgilCard aliceCard = virgil.getCards().create("alice", aliceKey);

    // export a Virgil Card to its string representation.
    String exportedCard = aliceCard.export();

    // import a Virgil Card to from its string representation
    VirgilCard importedCard = virgil.getCards().importCard(exportedCard);

Search for Virgil Cards
-------------------------------
.. code-block:: java
    :linenos:

    VirgilApi virgil = new VirgilApiImpl("[YOUR_ACCESS_TOKEN_HERE]");

    // search for all Alice's Cards.
    VirgilCards aliceCards = virgil.getCards().find("alice");

    // search for all Bob's Cards with type 'member'
    VirgilCards bobCards = virgil.getCards().find("member", Arrays.asList("bob"));

    // search for all Bob's global Cards
    VirgilCards bobGlobalCards = virgil.getCards().findGlobal(Arrays.asList("bob@virgilsecurity.com"));

    // search for application Card registered on Dev Portal.
    VirgilCards appCards = virgil.getCards().findGlobal(Arrays.asList("com.username.appname"));


Generating Virgil Keys
-------------------------------

Generate a new Virgil Key recommended by Virgil.

.. code-block:: java
    :linenos:

    // initialize a High Level API class
    VirgilApi virgil = new VirgilApiImpl();

    // generate a new private key
    VirgilKey aliceKey = virgil.getKeys().generate();

Generate a new Virgil Key with specified type.

.. code-block:: java
    :linenos:

    // initialize the Crypto with specified key pair type.
    Crypto crypto = new VirgilCrypto(KeysType.EC_BP512R1);

    // initialize a High Level API class with custom Crypto instance.
    VirgilApiContext context = new VirgilApiContext();
    context.setCrypto(crypto);
    
    VirgilApi virgil = new VirgilApiImpl(context);

    // generate a new private key
    VirgilKey aliceKey = virgil.getKeys().generate();

Export & Import Virgil Keys
-------------------------------

Export the Virgil Key to Base64 encoded string.

.. code-block:: java
    :linenos:

    // initialize a High Level API class
    VirgilApi virgil = new VirgilApiImpl();
    
    // generate a new Virgil Key
    VirgilKey aliceKey = virgil.getKeys().generate();

    // export the Virgil Key to Base64 encoded string
    String exportedKey = aliceKey.export("[OPTIONAL_KEY_PASSWORD]").toString(StringEncoding.Base64);

Import the Virgil Key from Base64 encoded string.

.. code-block:: java
    :linenos:

    // initialize a High Level API class
    VirgilApi virgil = new VirgilApiImpl();
    
    VirgilBuffer keyBuffer = VirgilBuffer.from("[BASE64_ENCODED_VIRGIL_KEY]", StringEncoding.Base64);

    // import the Virgil Key from Base64 encoded string
    VirgilKey aliceKey = virgil.getKeys().importKey(keyBuffer, "[OPTIONAL_KEY_PASSWORD]");

Encryption
-------------------------------
Initialize Virgil High Level API and generate the Virgil Key.

.. code-block:: java

    VirgilApi virgil = new VirgilApiImpl("[YOUR_ACCESS_TOKEN_HERE]");

Encrypting Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: java
    :linenos:

    // search for alice's and bob's Cards
    VirgilCards bobCards = virgil.getCards().find("bob");

    String message = "Hey Bob, are you crazy?";

    // encrypt the message for multiple recipients
    String ciphertext = bobCards.encrypt(message).toString(StringEncoding.Base64);
    
Decrypting Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: java
    :linenos:

    // load Bob's Key from secure storage provided by default.
    VirgilKey bobKey = virgil.getKeys().load("[KEY_NAME]", "[KEY_PASSWORD]");

    // decrypt message using Bob's Key.
    String originalMessage = aliceKey.decrypt(ciphertext).toString();

Encrypting & Signing Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: java
    :linenos:

    // load Bob's Key from secure storage defined by default
    VirgilKey aliceKey = virgil.getKeys().load("[KEY_NAME]", "[KEY_PASSWORD]");

    // search for Bob's and chris' Cards
    VirgilCards bobCards = virgil.getCards().find("bob");

    String message = "Hey Bob, are you crazy?";

    // encrypt and sign message for multiple recipients
    String ciphertext = aliceKey.signThenEncrypt(message, bobCards).toString(StringEncoding.Base64);

Decrypting & Verifying Data
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: java
    :linenos:

    // load Bob's Key from secure storage defined by default
    VirgilKey bobKey = virgil.getKeys().load("[KEY_NAME]", "[KEY_PASSWORD]");

    // search for Alice's Card
    VirgilCards aliceCards = virgil.getCards().find("alice");
    VirgilCard aliceCard = aliceCards.get(0);

    // decrypt cipher message using Bob's Key and verify it using alice's Card
    String originalMessage = bobKey.decryptThenVerify(encryptedData, aliceCard).toString();

Generating and Verifying Signatures
-----------------------------------
This section walks you through the steps necessary to use the VirgilCrypto to generate a digital signature for data and to verify that a signature is authentic.

.. code-block:: java

    // initialize Virgil SDK high-level API instance
    VirgilApi virgil = new VirgilApiImpl("[YOUR_ACCESS_TOKEN_HERE]");

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~~~~~
To generate the signature, simply call one of the sign methods:

.. code-block:: java
    :linenos:

    // load Alice's Key from protected storage
    VirgilKey aliceKey = virgil.getKeys().load("[KEY_NAME]", "[KEY_PASSWORD]");

    String message = "Hey Bob, hope you are doing well.";

    // generate signature of message using alice's key pair
    VirgilBuffer signature = aliceKey.sign(message);

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~~~~~~
The signature can now be verified by calling the verify method:

.. code-block:: java
    :linenos:

    // search for Alice's Card
    VirgilCards aliceCards = virgil.getCards().find("alice");
    VirgilCard aliceCard = aliceCards.get(0);

    if (!aliceCard.verify(message, signature)) {
        throw new Exception("Damn Alice it's not you.a"); 
    }

