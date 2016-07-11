*********
config
*********

Get information about Virgil CLI configuration file.

========
SYNOPSIS
========
::

    virgil config  [-o <file>] [-g] [-l] [-t] [--] [--version] [-h]

========
DESCRIPTION
========

Get information about Virgil CLI configuration file.

If Virgil Access Token hasn't been set  during the application build (cmake -DVIRGIL\_ACCESS\_TOKEN=<VIRGIL_ACCESS_TOKEN> ..) or if it should be changed, you can create a configuration file.

With ``virgil config`` utility you can find out what path should be used to create the configuration file and how it should look.

The Virgil Access Token is definitely needed for the following utilites.

**Private Virgil Card**:

* :doc:`cli-card-create-private`
* :doc:`cli-card-revoke-private`
* :doc:`cli-public-key-revoke-private`
* :doc:`cli-card-search-private`

**Global Virgil Card**:

* :doc:`cli-identity-verify`
* :doc:`cli-identity-valid`
* :doc:`cli-identity-confirm-global`
* :doc:`cli-card-create-global`
* :doc:`cli-card-revoke-global`
* :doc:`cli-public-key-revoke-global`
* :doc:`cli-card-search-global`

**Common**:

* :doc:`cli-card-get`
* :doc:`cli-public-key-get`
* :doc:`cli-private-key-add`
* :doc:`cli-private-key-get`
* :doc:`cli-private-key-del`

Part of the functionality, which refers to the **search of Cards in Virgil Keys Service**:

* :doc:`cli-verify`
* :doc:`cli-encrypt`
* :doc:`cli-decrypt`

========
OPTIONS
========

  ``-o`` <file>,  ``--out`` <file>
    If omitted, stdout is used.

  ``-g``,  ``--global``
    Show path to the configuration file applied for all users.

  ``-l``,  ``--local``
    Show path to the configuration file applied for current user.

  ``-t``,  ``--template``
    Show configuration file template.

  ``--``,  ``--ignore_rest``
    Ignores the rest of the labeled arguments following this flag.

  ``--version``
    Displays version information and exits.

  ``-h``,  ``--help``
    Displays usage information and exits.

========
EXAMPLES
========

1.  Show path to the configuration file applied for all users:
::

        virgil config --global

2.  Show path to the configuration file applied for current user:
::

        virgil config --local

3.  Show configuration file template:
::

        virgil config --template

========
SEE ALSO
========

* :doc:`cli-virgil`
