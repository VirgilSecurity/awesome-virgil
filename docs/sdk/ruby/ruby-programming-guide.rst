.NET/C# SDK Programming Guide
=============================

Creating a Virgil Card
----------------------

A *Virgil Card* is the main entity of the Virgil services, it includes the information about the user and his public key. The *Virgil Card* identifies the user/device by one of his types.

Collect App Credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~

Collect an *app_id* and *app_key* for your app. These parametes are required to create a Virgil Card in your app scope.

.. code-block:: ruby
    :linenos:

    app_id = "[YOUR_APP_ID_HERE]"
    app_key_password = "[YOUR_APP_KEY_PASSWORD_HERE]"
    app_key_data = Virgil::Crypto::Bytes.from_string(File.read("[YOUR_APP_KEY_PATH_HERE]"))

    app_key = crypto.import_private_key(app_key_data, app_key_password)

Generate New Keys
~~~~~~~~~~~~~~~~~~~

Generate a new Public/Private keypair using *VirgilCrypto* class:

.. code-block:: ruby
    :linenos:

    alice_keys = crypto.generate_keys()

Prepare Request
~~~~~~~~~~~~~~~

.. code-block:: ruby
    :linenos:

    exported_public_key = crypto.export_public_key(alice_keys.public_key)
    create_card_request = Virgil::SDK::Client::Requests::CreateCardRequest.new(
        identity: "alice",
        identity_type: "username",
        public_key: exported_public_key
    )

then, use ``RequestSigner`` class to sign request with owner's and app's keys:

.. code-block:: ruby
    :linenos:

    request_signer = Virgil::SDK::Client::RequestSigner.new(crypto)

    request_signer.self_sign(create_card_request, alice_keys.private_key)
    request_signer.authority_sign(create_card_request, app_id, app_key)

Publish a Virgil Card
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: ruby
    :linenos:

    alice_card = client.create_card_from_signed_request(create_card_request)

Or you can use the shorthand versions

.. code-block:: ruby
    :linenos:

    alice_keys = crypto.generate_keys()

    alice_card = virgil_client.create_card(
      "alice",
      "username",
      alice_keys,
      app_id,
      app_key
    )


Search for Virgil Cards
---------------------------

Performs the `Virgil Card`s search by criteria:
- the *identities* request parameter is mandatory;
- the *identity_type* is optional and specifies the *IdentityType* of a `Virgil Card`s to be found;
- the *scope* optional request parameter specifies the scope to perform search on. Either 'global' or 'application'. The default value is 'application';

.. code-block:: ruby
    :linenos:

    client = Virgil::SDK::Client::VirgilClient.new("[YOUR_ACCESS_TOKEN_HERE]")

    criteria = Virgil::SDK::Client::SearchCriteria.by_identities("alice", "bob")
    cards = client.search_cards_by_criteria(criteria)
    
Getting a Virgil Card
---------------------------

Gets a `Virgil Card` by ID.

.. code-block:: ruby
    :linenos:
    
    client = Virgil::SDK::Client::VirgilClient.new("[YOUR_ACCESS_TOKEN_HERE]")
    card = client.get_card("[YOUR_CARD_ID_HERE]")

Validating a Virgil Card
---------------------------

This sample uses *built-in* ```CardValidator``` to validate cards. By default ```CardValidator``` validates only *Cards Service* signature.

.. code-block:: ruby
    :linenos:

    # Initialize crypto API
    crypto = Virgil::SDK::Cryptography::VirgilCrypto.new

    validator = Virgil::SDK::Client::CardValidator.new(crypto)

    # Your can also add another Public Key for verification.
    # validator.add_verifier("[HERE_VERIFIER_CARD_ID]", [HERE_VERIFIER_PUBLIC_KEY]);

    # Initialize service client
    client = Virgil::SDK::Client::VirgilClient.new("[YOUR_ACCESS_TOKEN_HERE]")
    client.set_card_validator(validator)

    begin
        cards = client.search_cards_by_identities("alice", "bob");
    rescue Virgil::SDK::Client::InvalidCardException => ex
        # ex.invalid_cards is the list of Card objects that didn't pass validation
    end

Revoking a Virgil Card
---------------------------

You can delete a **Virgil Card** in case the keys were compromised or lost, or for any other reason.

Initialize required components:

.. code-block:: ruby
    :linenos:
    
    client = Virgil::SDK::Client::VirgilClient.new("[YOUR_ACCESS_TOKEN_HERE]")
    crypto = Virgil::SDK::Cryptography::VirgilCrypto.new
    request_signer = Virgil::SDK::Client::RequestSigner.new(crypto)
  
Collect an *App* credentials:

