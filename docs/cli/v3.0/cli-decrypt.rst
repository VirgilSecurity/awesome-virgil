**********
decrypt
**********

Decrypt data with the :term:`keypass <Keypass>`.

========
SYNOPSIS
========
::

  virgil decrypt  [-i <file>] [-o <file>] [--content-info <file>] <keypass> [-p <arg>] [-V] [--version] [-h] [--] 

========
DESCRIPTION
========

The utility allows you to decrypt data with a :term:`keypass <Keypass>`.

*keypass* consists of the given password used as the :term:`recipient-id <Recipient’s identifier>` or the :term:`private key <Private Key>` associated with the Public Key used for encryption. You also may need the :term:`private key password <Private key password>` if there is one.

Please note that you will need a password and/or the *recipient-id* for encryption.

========
OPTIONS
========

  ``-i`` <file>,  ``--in`` <file>
    Data to be decrypted. If omitted, stdin is used.

  ``-o`` <file>,  ``--out`` <file>
    Decrypted data. If omitted, stdout is used.

  ``--content-info`` <file>
    :term:`Content info` <Content info>. Use this option if content info is not embedded in the encrypted data.

  ``<keypass>``
    Contains Private Key or password.
    Format:
    [privkey|password]:<value>
    where:        
            
            * if **privkey**, then <value> - recipient's Private Key;
            
            * if **password**, then <value> - recipient's password.
            
   ``-p`` <arg>,  ``--private-key-password`` <arg>
    Private Key Password.

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

1.  Decrypt *plain.txt.enc* for a user with the password:
::

        virgil decrypt -i plain.enc -o plain.txt password:strong_password

2.  Decrypt *plain.txt.enc* for Bob with his private key:
::

        virgil decrypt -i plain.enc -o plain.txt privkey:bob/private.key -p myPassForKey

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-encrypt`
