***********
verify
***********

Verify data and signature.

========
SYNOPSIS
========
::

  virgil verify  [-i <file>] [-o <file>] [--return-status] -s <file> -r <arg> [-V] [--] 
                 [--version] [-h]

========
DESCRIPTION
========

The utility allows you to verify data and signature with a provided user's identifier or with his public key.

========
OPTIONS
========

  ``-i`` <file>,  ``--in`` <file>
    Data to be verified. If omitted, stdin is used.

  ``-o`` <file>,  ``--out`` <file>
    Verification result: success | failure. If omitted, stdout is used.

  ``--return-status``
    Just returns status, ignores '-o, --out'

  ``-s`` <file>,  ``--sign`` <file>
    (required)  Digest sign.

  ``-r`` <arg>,  ``--recipient`` <arg>
    (required)  Recipient defined in format:
    [id|vcard|pubkey]:<value>
    where:

            * if **id**, then <value> - recipient's UUID associated with a Virgil Card identifier;

            * if **vcard**, then <value> - recipient's Virgil Card(s) file stored locally;

            * if **pubkey**, then <value> - recipient's public key.

  ``-V``, ``--VERBOSE``
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
::

        virgil verify -i plain.txt -s plain.txt.sign -r vcard:bob/bob.vcard
::

        virgil verify -i plain.txt -s plain.txt.sign -r pubkey:bob/public.key

========
SEE ALSO
========

virgil(1)
virgil-config(1)
virgil-sign(1)
