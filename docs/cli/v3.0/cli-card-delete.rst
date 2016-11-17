:orphan:

virgil-card-delete
==================

SYNOPSIS
--------
::

  virgil card-delete [-i <file>] -k <file> [-p <arg>] [-r <arg>] [-V] [--]                              
                              
  virgil card-delete (-h | --help)

  virgil card-delete --version


DESCRIPTION 
-----------

:program:`virgil card-delete` revokes a :term:`Virgil Card <Virgil Card>` directly or by the :term:`Virgil Card id <Virgil Card id>`. The :term:`Private Key <Private Key>` that was used for Virgil Card creation is required.


OPTIONS 
-------

**Basic**

.. option:: -i <file>; --in <file>
    The Virgil Card id or the Virgil Card itself for revocation. If omitted, stdin is used.

.. option:: -k <file>;  --private-key <file>
    The Private Key.
    
.. option:: -p <arg>;  --private-key-password <arg>
    The :term:`Private Key password <Private Key password>` (if needed).
    
.. option:: -r <unspecified | compromised>; --revocation_reason <unspecified | compromised>
    The :term:`revocation reason <revocation reason>` must be ``unspecified`` or ``compromised``. If omitted, ``unspecified`` is used.

.. option:: -V; --VERBOSE
    Shows the detailed information.

.. option:: --; --ignore_rest
    Ignores the rest of the labeled arguments following this flag.

**Common**

.. option:: -h,  --help
    Displays usage information and exits.

.. option:: --version
    Displays version information and exits.


EXAMPLES 
--------

Revoke a Virgil Card:
::

       virgil card-delete -k private.key -c myCard.vcard


SEE ALSO 
--------

:cliref:`cli-virgil`
:cliref:`cli-config`
:cliref:`cli-card-create`
