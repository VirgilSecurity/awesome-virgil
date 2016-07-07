#########
Virgil Security CLI
#########

- `Description`_
- `Build Unix`_
- `Build Windows`_
- `Example: Virgil CLI with committing to services`_
- `Example: Virgil CLI without committing to services`_

============
Description
============

The **Virgil Security CLI** program is a command line tool for using `Virgil Security <https://virgilsecurity.com/>`_ stack functionality.

**Features**:

-   encrypt, decrypt, sign and verify data;
-   interact with `Virgil Keys Service <http://virgil.readthedocs.io/en/latest/keys-service.html>`_;
-   interact with `Virgil Private Keys Service <http://virgil.readthedocs.io/en/latest/private-keys-service.html>`_.

============
Build Unix
============

Unix toolchain
-----------------

* Compiler:

  - ``g++`` (version >= 4.8.5), or
  - ``clang++`` (version >= 3.5)

*   `CMake <http://www.cmake.org/>`_ (accessible in command prompt). Minimum version: 3.2:

    **For Ubuntu**: `see this link <http://askubuntu.com/questions/610291/how-to-install-cmake-3-2-on-ubuntu-14-04>`_
    
    **For Mac OS X** (make sure you have `Homebrew <http://brew.sh/>`_ installed):
      
    .. code:: 
      
        brew install cmake

*   `Git <http://git-scm.com/>`_ (accessible in command prompt).
*   `libcurl-devel + SSL <https://curl.haxx.se/download.html>`_:

    **For Ubuntu** (package libcurl4-openssl-dev):
    
    .. code:: 
    
        apt-get -y install git libcurl4-openssl-dev
    
    **For Mac OS X**:
    
    .. code:: 
    
        brew install curl --with-openssl

Unix build steps
--------------------

1.   Open terminal.

2.   Clone project.

.. code:: 

  git clone https://github.com/VirgilSecurity/virgil-cli.git

3.   Go to the project's folder.

.. code:: 

  cd virgil-cli

4.   Create folder for the build purposes and go to it.

.. code:: 

  mkdir build && cd build

5.   Configure, build and install.

.. code:: 

  cmake .. && make -j4 && make install

============
Build Windows
============

Windows MSVC toolchain
--------------------

*   `Visual Studio 2015 <https://www.visualstudio.com/>`_
*   `CMake <http://www.cmake.org/>`_ (accessible in command prompt). Minimum version: 3.2.
*   `Git <http://git-scm.com/>`_ (accessible in command prompt).
*   `NSIS <http://nsis.sourceforge.net/>`_.

Windows MSVC build steps
--------------------

1.   Open `Visual Studio Command Prompt`.

2.   Clone project.

.. code:: 

  git clone https://github.com/VirgilSecurity/virgil-cli.git

3.   Go to the project's folder.

.. code:: 

  cd virgil-cli

4.   Create folder for the build purposes and go to it.

.. code:: 

  mkdir build
  cd build

5.   Configure, build and make installer.

.. code:: 
  
  cmake -G"NMake Makefiles" -DCMAKE_BUILD_TYPE=Release ..
  nmake
  nmake package

============
Example: Virgil CLI with committing to services
============

.. note:: Virgil provides all necessary services for managing and performing operations with your keys. We recommend using Virgil Services to store your keys.

Let's create two users Alice and Bob and demonstrate the communication between them.

.. code:: 

  mkdir alice
  mkdir bob

Scenario for Alice is shown below, particularly `Generate Keys`_ and `Create a Global Virgil Card`_.
The same actions are performed for Bob.

Generate Keys
--------------------

.. sidebar:: Used commands

  - `keygen <https://github.com/VirgilSecurity/virgil-cli/wiki/virgil-keygen.1>`_

1.  A :term:`private key <Private Key>` is generated in the Private Keys Service with a default Elliptic 384-bits NIST Curve scheme.
You will be asked to enter the :term:`private key password <Private key password>`:

.. code:: 

  virgil keygen -o alice/private.key

.. sidebar:: Used commands

  - `key2pub <https://github.com/VirgilSecurity/virgil-cli/wiki/virgil-key2pub.1>`_

2.  A :term:`public key <Public Key>` is generated in the Keys Service using the private key.

.. code:: 

  virgil key2pub -i alice/private.key -o alice/public.key

