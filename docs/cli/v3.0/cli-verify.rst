***********
verify
***********

Verify data and signature.

========
SYNOPSIS
========
::

  virgil verify  [-i <file>] [-o <file>] [--return-status] -S <file> [-V] [-–version] [-h] [–-] <recipient-id>

========
DESCRIPTION
========

The utility allows you to verify data and signature with a provided user's idenififer - :term:`Public Key <Public Key>` or :term:`Virgil Card` <Virgil Card>.

========
OPTIONS
========

**-i <file>; --in <file>**
   Data to be signed. If omitted, stdin is used.
   
**-o <file>; --out <file>**
   Digest sign. If omitted, stdout is used.

**--return-status**
   Returns status, ignores '-o, --out'.
   
**-S <file>; --sign <file>**
   Digest sign.

**-V; --VERBOSE**
   Shows the detailed information.

**--; --ignore_rest**
   Ignores the rest of the labeled arguments following this flag.
   
**--version**
   Displays version information and exits.
   
**-h; --help**
   Displays usage information and exits.
   
**<recipient-id>**
   Contains information about the recipient. Format: [vcard|pubkey]:<value>

      if **vcard**
         then <value> - the recipient's Virgil Card id or the Virgil Card itself (the file stored locally); 
      
      if **pubkey**
         then <value> - Public Key of the recipient.

========
EXAMPLES
========

1. *plain.txt* is verified with the Bob's Virgil Card.
::

        virgil verify -i plain.txt -s plain.txt.sign -r vcard:bob/bob.vcard
        
2. *plain.txt* is verified with the Bob's Public Key.
::

        virgil verify -i plain.txt -s plain.txt.sign -r pubkey:bob/public.key

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-sign`
