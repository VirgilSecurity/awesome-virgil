*********
encrypt
*********

Encrypt data for provided recipients.

========
SYNOPSIS
========
::

  virgil encrypt  [-i <file>] [-o <file>] [-c <file>] [-V] [--] [--version] [-h]
                  <recipient> ...

========
DESCRIPTION
========

The utility allows you to encrypt data with a password or a combination of a :term:`public key <Public Key>` + :term:`recipient-id <Recipient’s identifier>`.

`recipient-id` is an identifier which will be associated with the public key. If a *sender* has a :term:`Virgil Card <Virgil Card>`, his recipient-id is the Card's id. Public key is saved in the Card.

Please note that you will need a provided password or a provided combination of `private key` + `recipient-id` for decryption.

========
OPTIONS
========

  ``-i`` <file>,  ``--in`` <file>
    Data to be encrypted. If omitted, stdin is used.

  ``-o`` <file>,  ``--out`` <file>
    Encrypted data. If omitted, stdout is used.

  ``-c`` <file>,  ``--content-info`` <file>
    Content info - meta information about encrypted data. If omitted, 
    becomes a part of the encrypted data.

  ``-V``,  ``--VERBOSE``
    Shows detailed information.

  ``--``,  ``--ignore_rest``
    Ignores the rest of the labeled arguments following this flag.

  ``--version``
    Displays version information and exits.

  ``-h``,  ``--help``
    Displays usage information and exits.

  ``<recipient>``  (accepted multiple times)
    Contains information about one recipient.
    Format:

         [password|id|vcard|email|pubkey|private]:<value>

         where:

            * if **password**, then <value> - recipient's password;

            * if **id**, then <value> - recipient's UUID associated with Virgil Card identifier;

            * if **vcard**, then <value> - recipient's the Virgil Card file stored locally;

            * if **email**, then <value> - recipient's email;

            * if **pubkey**, then <value> - recipient's public key + identifier, for example: pubkey:bob/public.key:ForBob.

            * if **private**, then set type:value for searching Private Virgil Card(s)  with confirmed identity (see 'virgil card-create-private'). For example: private:<obfuscated_type>:<obfuscated_value> ( obfuscator - see 'virgil hash')

========
EXAMPLES
========

1.  Alice encrypts *plain.txt* for Bob using his email (searching the Global Virgil Card(s)):
::

        virgil encrypt -i plain.txt -o plain.txt.enc email:bob@domain.com

2.  Alice encrypts *plain.txt* for Bob using his email (searching the Private Virgil Card(s)):
::

        virgil encrypt -i plain.txt -o plain.txt.enc private:email:bob@domain.com

3.  Alice encrypts *plain.txt* for Bob using his email (searching the Private Virgil Card(s)):
::

        virgil encrypt -i plain.txt -o plain.txt.enc private:<obfuscated_type>:<obfuscated_value>

4.  Alice encrypts *plain.txt* for Bob and Tom using their emails:
::

        virgil encrypt -i plain.txt -o plain.txt.venc email:bob@domain.com email:tom@domain.com

5.  Alice encrypts *plain.txt* with a password:
::

        virgil encrypt -i plain.txt -o plain.txt.venc password:strong_password

6.  Alice encrypts *plain.txt* with a combination of Public Key + recipient-id:
::

        virgil encrypt -i plain.txt -o plain.txt.venc pubkey:public.key:ForBob

========
SEE ALSO
========

virgil(1)
virgil-config(1)
virgil-decrypt(1)
