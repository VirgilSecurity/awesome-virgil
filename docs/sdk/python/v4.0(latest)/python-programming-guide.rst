Python SDK Programming Guide
=============================

Creating a Virgil Card
----------------------

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

``app_id``, ``app_key`` parameters are required to create a **Virgil Card** in your app scope.

Collect App Credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~

Collect an ``app_id`` and ``app_key`` for your app:

.. code-block:: python
    :linenos:

    app_id = "[YOUR_APP_ID_HERE]"
    app_key_password = "[YOUR_APP_KEY_PASSWORD_HERE]"
    app_key_data = crypto.strtobytes(open("[YOUR_APP_KEY_PATH_HERE]", "r").read())

    app_key = crypto.import_private_key(app_key_data, app_key_password)

Generate New Keys
~~~~~~~~~~~~~~~~~~~

Generate a new Public/Private keypair using ``VirgilCrypto`` class:

.. code-block:: python
    :linenos:

    alice_keys = crypto.generate_keys()

Prepare Request
~~~~~~~~~~~~~~~

.. code-block:: python
    :linenos:

    exported_public_key = crypto.export_public_key(alice_keys.public_key)
    create_card_request = client.requests.CreateCardRequest("alice", "username", exported_public_key)

then, use ``RequestSigner`` class to sign request with owner's and app's keys:

.. code-block:: python
    :linenos:

    request_signer = client.RequestSigner(crypto)

    request_signer.self_sign(create_card_request, alice_keys.private_key)
    requestSigner.authority_sign(create_card_request, app_id, app_key)

Publish a Virgil Card
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: python
    :linenos:

    alice_card = virgil_client.create_card_from_signed_request

Or you can use the shorthand version which will sign and send the card creation request.

.. code-block:: python
    :linenos:

    alice_keys = crypto.generate_keys()
    alice_card = virgil_client.create_card(
        identity="alice",
        identity_type="username",
        key_pair=alice_keys,
        app_id=app_id,
        app_key=app_key
    )

Search for Virgil Cards
---------------------------

You can search for **Virgil Cards** by identity value(s) and optional additional parameters can be set:

    - identity type ('email' or any type created by user). You can find more information about :term:`confirmed <Confirmed Card>` and :term:`unconfirmed <Unconfirmed Card>` **Virgil Cards**.
    - scope (by default it is 'application', can be 'global'). You can find more information about :term:`global <Global Virgil Card>` and :term:`application <Application Virgil Card>` **Virgil Cards**.

.. code-block:: python
    :linenos:

    virgil_client = VirgilClient("[YOUR_ACCESS_TOKEN_HERE]")

    criteria = SearchCriteria.by_identities("alice", "bob")
    cards = client.search_cards_by_criteria(criteria)

Or you can use the shorthand version

.. code-block:: python
    :linenos:

    virgil_client = VirgilClient("[YOUR_ACCESS_TOKEN_HERE]")

    cards = client.search_cards_by_identities("alice", "bob")
    app_bundle_cards = client.seach_cards_by_app_bundle("[APP_BUNDLE]")

Validating a Virgil Card
---------------------------

You might want to make sure that a received **Virgil Card** wasn't changed, Public Key is authentic, or validate any other fields.
This sample uses built-in ``CardValidator`` to validate **Virgil Cards**. By default ``CardValidator`` validates only Cards Service signature.

.. code-block:: python
    :linenos:

    # Initialize crypto API
    crypto = VirgilCrypto()

    validator = CardValidator(crypto)

    # You can also add another Public Key for verification.
    # validator.add_verifier("[HERE_VERIFIER_CARD_ID]", [HERE_VERIFIER_PUBLIC_KEY]);

    # Initialize service client
    virgil_client = VirgilClient("[YOUR_ACCESS_TOKEN_HERE]")
    virgil_client.set_card_validator(validator)

    try:
        cards = virgil_client.search_cards_by_identities("alice", "bob");
    except CardValidationException as ex:
        # ex.invalid_cards is the list of Card objects that didn't pass validation

Get a Virgil Card
---------------------------

Gets a Virgil Card by ID.

.. code-block:: python
    :linenos:

    virgil_client = VirgilClient("[YOUR_ACCESS_TOKEN_HERE]")
    card = virgil_client.get_card("[YOUR_CARD_ID_HERE]")

Revoking a Virgil Card
---------------------------

You can delete a **Virgil Card** in case the keys were compromised or lost, or for any other reason.

Initialize required components.

.. code-block:: python
    :linenos:

    virgil_client = new VirgilClient("[YOUR_ACCESS_TOKEN_HERE]")
    crypto = VirgilCrypto()
    request_signer = RequestSigner(crypto)

Collect **App** credentials

.. code-block:: python
    :linenos:

    app_id = "[YOUR_APP_ID_HERE]"
    app_key_password = "[YOUR_APP_KEY_PASSWORD_HERE]"
    app_key_data = crypto.strtobytes(open("[YOUR_APP_KEY_PATH_HERE]", "r").read())

    app_key = crypto.import_private_key(app_key_data, app_key_password)

Prepare revocation request

.. code-block:: python
    :linenos:

    card_id = "[YOUR_CARD_ID_HERE]"

    revoke_request = RevokeCardRequest(card_id, RevokeCardRequest.Reasons.Unspecified)
    request_signer.authority_sign(revoke_request, app_id, app_key)

    client.revoke_card_from_signed_request(revoke_request);

