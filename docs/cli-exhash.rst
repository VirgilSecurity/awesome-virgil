*********
exhash
*********

Derives hash from the given data with :term:`PBKDF function <PBKDF function>`.

========
SYNOPSIS
========
::

  virgil exhash  [-i <file>] [-o <file>] -s <file> [-a <alg>] [-c <int>] [-V] [--] 
                 [--version] [-h]

========
DESCRIPTION
========

Derives the obfuscated data from incoming parameters using PBKDF function.

========
OPTIONS
========

  ``-i`` <file>,  ``--in`` <file>
    The string value to be hashed. If omitted, stdout is used.

  ``-o`` <file>,  ``--out`` <file>
    Hash. If omitted, stdout is used.

  ``-s`` <file>,  ``--salt`` <file>
    (required)  The hash salt.

  ``-a`` <sha1|sha224|sha256|sha384|sha512>,  ``--algorithm`` <sha1|sha224|sha256|sha384|sha512>
    Underlying hash algorithm:

      * sha1 -   secure Hash Algorithm 1;
      * sha224 - secure Hash Algorithm 2, that are 224 bits;
      * sha256 - secure Hash Algorithm 2, that are 256 bits;
      * sha384 - secure Hash Algorithm 2, that are 384 bits(default);
      * sha512 - secure Hash Algorithm 2, that are 512 bits;

  ``-c`` <int>,  ``--iterations`` <int>
    Iterations count. Default - 2048

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

1.  Underlying hash - SHA384 (default), iterations - 2048 (default):
::

        virgil exhash -i data.txt -o obfuscated_data.txt -s data_salt.txt

2.  Underlying hash - SHA512, iterations - 4096:
::

        virgil exhash -i data.txt -o obfuscated_data.txt -s data_salt.txt -a sha512 -c 4096

========
SEE ALSO
========

virgil(1)
virgil-card-create-private(1)
