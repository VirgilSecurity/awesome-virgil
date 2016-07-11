*********
private-key-add
*********

Add a private key to the Private Keys Service.

========
SYNOPSIS
========
::

  virgil private-key-add  -a <arg> -k <file> [-p <arg>] [-V] [--] [--version][-h]

========
DESCRIPTION
========

The utility allows you to add a private key to the Private Keys Service. Pay attention to these statements:

1.  Make sure that you have registered and confirmed your account for the Keys Service.
2.  Make sure that you have a public/private key pair and you have already uploaded the public key to the Keys Service.
3.  Make sure that you have your private key on your machine saved locally.
4.  Make sure that you have registered an application at `Virgil Security, Inc <https://developer.virgilsecurity.com/account/signin>`_.

========
OPTIONS
========

  ``-a`` <arg>,  ``--card-id`` <arg>
    (required)  Virgil Card identifier

  ``-k`` <file>,  ``--key`` <file>
    (required)  Private Key

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

1.  Add a private key to Private Keys Service:
::

  virgil private-key-add -k private.key -a <card_id>

========
SEE ALSO
========

virgil(1)
virgil-config(1)
virgil-private-key-del(1)
virgil-keygen(1)
virgil-identity-confirm-private(1)
virgil-identity-confirm-global(1)
