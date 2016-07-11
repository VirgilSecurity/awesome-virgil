************
card-search-global
************

Search for :term:`a Global Virgil Card <Global Virgil Card>` from the Virgil Keys Service.

========
SYNOPSIS
========
::

  virgil card-search-global  {-e <arg>|-c <arg>} [-o <arg>] [-V] [--] [--version][-h]

========
DESCRIPTION
========

The utility allows you to search for a Global Virgil Card from the Virgil Keys Service by:

1.  ``application_name`` - search an application Global Virgil Card.
2.  ``email`` - search for a Global Virgil Card.

========
OPTIONS
========

  ``-e`` <arg>,  ``--email`` <arg>
    (OR required)  Email.
  -- OR --
  ``-c`` <arg>,  ``--application-name`` <arg>
  (OR required)  Application name, name = 'com.virgilsecurity.*' - get all Cards

  ``-o`` <arg>,  ``--out`` <arg>
    Folder where Virgil Cards will be saved.

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

1.  Search for Global Virgil Card by user's email:
::

  virgil card-search-global -e alice@mailinator.com -o alice/

2.  Search for application Global Virgil Cards by application name:
::

  virgil card-search-global -c <app_name> -o all_app_cards/

3.  Get all application Cards:
::

  virgil card-search-global -c "com.virgilsecurity.*" -o all_app_cards/

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-card-create-global`
* :doc:`cli-card-get`
