:orphan:

virgil-verify
=============

.. program:: virgil-verify


SYNOPSIS
--------

.. code:: bash

    virgil verify [-i <file>] [-o <file>] [--return-status] -S <file> [-V...] [–-] <recipient-id>
    virgil verify (-h | --help)
    virgil verify --version


DESCRIPTION 
-----------

    :program:`virgil verify` verifies the data and the signature with a provided user's idenififer - :term:`Public Key` or :term:`Virgil Card`.


OPTIONS 
-------

.. option:: -i <file>, --in=<file>
    Data to be signed. If omitted, stdin is used.
   
.. option:: -o <file>, --out=<file>
    Digest sign. If omitted, stdout is used.

.. option:: --return-status
    Returns status, ignores :option:`--out` .
   
.. option:: -S <file>, --sign=<file>
    Digest sign.

.. option:: -V, --VERBOSE
    Shows the detailed information.

.. option:: --
    Ignores the rest of the labeled arguments following this flag.
   
.. cli:positional:: <recipient-id>
    Contains information about the recipient. Format: [vcard | pubkey]:<value>
    
        .. cli:argument:: <recipient-id>
        
        .. default-role:: cli:value
      
        * if `vcard`, then <value> - the recipient's Virgil Card id or the Virgil Card itself (the file stored locally);
        * if `pubkey`, then <value> - Public Key of the recipient.
        
        .. default-role::

.. option:: -h,  --help
    Displays usage information and exits.

.. option:: --version
    Displays version information and exits.


EXAMPLES 
--------

1. *plain.txt* is verified with the Bob's Virgil Card.

.. code:: bash

    virgil verify -i plain.txt -s plain.txt.sign vcard:bob/bob.vcard
        
2. *plain.txt* is verified with the Bob's Public Key.

.. code:: bash

    virgil verify -i plain.txt -s plain.txt.sign pubkey:bob/public.key


SEE ALSO 
--------

:cli:ref:`virgil`
