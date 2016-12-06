:orphan:

virgil-keygen
=============

.. program:: virgil-keygen


SYNOPSIS
--------

.. code:: bash

    virgil keygen [-o <file>] [-g <alg>] [-p <arg> | --no-password] [-V...] [–-]
    virgil keygen (-h | --help)
    virgil keygen --version


DESCRIPTION 
-----------

    :program:`virgil keygen` generates an Elliptic Curve :term:`Private Key` or an RSA Private Key with the provided parameters.


OPTIONS 
-------

.. option:: -o <file>, --out=<file>

    The generated Private Key. If omitted, stdout is used.
   
.. option:: -g <alg>, --algorithm=<alg>  

    Generate an Elliptic Curve key or an RSA key with one of the following algorithms:
    
        .. cli:argument:: <alg>
        
        .. default-role:: cli:value
        
        * `bp256r1` - 256-bits Brainpool **curve**;
        * `bp256r1` - 256-bits Brainpool curve;
        * `bp384r1` - 384-bits Brainpool curve;
        * `bp512r1` - 512-bits Brainpool curve;
        * `secp192r1` - 192-bits NIST curve;
        * `secp224r1` - 224-bits NIST curve;
        * `secp256r1` - 256-bits NIST curve;
        * `secp384r1` - 384-bits NIST curve;
        * `secp521r1` - 521-bits NIST curve;
        * `secp192k1` - 192-bits "Koblitz" curve;
        * `secp224k1` - 224-bits "Koblitz" curve;
        * `secp256k1` - 256-bits "Koblitz" curve;
        * `curve25519` - Curve25519 (default);
        * `rsa3072` - 3072-bits "RSA" key;
        * `rsa4096` - 4096-bits "RSA" key;
        * `rsa8192` - 8192-bits "RSA" key.
        
        .. default-role::

.. option:: -p <arg>, --private-key-password=<arg>

    Password to be used for private key encryption.
   
.. option:: --no-password

    If :option:'--private-key-password' is omitted then key password won’t be requested.
    
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

1.  Generate a Private Key with the default algorithm. A password will be requested:

.. code:: bash

    virgil keygen -o private.key

2.  Generate an Elliptic Curve Private Key with the password:

.. code:: bash

    virgil keygen -o private.key -p STRONGPASS

3.  Generate an Elliptic 521-bits NIST Curve Private Key. A password will be requested:

.. code:: bash

    virgil keygen -o private.key -g secp521r1

4.  Generate an 8192-bits RSA Private Key with the password:

.. code:: bash

   virgil keygen -o private.key -g rsa8192 -p STRONGPASS


SEE ALSO 
--------

:cli:ref:`virgil`
