*******
key2pub
*******

Get a public key from the Private Key Service.

========
SYNOPSIS
========

::

  virgil key2pub  [-i <file>] [-o <file>] [-p <arg>] [-V] [--] [--version] [-h]

===========
DESCRIPTION
===========

The utility allows you to extract a :term:`public key <Public Key>` from the :term:`private key <Private Key>`.

===========
OPTIONS
===========

  ``-i`` <file>, ``--in`` <file>
    Private key. If omitted, stdin is used.

  ``-o`` <file>, ``--out`` <file>
    Public key. If omitted, stdout is used.

  ``-p`` <arg>, ``--private-key-password`` <arg>
    Private Key Password.

  ``-V``, ``--VERBOSE``
    Shows detailed information.

  ``--``, ``--ignore_rest``
    Ignores the rest of the labeled arguments following this flag.

  ``--version``
    Displays version information and exits.

  ``-h``, ``--help``
    Displays usage information and exits.

===========
EXAMPLES
===========

::

  virgil key2pub -i private.key -o public.key

::

  virgil key2pub -i private.key -o public.key -p STRONGPASS

===========
SEE ALSO
===========

virgil(1)
virgil-config(1)
virgil-keygen(1)
