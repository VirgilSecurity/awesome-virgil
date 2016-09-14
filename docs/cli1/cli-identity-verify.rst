**********
identity-verify
**********

Verify an Identity for a :term:`Global Virgil Card <Global Virgil Card>`.

========
SYNOPSIS
========
::

  virgil identity-verify  -d <arg> [-o <file>] [-V] [--] [--version] [-h]

========
DESCRIPTION
========

The utility allows you to verify an Identity for a Global Virgil Card with such steps:

1.  Send a ``confirmation_code`` to an email.
2.  Get an ``action_id`` as a result.

========
OPTIONS
========

  ``-d`` <arg>,  ``--identity`` <arg>
    (required)  Identity email

  ``-o`` <file>,  ``--out`` <file>
    Action id. If omitted stdout is used.

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

On success, :term:`action_id <Action id>` is returned. On error, exception is thrown.

========
EXAMPLES
========
::

        virgil identity-verify -d email:user@domain.com

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-identity-confirm-global`
