:orphan:

virgil-card-search
==================

SYNOPSIS
--------
::

  virgil card-search  [-o <arg>] -d <arg>... [-t <arg>] [-s <arg>] [-V] [--]
  
  virgil card-search (-h | --help)

  virgil card-search --version


DESCRIPTION 
-----------

:program:`virgil card-search` searches for a :term:`Virgil Card(s) <Virgil Card>` by its :term:`identities <identity>` (required), :term:`identity type <identity type>` and :term:`scope <scope>`.


OPTIONS 
-------

**Basic**

.. option:: -o <file>; --out <file>
    A folder where Virgil Cards will be saved. If omitted, stdout is used.

.. option:: -d <arg>; --identity <arg>
    The identity must be a valid email for a :term:`confirmed Virgil Card <Confirmed Virgil Card>` with an identity type of 'email' and can be any value for a :term:`segregated Virgil Card <Segregated Virgil Card>`. Multiple identitites can be used for the Virgil Cards search.

.. option:: -t <arg>; --identity-type <arg>
    Specifies the identity type of a Virgil Cards to be found. The identity type must be 'email' for a confirmed Virgil Card and can be any value for a segregated one.
    
.. option:: -s <global | application>; --scope <global | application>
    Specifies the scope to perform search on. Must be 'global' or 'application'. If omitted, 'application' is used.

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

Search for the Virgil Cards by Alice's and Bob's emails:
::

        virgil card-search -o cards/ -d alice@mail.com bob@mail.com


SEE ALSO 
--------

:cliref:`cli-virgil`
:cliref:`cli-config`
:cliref:`cli-card-create`
:cliref:`cli-card-get`
