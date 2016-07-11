******
sign
******

Sign data.

========
SYNOPSIS
========
::

  virgil sign  [-i <file>] [-o <file>] -k <file> [-p <arg>] [-V] [--] [--version] [-h]

========
DESCRIPTION
========

The utility allows you to sign data with a provided user's :term:`private key <Private Key>`. 

========
OPTIONS
========

  ``-i`` <file>,  ``--in`` <file>
    Data to be signed. If omitted, stdin is used.

  ``-o`` <file>,  ``--out`` <file>
    Digest sign. If omitted, stdout is used.

  ``-k`` <file>,  ``--key`` <file>
    (required)  Signer's private key.

  ``-p`` <arg>,  ``--private-key-password`` <arg>
    Private Key Password.

  ``-V``,  ``--VERBOSE``
    Shows detailed information.

  ``--``,  ``--ignore_rest``
    Ignores the rest of the labeled arguments following this flag.

  ``--version``
    Displays version information and exits.

  ``-h``, ``--help``
    Displays usage information and exits.

========
EXAMPLES
========
::

        virgil sign -i plain.txt -o plain.txt.sign -k alice/private.key
::

        virgil sign -i plain.txt -o plain.txt.sign -k alice/private.key -p STRONGPASS

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-verify`
