:orphan:

virgil-card-get
==============

SYNOPSIS
--------
::

  virgil card-get [-o <arg>] -a <arg> [-e <arg>] [-k <file>] [-p <arg>] [-V] [--]
          
  virgil card-get (-h | --help)

  virgil card-get --version


DESCRIPTION 
-----------

:program:`virgil card-get` gets the :term:`Virgil Card <Virgil Card>` by the :term:`Virgil Card id <Card id>`.


OPTIONS 
-------

**Basic**


.. option:: -i <arg>; --in <arg>
    Virgil Card id. If omitted, stdin is used.
   
.. option:: -o <file>; --out <file>
    A folder where Virgil Cards will be saved. If omitted, stdout is used.
   
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

Get a Virgil Card by Virgil Card id:
::
  virgil card-get -i <card_id> -o cards/


SEE ALSO 
--------

:cliref:`cli-virgil`
:cliref:`cli-config`
:cliref:`cli-card-create`
:cliref:`cli-card-search`
