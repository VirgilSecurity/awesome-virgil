Javascript SDK Programming Guide
================================

Creating a Virgil Card
----------------------

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

``appID`` and ``appKey`` parameters are required to create a **Virgil Card** in your app scope.

Collect App Credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~

Collect an ``appID`` and ``appKey`` for your app:

.. code-block:: javascript
    :linenos:

    var appID = "[YOUR_APP_ID_HERE]";
    var appKeyPassword = "[YOUR_APP_KEY_PASSWORD_HERE]";

    // Browsers
    var appKeyData = new virgil.Buffer("[YOUR_BASE64_ENCODED_APP_KEY_HERE]", "base64");

    // Node
    // var appKeyData = new Buffer("[YOUR_BASE64_ENCODED_APP_KEY_HERE]", "base64");

    var appKey = crypto.importPrivateKey(appKeyData, appKeyPassword);

Generate New Keys
~~~~~~~~~~~~~~~~~~~

Generate a new Public/Private keypair using ``VirgilCrypto`` class:

.. code-block:: javascript
    :linenos:

    var aliceKeys = crypto.generateKeys();

Prepare Request
~~~~~~~~~~~~~~~

To make request object to create a Virgil Card use ``virgil.cardCreateRequest`` factory function. It accepts an ``options`` object with the following properties: 

- **public\_key** 
- Public key associated with the Card as a ``Buffer`` (Required) 
- **scope** - Determines the *Virgil Card*'s scope that can be either *'global'* or *'application'*. Creating 'global' cards is *not supported* by this SDK currently so you may omit this parameter as it defaults to "application"
- **identity\_type** - Can be any string value (Required) 
- **identity** - Can be any string value (Required) 
- **data** - Associative array that contains application specific parameters. All keys must contain only latin characters and digits. The length of keys and values must not exceed 256 characters. Max number of entries is 16 (Optional) 
- **info** - Associative array with predefined keys that contain information about the device associated with the Card. The keys are always 'device\_name' and 'device' and the values must not exceed 256 characters. (Optional)

.. code-block:: javascript
    :linenos:

    var exportedPublicKey = crypto.exportPublicKey(aliceKeys.publicKey);
    var createCardRequest = virgil.cardCreateRequest({
          public_key: exportedPublicKey,
          identity: "alice",
          identity_type: "username"
        });

Sign request
~~~~~~~~~~~~

When you have the request object ready you must sign it with two private keys: the key of the Card being created and your application's key. Use ``virgil.requestSigner`` function to create an object you can use to sign the request

.. code-block:: javascript
    :linenos:

    var requestSigner = virgil.requestSigner(crypto);

    requestSigner.selfSign(createCardRequest, aliceKeys.privateKey);
    requestSigner.authoritySign(createCardRequest, appID, appKey);

Publish a Virgil Card
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: javascript
    :linenos:

    client.createCard(createCardRequest).then(function (aliceCard) {
      console.log(aliceCard);
    });

Get Virgil Card by Id
---------------------

To get a single Virgil Card by its Id use ``client.getCard`` method. It accepts a single argument - ``card_id`` as a string

.. code-block:: javascript
    :linenos:

    var client = virgil.client("[YOUR_ACCESS_TOKEN_HERE]");
    var cardId = "[ID_OF_CARD_TO_GET]";
    client.getCard(cardId).then(function (card) {
      console.log(card);
    });

Search for Virgil Cards
---------------------------

You can search for **Virgil Cards** by identity value(s) and optional additional parameters can be set:

    - identity type ('email' or any type created by user). You can find more information about :term:`confirmed <Confirmed Card>` and :term:`unconfirmed <Unconfirmed Card>` **Virgil Cards**.
    - scope (by default it is 'application', can be 'global'). You can find more information about :term:`global <Global Virgil Card>` and :term:`application <Application Virgil Card>` **Virgil Cards**.

.. code-block:: javascript
    :linenos:

    var client = virgil.client("[YOUR_ACCESS_TOKEN_HERE]");
     
    var criteria = {
      identities: [ "alice", "bob" ]
    };
    client.searchCards(criteria).then(function (cards) {
      console.log(cards);
    });

Validating a Virgil Card
---------------------------

You might want to make sure that a received **Virgil Card** wasn't changed, Public Key is authentic, or validate any other fields.
This sample uses built-in ``cardValidator`` to validate **Virgil Cards**. By default ``cardValidator`` validates only Cards Service signature.

.. code-block:: javascript
    :linenos:

    // Get the crypto reference
    var crypto = virgil.crypto;

    var validator = virgil.cardValidator(crypto);

    // Your can also add another Public Key for verification.
    // validator.addVerifier("[VERIFIER_CARD_ID]", [VERIFIER_PUBLIC_KEY_AS_BUFFER]);

    // Initialize service client
    var client = virgil.client("[YOUR_ACCESS_TOKEN_HERE]");
    client.setCardValidator(validator);

    var criteria = {
      identities: [ "alice", "bob" ]
    };
    client.searchCards(criteria)
    .then(function (cards) {
      console.log(cards);
    })
    .catch(function (err) {
      if (err.invalidCards) {
        // err.invalidCards contains an array of Card objects that didn't pass validation
      }
    });

Revoking a Virgil Card
---------------------------

You can delete a **Virgil Card** in case the keys were compromised or lost, or for any other reason.

Initialize required components:

.. code-block:: javascript
    :linenos:

    var client = virgil.client("[YOUR_ACCESS_TOKEN_HERE]");
    var crypto = virgil.crypto;
    var requestSigner = virgil.requestSigner(crypto);
  
