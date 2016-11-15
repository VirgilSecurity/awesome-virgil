:orphan:

virgil-decrypt
==============

SYNOPSIS
--------
::

  virgil decrypt  [-i <file>] [-o <file>] [--content-info <file>] [-p <arg>] [-V] [--] <keypass>...
    
  virgil decrypt (-h | --help)

  virgil decrypt --version


DESCRIPTION 
-----------

:program:`virgil encrypt` decrypts the encrypted data with a :term:`keypass <Keypass>`.

*keypass* consists of the given password used as the :term:`recipient-id <Recipient’s identifier>` or the :term:`private key <Private Key>` associated with the Public Key used for encryption. You also may need the :term:`Private Key password <Private key password>` if there is one.

Please note that you will need a password and/or the *recipient-id* for encryption.


OPTIONS 
-------

**Basic**

.. option:: -i <file>,  --in <file>
    Data to be decrypted. If omitted, stdin is used.

.. option:: -o <file>,  --out <file>
    Decrypted data. If omitted, stdout is used.

.. option:: --content-info <file>
    :term:`Content info` <Content info>. Use this option if content info is not embedded in the encrypted data.
            
.. option:: -p <arg>,  --private-key-password <arg>
    Private Key Password.

.. option:: -V,  --VERBOSE
    Shows detailed information.

.. option:: --,  --ignore_rest
    Ignores the rest of the labeled arguments following this flag.

.. option:: <keypass>
    Contains Private Key or password. Format: [privkey|password]:<value>       
            
      *if **privkey**, then <value> - recipient's Private Key;
            
      *if **password**, then <value> - recipient's password.
      
**Common**

.. option:: -h,  --help
    Displays usage information and exits.

.. option:: --version
    Displays version information and exits.
  

EXAMPLES 
--------

1.  Anyone with the password decrypts *plain.enc*:
::

        virgil decrypt -i plain.enc -o plain.txt password:strong_password

2.  Bob decrypts *plain.enc* with his private key:
::

        virgil decrypt -i plain.enc -o plain.txt privkey:bob/private.key -p myPassForKey


SEE ALSO 
--------

:cliref:`cli-virgil`
:cliref:`cli-config`
:cliref:`cli-encrypt`
