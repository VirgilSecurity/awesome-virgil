**************
public-key-revoke-private
**************

Revoke the Card from the Public Keys Service.

========
SYNOPSIS
========
::

  virgil public-key-revoke-private  {-f <file> ... |-d <arg> ... } -e <arg> -a <arg> -k
                                    <file> [-p <arg>] [-V] [--] [--version] [-h]

========
DESCRIPTION
========

Revoke a group of Private Virgil Cards from the Virgil Keys Service connected by public-key-id + card-id of one of the Cards from the group.

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

1.  Revoke a chain of Virgil Private Cards with confirmed identities connected by public-key-id from Public Keys Service:
::

  virgil public-key-revoke-private -e <public_key_id> -a <card_id> -k alice/private.key -f alice/private-main-validated-identity.txt -f alice/private-reserve-validated-identity.txt

2.  Revoke a chain of Virgil Private Cards with unconfirmed identities connected by public-key-id from Public Keys Service:
::

  virgil public-key-revoke-private -e <public_key_id> -a <card_id> -k alice/private.key -d email:alice_main@domain.com -d email:alice_reserve@domain.com

3.  Revoke a chain of Virgil Private Cards with unconfirmed identities and obfuscator identity value and/or type connected by public-key-id from Public Keys Service :
::

  virgil public-key-revoke-private -e <public_key_id> -a <card_id> -k alice/private.key -d <obfuscator_type>:<obfuscator_value_1> -d <obfuscator_type>:<obfuscator_value_2>

========
SEE ALSO
========

virgil(1)
virgil-config(1)
virgil-card-create-global(1)
virgil-card-create-private(1)
virgil-public-key-revoke(1)
