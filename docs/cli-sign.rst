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

+----------------------------------+--------------------------------------------------+
| Option                           | Description                                      | 
+==================================+==================================================+
| ``-i`` <file>,                   | Data to be signed. If omitted, stdin is used.    |
| ``--in`` <file>                  |                                                  |
+----------------------------------+--------------------------------------------------+
| ``-o`` <file>,                   | Digest sign. If omitted, stdout is used.         |
| ``--out`` <file>                 |                                                  |
+----------------------------------+--------------------------------------------------+
| ``-k`` <file>,                   | (required)  Signer's private key.                |
| ``--key`` <file>                 |                                                  |
+----------------------------------+--------------------------------------------------+
| ``-p`` <arg>,                    | Private Key Password.                            |
| ``--private-key-password`` <arg> |                                                  |
+----------------------------------+--------------------------------------------------+
| ``-V``,                          | Shows detailed information.                      |
| ``--VERBOSE``                    |                                                  |
+----------------------------------+--------------------------------------------------+
| ``--``,                          | Ignores the rest of the labeled arguments        |
| ``--ignore_rest``                | following this flag.                             |
+----------------------------------+--------------------------------------------------+
| ``--version``                    | Displays version information and exits.          |
+----------------------------------+--------------------------------------------------+
| ``-h``,                          | Displays usage information and exits.            |
| ``--help``                       |                                                  |
+----------------------------------+--------------------------------------------------+

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
