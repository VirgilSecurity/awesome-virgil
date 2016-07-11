*************
private-key-get
*************

Get a private key from the Private Keys Service.

========
SYNOPSIS
========
::

  virgil private-key-get  [-o <file>] -a <arg> -f <file> [-V] [--] [--version][-h]

========
DESCRIPTION
========

This utility allows you to get a private key from the Private Keys Service.

========
OPTIONS
========

  ``-o`` <file>,  ``--out`` <file>
    Private Key. If omitted, stdout is used.

  ``-a`` <arg>,  ``--card-id`` <arg>
    (required)  Virgil Card identifier

  ``-f`` <file>,  ``--validated-identity`` <file>
    (required)  Validated Identity for Private Virgil Card - see virgil identity-confirm-private, 
    for Global Virgil Card - see virgil identity-confirm-global

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

1.  Get a private key from the Private Keys Service:
::

  virgil private-key-get -a <card_id> -f alice/validated_identity.txt -o alice/private.key

========
SEE ALSO
========

virgil(1)
virgil-config(1)
virgil-keygen(1)
virgil-private-key-add(1)
virgil-identity-confirm-private(1)
virgil-identity-confirm-global(1)
