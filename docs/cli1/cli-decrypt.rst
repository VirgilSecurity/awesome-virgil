**********
decrypt
**********

Decrypt data with given password or :term:`private key <Private Key>` + :term:`private key password <Private key password>`(if there is one) + :term:`recipient-id <Recipient’s identifier>`.

========
SYNOPSIS
========
::

  virgil decrypt  [-i <file>] [-o <file>] [-c <file>] [-k <file>] [-p <arg>] -r <arg> [-V] [--] 
                  [--version] [-h]

========
DESCRIPTION
========

The utility allows you to decrypt data with a provided password or a provided combination of private key + *recipient-id*.

*recipient-id* is an identifier which is associated with the public key. If a *sender* has a Virgil Card, his *recipient-id* is his Card's id.

Please note that you will need a password or a combination of public key + *recipient-id* for encryption.

========
OPTIONS
========

  ``-i`` <file>,  ``--in`` <file>
    Data to be decrypted. If omitted, stdin is used.

  ``-o`` <file>,  ``--out`` <file>
    Decrypted data. If omitted, stdout is used.

  ``-c`` <file>,  ``--content-info`` <file>
    Content info. Use this option if content info is not embedded in the encrypted data.

  ``-k`` <file>,  ``--key`` <file>
    Private Key.

  ``-p`` <arg>,  ``--private-key-password`` <arg>
    Private Key Password.

  ``-r`` <arg>,  ``--recipient`` <arg>
    (required)  Recipient defined in format:
    [password|id|vcard|email|private]:<value>
    where:
            * if **password**, then <value> - recipient's password;
            
            * if **id**, then <value> - recipient's UUID associated with a Virgil Card identifier;

            * if **vcard**, then <value> - recipient's Virgil Card/Cards file stored locally;

            * if **email**, then <value> - recipient's email;

            * if **private**, then set type:value for searching Private Virgil Card(s). For example: private:email:<obfuscator_email> (obfuscator - see :doc:`cli-exhash`)

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

1.  Decrypt *plain.txt.enc* for a user identified by his password:
::

        virgil decrypt -i plain.txt.enc -o plain.txt -r password:strong_password

2.  Decrypt *plain.txt.enc* for Bob identified by his private key + `recipient-id` \[id|vcard|email|private\]:
::

        virgil decrypt -i plain.txt.enc -o plain.txt -k bob/private.key -r id:<recipient_id>

========
SEE ALSO
========

* :doc:`cli-virgil`
* :doc:`cli-config`
* :doc:`cli-encrypt`