.. code-block:: csharp
    :linenos:

    app_id = "[YOUR_APP_ID_HERE]"
    app_key_password = "[YOUR_APP_KEY_PASSWORD_HERE]"
    app_key_path = "[YOUR_APP_KEY_PATH_HERE]"
    app_key_data = Virgil::Crypto::Bytes.from_string(File.read(app_key_path))

    app_key = crypto.import_private_key(app_key_data, app_key_password)

Prepare revocation request:

.. code-block:: ruby
    :linenos:

    card_id = "[YOUR_CARD_ID_HERE]"

    revoke_request = Virgil::SDK::Client::Requests::RevokeCardRequest(
      card_id, Virgil::SDK::Client::Requests::RevokeCardRequest::Reasons::Unspecified
    )
    request_signer.authority_sign(revoke_request, app_id, app_key)

    client.revoke_card_from_signed_request(revoke_request)

The shorthand version is

.. code-block:: ruby
    :linenos:

    client.revoke_card(
      "[YOUR_CARD_ID_HERE]",
      Virgil::SDK::Client::Requests::RevokeCardRequest::Reasons::Unspecified,
      app_id,
      app_key
    )

Operations with Crypto Keys
---------------------------

Generate Keys
~~~~~~~~~~~~~

You can generate a keypair using ``VirgilCrypto`` class. The default algorithm is ``ed25519``. 

.. code-block:: ruby
    :linenos:

     alice_keys = crypto.generate_keys

Import and Export Keys
~~~~~~~~~~~~~~~~~~~~~~

If you need to import or export your Public/Private keys you can easily do it.
Simply call one of the Export methods:

.. code-block:: ruby
    :linenos:

    exported_private_key = crypto.export_private_key(alice_keys.private_key)
    exported_public_key = crypto.export_public_key(alice_keys.public_key)

To import Public/Private keys, simply call one of the Import methods:

.. code-block:: ruby
    :linenos:

    private_key = crypto.import_private_key(exported_private_key)
    public_key = crypto.import_public_key(exported_public_key)


Encryption and Decryption
---------------------------

Initialize Crypto API and generate keypair.

.. code-block:: ruby
    :linenos:

    crypto = Virgil::SDK::Cryptography::VirgilCrypto.new
    alice_keys = crypto.generate_keys

Encrypt Data
~~~~~~~~~~~~

You can enrypt some data, ECIES scheme with ``AES-GCM`` is used in **Virgil Security**. You have several options for encryption:

.. code-block:: ruby
    :linenos:

    plain_data = Virgil::Crypto::Bytes.from_string("Hello Bob!")
    cipher_data = crypto.encrypt(plain_data, alice_keys.public_key)
     
Decrypt Data
~~~~~~~~~~~~

You can decrypt data using your private key. You have such options for decryption: 

.. code-block:: ruby
    :linenos:

    crypto.decrypt(cipher_data, alice_keys.private_key);

Generating and Verifying Signatures
-----------------------------------

Generate a new Public/Private keypair and ``data`` to be signed.

.. code-block:: ruby
    :linenos:

    crypto = Virgil::SDK::Cryptography::VirgilCrypto.new
    alice_keys = crypto.generate_keys()

    # The data to be signed with alice's Private key
    data = Virgil::Crypto::Bytes.from_string("Hello Bob, How are you?")

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~

You can generate a digital signature for data. Options for signing data:

.. code-block:: ruby
    :linenos:

    signature = crypto.sign(data, alice.private_key)


Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~

You can verify that a signature is authentic. You will verify the signature of the ``SHA-384`` fingerprint using the public key. Options for verification:

.. code-block:: ruby
    :linenos:    

    is_valid = crypto.verify(data, signature, alice.public_key)

Authenticated Encryption
-------------------------

Authenticated encryption provides both data confidentiality and data integrity assurances that the information is protected.

.. code-block:: ruby
    :linenos:

    crypto = Virgil::SDK::Cryptography::VirgilCrypto.new

    alice = crypto.generate_keys
    bob = crypto.generate_keys

    # The data to be signed with alice's Private key
    data = Virgil::Crypto::Bytes.from_string("Hello Bob, How are you?")

Sign then Encrypt
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: ruby
    :linenos:

    cipher_data = crypto.sign_then_encrypt(
      data,
      alice.private_key,
      bob.public_key
    )

Decrypt then Verify
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: csharp
    :linenos:

    decrypted_data = crypto.decrypt_then_verify(
      cipher_data,
      bob.private_key,
      alice.public_key
    )

Fingerprint Generation
----------------------

The default Fingerprint algorithm is ``SHA-256``.

.. code-block:: csharp
    :linenos:

    crypto = Virgil::SDK::Cryptography::VirgilCrypto.new
    fingerprint = crypto.calculate_fingerprint(content_bytes)

See Also: 
---------
`Source code <https://github.com/VirgilSecurity/virgil-ruby-net>`__
