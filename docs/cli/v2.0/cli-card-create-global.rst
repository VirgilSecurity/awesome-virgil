********
card-create-global
********

Create a :term:`global Virgil Card <Global Virgil Card>`.

========
SYNOPSIS
========

::

  virgil card-create-global  {-e <arg>|--public-key <file>} {-d <arg>|-f <file>}
                             [-o <file>] -k <file> [-p <arg>] [-V] [--][--version] [-h]

========
DESCRIPTION
========

Create a global Virgil Card.

========
OPTIONS
========

  ``-e`` <arg>, ``--public-key-id`` <arg>
    (OR required)  Public key identifier.
  -- OR --
  ``--public-key`` <file>
    (OR required)  Public key.

  ``-d`` <arg>, ``--identity`` <arg>
    (OR required)  Identity: email.
  -- OR --
  ``-f`` <file>, ``--validated-identity`` <file>
    (OR required)  Validated identity (see :doc:`cli-identity-confirm-global`).

  ``-o`` <file>, ``--out`` <file>
    Global Virgil Card. If omitted, stdout is used.

  ``-k`` <file>, ``--key`` <file>
    (required)  Private key.

  ``-p`` <arg>,  ``--private-key-password`` <arg>
    Private Key Password.

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

1.  Create a Global Virgil Card:
::

        virgil card-create-global -f alice/validated_identity_global.txt --public-key public.key -k alice/private.key -o alice/my_card.vcard

2.  Create a Global Virgil Card, with Identity confirmation:
::

        virgil card-create-global -d alice@domain.com --public-key public.key -k alice/private.key -o alice/my_card.vcard

3.  Create a connection with already existing Global Virgil Card, by :term:`public-key-id <Public key id>`:
::
  
        virgil card-create-global -f alice/validated_identity_global.txt -e <pub_key_id> -k alice/private.key -o alice/my_card.vcard

4.  Create a connection with already existing Global Virgil Card, by public-key-id. With confirming of identity:
::

        virgil card-create-global -d alice@domain.com -e <pub_key_id> -k alice/private.key -o alice/my_card.vcard

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-keygen`
* :doc:`cli-identity-confirm-global`
