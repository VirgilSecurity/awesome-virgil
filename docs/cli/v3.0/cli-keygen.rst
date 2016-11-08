******
keygen
******

Generate a :term:`Private Key <Private Key>` with the provided parameters.

========
SYNOPSIS
========

::

        virgil keygen [-o <file>] [-g <alg>] [-p <arg> | --no-password-input] [-V] [-–version] [-h] [–-]

===========
DESCRIPTION
===========

The utility allows you to generate an Elliptic Curve Private Key or an RSA Private Key.

=======
OPTIONS
=======
 
**-o <file>; --out <file>**
   The generated Private Key. If omitted, stdout is used.
   
**-g <alg>; --algorithm <alg>**
   The generated Private Key. If omitted, stdout is used.
   Generate an Elliptic Curve key or an RSA key with one of the following options:

      * bp256r1 - 256-bits Brainpool curve;

      * bp384r1 - 384-bits Brainpool curve;

      * bp512r1 - 512-bits Brainpool curve;

      * secp192r1 - 192-bits NIST curve;

      * secp224r1 - 224-bits NIST curve;

      * secp256r1 - 256-bits NIST curve;

      * secp384r1 - 384-bits NIST curve;

      * secp521r1 - 521-bits NIST curve;

      * secp192k1 - 192-bits "Koblitz" curve;

      * secp224k1 - 224-bits "Koblitz" curve;

      * secp256k1 - 256-bits "Koblitz" curve;

      * curve25519 - Curve25519 (default);

      * rsa3072 - 3072-bits "RSA" key;

      * rsa4096 - 4096-bits "RSA" key;

      * rsa8192 - 8192-bits "RSA" key
      
**-p <arg>; --private-key-password <arg>**
   Password to be used for private key encryption.
   
**--no-password-input**
    --private-key-password is omitted and password won’t be requested.
    
**-V; --VERBOSE**
   Shows the detailed information.

**--; --ignore_rest**
   Ignores the rest of the labeled arguments following this flag.
   
**--version**
   Displays version information and exits.
   
**-h; --help**
   Displays usage information and exits.

========
EXAMPLES
========

1.  Generate a Curve25519 Private Key (default). A password will be requested:
::

        virgil keygen -o private.key

2.  Generate an Elliptic Curve Private Key with the password:
::

        virgil keygen -o private.key -p STRONGPASS

3.  Generate an Elliptic 521-bits NIST Curve Private Key. A password will be requested:
::

        virgil keygen -o private.key -g secp521r1

4.  Generate an 8192-bits RSA Private Key with the password:
::

        virgil keygen -o private.key -g rsa8192 -p STRONGPASS

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-key2pub`
