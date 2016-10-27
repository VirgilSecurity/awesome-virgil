*********
encrypt
*********

Encrypt data for provided recipients.

========
SYNOPSIS
========
::

virgil encrypt [-i <file>] [-o <file>] [--content-info] [-V] [–-] [-–version] [-h] <recipient-id> …

======== DESCRIPTION ========

The utility allows you to encrypt data for a specified recipient(s) and/or with a password.

``recipient-id`` is an identifier which will be associated with the :term:`public key <Public Key>` used for the encryption. Thus, the email, the Public Key (accompanied by the :term:`alias` <Alias> or not), the :term:`Virgil Card` <Virgil Card> or the :term:`Virgil Card id` <Virgil Card id> can be used as well as any combinations of these recipient identifiers. 

Please note that for decryption you will need a provided password or a :term:`Private Key` <Private Key> associated with the `Public Key` used for encryption.

======== OPTIONS ========

+---------------------------------------------+----------------------------------------------------------------+
| Option                                      | Description                                                    | 
+=============================================+================================================================+
| ``-i`` <file>,  ``--in`` <file>             | Data to be encrypted. If omitted, stdin is used.               |
+---------------------------------------------+----------------------------------------------------------------+
| ``-o`` <file>,  ``--out`` <file>            | Encrypted data. If omitted, stdout is used.                    |
+---------------------------------------------+----------------------------------------------------------------+
| ``--content-info`` <file>                   | :term:`Content info` <Content info> - meta information about   |
|                                             | the encrypted data.                                            |
|                                             | If omitted, becomes a part of the encrypted data.              |
+---------------------------------------------+----------------------------------------------------------------+
| ``-V``,  ``--VERBOSE``                      | Shows the detailed information.                                |
+---------------------------------------------+----------------------------------------------------------------+
| ``--``,  ``--ignore_rest``                  | Ignores the rest of the labeled arguments following this flag. |
+---------------------------------------------+----------------------------------------------------------------+
| ``--version``                               | Displays version information and exits.                        |
+---------------------------------------------+----------------------------------------------------------------+
| ``-h``,  ``--help``                         | Displays usage information and exits.                          |
+---------------------------------------------+----------------------------------------------------------------+
| ``<recipient-id>`` (accepted multiple times)| Contains information about one recipient.                      |
|                                             |                                                                |
|                                             | Format:                                                        |
|                                             |                                                                |
|                                             | [password|email|vcard|pubkey]:<value>                          |
|                                             |                                                                |
|                                             | where:                                                         |
|                                             |                                                                |
|                                             | * if **password**, then <value> - a password for decrypting;   |
|                                             |                                                                |
|                                             | * if **email**, then <value> - the email of the recipient;     |
|                                             |                                                                |
|                                             | * if **vcard**, then <value> - the recipient's Virgil Card id  |
|                                             |   or the Virgil Card itself (the file stored locally);         |
|                                             |                                                                |
|                                             | * if **pubkey**, then <value> - Public Key of the recipient.   |
|                                             |     An alias may also be added.                                | 
|                                             |     Example: pubkey:bob/public.key:ForBob.                     |
+---------------------------------------------+----------------------------------------------------------------+

======== EXAMPLES ========

1. Alice encrypts *plain.txt* for Bob using his email as a recipient-id. A search of the Virgil Card(s) associated with Bob's email is performed: 
::

       virgil encrypt -i plain.txt -o plain.enc email:bob@email.com

2. Alice encrypts *plain.txt* for Bob and Tom using their emails: 
::
       virgil encrypt -i plain.txt -o plain.enc email:bob@email.com email:tom@email.com

3. Alice encrypts *plain.txt* with a password:
::
       virgil encrypt -i plain.txt -o plain.enc password:Strong_Password_123

4. Alice encrypts *plain.txt* with a combination of a password and recipient-id:
::

       virgil encrypt -i plain.txt -o plain.txt.enc email:bob@email.com password:Strong_Password_123
       
5. Alice encrypts *plain.txt* for Bob using his Virgil Card id:
::
       virgil encrypt -i plain.txt -o plain.txt.enc vcard:bb5db5084dab511135ec24c2fdc5ce2bca8f7bf6b0b83a7fa4c3cbdcdc740a59
       
6. Alice encrypts *plain.txt* with Bob's Public Key accompanied with the alias ForBob:
::

      virgil encrypt -i plain.txt -o plain.txt.enc pubkey:bob/public.key:ForBob

======== SEE ALSO ========

-  :doc:``cli-virgil``
-  :doc:``cli-decrypt``
