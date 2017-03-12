Programming guide
=================

This guide is a practical introduction to creating PHP apps for that make use of Virgil Security services.

In this guide you will find code for every task you need to implement in order to create an application using Virgil Security. It also includes a description of the main objects and methods. The aim of this guide is to get you up and running quickly. You should be able to copy and paste the code provided here into your own apps and use it with minimal changes.

Setting up your project
-----------------------

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
~~~~~

Now that you have your account and application in place you can start making
requests to Virgil Services.

Initializing
------------

To initialize the SDK Client, you need the *token* that you created for
your application on [Virgil Developer Portal](https://developer.virgilsecurity.com/)

This inializes a VirgilApi class without application *token* (works only with global Virgil Cards)

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Api\VirgilApi;

        $virgilApi = new VirgilApi();


.. code-block:: php
    :linenos:

        use Virgil\Sdk\Api\VirgilApi;

        $virgilApi = VirgilApi::create('[YOUR_ACCESS_TOKEN_HERE]');

    Initialize high-level SDK using context class

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Buffer;

        use Virgil\Sdk\Api\AppCredentials;
        use Virgil\Sdk\Api\VirgilApi;
        use Virgil\Sdk\Api\VirgilApiContext;

        use Virgil\Sdk\Client\Validator\CardVerifier;

        use Virgil\Sdk\Cryptography\VirgilCrypto;

        use Virgil\Sdk\Cryptography\Constants\KeyPairTypes;

        $virgilApiContext = VirgilApiContext::create(
            [
                VirgilApiContext::Credentials         => new AppCredentials(        //sets a credentials to work with application virgil cards
                    '[YOUR_APP_ID_HERE]', Buffer::fromBase64('[YOUR_APP_PRIVATE_KEY_HERE]'), '[YOUR_APP_PRIVATE_KEY_PASS_HERE]'
                ),
                VirgilApiContext::UseBuiltInVerifiers => false,                      //disable built in verifiers. By default it's enabled.
                VirgilApiContext::KeyPairType         => KeyPairTypes::RSA1024,      //sets custom key pair type for key generation
                VirgilApiContext::KeysPath            => '[PATH_TO_KEYS_STORE]',     //sets custom virgil keystore path
                VirgilApiContext::AccessToken         => '[YOUR_ACCESS_TOKEN_HERE]', //sets application access token
                VirgilApiContext::CardVerifiers       => [                           //sets a list of additional card verifiers
                    new CardVerifier('[YOUR_CARD_ID_HERE]', Buffer::fromBase64('[YOUR_PUBLIC_KEY_HERE]')),
                ],
            ]
        );

        $virgilApiContext->setCrypto(new VirgilCrypto());
        $virgilApiContext->setKeyStorage(new MemoryKeyStorage());

        $virgilApi = new VirgilApi($virgilApiContext);

At this point you can start creating and publishing *Virgil Cards* for your users.

> *Virgil Card* is the main entity of Virgil Services, it includes the user's
> identity and their public key.

There are two ways to create a Virgil Card.

The first way is to create the Virgil Card in application scope. The cards created this way will only be available to your application (i.e. will only be returned in response to a request presenting your application's *token*).

The second way is to create the Virgil Card in global scope. The cards created in global scope will be available within all Virgil Services and to find them you don't need an application *token*.

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil Services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

Registering Virgil Cards
------------------------
Generate user's Key and create a Virgil Card

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Api\VirgilApi;

        // initialize Virgil SDK
        $virgilApi = VirgilApi::create('[YOUR_ACCESS_TOKEN_HERE]');

        // generate and save alice's Key
        $aliceKey = $virgilApi->Keys->generate()->save('[KEY_NAME]', '[KEY_PASSWORD]');

        // create alice's Card using her Key
        $aliceCard = $virgilApi->Cards->create('alice', 'alice_member', $aliceKey);

Transmit alice's Card to the server side where it would be signed, validated and published on the Virgil Services.

.. code-block:: php

    // export alice's Card to string
    $exportedAliceCard = $aliceCard->export();

Publish a Virgil Card on Server-Side

.. code-block:: php
    :linenos:

        $virgilApiContext = VirgilApiContext::create(
            [
                VirgilApiContext::AccessToken => '[YOUR_ACCESS_TOKEN_HERE]', //sets application access token
                VirgilApiContext::Credentials => new AppCredentials(         //sets a credentials to work with application virgil cards
                    '[YOUR_APP_ID_HERE]', Buffer::fromBase64('[YOUR_APP_PRIVATE_KEY_HERE]'), '[YOUR_APP_PRIVATE_KEY_PASS_HERE]'
                ),
            ]
        );

        $virgilApi = new VirgilApi($virgilApiContext);

        // import Alice's Card from its string representation.
        $aliceCard = $virgilApi->Cards->import($exportedAliceCard);

        // publish alice's Card on Virgil Services
        $virgilApi->Cards->publish($aliceCard);

Revoking Virgil Cards
---------------------

.. code-block:: php
    :linenos:

        // initialize Virgil SDK high-level instance.
        $virgilApiContext = VirgilApiContext::create(
            [
                VirgilApiContext::AccessToken => '[YOUR_ACCESS_TOKEN_HERE]', //sets application access token
                VirgilApiContext::Credentials => new AppCredentials(         //sets a credentials to work with application virgil cards
                    '[YOUR_APP_ID_HERE]', Buffer::fromBase64('[YOUR_APP_PRIVATE_KEY_HERE]'), '[YOUR_APP_PRIVATE_KEY_PASS_HERE]'
                ),
            ]
        );

        $virgilApi = new VirgilApi($virgilApiContext);

        // get Alice's Card by ID
        $aliceCard = $virgilApi->Cards->get('[ALICE_CARD_ID]');

        // revoke Alice's Card from Virgil Services.
        $virgilApi->Cards->revoke($aliceCard);

Registering Global Virgil Cards
-------------------------------

.. code-block:: php
    :linenos:

        // initialize Virgil's high-level instance.
        $virgilApi = VirgilApi::create('[YOUR_ACCESS_TOKEN_HERE]');

        // generate and save Alice's Key.
        $aliceKey = $virgilApi->Keys->generate()
                                    ->save('[KEY_NAME]', '[KEY_PASSWORD]')
        ;

        // create Alice's Card using her newly generated Key.
        $aliceCard = $virgilApi->Cards->createGlobal('alice@virgilsecurity.com', IdentityTypes::TYPE_EMAIL, $aliceKey);

        // initiate an identity verification process.
        $attempt = $aliceCard->checkIdentity();

        // confirm a Card's identity using confirmation code retrived on the email.
        $token = $attempt->confirm(new EmailConfirmation('[CONFIRMATION_CODE]'));

        // publish a Card on the Virgil Security services.
        $virgilApi->Cards->publish($aliceCard);


Revoking Global Virgil Cards
----------------------------

.. code-block:: php
    :linenos:

        // initialize Virgil SDK high-level
        $virgilApi = VirgilApi::create('[YOUR_ACCESS_TOKEN_HERE]');

        // load Alice's Key from secure storage provided by default.
        $aliceKey = $virgilApi->Keys->load('[KEY_NAME]', '[KEY_PASSWORD]');

        // load Alice's Card from Virgil Security services.
        $aliceCard = $virgilApi->Cards->get('[ALICE_CARD_ID]');

        // initiate Card's identity verification process.
        $attempt = $aliceCard->checkIdentity();

        // confirm Card's identity using confirmation code and grub validation token.
        $token = $attempt->confirm(new EmailConfirmation('[CONFIRMATION_CODE]'));

        // revoke Virgil Card from Virgil Security services.
        $virgilApi->Cards->revokeGlobal($aliceCard, $aliceKey, $token);

Export & Import Virgil Cards
----------------------------

.. code-block:: php
    :linenos:

        // initialize Virgil's high-level instance.
        $virgilApi = VirgilApi::create('[YOUR_ACCESS_TOKEN_HERE]');

        $aliceKey = $virgilApi->Keys->generate();
        $aliceCard = $virgilApi->Cards->create('alice', 'alice_member', $aliceKey);

        // export a Virgil Card to its string representation.
        $exportedAliceCard = $aliceCard->export();

        // import a Virgil Card to from its string representation
        $importedCard = $virgilApi->Cards->import($exportedAliceCard);

Search for Virgil Cards
-----------------------

.. code-block:: php
    :linenos:

        $virgilApi = VirgilApi::create('[YOUR_ACCESS_TOKEN_HERE]');

        // search for all Alice's Cards.
        $aliceCards = $virgilApi->Cards->find(['alice']);

        // search for all Bob's Cards with type 'member'
        $bobCards = $virgilApi->Cards->find(['bob']);

        // search for all Bob's global Cards
        $bobGlobalCards = $virgilApi->Cards->findGlobal(['bob@virgilsecurity.com'], IdentityTypes::TYPE_EMAIL);

        // search for application Card registered on Dev Portal.
        $appCards = $virgilApi->Cards->findGlobal(['com.username.appname'], IdentityTypes::TYPE_APPLICATION);

Generating Virgil Keys
----------------------
Generate a new Virgil Key recommended by Virgil.

.. code-block:: php
    :linenos:

        // initialize a High Level API class
        $virgilApi = VirgilApi::create();

        // generate a new private key
        $aliceKey = $virgilApi->Keys->generate();

Generate a new Virgil Key with specified type.

.. code-block:: php
    :linenos:

        // create context with specified key pair type.
        $virgilApiContext = VirgilApiContext::create(
            [
                VirgilApiContext::KeyPairType => KeyPairTypes::EC_BP512R1,
            ]
        );

        // initialize a High Level API class with specified context.
        $virgilApi = new VirgilApi($virgilApiContext);

        // generate alice key with KeyPairTypes::EC_BP512R1 key pair type.
        $aliceKey = $virgilApi->Keys->generate();


Export & Import Virgil Keys
---------------------------

Export the Virgil Key to Base64 encoded string.

.. code-block:: php
    :linenos:

        // initialize a High Level API class
        $virgilApi = VirgilApi::create();

        // generate a new private key
        $aliceKey = $virgilApi->Keys->generate();

        // exports alice key to base64 encoded string presentation.
        $exportedAliceKey = $aliceKey->export('[OPTIONAL_KEY_PASSWORD]')
                                     ->toBase64()
        ;

Import the Virgil Key from Base64 encoded string.

.. code-block:: php
    :linenos:

        // initialize a High Level API class
        $virgilApi = VirgilApi::create();

        // import the Virgil Key from Base64 encoded string
        $aliceKey = $virgilApi->Keys->import(Buffer::fromBase64($exportedAliceKey), '[OPTIONAL_KEY_PASSWORD]');

Encryption
----------
Initialize Virgil High Level API and generate the Virgil Key.

.. code-block:: php

    $virgilApi = VirgilApi::create('[YOUR_ACCESS_TOKEN_HERE]');

Encrypting Data
~~~~~~~~~~~~~~~
.. code-block:: php
    :linenos:

        // search for bob's and alice's Cards
        $bobAndAliceCards = $virgilApi->Cards->find(['bob', 'alice']);

        $message = "Hey Bob and Alice, are you crazy?";

        // encrypt the message for multiple recipients
        $cipherText = $bobAndAliceCards->encrypt($message)
                                       ->toBase64()
        ;

Decrypting Data
~~~~~~~~~~~~~~~
.. code-block:: php
    :linenos:

        // load Bob's Key from storage.
        $bobKey = $virgilApi->Keys->load('[KEY_NAME]', '[KEY_PASSWORD]');

        // decrypt message using Bob's Key.
        $originalMessage = $bobKey->decrypt($cipherText)
                                  ->toString()
        ;

Encrypting & Signing Data
~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: php
    :linenos:

        // load Alice's Key from storage.
        $aliceKey = $virgilApi->Keys->load('[KEY_NAME]', '[KEY_PASSWORD]');

        // search for Bob's Cards.
        $bobCards = $virgilApi->Cards->find(['bob']);

        $message = 'Hey Bob, are you crazy?';

        // sign by Alice's key and then encrypt message for found Bob's Cards.
        $cipherText = $aliceKey->signThenEncrypt($message, $bobCards)
                               ->toBase64()
        ;


Decrypting & Verifying Data
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: php
    :linenos:

        // load Bob's Key from storage.
        $bobKey = $virgilApi->Keys->load('[KEY_NAME]', '[KEY_PASSWORD]');

        // search for Alice's Cards
        $aliceCards = $virgilApi->Cards->find(['alice']);

        /** @var VirgilCardInterface $aliceCard */
        foreach ($aliceCards as $aliceCard) {
            if ($aliceCard->getCard()
                          ->getDevice() == 'iPhone 7'
            ) {
                // decrypt cipher message using Bob's Key and verify it using alice's Card
                $originalMessage = $bobKey->decryptThenVerify($cipherText, $aliceCard)
                                          ->toString()
                ;
            }
        }


Generating and Verifying Signatures
-----------------------------------
This section walks you through the steps to generate a digital signature for data and to verify that a signature is authentic.

.. code-block:: php

    // initialize Virgil SDK high-level API instance
    $virgilApi = VirgilApi::create('[YOUR_ACCESS_TOKEN_HERE]');

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~
To generate the signature, simply call sign method:

.. code-block:: php
    :linenos:

        // load Alice's Key from storage.
        $aliceKey = $virgilApi->Keys->load('[KEY_NAME]', '[KEY_PASSWORD]');

        $message = 'Hey Bob, hope you are doing well.';

        // generate signature of message using alice's key
        $aliceSignature = $aliceKey->sign($message);

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~
The signature can now be verified by calling the verify method:

.. code-block:: php
    :linenos:

        // search for Alice's Card
        $aliceCards = $virgilApi->Cards->find(['alice']);

        /** @var VirgilCardInterface $aliceCard */
        foreach ($aliceCards as $aliceCard) {
            if ($aliceCard->getCard()
                          ->getDevice() == 'iPhone 7'
            ) {
                // verifies that given signature belongs to Alice
                if (!$aliceCard->verify($message, $aliceSignature)) {
                    throw new Exception("Damn Alice it's not you.");
                }
            }
        }


