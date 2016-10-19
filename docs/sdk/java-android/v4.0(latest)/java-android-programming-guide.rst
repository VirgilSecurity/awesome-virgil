Java/Android SDK Programming Guide
=====================================

Creating a Virgil Card
----------------------

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

``appID`` and ``appKey`` parameters are required to create a **Virgil Card** in your app scope.

Collect App Credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~

Collect an ``appID`` and ``appKey`` for your app:

.. code-block:: java
    :linenos:

    String appID = "[YOUR_APP_ID_HERE]";
    String appKeyPassword = "[YOUR_APP_KEY_PASSWORD_HERE]";
    String appKeyData = "[YOUR_APP_KEY_HERE]";

    String appKey = crypto.importPrivateKey(appKeyData.getBytes(), appKeyPassword);

Generate New Keys
~~~~~~~~~~~~~~~~~~~

Generate a new Public/Private keypair using ``VirgilCrypto`` class:

.. code-block:: java
    :linenos:

    KeyPair aliceKeys = crypto.generateKeys();

Prepare Request
~~~~~~~~~~~~~~~

.. code-block:: java
    :linenos:

    byte[] exportedPublicKey = crypto.exportPublicKey(aliceKeys.getPublicKey());
    CreateCardRequest createCardRequest = new CreateCardRequest("alice", "username", exportedPublicKey);

then, use ``RequestSigner`` class to sign request with owner's and app's keys:

.. code-block:: java
    :linenos:

    RequestSigner requestSigner = new RequestSigner(crypto);

    requestSigner.selfSign(createCardRequest, aliceKeys.getPrivateKey());
    requestSigner.authoritySign(createCardRequest, appID, appKey);

Publish a Virgil Card
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: java
    :linenos:

    Card aliceCard = client.createCard(createCardRequest);


Search for Virgil Cards
---------------------------

You can search for **Virgil Cards** by identity value(s) and optional additional parameters can be set:

    - identity type ('email' or any type created by user). You can find more information about :term:`confirmed <Confirmed Card>` and :term:`unconfirmed <Unconfirmed Card>` **Virgil Cards**.
    - scope (by default it is 'application', can be 'global'). You can find more information about :term:`global <Global Virgil Card>` and :term:`application <Application Virgil Card>` **Virgil Cards**.

.. code-block:: java
    :linenos:

    VirgilClient client = new VirgilClient("[YOUR_ACCESS_TOKEN_HERE]");

    SearchCriteria criteria = SearchCriteria.byIdentities(Arrays.asList("alice", "bob"));
    List<Card> cards = client.searchCards(criteria);

Validating a Virgil Card
---------------------------

You might want to make sure that a received **Virgil Card** wasn't changed, Public Key is authentic, or validate any other fields.
This sample uses built-in ``CardValidator`` to validate **Virgil Cards**. By default ``CardValidator`` validates only Cards Service signature.

.. code-block:: java
    :linenos:

    // Initialize crypto API
    Crypto crypto = new VirgilCrypto();

    VirgilCardValidator validator = new VirgilCardValidator(crypto);

    // Your can also add another Public Key for verification.
    // validator.addVerifier("[HERE_VERIFIER_CARD_ID]", [HERE_VERIFIER_PUBLIC_KEY]);

    // Initialize service client
    VirgilClient client = new VirgilClient("[YOUR_ACCESS_TOKEN_HERE]");
    client.setCardValidator(validator);

    try {
        SearchCriteria criteria = SearchCriteria.byIdentities(Arrays.asList("alice", "bob"));
        List<Card> cards = client.searchCards(criteria);
        ...
    } catch (CardValidationException ex) {
        // ex.getInvalidCards()
    }

Revoking a Virgil Card
---------------------------

You can delete a **Virgil Card** in case the keys were compromised or lost, or for any other reason.

Initialize required components:

.. code-block:: java
    :linenos:

    Crypto crypto = new VirgilCrypto();
    VirgilClient client = new VirgilClient("[YOUR_ACCESS_TOKEN_HERE]");

    RequestSigner requestSigner = new RequestSigner(crypto);
  
Collect an *App* credentials:

.. code-block:: java
    :linenos:

    String appID = "[YOUR_APP_ID_HERE]";
    String appKeyPassword = "[YOUR_APP_KEY_PASSWORD_HERE]";
    String appKeyData = "[YOUR_APP_KEY_PATH_HERE]";

    String appKey = crypto.importPrivateKey(appKeyData.getBytes(), appKeyPassword);

Prepare revocation request:

