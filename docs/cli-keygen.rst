******
keygen
******

Generate a :term:`private key <Private Key>` with provided parameters.

========
SYNOPSIS
========

::

        virgil keygen [-o *file*] [-a *bp256r1|bp384r1|bp512r1|secp192r1|secp224r1
                   |secp256r1|secp384r1|secp521r1|secp192k1|secp224k1|secp256k1
                   |rsa3072|rsa4096|rsa8192*] [-p *arg*] [-V] [--] [--version]
                   [-h]

===========
DESCRIPTION
===========

The utility allows you to generate an Elliptic Curve private key or an RSA private key.

=======
OPTIONS
=======

  ``-o`` <file>,  ``--out`` <file>
    Private key. If omitted, stdout is used.

  ``-a`` <alg>,  ``--algorithm`` <alg>
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

  ``-p`` <arg>,  ``--private-key-password`` <arg>
    Password to be used for private key encryption.

  ``--no-password-input``
    If parameter -p, --private-key-password is omitted and password won’t be requested.

  ``-V``,  ``--VERBOSE``
    Shows detailed information.

  ``--``,  ``--ignore_rest``
    Ignores the rest of the labeled arguments following this flag.

  ``--version``
    Displays version information and exits.

  ``-h``,  ``--help``
    Displays usage information and exits.

========
EXAMPLES
========

1.  Generate a Curve25519 private key(default), your password will be requested:

.. code::

        virgil keygen -o private.key

2.  Generate an Elliptic Curve private key with password protection:

.. code::

        virgil keygen -o private.key -p STRONGPASS

3.  Generate an Elliptic 521-bits NIST Curve private key, your password will be requested:

.. code::

        virgil keygen -o private.key -a secp521r1

4.  Generate 8192-bits RSA private key, your password will be requested:

.. code::

        virgil keygen -a rsa8192 -o private.key

========
SEE ALSO
========

virgil(1)
virgil-config(1)
virgil-key2pub(1)