The shorthand version is

.. code-block:: python
    :linenos:

    virgil_client.revoke_card(
        card_id="[YOUR_CARD_ID_HERE]",
        reason=RevokeCardRequest.Reasons.Unspecified,
        app_id=app_id,
        app_key=app_key
    )


Operations with Crypto Keys
---------------------------

Generate Keys
~~~~~~~~~~~~~

You can generate a keypair using ``VirgilCrypto`` class. The default algorithm is ``ed25519``. 

.. code-block:: python
    :linenos:

    alice_keys = crypto.generate_keys()

Import and Export Keys
~~~~~~~~~~~~~~~~~~~~~~

If you need to import or export your Public/Private keys you can easily do it.
Simply call one of the Export methods:

.. code-block:: python
    :linenos:

    exported_private_key = crypto.export_private_key(alice_keys.private_key)
    exported_public_key = crypto.export_public_key(alice_keys.public_key)

To import Public/Private keys, simply call one of the Import methods:

.. code-block:: python
    :linenos:

    private_key = crypto.import_private_key(exported_private_key)
    public_key = crypto.import_public_key(exported_public_key)


Encryption and Decryption
---------------------------

Initialize Crypto API and generate keypair.

.. code-block:: python
    :linenos:

    crypto = VirgilCrypto()
    alice_keys = crypto.generate_keys()

Encrypt Data
~~~~~~~~~~~~

You can enrypt some data, ECIES scheme with ``AES-GCM`` is used in **Virgil Security**. You have several options for encryption:

    - stream encryption;
    - byte array encryption;
    - one recipient;
    - multiple recipients (public keys of every user are used for encryption).

*Byte Array*

.. code-block:: python
    :linenos:

    plain_data = crypto.strtobytes("Hello Bob!")
    cipher_data = crypto.encrypt(plain_data, alice_keys.public_key)

*Stream*

.. code-block:: python
    :linenos:

    with io.open("[YOUR_FILE_PATH_HERE]", "rb") as input_stream:
        with io.open("[YOUR_ENCRYPTED_FILE_PATH_HERE]", "wb") as output_stream:
            c.encrypt_stream(input_stream, output_stream, [alice_keys.public_key])
     
Decrypt Data
~~~~~~~~~~~~

You can decrypt data using your private key. You have such options for decryption: 

    - stream;
    - byte array.

*Byte Array*

.. code-block:: python
    :linenos:

    crypto.decrypt(cipher_data, alice_keys.private_key);

*Stream*

.. code-block:: python
    :linenos:

    with io.open("[YOUR_ENCRYPTED_FILE_PATH_HERE]", "rb") as cipher_stream:
        with io.open("[YOUR_DECRYPTED_FILE_PATH_HERE]", "wb") as result_stream:
            c.decrypt_stream(cipher_stream, result_stream, alice_keys.private_key)

Generating and Verifying Signatures
-----------------------------------

Generate a new Public/Private keypair and ``data`` to be signed.

.. code-block:: python
    :linenos:

    crypto = new VirgilCrypto()
    alice_keys = crypto.GenerateKeys()

    # The data to be signed with alice's Private key
    data = crypto.strtobytes("Hello Bob, How are you?")

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~

You can generate a digital signature for data. Options for signing data:

    - stream;
    - byte array.

*Byte Array*

.. code-block:: python
    :linenos:

    signature = crypto.sign(data, alice.private_key)

*Stream*

.. code-block:: python
    :linenos:

    with io.open("[YOUR_FILE_PATH_HERE]", "rb") as input_stream:
        signature = crypto.sign_stream(input_stream, alice.private_key)

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~

You can verify that a signature is authentic. You will verify the signature of the ``SHA-384`` fingerprint using the public key. Options for verification:

    - stream;
    - byte array.

*Byte Array*

.. code-block:: python
    :linenos:

    is_valid = crypto.verify(data, signature, alice.public_key)
     
*Stream*
     
.. code-block:: python
    :linenos:    

    with io.open("[YOUR_FILE_PATH_HERE]", "rb") as input_stream:
        is_valid = crypto.verify_stream(input_stream, signature, alice.public_key)

Authenticated Encryption
-------------------------

Authenticated encryption provides both data confidentiality and data integrity assurances that the information is protected.

.. code-block:: python
    :linenos:  

    crypto = VirgilCrypto()

    alice = crypto.generate_keys()
    bob = crypto.generate_keys()

    # The data to be signed with alice's Private key
    data = crypto.strtobytes("Hello Bob, How are you?")

Sign then Encrypt
~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: python
    :linenos: 

    cipher_data = crypto.sign_then_encrypt(
    data,
    alice.private_key,
    bob.public_key
    )

Decrypt then Verify
~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: python
    :linenos: 

    decrypted_data = crypto.decrypt_then_verify(
    cipher_data,
    bob.private_key,
    alice.public_key
    )

Fingerprint Generation
----------------------

The default Fingerprint algorithm is ``SHA-256``.

.. code-block:: python
    :linenos:

    crypto = new VirgilCrypto()
    fingerprint = crypto.calculate_fingerprint(content_bytes)

See Also: 
---------
`Source code <https://github.com/VirgilSecurity/virgil-sdk-python/tree/v4>`__