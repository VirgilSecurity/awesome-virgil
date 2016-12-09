:orphan:

virgil-card-delete
==================

.. program:: virgil-card-delete


SYNOPSIS
--------

.. code:: bash

    virgil card-delete [-i <file>] -k <file> [-p <arg>] [-r <reason>] [-V...] [--]
    virgil card-delete (-h | --help)
    virgil card-delete --version


DESCRIPTION
-----------

    :program:`virgil card-delete` revokes a :term:`Virgil Card` directly or by the :term:`Virgil Card id`. The :term:`Private Key` that was used for Virgil Card creation is required.


OPTIONS
-------

.. option:: -i <file>, --in=<file>

    The Virgil Card id or the Virgil Card itself for revocation. If omitted, stdin is used.

.. option:: -k <file>, --private-key=<file>

    The Private Key.

.. option:: -p <arg>, --private-key-password=<arg>

    The :term:`Private Key password` (if needed).

.. option:: -r <reason>, --revocation-reason=<reason>

    .. cli:argument:: <reason>

    .. default-role:: cli:value

    The :term:`revocation reason` must be `unspecified` or `compromised`. If omitted, `unspecified` is used.

    .. default-role:: cli:value

.. option:: -V, --VERBOSE

    Shows the detailed information.

.. option:: --

    Ignores the rest of the labeled arguments following this flag.

.. option:: -h,  --help

    Displays usage information and exits.

.. option:: --version

    Displays version information and exits.


EXAMPLES
--------

Revoke a Virgil Card:

.. code:: bash

    virgil card-delete -k private.key -c myCard.vcard


SEE ALSO
--------

:cli:ref:`virgil`
