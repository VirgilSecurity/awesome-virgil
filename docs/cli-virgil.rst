************
virgil
************

Command line tool for using Virgil Security full stack functionality.

SYNOPSIS
========
::

  virgil command [command opts] [command args]

DESCRIPTION
===========

The **Virgil** program is a command line tool for using Virgil Security stack functionality:

-   encrypt, decrypt, sign and verify data;
-   interact with Virgil Keys Service;
-   interact with Virgil Private Keys Service.

COMMON COMMANDS
===============

**keygen** Generate :term:`a private key <Private Key>` with provided parameters.

**key2pub** Extract :term:`a public key <Public Key>` from the private key.

**encrypt** Encrypt data for given recipients who can be defined by their Virgil Keys and by passwords.

**decrypt** Decrypt data for a given recipient who can be defined by his public key or by his password.

**sign** Sign data with the private key.

**verify** Verify data and signature with the public key.

**exhash** Derives hash from the given data with :term:`PBKDF function <PBKDF function>`.

**config** Get information about Virgil CLI configuration file.

IDENTITY SERVICE COMMANDS
=========================

**:doc:`cli-identity-confirm-global`**  
Confirmation of the Identity. Returns validation token which is required for operations with :term:`Global Virgil Cards <Global Virgil Card>` and :term:`the confirmed Identity <Confirmed Identity>`:

1.  **:doc:`cli-card-create-global`**;
2.  **:doc:`cli-card-revoke-global`**;
3.  **:doc:`cli-public-key-revoke-global`**.

**:doc:`cli-identity-confirm-private`** Confirmation of the Identity. Returns the validation token which is required for the operations with :term:`Private Virgil Cards <Private Virgil Card>` and the confirmed identity:

1.  **:doc:`cli-card-create-private`**;
2.  **:doc:`cli-card-revoke-private`**;
3.  **:doc:`cli-public-key-revoke-private`**.

**:doc:`cli-identity-verify`** Verify an identity Returns :term:`action id <Action id>`.

**:doc:`cli-identity-valid`** Validates the passed token. Checks whether :term:`time <Time to live>` and :term:`usage <Count to live>` limits for :term:`validation token <Validation token>` are not exceeded.

KEYS SERVICE COMMANDS
=====================

**:doc:`cli-public-key-get`** Get user's Virgil Public Key from the Virgil Keys service.

**:doc:`cli-public-key-revoke-global`** Revoke a group of Global Virgil Cards from the Public Keys Service connected by :term:`public-key-id <Public key id>` + :term:`card-id <Card id>` of one of the Cards from the group.

**:doc:`cli-public-key-revoke-private`** Revoke a group of Private Virgil Cards from the Public Keys Service connected by :term:`public-key-id <Public key id>` + :term:`card-id <Card id>` of one of the Cards from the group.

VIRGIL CARD SERVICE COMMANDS
============================

**:doc:`cli-card-create-global`** Create a Global Virgil Card. This means **:doc:`cli-identity-verify`** **:doc:`cli-identity-confirm-global`**.

**:doc:`cli-card-create-private`** Create a Private Virgil Card. This means **:doc:`cli-identity-confirm-private`**.

**:doc:`cli-card-search-global`** Search for a Global Virgil Card from the Virgil Keys Service by:

1.  application name - search an application Global Virgil Card.
2.  email - search a Global Virgil Card.

**:doc:`cli-card-search-private`** Search the Private Virgil Card from the Virgil Keys Service.

**:doc:`cli-card-get`** **:doc:`cli-card-get`** Get user's :term:`Virgil Card <Virgil Card>` from the Virgil Keys service.

**:doc:`cli-card-revoke-private`** Revoke a Private Virgil Card by the card-id.

**:doc:`cli-card-revoke-global`** Revoke a Global Virgil Card by the card-id.

PRIVATE KEYS SERVICE COMMANDS
=============================

**:doc:`cli-private-key-add`** Add existing the private key to the Private Keys Service.

**:doc:`cli-private-key-get`** Get the private key from the Virgil Private Keys Service.

**:doc:`cli-private-key-del`** Delete the private key object from the Private Keys Service.

SEE ALSO
========

  * :doc:`cli-encrypt`
  * :doc:`cli-decrypt`
  * :doc:`cli-sign`
  * :doc:`cli-verify`
  * :doc:`cli-keygen`
  * :doc:`cli-key2pub`
  * :doc:`cli-exhash`
  * :doc:`cli-config`
  * :doc:`cli-identity-verify`
  * :doc:`cli-identity-confirm-private`
  * :doc:`cli-identity-confirm-global`
  * :doc:`cli-identity-valid`
  * :doc:`cli-card-create-global`
  * :doc:`cli-card-create-private`
  * :doc:`cli-card-get`
  * :doc:`cli-card-search-global`
  * :doc:`cli-card-search-private`
  * :doc:`cli-card-revoke-global`
  * :doc:`cli-card-revoke-private`
  * :doc:`cli-public-key-revoke-global`
  * :doc:`cli-public-key-revoke-private`
  * :doc:`cli-public-key-get`
  * :doc:`cli-private-key-add`
  * :doc:`cli-private-key-del`
  * :doc:`cli-private-key-get`
