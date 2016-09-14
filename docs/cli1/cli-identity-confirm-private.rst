***********
identity-confirm-private
***********

Generate validation token based on application's private key.

========
SYNOPSIS
========
::

  virgil identity-confirm-private  [-o <file>] -d <arg> -t <arg> --app-key <file>
                                   [--app-key-password <arg>] [-V] [--]
                                   [--version] [-h]

========
DESCRIPTION
========

Provides helper methods to generate validation token based on application's private key. It is required for the following operations:

1.  Create a :term:`Private Virgil Card <Private Virgil Card>` with a :term:`confirmed Identity <Confirmed Identity>`. See :doc:`cli-card-create-private`;
2.  Revoke a Private Virgil Card, a group of Cards. See :doc:`cli-card-revoke-private`, :doc:`cli-public-key-revoke-private`;
3.  Get a private key from the Private Keys Service. See :doc:`cli-private-key-get`.

========
OPTIONS
========

  ``-o`` <file>,  ``--validation-token`` <file>
    A Validation-token. If omitted, stdout is used.

  ``-d`` <arg>,  ``--identity`` <arg>
    (required)  Identity value

  ``-t`` <arg>,  ``--identity-type`` <arg>
    (required)  Identity type

  ``--app-key`` <file>
    (required)  Application Private key

  ``--app-key-password`` <arg>
    Password to be used for Application Private Key encryption.

  ``-V``,  ``--VERBOSE``
    Shows detailed information.

  ``--``,  ``--ignore_rest``
    Ignores the rest of the labeled arguments following this flag.

  ``--version``
    Displays version information and exits.

  ``-h``,  ``--help``
    Displays usage information and exits.

========
RETURN VALUE
========

On success, *validated identity model*:

1.  Not obfuscated identity value and identity type
::

        -d, --identity = "alice@domain.com"
        -t, --identity-type = "email"
        {
            "type": "email",
            "value": "alice@domain.com",
            "validation_token": *validation_token*
        }

2.  Obfuscated identity (see :doc:`cli-exhash`) value and identity type
::

        -d, --identity = "xSf79dt6Bl6/WwHmO/KrIlaWrUxX2GLV7l7Jo+SCZSqT48Cq6mMWNDTkUPeMp82r"
        -t, --identity-type = "WHTbiO4KeZUYC4tm5DWVJfacwdlmLkJZnhJKbMCFAdjC0hSkdHs3EnIWlPt+Lnni"
        {
            "type": "WHTbiO4KeZUYC4tm5DWVJfacwdlmLkJZnhJKbMCFAdjC0hSkdHs3EnIWlPt+Lnni",
            "value": "xSf79dt6Bl6/WwHmO/KrIlaWrUxX2GLV7l7Jo+SCZSqT48Cq6mMWNDTkUPeMp82r",
            "validation_token": *validation_token*
        }

is returned. On error, exception is thrown.

========
EXAMPLES
========

1.  Generate a :term:`validation token <Validation token>`:
::

  virgil identity-confirm-private -d alice@domain.com -t email -o validated-identity-private.txt --app-key application-private.key

2.  Generate validation-token with obfuscated identity:
::

  virgil identity-confirm-private -d <obfuscated_value> -t <obfuscated_type> -o validated-identity-private.txt --app-key application-private.key

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-card-create-private`
* :doc:`cli-card-revoke-private`
* :doc:`cli-private-key-get`
