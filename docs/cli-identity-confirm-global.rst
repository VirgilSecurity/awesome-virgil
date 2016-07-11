***********
identity-confirm-global
***********

Confirm identity for :term:`a Global Virgil Card <Global Virgil Card>`.

========
SYNOPSIS
========
::

  virgil identity-confirm-global  [-o <file>] [-d <arg>] [--action-id <arg>]
                                  [--confirmation-code <arg>] [-t <int>] [-c <int>] 
                                  [-V] [--] [--version] [-h]

========
DESCRIPTION
========

It is required to pass ``identity-confirm`` if you want to confirm your Identity so that other people can be sure that a received signature and encrypted data came from you. After entering your email, a :term:`confirmation code <Confirmation code>` will be sent to you, you have to enter it to receive :term:`a confirmed Identity <Confirmed Identity>`. ``validated-identity`` consists of *validation token* and your Identity. It is required for the following operations:

1.  Create a Global Virgil Card. See :doc:`cli-card-create-global`;
2.  Revoke a Global Virgil Card, a group of Cards. See :doc:`cli-card-revoke-global`, :doc:`cli-public-key-revoke-global`;
3.  Get a private key from the Private Keys Service. See :doc:`cli-private-key-get`.

========
OPTIONS
========

  ``-o`` <file>,  ``--out`` <file>
    Validated identity. If omitted, stdout is used.

  ``-d`` <arg>,  ``--identity`` <arg>
    Identity email:alice@domain.com

  ``--action-id`` <file>
    Action id.

  ``--confirmation-code`` <arg>
    Confirmation code

  ``-t`` <int>, ``--time-to-live`` <int>
    Time to live, by default = 3600.

  ``-c`` <int>,  ``--count-to-live`` <int>
    Count to live, by default = 2.

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
::

    {
        "type": "email",
        "value": "alice@gmail.com",
        "validation_token": *validation_token*
    }

is returned. On error, exception is thrown.

========
EXAMPLES
========

1.  Identity confirmation with requests number limit = 2 and time validity limit = 3600:
::

        virgil identity-confirm-global -d email:alice@gmail.com -o validated-identity.txt

2.  Identity confirmation with requests number limit = 10 and time validity limit = 60:
::

        virgil identity-confirm-global -d email:alice@gmail.com -o validated-identity.txt -l 60 -c 10

3.  Identity confirmation with requests number limit = 2 and time validity limit = 3600:
::

        virgil identity-verify -d email:user@domain.com -o userDomain/action_id.txt
        virgil identity-confirm-global --action-id userDomain/action_id.txt --confirmation-code <code> -o alice/validated-identity.txt

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-card-create-global`
* :doc:`cli-card-revoke-global`
* :doc:`cli-private-key-get`