.. code-block:: java
    :linenos:

    String cardId = "[YOUR_CARD_ID_HERE]";

    RevokeCardRequest revokeRequest = new RevokeCardRequest(cardId, RevocationReason.UNSPECIFIED);
    requestSigner.authoritySign(revokeRequest, appID, appKey);

    client.revokeCard(revokeRequest);


Operations with Crypto Keys
---------------------------

Generate Keys
~~~~~~~~~~~~~

You can generate a keypair using ``VirgilCrypto`` class. The default algorithm is ``ed25519``. 

.. code-block:: java
    :linenos:

    KeyPair aliceKeys = crypto.generateKeys();

Import and Export Keys
~~~~~~~~~~~~~~~~~~~~~~

If you need to import or export your Public/Private keys you can easily do it.
Simply call one of the Export methods:

.. code-block:: java
    :linenos:

    byte[] exportedPrivateKey = crypto.exportPrivateKey(aliceKeys.getPrivateKey());
    byte[] exportedPublicKey = crypto.exportPublicKey(aliceKeys.getPublicKey());

To import Public/Private keys, simply call one of the Import methods:

.. code-block:: java
    :linenos:

    PrivateKey privateKey = crypto.importPrivateKey(exportedPrivateKey);
    PublicKey publicKey = crypto.importPublicKey(exportedPublicKey);


Encryption and Decryption
---------------------------

Initialize Crypto API and generate keypair.

.. code-block:: java
    :linenos:

    Crypto crypto = new VirgilCrypto();
    KeyPair aliceKeys = crypto.generateKeys();

Encrypt Data
~~~~~~~~~~~~

You can enrypt some data, ECIES scheme with ``AES-GCM`` is used in **Virgil Security**. You have several options for encryption:

    - stream encryption;
    - byte array encryption;
    - one recipient;
    - multiple recipients (public keys of every user are used for encryption).

*Byte Array*

.. code-block:: java
    :linenos:

    byte[] plaintext = "Hello Bob!".getBytes();
    byte[] cipherData = crypto.encrypt(plaintext, new PublicKey[] { aliceKeys.getPublicKey() });

*Stream*

.. code-block:: java
    :linenos:

    try (InputStream in = new FileInputStream([YOUR_FILE_PATH_HERE]);
            OutputStream out = new FileOutputStream("[YOUR_ENCRYPTED_FILE_PATH_HERE]")) {

        crypto.encrypt(in, out, new PublicKey[] { aliceKeys.getPublicKey() });
    }
     
Decrypt Data
~~~~~~~~~~~~

You can decrypt data using your private key. You have such options for decryption: 

    - stream;
    - byte array.

*Byte Array*

.. code-block:: java
    :linenos:

    byte[] decryptedData = crypto.decrypt(cipherData, aliceKeys.getPrivateKey());

*Stream*

.. code-block:: java
    :linenos:

    try (InputStream in = new FileInputStream("[YOUR_ENCRYPTED_FILE_PATH_HERE]");
            OutputStream out = new FileOutputStream("[YOUR_DECRYPTED_FILE_PATH_HERE]")) {

        crypto.decrypt(in, out, aliceKeys.getPrivateKey());
    }

Generating and Verifying Signatures
-----------------------------------

Generate a new Public/Private keypair and ``data`` to be signed.

.. code-block:: java
    :linenos:

    Crypto crypto = new VirgilCrypto();
    KeyPair alice = crypto.generateKeys();

    byte[] data = "Hello Bob, How are you?".getBytes();

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~

You can generate a digital signature for data. Options for signing data:

    - stream;
    - byte array.

*Byte Array*

.. code-block:: java
    :linenos:

    byte[] signature = crypto.sign(data, alice.getPrivateKey());

*Stream*

.. code-block:: java
    :linenos:

    try (InputStream in = new FileInputStream("[YOUR_FILE_PATH_HERE]")) {

        byte[] signature = crypto.sign(in, alice.getPrivateKey());
    }

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~

You can verify that a signature is authentic. You will verify the signature of the ``SHA-384`` fingerprint using the public key. Options for verification:

    - stream;
    - byte array.

*Byte Array*

.. code-block:: java
    :linenos:

    boolean isValid = crypto.verify(data, signature, alice.getPublicKey());
     
*Stream*
     
.. code-block:: java
    :linenos:    

    try (InputStream in = new FileInputStream("[YOUR_FILE_PATH_HERE]")) {

        boolean isValid = crypto.verify(in, signature, alice.getPublicKey());
    }


Fingerprint Generation
----------------------

The default Fingerprint algorithm is ``SHA-256``.

.. code-block:: java
    :linenos:

    Fingerprint fingerprint = crypto.calculateFingerprint("Just a text".getBytes());

See Also: 
---------
`Source code <https://github.com/VirgilSecurity/virgil-sdk-java-android>`__