Create a Global Virgil Card
--------------------

.. sidebar:: Used commands

  - `card-create-global <https://github.com/VirgilSecurity/virgil-cli/wiki/virgil-card-create-global.1>`_

A Virgil Card is the main entity of the Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.
:term:`Global Card <Global Virgil Card>` is automatically verified in Virgil Identity Service, it is globally available to all Virgil users.

.. code:: 

  virgil card-create-global --public-key alice/public.key -k alice/private.key -o alice/alice.vcard -d alice@domain.com 
  
.. note:: ``alice@domain.com`` - is your email

Encrypt Data
--------------

.. sidebar:: Used commands

  - `encrypt <https://github.com/VirgilSecurity/virgil-cli/wiki/virgil-encrypt.1>`_

- Bob encrypts *plain.txt* for Alice.
- Bob needs Alice's Global Card to encrypt some data for her.
- He can get it from the Keys Service by indicating Alice's email.

.. code:: 

  virgil encrypt -i plain.txt -o plain.txt.enc email:alice@domain.com

Decrypt Data
----------

.. sidebar:: Used commands

  - `decrypt <https://github.com/VirgilSecurity/virgil-cli/wiki/virgil-decrypt.1>`_

- Alice decrypts *plain.txt.enc*.
- Alice uses her private key and her Card.

.. code:: 

  virgil decrypt -i plain.txt.enc -k alice/private.key -r vcard:alice/alice.vcard

Sign Data
----------

.. sidebar:: Used commands

  - `sign <https://github.com/VirgilSecurity/virgil-cli/wiki/virgil-sign.1>`_

- Alice signs *plain.txt* before passing it to Bob.
- Alice's private key is used to create a signature.

.. code:: 

  virgil sign -i plain.txt -o plain.txt.sign -k alice/private.key

Verify Data
----------

.. sidebar:: Used commands

  - `verify <https://github.com/VirgilSecurity/virgil-cli/wiki/virgil-verify.1>`_

- Bob verifies *plain.txt.sign*.
- He must have Alice's Virgil Card to verify the signature.

.. code:: 

  virgil card-search-global -o bob/ -e alice@domain.com
  virgil verify -i plain.txt -s plain.txt.sign -r vcard:bob/alice.vcard
  
.. note:: Pay attention that ``alice.vcard`` is a shortened example of a Virgil Card name.

============
Example: Virgil CLI without committing to services
============

.. note:: You can choose to take care of keeping your keys securely by yourself. This way you don't save your public key in Virgil Services and have to manage sharing it every time. 

Encrypt Data
----------

.. sidebar:: Used commands

  - `encrypt <https://github.com/VirgilSecurity/virgil-cli/wiki/virgil-encrypt.1>`_

- Alice encrypts *plain.txt* for Bob.
- Alice needs Bob's public key and his identifier to encrypt some data for him.
- `pubkey` is an argument, which contains sender's public key and recipient's identifier.
- Recipient's identifier is a plain text, which is needed for the Public key association.

.. code:: 

  virgil encrypt -i plain.txt -o plain.txt.enc pubkey:bob/public.key:ForBob

Decrypt Data
----------

.. sidebar:: Used commands

  - `decrypt <https://github.com/VirgilSecurity/virgil-cli/wiki/virgil-decrypt.1>`_

- Bob decrypts *plain.txt.enc*.
- Bob uses his private key and the identifier, which has been provided by Alice.

.. code:: 

  virgil decrypt -i plain.txt.enc -k bob/private.key -r id:ForBob

Sign Data
----------

.. sidebar:: Used commands

  - `sign <https://github.com/VirgilSecurity/virgil-cli/wiki/virgil-sign.1>`_

- Alice signs *plain.txt* before passing it to Bob.
- Alice's private key is used to create a signature.

.. code:: 

  virgil sign -i plain.txt -o plain.txt.sign -k alice/private.key

Verify Data
----------

.. sidebar:: Used commands

  - `verify <https://github.com/VirgilSecurity/virgil-cli/wiki/virgil-verify.1>`_

- Bob verifies *plain.txt.sign*.
- He need's Alice's public key to verify the signature.

.. code:: 

  virgil verify -i plain.txt -s plain.txt.sign -r pubkey:alice/public.key
