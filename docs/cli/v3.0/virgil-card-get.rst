:orphan:

virgil-card-get
===============

.. program:: virgil-card-get


SYNOPSIS
--------

.. code:: bash

    virgil card-get [-i <arg>] [-o <arg>] [-V...] [--]
    virgil card-get (-h | --help)
    virgil card-get --version


DESCRIPTION
-----------

    :program:`virgil card-get` gets the :term:`Virgil Card` from the :term:`Virgil Keys Service` by the :term:`Virgil Card id`.


OPTIONS
-------

.. option:: -i <arg>, --in=<arg>

    Virgil Card id. If omitted, stdin is used.

.. option:: -o <file>, --out=<file>

    A folder where Virgil Cards will be saved. If omitted, stdout is used.

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

Get a Virgil Card by Virgil Card id:

.. code:: bash

    virgil card-get -i <card_id> -o cards/


SEE ALSO
--------

:cli:ref:`virgil`
