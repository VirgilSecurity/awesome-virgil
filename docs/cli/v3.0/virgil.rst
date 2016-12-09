:orphan:

virgil
======

.. program:: virgil


SYNOPSIS
--------

.. code:: bash

    virgil <command> [<args>...]
    virgil --version
    virgil (-h | --help)


DESCRIPTION
-----------

:program:`virgil` is a command line tool for using Virgil Security stack functionality.


OPTIONS
-------

.. option:: -h,  --help

    Displays usage information and exits.

.. option:: --version

    Displays version information and exits.

.. cli:positional:: <command>

    Specific command to execute, see sections below.


COMMANDS
--------

This section contains brief description of the available commands that are available via Virgil CLI.

**CRYPTO COMMANDS**

.. cli:argument:: <command>

.. cli:value:: keygen

    Generate a :term:`Private Key` with provided parameters.

.. cli:value:: key2pub

    Extract a :term:`Public Key` from the Private Key.

.. cli:value:: encrypt

    Encrypt the data for given recipients who can be defined by their Public Keys and by the passwords (:term:`Recipient-id`).

.. cli:value:: decrypt

    Decrypt the data for a given recipient who can be defined by his Public Key or by the password.

.. cli:value:: sign

    Sign the data with the Private Key.

.. cli:value:: verify

    Verify the data and the signature with the Public Key.

.. cli:value:: exhash

    Derive :term:`Hash` from the given data with the :term:`PBKDF function <PBKDF function>`.

.. cli:value:: config

    Get the information about Virgil CLI configuration file.

**VIRGIL CARD SERVICE COMMANDS**

.. cli:value:: card-create

    Create a :term:`Virgil Card` entity.

.. cli:value:: card-get

    Get the Virgil Card from the :term:`Virgil Keys Service` by the :term:`Virgil Card id`.

.. cli:value:: card-search

    Search for the Virgil Card from the Virgil Keys Service by the :term:`identity`.

.. cli:value:: card-revoke

    Revoke the Virgil Card by the Virgil Card id.


SEE ALSO
--------

:cli:ref:`virgil-keygen`
