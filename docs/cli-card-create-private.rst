***********
card-create-private
***********

Create :term:`a Private Virgil Card <Private Virgil Card>`.

========
SYNOPSIS
========
::

  virgil card-create-private  {--public-key <file>|-e <arg>} {-d <arg>|-f <file>}
                              [-o <file>] -k <file> [-p <arg>] [-V] [--]
                              [--version] [-h]

========
DESCRIPTION
========

Create a Private Virgil Card.

========
OPTIONS
========

  ``--public-key`` <file>
    (OR required)  Public key
  -- OR --
  ``-e`` <arg>,  ``--public-key-id`` <arg>
    (OR required)  Public key identifier

  ``-d`` <arg>,  ``--identity`` <arg>
    (OR required)  Identity: type:value
  -- OR --
  ``-f`` <file>,  ``--validated-identity`` <file>
    (OR required)  Validated identity. See :doc:`cli-identity-confirm-private`

  ``-o`` <file>,  ``--out`` <file>
    Private Virgil Card. If omitted, stdout is used.

  ``-k`` <file>,  ``--key`` <file>
    (required)  Private key

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

1.  Create a Private Virgil Card with a confirmed Identity:
::

        virgil card-create-private -f alice/validated_identity.txt --public-key alice/public.key -k alice/private.key -o alice/my_card.vcard

2.  Create a connection with an already existing a Private Virgil Card with a confirmed Identity by public-key-id:
::

        virgil card-create-private -f alice/validated_identity.txt -e <pub_key_id> -k alice/private.key -o alice/my_card.vcard

3.  Create a Private Virgil Card with :term:`an unconfirmed Identity <Unconfirmed Identity>`:
::

        virgil card-create-private -d <identity_type>:<identity_value> --public-key alice/public.key -k alice/private.key -o alice/anonim_card1.vcard

4.  Create a connection with an already existing a Private Virgil Card with an unconfirmed Identity by public-key-id:
::

        virgil card-create-private -d <identity_type>:<identity_value> -e <pub_key_id> -k alice/private.key -o alice/anonim_card2.vcard

========
SEE ALSO
========

virgil(1)
virgil-config(1)
virgil-keygen(1)
virgil-identity-confirm-private(1)
