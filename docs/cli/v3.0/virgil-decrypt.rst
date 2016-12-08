:orphan:

virgil-decrypt
==============

.. program:: virgil-decrypt


SYNOPSIS
--------

.. code:: bash

    virgil decrypt  [-i <file>] [-o <file>] [-c <file>] [-p <arg>] [-V...] [--] <keypass>...    
    virgil decrypt (-h | --help)
    virgil decrypt --version


DESCRIPTION 
-----------

    :program:`virgil decrypt` decrypts the encrypted data with a :term:`keypass`.

    *keypass* consists of the given password used as the :term:`recipient-id <Recipient's identifier>` or the :term:`Private Key` associated with the :term:`Public Key` used for encryption. You also may need the :term:`Private Key password` if there is one.

    Please note that you will need a password and/or the *recipient-id* for encryption.


OPTIONS 
-------

.. option:: -i <file>,  --in=<file>

    Data to be decrypted. If omitted, stdin is used.

.. option:: -o <file>,  --out=<file>

    Decrypted data. If omitted, stdout is used.

.. option:: -c <file>, --content-info=<file>

    :term:`Content info`. Use this option if content info is not embedded in the encrypted data.
            
.. option:: -p <arg>,  --private-key-password=<arg>

    Private Key Password.

.. option:: -V, --VERBOSE

    Shows detailed information.

.. option:: --

    Ignores the rest of the labeled arguments following this flag.

.. cli:positional:: <keypass>

    Contains Private Key or password. Format: [privkey|password]:<value>       
      
        .. cli:argument:: <keypass>
        
        .. default-role:: cli:value
      
        * if `privkey`, then <value> - recipient's Private Key;
        * if `password`, then <value> - recipient's password.

        .. default-role::

.. option:: -h,  --help

    Displays usage information and exits.

.. option:: --version

    Displays version information and exits.
  

EXAMPLES 
--------

1.  Anyone with the password decrypts *plain.enc*:

.. code:: bash

    virgil decrypt -i plain.enc -o plain.txt password:strong_password
    
2.  Bob decrypts *plain.enc* with his private key:

.. code:: bash

    virgil decrypt -i plain.enc -o plain.txt privkey:bob/private.key -p myPassForKey


SEE ALSO 
--------

:cli:ref:`virgil`
