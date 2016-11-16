:orphan:

virgil
==============

SYNOPSIS
--------
::

  virgil command [command opts] [command args]


DESCRIPTION 
-----------

:program:`virgil` is a command line tool for using Virgil Security stack functionality.


COMMON COMMANDS
---------------

**keygen** Generate a :term:`a Private Key <Private Key>` with provided parameters.

**key2pub** Extract a :term:`Public Key <Public Key>` from the Private Key.

**encrypt** Encrypt the data for given recipients who can be defined by their Public Keys and by the passwords.

**decrypt** Decrypt the data for a given recipient who can be defined by his Public Key or by the password.

**sign** Sign the data with the Private Key.

**verify** Verify the data and the signature with the Public Key.

**exhash** Derive hash from the given data with the :term:`PBKDF function <PBKDF function>`.

**config** Get the information about Virgil CLI configuration file.


VIRGIL CARD SERVICE COMMANDS
----------------------------

:cliref:`cli-card-create` Create a :term:`Virgil Card <Virgil Card>` entity.

:cliref:`cli-card-get` Get the Virgil Card from the :term:`Virgil Keys service <Virgil Keys service>` by the :term:`Virgil Card id <Card id>`.

:cliref:`cli-card-search` Search for the Virgil Card from the Virgil Keys Service by the :term:`identity <identity>`.

:cliref:`cli-card-revoke` Revoke the Virgil Card by the Virgil Card id.


SEE ALSO
========

:cliref:`cli-encrypt`
:cliref:`cli-decrypt`
:cliref:`cli-sign`
:cliref:`cli-verify`
:cliref:`cli-keygen`
:cliref:`cli-key2pub`
:cliref:`cli-exhash`
:cliref:`cli-config`
:cliref:`cli-card-create`
:cliref:`cli-card-get`
:cliref:`cli-card-search`
:cliref:`cli-card-delete`
