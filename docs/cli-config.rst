*********
config
*********

Get information about Virgil CLI configuration file.

========
SYNOPSIS
========

    virgil config  [-o <file>] [-g] [-l] [-t] [--] [--version] [-h]

========
DESCRIPTION
========

Get information about Virgil CLI configuration file.

If Virgil Access Token hasn't been set  during the application build (cmake -DVIRGIL\_ACCESS\_TOKEN=<VIRGIL_ACCESS_TOKEN> ..) or if it should be changed, you can create a configuration file.

With ``virgil config`` utility you can find out what path should be used to create the configuration file and how it should look.

The Virgil Access Token is definitely needed for the following utilites.

**Private Virgil Card**:

-   `virgil-card-create-private(1)`
-   `virgil-card-revoke-private(1)`
-   `virgil-public-key-revoke-private(1)`
-   `virgil-card-search-private(1)`

**Global Virgil Card**:

-   `virgil-identity-verify(1)`
-   `virgil-identity-valid(1)`
-   `virgil-identity-confirm-global(1)`

-   `virgil-card-create-global(1)`
-   `virgil-card-revoke-global(1)`
-   `virgil-public-key-revoke-global(1)`
-   `virgil-card-search-global(1)`

**Common**:

-   `virgil-card-get(1)`

-   `virgil-public-key-get(1)`

-   `virgil-private-key-add(1)`
-   `virgil-private-key-get(1)`
-   `virgil-private-key-del(1)`

Part of the functionality, which refers to the **search of Cards in Virgil Keys Service**:

-   `virgil-verify(1)`
-   `virgil-encrypt(1)`
-   `virgil-decrypt(1)`

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

virgil(1)
