**************
public-key-revoke-global
**************

Revoke the Global Virgil Card from the Keys Service.

========
SYNOPSIS
========
::

  virgil public-key-revoke-global {-f <file> ... |-d <arg> ... } -e <arg> -a <arg> -k
                                  <file> [-p <arg>] [-V] [--] [--version] [-h]

========
DESCRIPTION
========

Revoke a group of Global Virgil Cards from the Public Keys Service connected by public-key-id + card-id of one of the Cards from the group.

========
OPTIONS
========

  ``-f`` <file>,  ``--validated-identity`` <file>  (accepted multiple times)
    (OR required)  Validated Identity for Private Virgil Card - see virgil identity-confirm-private
  -- OR --
  ``-d`` <arg>,  ``--identity`` <arg>  (accepted multiple times)
    (OR required)  User identifier for Private Virgil Card with unconfirmed identity

  ``-e`` <arg>,  ``--public-key-id`` <arg>
    (required)  Public Key identifier

  ``-a`` <arg>,  ``--card-id`` <arg>
    (required)  Private Virgil Card identifier

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

1.  Revoke a chain of Global Virgil Cards connected by public-key-id from Virgil Keys Service:
::

  virgil public-key-revoke-global -e <public_key_id> -a <card_id> -k alice/private.key -f alice/validated-identity-main.txt -f alice/validated-identity-reserve.txt

2.  Revoke a chain of Global Virgil Cards by public-key-id from Virgil Keys Service, with confirming of identity:
::

  virgil public-key-revoke-global -e <public_key_id> -a <card_id> -k alice/private.key -d email:alice_main@domain.com -d email:alice_reserve@domain.com

========
SEE ALSO
========

virgil(1)
virgil-config(1)
virgil-card-create-global(1)
virgil-card-create-private(1)
virgil-public-key-revoke(1)
