***********
card-search-private
***********

Search for :term:`a Private Virgil Card(s) <Private Virgil Card>` from the Keys Service.

SYNOPSIS
========
::

  virgil card-search-private  [-o <arg>] -d <arg> -t <arg> [-u] [-V] [--]
                              [--version] [-h]

DESCRIPTION
===========

Search for a Private Virgil Card from the Virgil Keys Service.

OPTIONS
=======

  ``-o`` <arg>,  ``--out`` <arg>
    Folder where Virgil Cards will be saved.

  ``-d`` <arg>,  ``--identity`` <arg>
    (required)  Identity value or obfuscated identity value (see :doc:`cli-exhash`)

  ``-t`` <arg>,  ``--identity-type`` <arg>
    (required)  Identity type or obfuscated identity type (see :doc:`cli-exhash`)

  ``-u``,  ``--unconfirmed``
    Includes unconfirmed identities into Cards search.

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

1.  Search for Private Virgil Cards with a confirmed Identity:
::

  virgil card-search-private -d alice@gmail.com -t email -o alice/

2.  Search for Cards with a confirmed Identity and an uncorfirmaed Identity:
::

  virgil card-search-private -d alice@gmail.com -t email -o alice-with-unconfirmed-identity/ -u

3.  Search for Private Virgil Cards with a confirmed Identity:
::

  virgil card-search-private -d <obfuscated_value> -t <obfuscated_type> -o alice/

4.  Search for Private Virgil Cards with a confirmed Identity and an uncorfirmaed Identity:
::

  virgil card-search-private -d <obfuscated_value> -t <obfuscated_type> -o alice/ -u

SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-card-create-private`
* :doc:`cli-card-get`
