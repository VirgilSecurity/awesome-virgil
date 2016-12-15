:orphan:

virgil-card-search
==================

.. program:: virgil-card-search


SYNOPSIS
--------

.. code:: bash

    virgil card-search  [-o <arg>] -d <identity>... [-t <arg>] [-s <scope>] [-V...] [--]
    virgil card-search (-h | --help)
    virgil card-search --version


DESCRIPTION
-----------

    :program:`virgil card-search` searches for a :term:`Virgil Card(s) <Virgil Card>` by its :term:`identities <identity>` (required), :term:`identity-type` and :term:`scope`.


OPTIONS
-------

.. option:: -o <file>, --out=<file>

    A folder where Virgil Cards will be saved. If omitted, stdout is used.

.. option:: -d <identity>, --identity=<identity>

    .. cli:argument:: <identity>

    .. default-role:: cli:value

    * for :term:`confirmed Virgil Card` with an identity type of 'email' the :term:`identity` must be a valid email;

    * for :term:`segregated Virgil Card` the identity can be any value.

     Multiple identitites can be used for the Virgil Cards search.

    .. default-role::

.. option:: -t <identity-type>, --identity-type=<identity-type>

    .. cli:argument:: <identity-type>

    Specifies the :term:`identity-type` of a Virgil Cards to be found.

    .. default-role:: cli:value

    * for confirmed Virgil Card the identity-type must be `email`;

    * for segregated Virgil Card the identity-type can be any value.

    If omitted, `email` is used.

    .. default-role::

.. option:: -s <scope>, --scope=<scope>

    Specifies the :term:`scope` to perform search on.

    .. cli:argument:: <scope>

    .. default-role:: cli:value

    * for :term:`global Virgil Card` the scope must be `global`;
    * for :term:`application Virgil Card` the scope must be `application`.

    If omitted, `application` is used.

    .. default-role::

.. option:: -V, --VERBOSE

    Shows the detailed information.

.. option:: --

    Ignores the rest of the labeled arguments following this flag.

.. option:: -h,  --help

    Displays usage information and exits.

.. option:: --version

    Displays version information and exits.


EXAMPLES
--------

Search for the Virgil Cards by Alice's and Bob's emails:

.. code:: bash

    virgil card-search -o cards/ -d alice@mail.com bob@mail.com


SEE ALSO
--------

:cli:ref:`virgil`
