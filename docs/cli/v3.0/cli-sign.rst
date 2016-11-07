******
sign
******

Sign the data.

========
SYNOPSIS
========
::

  virgil sign  [-i <file>] [-o <file>] -k <file> [-p <arg>] [-V] [-–version] [-h] [–-]

========
DESCRIPTION
========

The utility allows you to sign data with a provided user's :term:`private key <Private Key>`. 

========
OPTIONS
========

**-i <file>; --in <file>**
   Data to be signed. If omitted, stdin is used.
   
**-o <file>; --out <file>**
   Digest sign. If omitted, stdout is used.
   
**-k <file>; --private-key <file>**
   Signer's Private Key.
   
**-p <arg>; --private-key-password <arg>**
   Private Key password.
   
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

1. Alice signs *plain.txt* with her Private Key. The Private Key is protected with the password "STRONGPASS".
:: 

        virgil sign -i plain.txt -o plain.signedtxt -k alice/private.key -p STRONGPASS

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-verify`
