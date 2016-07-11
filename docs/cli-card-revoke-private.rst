***********
card-revoke-private
***********

Revoke :term:`a Private Virgil Card <Private Virgil Card>` from the Keys Service.

SYNOPSIS
========
::

  virgil card-revoke-private  -a <arg> [-f <file>] -k <file> [-p <arg>] [-V] [--]
                              [--version] [-h]

DESCRIPTION
===========

The utility allows you to revoke a Private Virgil Card from the Keys Service.

OPTIONS
=======

  ``-a`` <arg>,  ``--card-id`` <arg>
    (required)  Private Virgil Card identifier

  ``-f`` <file>,  ``--validated-identity`` <file>
    Private Validated identity. See 'virgil identity-confirm-private'

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

EXAMPLES
========

1.  Revoke a Private Virgil Card with :term:`a confirmed identity <Confirmed Identity>`:
::

  virgil card-revoke-private -a <card_id> -f validated-identities.txt -k private.key

2.  Revoke Virgil Card with :term:`an unconfirmed Identity <Unconfirmed Identity>`:
::

  virgil card-revoke-private -a <card_id> -k private.key

SEE ALSO
========

virgil(1)
virgil-config(1)
virgil-card-create-private(1)
virgil-public-key-revoke-private(1)
