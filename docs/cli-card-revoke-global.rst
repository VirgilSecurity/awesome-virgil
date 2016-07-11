*********
card-revoke-global
*********

Revoke a Global Virgil Card from the Keys Service.

========
SYNOPSIS
========
::

  virgil card-revoke-global  {-d <arg>|-f <file>} -a <arg> -k <file> [-p <arg>]
                             [-V] [--] [--version] [-h]

========
DESCRIPTION
========

The utility allows you to revoke a Global Virgil Card from the Keys Service.

========
OPTIONS
========

  ``-d`` <arg>,  ``--identity`` <arg>
    (OR required)  Identity: email:alice@domain.com
  -- OR --
  ``-f`` <file>,  ``--validated-identity`` <file>
    (OR required)  Validated identity (see 'virgil identity-confirm-global')


  ``-a`` <arg>,  ``--card-id`` <arg>
    (required)  Virgil Card identifier

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

  ``-h``, ``--help``
    Displays usage information and exits.

========
EXAMPLES
========

1.  Revoke :term:`a Global Virgil Card <Global Virgil Card>`:
::

  virgil card-revoke-global -a <card_id> -f validated-identities.txt -k private.key

2.  Revoke :term:`a Global Virgil Card <Global Virgil Card>`. After entering your email confirmation code will be sent to you, you have to enter it to revoke the card:
::

  virgil card-revoke-global -a <card_id> -d alice@domain.com -k alice/private.key

========
SEE ALSO
========

virgil(1)
virgil-config(1)
virgil-card-create-global(1)
virgil-public-key-revoke-global(1)
