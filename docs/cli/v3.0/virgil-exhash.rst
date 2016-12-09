:orphan:

virgil-exhash
==============

.. program:: virgil-exhash


SYNOPSIS
--------

.. code:: bash

    virgil exhash  [-i <file>] [-o <file>] -z <file> [-g <alg>] [-x <int>] [-V...] [--]
    virgil exhash (-h | --help)
    virgil exhash --version


DESCRIPTION
-----------

    :program:`virgil exhash` derives the obfuscated data from incoming parameters using the :term:`PBKDF function`.


OPTIONS
-------

.. option:: -i <file>, --in=<file>

    The string value to be hashed. If omitted, stdout is used.

.. option:: -o <file>, --out=<file>

    :term:`Hash`. If omitted, stdout is used.

.. option:: -z <file>, --salt=<file>

    The hash :term:`salt`.

.. option:: -g <alg>, --algorithm=<alg>

    The underlying hash algorithm [default: sha384]:

        .. cli:argument:: <alg>

        .. default-role:: cli:value

        * `sha1` - secure Hash Algorithm 1;
        * `sha224` - secure Hash Algorithm 2, that are 224 bits;
        * `sha256` - secure Hash Algorithm 2, that are 256 bits;
        * `sha384` - secure Hash Algorithm 2, that are 384 bits;
        * `sha512` - secure Hash Algorithm 2, that are 512 bits;

        .. default-role::

.. option:: -x <int>, --iterations=<int>

    Iterations count [default: 4096].

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

1.  Underlying hash - SHA384 (default), iterations - 4096 (default):

.. code:: bash

    virgil exhash -i data.txt -o obfuscated_data.txt -z data_salt.txt

2.  Underlying hash - SHA512, iterations - 8192:

.. code:: bash

    virgil exhash -i data.txt -o obfuscated_data.txt -z data_salt.txt -g sha512 -x 8192


SEE ALSO
--------

:cli:ref:`virgil`
