:orphan:

virgil-glossary
===============

.. program:: virgil-glossary


SYNOPSYS
--------

.. code:: bash

    virgil glossary [-o <file>] [-V...] [--]
    virgil glossary (-h | --help)
    virgil glossary --version


DESCRIPTION
-----------

    :program:`virgil glossary` shows the list of the terms used in Virgil Services with the accompanying definitions.
    
 
OPTIONS
-------

.. option:: -o <file>, --out=<file>

    The list of glossary terms. If omitted, stdout is used.
    
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

1. Save the Glossary into the file.

.. code:: bash

    virgil glossary -o VirgilGlossary.txt
