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

+----------------------------------+----------------------------------------------------------------------------------------+
| Option                           | Description                                                                            |
+==================================+========================================================================================+
| ``-i`` <file>,                   | Data to be signed. If omitted, stdin is used.                                          |
| ``--in`` <file>                  |                                                                                        |
+----------------------------------+----------------------------------------------------------------------------------------+
| ``-o`` <file>,                   | Digest sign. If omitted, stdout is used.                                               |
| ``--out`` <file>                 |                                                                                        |
+----------------------------------+----------------------------------------------------------------------------------------+
|``--return-status``               | Just returns status, ignores '-o, --out'                                               |
+----------------------------------+----------------------------------------------------------------------------------------+
| ``-s`` <file>, ``--sign`` <file> | (required)  Digest sign.                                                               |
+----------------------------------+----------------------------------------------------------------------------------------+
| ``-r`` <arg>,                    | (required)  Recipient defined in format:                                               |
| ``--recipient`` <arg>            |                                                                                        |
|                                  | ``[id|vcard|pubkey]:<value>``                                                          |
|                                  |                                                                                        |
|                                  | where:                                                                                 |
|                                  |                                                                                        |
|                                  | * if **id**, then <value> - recipient's UUID associated with a Virgil Card identifier; |
|                                  |                                                                                        |
|                                  | * if **vcard**, then <value> - recipient's Virgil Card(s) file stored locally;         |
|                                  |                                                                                        |
|                                  | * if **pubkey**, then <value> - recipient's public key.                                |
+----------------------------------+----------------------------------------------------------------------------------------+
|``-V``, ``--VERBOSE``             | Shows detailed information.                                                            |
+----------------------------------+----------------------------------------------------------------------------------------+
|``--``,  ``--ignore_rest``        | Ignores the rest of the labeled arguments following this flag.                         |
+----------------------------------+----------------------------------------------------------------------------------------+
|``--version``                     | Displays version information and exits.                                                |
+----------------------------------+----------------------------------------------------------------------------------------+
|``-h``,  ``--help``               | Displays usage information and exits.                                                  |
+----------------------------------+----------------------------------------------------------------------------------------+

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

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-sign`
