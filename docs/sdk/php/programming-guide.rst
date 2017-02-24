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

To create an instance of *VirgilClient* class, just call its static method with your application's *accessToken* which you generated on developer's dashboard.

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Client\VirgilClient;


        $client = VirgilClient::create("[ACCESS_TOKEN_HERE]");

note that application's *AccessToken* is not necessary parameter if you are going to work only with global cards:

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Client\VirgilClient;


        $client = VirgilClient::create();

you can also customize initialization using your own parameters

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Client\VirgilClient;
        use Virgil\Sdk\Client\VirgilClientParams;


        $parameters = new VirgilClientParams("[ACCESS_TOKEN_HERE]");

        $parameters->setCardsServiceAddress("https://cards.virgilsecurity.com");
        $parameters->setReadCardsServiceAddress("https://cards-ro.virgilsecurity.com");
        $parameters->setIdentityServiceAddress("https://identity.virgilsecurity.com");
        $parameters->setRegistrationAuthorityService("https://ra.virgilsecurity.com");

        $client = new VirgilClient($parameters);

At this point you can start creating and publishing *Virgil Cards* for your
users.

> *Virgil Card* is the main entity of Virgil Services, it includes the user's
> identity and their public key.

There are two ways to create a Virgil Card.

The first way is to create the Virgil Card in application scope. The cards created this way will only be available to your application (i.e. will only be returned in response to a request presenting your application's *token*).

The second way is to create the Virgil Card in global scope. The cards created in global scope will be available within all Virgil Services and to find them you don't need an application *token*.

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil Services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

Initializing Crypto
~~~~~~~~~~~~~~~~~~~

The *VirgilCrypto* class provides cryptographic operations in applications, such as hashing, signature generation and verification, and encryption and decryption.


.. code-block:: php
    :linenos:

        use Virgil\Sdk\Cryptography\VirgilCrypto;


        $crypto = new VirgilCrypto();

Initializing Request Signer
~~~~~~~~~~~~~~~~~~~~~~~~~~~
The *RequestSigner* class provides methods for signing card requests. There a two ways how card can be signed:
just sign by card owner signature and by any authority signatures like card service signature.

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Client\Requests\RequestSigner;


        $requestSigner = new RequestSigner($crypto);

Registering Virgil Cards
------------------------
Collect an *appID* and *appKey* for your app. These parameters are required to create a Virgil Card in your app scope.
Generate user's Key and create a Virgil Card

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Buffer;


        //collect application related parameters
        $appID = "[APP_ID_HERE]";
        $appKeyPassword = "[APP_KEY_PASSWORD_HERE]";
        $appKeyData = new Buffer(file_get_contents("[APP_KEY_PATH_HERE]"));

        // import application Key
        $appKey = $crypto->importPrivateKey($appKeyData, $appKeyPassword);

        // generate alice's Key
        $aliceKeys = $crypto->generateKeys();

        // create alice's Card using her Key
        var aliceCard = virgil.Cards.Create("alice", aliceKey);

Prepare request

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Client\Requests\PublishCardRequest;


        $exportedPublicKey = $crypto->exportPublicKey($aliceKeys->getPublicKey());

        $createCardRequest = new PublishCardRequest("alice", "username", $exportedPublicKey);

then, use *RequestSigner* class to sign request with owner and app keys.

.. code-block:: php
    :linenos:

        $requestSigner->selfSign($createCardRequest, $aliceKeys->getPrivateKey())
                      ->authoritySign($createCardRequest, $appID, $appKey);

Publish a Virgil Card on Server-Side

.. code-block:: php
    :linenos:

        $aliceCard = $client->createCard($createCardRequest);

Revoking Virgil Cards
---------------------

Prepare revoke request and to perform application card revocation

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Buffer;

        use Virgil\Sdk\Client\Requests\RevokeCardRequest;

        use Virgil\Sdk\Client\Requests\Constants\RevocationReasons;


        //collect application related parameters
        $appID = "[APP_ID_HERE]";
        $appKeyPassword = "[APP_KEY_PASSWORD_HERE]";
        $appKeyData = new Buffer(file_get_contents("[APP_KEY_PATH_HERE]"));

        // import application Key
        $appKey = $crypto->importPrivateKey($appKeyData, $appKeyPassword);

        $cardId = "[CARD_ID_HERE]";

        $revokeRequest = new RevokeCardRequest($cardId, RevocationReasons::TYPE_UNSPECIFIED);

        $requestSigner->authoritySign($revokeRequest, $appID, $appKey);

        $client->revokeCard($revokeRequest);

Registering Global Virgil Cards
-------------------------------
Prepare request

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Client\Requests\Constants\IdentityTypes;

        use Virgil\Sdk\Client\VirgilServices\Model\ValidationModel;

        use Virgil\Sdk\Client\Requests\PublishGlobalCardRequest;


        $exportedPublicKey = $crypto->exportPublicKey($aliceKeys->getPublicKey());

        $createGlobalCardRequest = new PublishGlobalCardRequest("alice@gmail.com", IdentityTypes::TYPE_EMAIL, $exportedPublicKey, new ValidationModel("[VALIDATION_TOKEN_HERE]"));

then, use *RequestSigner* class to sign request with owner signature.

.. code-block:: php
    :linenos:

        $requestSigner->selfSign($createGlobalCardRequest, $aliceKeys->getPrivateKey());

Publish a Global Virgil Card

.. code-block:: php
    :linenos:

        $aliceCard = $client->publishGlobalCard($createGlobalCardRequest);


Revoking Global Virgil Cards
----------------------------
Prepare revoke request and to perform global card revocation

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Client\Requests\Constants\RevocationReasons;

        use Virgil\Sdk\Client\Requests\RevokeGlobalCardRequest;

        use Virgil\Sdk\Client\VirgilServices\Model\ValidationModel;


        $cardId = "[CARD_ID_HERE]";

        $globalRevokeRequest = new RevokeGlobalCardRequest($cardId, RevocationReasons::TYPE_UNSPECIFIED, new ValidationModel("[VALIDATION_TOKEN_HERE]"));

        $requestSigner->authoritySign($globalRevokeRequest, $cardId, $privateKeyReference);

        $client->revokeGlobalCard($globalRevokeRequest);

Search for Virgil Cards
-----------------------
Perform the *Virgil Card* search by criteria request:
- the *IdentityType* is optional and specifies the *IdentityType* of a *Virgil Cards* to be found. Supports any value to describe identity type e.g. *email* etc;
- the *Scope* optional request parameter specifies the scope to perform search on. Either 'global' or 'application'. The default value is 'application';
- There is need append one *Identity* at least or set all of them.

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Client\Requests\SearchCardRequest;


        $searchCardRequest = new SearchCardRequest();

        $searchCardRequest->appendIdentity("alice")
                          ->appendIdentity("bob");

        $cards = $client->searchCards($searchCardRequest);

Generating Virgil Keys
----------------------
Generate a new Virgil Key recommended by Virgil.

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Cryptography\VirgilCrypto;


        $crypto = new VirgilCrypto();

        $aliceKeys = $crypto->generateKeys();

Export & Import Virgil Keys
---------------------------

Export the Virgil Key to Base64 encoded string.

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Cryptography\VirgilCrypto;


        $crypto = new VirgilCrypto();

        $aliceKeys = $crypto->generateKeys();

        $exportedBase64EncodedAliceKey = $virgilCrypto->exportPrivateKey($aliceKeys->getPrivateKey(), "[OPTIONAL_KEY_PASSWORD]")
                                                      ->toBase64();

Import the Virgil Key from Base64 encoded string.

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Buffer;

        use Virgil\Sdk\Cryptography\VirgilCrypto;


        $crypto = new VirgilCrypto();

        $exportedAliceKey = Buffer::fromBase64($exportedBase64EncodedAliceKey);
        $aliceKey = $crypto->importPrivateKey($exportedAliceKey, "[OPTIONAL_KEY_PASSWORD]");

Same import\export operations are available for public keys.

Encryption
----------
Initialize Crypto API and generate keypairs.

.. code-block:: php

    use Virgil\Sdk\Cryptography\VirgilCrypto;


    $crypto = new VirgilCrypto();

    $aliceKeys = $crypto->generateKeys();
    $bobKeys = $crypto->generateKeys();

Encrypting Data
~~~~~~~~~~~~~~~
Data encryption using ECIES scheme with AES-GCM. You can encrypt either data string or stream.
There also can be more than one recipient

.. code-block:: php
    :linenos:

        $plaintext = "Hello Alice!";

        $encryptedDataBase64Encoded = $crypto->encrypt($plaintext, [$aliceKeys->getPublicKey()])
                                             ->toBase64();
Decrypting Data
~~~~~~~~~~~~~~~
.. code-block:: php
    :linenos:

        use Virgil\Sdk\Buffer;

        $encryptedData = Buffer::fromBase64($encryptedDataBase64Encoded);
        $originalMessage = $crypto->decrypt($encryptedData, $aliceKeys->getPrivateKey())
                                  ->toString();

Encrypting & Signing Data
~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: php
    :linenos:

        $data = "Hello Bob, How are you?";

        $encryptedDataBase64Encoded = $crypto->signThenEncrypt($data, $aliceKeys->getPrivateKey(), [$bobKeys->getPublicKey()])
                                             ->toBase64();

Decrypting & Verifying Data
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Buffer;

        $encryptedData = Buffer::fromBase64($encryptedDataBase64Encoded);
        $originalMessage = $crypto->decryptThenVerify($encryptedData, $bobKeys->getPrivateKey(), $aliceKeys->getPublicKey())
                                  ->toString();

Generating and Verifying Signatures
-----------------------------------
This section walks you through the steps necessary to use the *VirgilCrypto* to generate a digital signature for data and to verify that a signature is authentic.

.. code-block:: php

    use Virgil\Sdk\Cryptography\VirgilCrypto;


    $crypto = new VirgilCrypto();

    $aliceKeys = $crypto->generateKeys();

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~
To generate the signature, simply call the sign method:

.. code-block:: php
    :linenos:

        $message = "Hey Bob, hope you are doing well.";

        // generate signature of message using Alice's key pair
        $signature = $crypto->sign($message, $aliceKeys->getPrivateKey());

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~
The signature can now be verified by calling the verify method:

.. code-block:: php
    :linenos:
    
        // verify if message was signed by Alice.
        $isValid = $crypto->verify($message, $signature, $aliceKeys->getPublicKey());

        if(!$isValid)
        {
            throw new Exception("Damn Alice it's not your message.");
        }

