####################
.NET/C# SDK Features
####################

Working with Virgil Cards
=========================

Create a Virgil Card
----------------------

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

``appID`` and ``appKey`` parameters are required to create a **Virgil Card** in your app scope. [`Source <dot-net-csharp-programming-guide.html#creating-a-virgil-card>`__]

Search for Virgil Cards
---------------------------

You can search for **Virgil Cards** by identity value(s) and optional additional parameters can be set:

	- identity type ('email' or any type created by user). You can find more information about :term:`confirmed <Confirmed Identity>` and :term:`uncofirmed <Unconfirmed Identity>` **Virgil Cards**.
	- scope (by default it is 'application', can be 'global'). You can find more information about :term:`global <Global Virgil Card>` and :term:`application <>` **Virgil Cards**.

Revoke a Virgil Card
---------------------------

You can delete a **Virgil Card** in case the keys were compromised or lost, or for any other reason.

Working with Crypto Library
===========================

Generate Keys
-------------

You can generate a keypair using ``VirgilCrypto`` class. The default algorithm is ``ed25519``. 

Import and Export Keys
----------------------

If you need to import or export your Public/Private keys you can easily do it. **Какие условия или предостережения? Supported wire representation.**

Encrypt Data
------------

You can enrypt some data, ECIES scheme with ``AES-GCM`` is used in **Virgil Security**. You have several options for encryption:

	- stream encryption;
	- byte array encryption;
	- one recipient;
	- multiple recipients (public keys of every user are used for encryption).

Decrypt Data
------------

You can decrypt data using your private key. You have such options for decryption: 

	- stream;
	- byte array.

Generate a Signature
--------------------

You can generate a digital signature for data and sign the ``SHA-384`` fingerprint using your private key. Options for signing data:

	- stream;
	- byte array.

Verify a Signature
------------------

You can verify that a signature is authentic. You will verify the signature of the ``SHA-384`` fingerprint using the public key. Options for verification:

	- stream;
	- byte array.

Fingerprint generation
-------------------------

The default Fingerprint algorithm is ``SHA-256``. The hash is then converted to HEX.
