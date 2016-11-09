*******
key2pub
*******

Extract the :term:`Public Key <Public Key>` from the :term:`Private Key <Private Key>`.

========
SYNOPSIS
========

::

  virgil key2pub  [-i <file>] [-o <file>] [-p <arg>] [-V] [-–version] [-h] [–-]

===========
DESCRIPTION
===========

The utility allows you to extract the Public Key from the Private Key.

===========
OPTIONS
===========

**-i <file>; --in <file>**
   Private key. If omitted, stdin is used.
   
**-o <file>; --out <file>**
   Public key. If omitted, stdout is used.

**-p <arg>, --private-key-password <arg>**
    Private Key Password.

**-V; --VERBOSE**
   Shows the detailed information.

**--; --ignore_rest**
   Ignores the rest of the labeled arguments following this flag.
   
**--version**
   Displays version information and exits.
   
**-h; --help**
   Displays usage information and exits.

===========
EXAMPLES
===========

1. Extract the Public Key from the Private Key.
::
  virgil key2pub -i private.key -o public.key

2. Extract the Public Key from the Private Key protected with the password.
::
  virgil key2pub -i private.key -o public.key -p STRONGPASS

===========
SEE ALSO
===========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-keygen`
