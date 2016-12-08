:orphan:

virgil-encrypt
==============

.. program:: virgil-encrypt


SYNOPSIS
--------

.. code:: bash

    virgil encrypt [-i <file>] [-o <file>] [--c <file>] [-V...] [–-] <recipient-id>...
    virgil encrypt (-h | --help)
    virgil encrypt --version


DESCRIPTION 
-----------

    :program:`virgil encrypt` encrypts any data for the specified recipient(s) and/or with a password using the :term:`recipient-id`.

`recipient-id` is an identifier which will be associated with the :term:`Public Key` used for the encryption. Thus, the email, the Public Key (accompanied by the :term:`alias` or not), the :term:`Virgil Card` or the :term:`Virgil Card id` can be used as well as any combinations of these recipient identifiers. 

Please note that for decryption you will need a provided password or a :term:`Private Key` associated with the Public Key used for encryption.


OPTIONS 
-------

.. option:: -i <file>, --in=<file>

    Data to be encrypted. If omitted, stdin is used.
   
.. option:: -o <file>, --out=<file>

    Encrypted data. If omitted, stdout is used.

.. option:: -c <file>, --content-info=<file>

    :term:`Content info` <Content info> - meta information about the encrypted data. If omitted, becomes a part of the encrypted data.
   
.. option:: -V, --VERBOSE

    Shows the detailed information.

.. option:: --

    Ignores the rest of the labeled arguments following this flag.
 
.. cli:positional:: <recipient-id> (accepted multiple times)

    Contains information about one recipient. Format: [password|email|vcard|pubkey]:<value>
   
        .. cli:argument:: <recipient-id>
        
        .. default-role:: cli:value
      
        * if `password`, then <value> - a password for decrypting;            
        * if `email`, then <value> - the email of the recipient;
        * if `vcard`, then <value> - the recipient's Virgil Card id or the Virgil Card itself (the file stored locally);       
        * if `pubkey`, then <value> - Public Key of the recipient. An alias may also be added. Example: pubkey:bob/public.key:ForBob
        
        .. default-role:: 
        
.. option:: -h,  --help

    Displays usage information and exits.

.. option:: --version

    Displays version information and exits.


EXAMPLES 
--------

1. Alice encrypts *plain.txt* for Bob using his email as a recipient-id. A search of the Virgil Card(s) associated with Bob's email is performed: 

.. code:: bash

    virgil encrypt -i plain.txt -o plain.enc email:bob@email.com

2. Alice encrypts *plain.txt* for Bob and Tom using their emails: 

.. code:: bash

    virgil encrypt -i plain.txt -o plain.enc email:bob@email.com email:tom@email.com

3. Alice encrypts *plain.txt* with a password:

.. code:: bash

    virgil encrypt -i plain.txt -o plain.enc password:Strong_Password_123

4. Alice encrypts *plain.txt* with a combination of a password and recipient-id:

.. code:: bash

    virgil encrypt -i plain.txt -o plain.enc email:bob@email.com password:Strong_Password_123

5. Alice encrypts *plain.txt* for Bob using his Virgil Card id:

.. code:: bash

    virgil encrypt -i plain.txt -o plain.enc vcard:bb5db5084dab511135ec24c2fdc5ce2bca8f7bf6b0b83a7fa4c3cbdcdc740a59

6. Alice encrypts *plain.txt* with Bob's Public Key accompanied with the alias ForBob:

.. code:: bash

    virgil encrypt -i plain.txt -o plain.enc pubkey:bob/public.key:ForBob

 
SEE ALSO 
--------

:cli:ref:`virgil`
