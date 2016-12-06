:orphan:

virgil-sign
===========

.. program:: virgil-sign


SYNOPSIS
--------

.. code:: bash

    virgil sign  [-i <file>] [-o <file>] -k <file> [-p <arg>] [-V...] [–-]    
    virgil sign (-h | --help)
    virgil sign --version


DESCRIPTION 
-----------

    :program:`virgil sign` signs the data with a provided user's :term:`Private Key`. 


OPTIONS 
-------

.. option:: -i <file>, --in=<file>

    Data to be signed. If omitted, stdin is used.
   
.. option:: -o <file>, --out=<file>

    Digest sign. If omitted, stdout is used.
   
.. option:: -k <file>, --private-key=<file>

    Signer's Private Key.
   
.. option:: -p <arg>, --private-key-password=<arg>

    Private Key password.
   
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

Alice signs *plain.txt* with her Private Key. The Private Key is protected with the password "STRONGPASS".

.. code:: bash

    virgil sign -i plain.txt -o plain.signed -k alice/private.key -p STRONGPASS


SEE ALSO 
--------

:cli:ref:`virgil`
