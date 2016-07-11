***********
identity-valid
***********

Check *validated-identity* received by *identity-confirm-global*.

========
SYNOPSIS
========
::

  virgil identity-valid  [-o <file>] -f <file> [-V] [--] [--version] [-h]

========
DESCRIPTION
========

Checks a :term:`confirmed Identity <Confirmed Identity>` received by *identity-confirm-global*.

========
OPTIONS
========

  ``-o`` <file>,  ``--out`` <file>
    Return status. If omitted, stdout is used.

  ``-f`` <file>,  ``--validated-identity`` <file>
    (required)  Validated identity (see :doc:`cli-identity-confirm-global`)

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

On success "true" is returned, else "false".

========
EXAMPLES
========
::

  virgil identity-valid -f validated-identity.txt

SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-identity-confirm-global`
