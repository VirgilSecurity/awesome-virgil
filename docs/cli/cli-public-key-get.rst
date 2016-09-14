********
public-key-get
********

Get Global/Private Virgil Public Key from the Virgil Keys Service.

========
SYNOPSIS
========
::

  virgil public-key-get  [-o <file>] -e <arg> [-V] [--] [--version] [-h]

========
DESCRIPTION
========

This utility allows you to get a public key by its ``public-key-id``.

========
OPTIONS
========

  ``-o`` <file>,  ``--out`` <file>
    Virgil Public Key. If omitted, stdout is used.

  ``-e`` <arg>,  ``--public-key-id`` <arg>
    (required)  Public Key identifier

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

1.  Get a public key by its :term:`public-key-id <Public key id>`:
::

  virgil public-key-get -o public.vkey -e <public_key_id>

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-card-get`
* :doc:`cli-card-search-global`
* :doc:`cli-card-search-private`
* :doc:`cli-card-create-global`
* :doc:`cli-card-create-private`
