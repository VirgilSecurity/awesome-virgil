:orphan:

virgil-key2pub
==============

SYNOPSIS
--------
::

  virgil key2pub  [-i <file>] [-o <file>] [-p <arg>] [-V] [–-]
  
  virgil key2pub (-h | --help)

  virgil key2pub --version


DESCRIPTION 
-----------

:program:`virgil key2pub` extracts the :term:`Public Key <Public Key>` from the :term:`Private Key <Private Key>`.


OPTIONS 
-------

**Basic**

.. option:: -i <file>; --in <file>
    Private key. If omitted, stdin is used.
   
.. option:: -o <file>; --out <file>
    Public key. If omitted, stdout is used.

.. option:: -p <arg>, --private-key-password <arg>
    Private Key Password.

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

1. Extract the Public Key from the Private Key.
::

        virgil key2pub -i private.key -o public.key

2. Extract the Public Key from the Private Key protected with the password.
::

        virgil key2pub -i private.key -o public.key -p STRONGPASS

 
SEE ALSO 
--------

:cliref:`cli-virgil`
:cliref:`cli-config`
:cliref:`cli-keygen`
