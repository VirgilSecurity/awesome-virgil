####################
.NET/C# SDK Features
####################

Working with Virgil Cards
=========================

Create a Virgil Card
----------------------

A **Virgil Card** is the main entity of the Virgil services, it includes the information about the user and his public key. The **Virgil Card** identifies the user/device by one of his types.

Search for the Virgil Cards
---------------------------

Performs the **Virgil Cards** search by criteria: 

	- ``Identities`` request parameter is mandatory; 
	- ``IdentityType`` request parameter is optional and specifies the ``IdentityType`` of a **Virgil Cards** to be found; 
	- ``Scope`` optional request parameter specifies the scope to perform search on. Either 'global' or 'application'. The default value is 'application'

Working with Crypto Library
===========================

Generate Keys
-------------

Import and Export Keys
----------------------

Encrypt Data
------------

Data encryption using ECIES scheme with ``AES-GCM``:

	- stream encryption;
	- byte array encryption;
	- one recipient;
	- multiple recipients. 

Decrypt Data
------------

You can decrypt data using your private key:

	- stream;
	- byte array.

Generate a Signature
--------------------

Sign the ``SHA-384`` fingerprint of either stream or a byte array using your private key.

Verify a Signature
------------------

Verify the signature of the ``SHA-384`` fingerprint of either stream or a byte array using the Public key.

Fingerprint generation
----------------------

The default Fingerprint algorithm is ``SHA-256``. The hash is then converted to HEX.
