**********
private-key-del
**********

Delete a private key from the Private Keys Service.

========
SYNOPSIS
========
::
  
  virgil private-key-del  -a <arg> -k <file> [-p <arg>] [-V] [--] [--version][-h]

========
DESCRIPTION
========

The utility allows you to delete the private key from the Private Keys Service.

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

1.  Delete a private key from the Private Keys Service:
::

  virgil private-key-del -k private.key -a <card_id>

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-keygen`
* :doc:`cli-identity-confirm-private`
* :doc:`cli-identity-confirm-global`