Collect an *App* credentials:

.. code-block:: javascript
    :linenos:

    var appID = "[YOUR_APP_ID_HERE]";
    var appKeyPassword = "[YOUR_APP_KEY_PASSWORD_HERE]";

    // Browsers
    var appKeyData = new virgil.Buffer("[YOUR_BASE64_ENCODED_APP_KEY_HERE]", "base64");

    // Node
    // var appKeyData = new Buffer("[YOUR_BASE64_ENCODED_APP_KEY_HERE]", "base64");

    var appKey = crypto.importPrivateKey(appKeyData, appKeyPassword);

Prepare revocation request:

To make a request object to revoke a Virgil Card use ``virgil.cardRevokeRequest`` factory function. It accepts an ``options`` object with the following properties: 

- **card\_id** - Id of card to revoke (Required) 
- **revocation\_reason** - The reason for revoking the card. Must be either "unspecified" or "compromised". Default is "unspecified"

.. code-block:: javascript
    :linenos:

    var cardId = "[YOUR_CARD_ID_HERE]";

    var revokeRequest = virgil.cardRevokeRequest({
      card_id: cardId,
      revocation_reason: "compromised"
    });

Sign request

.. code-block:: javascript
    :linenos:

    requestSigner.authoritySign(revokeRequest, appID, appKey);

Send request

.. code-block:: javascript
    :linenos:

    client.revokeCard(revokeRequest).then(function () {
      console.log('Revoked successfully');
    });


Operations with Crypto Keys
---------------------------

Generate Keys
~~~~~~~~~~~~~

You can generate a keypair using ``VirgilCrypto`` class. The default algorithm is ``ed25519``. 

.. code-block:: javascript
    :linenos:

    var aliceKeys = crypto.generateKeys();

To specify a different algorithm, pass one of the values of ``virgil.crypto.KeyPairType`` enumeration

.. code-block:: javascript
    :linenos:

    var aliceKeys = crypto.generateKeys(crypto.KeyPairType.FAST_EC_X25519) // Curve25519

Import and Export Keys
~~~~~~~~~~~~~~~~~~~~~~

All ``virgil.crypto`` API functions accept and return keys in an internal format. To get the raw key data as ``Buffer`` object use ``exportPrivateKey`` and ``exportPublicKey`` methods of ``virgil.crypto`` passing the appropriate internal key representation.

To get the internal key representation out of the raw key data use ``importPrivateKey`` and ``importPublicKey`` respectively:

.. code-block:: javascript
    :linenos:

    var exportedPrivateKey = crypto.exportPrivateKey(aliceKeys.privateKey);
    var exportedPublicKey = crypto.exportPublicKey(aliceKeys.publicKey);

    var privateKey = crypto.importPrivateKey(exportedPrivateKey);
    var publicKey = crypto.importPublicKey(exportedPublicKey);


Encryption and Decryption
---------------------------

Initialize Crypto API and generate keypair.

.. code-block:: javascript
    :linenos:

    var crypto = virgil.crypto;
    var aliceKeys = crypto.generateKeys();

Encrypt Data
~~~~~~~~~~~~

The ``virgil.crypto.encrypt`` method requires two parameters: 

- **data** - The data to be encrypted as a Buffer 
- **recipients** - Public key or an array of public keys to encrypt the data with

.. code-block:: javascript
    :linenos:

    // Browsers
    var plaintext = new virgil.Buffer("Hello Bob!");

    // Node.js
    // var plaintext = new Buffer("Hello Bob!");


    var cipherData = crypto.encrypt(plaintext, aliceKeys.publicKey);
     
Decrypt Data
~~~~~~~~~~~~

The ``virgil.crypto.decrypt`` method requires two parameters: 

- **cipherData** - Encrypted data as a Buffer 
- **privateKey** - The private key to decrypt with

.. code-block:: javascript
    :linenos:

    var decryptedData = crypto.decrypt(cipherData, aliceKeys.privateKey);

Generating and Verifying Signatures
-----------------------------------

This section walks you through the steps necessary to use the ``virgil.crypto`` to generate a digital signature for data and to verify that a signature is authentic.

Generate a new Public/Private keypair and *data* to be signed.

.. code-block:: javascript
    :linenos:

    var crypto = virgil.crypto;
    var aliceKeys = crypto.generateKeys();

    // The data to be signed with Alice's Private key
    // Browsers
    var data = new virgil.Buffer("Hello Bob, How are you?");

    // Node.js
    // var data = new Buffer("Hello Bob, How are you?");

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~

Sign the SHA-384 fingerprint of data using your private key. To generate the signature, simply call one of the sign methods:

.. code-block:: javascript
    :linenos:

    var signature = crypto.sign(data, aliceKeys.privateKey);

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~

Verify the signature of the SHA-384 fingerprint of data using Public
key. The signature can now be verified by calling the verify method:

.. code-block:: javascript
    :linenos:  

    var isValid = crypto.verify(data, signature, alice.publicKey);


Fingerprint Generation
----------------------

The default Fingerprint algorithm is ``SHA-256``.

.. code-block:: javascript
    :linenos:

    var crypto = virgil.crypto;

    // Browsers
    var content = new virgil.Buffer("CONTENT_TO_CALCULATE_FINGERPRINT_OF");

    // Node.js
    // var content = new Buffer("CONTENT_TO_CALCULATE_FINGERPRINT_OF");

    var fingerprint = crypto.calculateFingerprint(content);

See Also: 
---------
`Source code <https://github.com/VirgilSecurity/virgil-sdk-javascript/releases/tag/4.0.0-beta.0>`__