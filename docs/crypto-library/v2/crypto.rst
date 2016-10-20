Virgil Crypto Library: Overview
===============================

-  `Introduction <#introduction>`__
-  `Supported languages and platforms <#supported-languages-and-platforms>`__
-  `Library purposes <#library-purposes>`__
-  `Where library can be used <#where-library-can-be-used>`__
-  `Build prerequisites <#build-prerequisites>`__
-  `Simple build <#simple-build>`__
-  `Multiarch build <#multiarch-build>`__

Introduction
------------

Virgil is a stack of security libraries (ECIES with Crypto Agility
wrapped in Virgil Cryptogram) and all the necessary infrastructure to
enable seamless, end-to-end encryption for any application, platform or
device. See below for currently available languages and platforms. Get
in touch with us to get preview access to our key infrastructure.

Virgil Security, Inc., guides software developers into the forthcoming
security world in which everything will be encrypted (and passwords will
be eliminated). In this world, the days of developers having to raise
millions of dollars to build a secure chat, secure email, secure
file-sharing, or a secure anything have come to an end. Now developers
can instead focus on building features that give them a competitive
market advantage while end-users can enjoy the privacy and security they
increasingly demand.

Supported languages and platforms
---------------------------------

+------------+------------------------------+
| Language   | Supported OS                 |
+============+==============================+
| C++        | ANY                          |
+------------+------------------------------+
| PHP        | Unix, Linux, OS X            |
+------------+------------------------------+
| Python     | Unix, Linux, OS X            |
+------------+------------------------------+
| Ruby       | Unix, Linux, OS X            |
+------------+------------------------------+
| Java       | Unix, Linux, OS X, Windows   |
+------------+------------------------------+
| .NET       | Unix, Linux, OS X, Windows   |
+------------+------------------------------+
| AsmJS      | Unix, Linux, OS X, Windows   |
+------------+------------------------------+
| NodeJS     | Unix, Linux, OS X, Windows   |
+------------+------------------------------+

Library purposes
----------------

-  Encrypt data;
-  Decrypt data;
-  Sign data;
-  Verify data.

Where library can be used
-------------------------

-  on the client-side application;
-  on the server-side application.

Build prerequisites
-------------------

The page lists the prerequisite packages which need to be installed on
the different platforms to be able to configure and to build Virgil
Crypto Library.

Compiler:

    -  ``g++`` (version >= 4.9), or
    -  ``clang++`` (version >= 3.6), or
    -  ``msvc++`` (version >= 14.0)

Build tools:

    -  ``cmake`` (version >= 3.2)
    -  ``make``

Other tools:

    -  ``git``
    -  ``swig`` (version >= 3.0.7), optional for C++ build
    -  ``doxygen`` (optional)

Simple build
------------

This section describes how to build Virgil Crypto Library for а
particular language.

Step 1 - Choose target language
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Table 1 - Supported languages

+------------+--------------------------------+-------------------------+--------------------+---------------+------------------------------------------------------------------+
| Language   | Supported OS                   | Dependencies            | Build parameters   | Environment   | Binary                                                           |
+============+================================+=========================+====================+===============+==================================================================+
| C++        | ANY                            |                         | LANG=cpp           |               | `CDN <https://cdn.virgilsecurity.com/virgil-crypto/cpp/>`__      |
+------------+--------------------------------+-------------------------+--------------------+---------------+------------------------------------------------------------------+
| PHP        | Unix, Linux, OS X              | php, php5-dev           | LANG=php           |               | `CDN <https://cdn.virgilsecurity.com/virgil-crypto/php/>`__      |
+------------+--------------------------------+-------------------------+--------------------+---------------+------------------------------------------------------------------+
| Python     | Unix, Linux, OS X              | python                  | LANG=python        |               | `CDN <https://cdn.virgilsecurity.com/virgil-crypto/python/>`__   |
+------------+--------------------------------+-------------------------+--------------------+---------------+------------------------------------------------------------------+
| Ruby       | Unix, Linux, OS X              | ruby, ruby-dev          | LANG=ruby          |               | `CDN <https://cdn.virgilsecurity.com/virgil-crypto/ruby/>`__     |
+------------+--------------------------------+-------------------------+--------------------+---------------+------------------------------------------------------------------+
| Java       | Unix, Linux, OS X, Windows\*   | Java JDK 1.6            | LANG=java          | JAVA\_HOME    | `CDN <https://cdn.virgilsecurity.com/virgil-crypto/java/>`__     |
+------------+--------------------------------+-------------------------+--------------------+---------------+------------------------------------------------------------------+
| .NET       | Unix, Linux, OS X, Windows\*   | .NET 2.0, or mono 2.0   | LANG=net           |               | `CDN <https://cdn.virgilsecurity.com/virgil-crypto/net/>`__      |
+------------+--------------------------------+-------------------------+--------------------+---------------+------------------------------------------------------------------+
| AsmJS      | Unix, Linux, OS X, Windows\*   | Emscripten 1.35         | LANG=asmjs         | EMSDK\_HOME   | `CDN <https://cdn.virgilsecurity.com/virgil-crypto/asmjs/>`__    |
+------------+--------------------------------+-------------------------+--------------------+---------------+------------------------------------------------------------------+
| NodeJS     | Unix, Linux, OS X, Windows\*   |                         | LANG=nodejs        |               | `CDN <https://cdn.virgilsecurity.com/virgil-crypto/nodejs/>`__   |
+------------+--------------------------------+-------------------------+--------------------+---------------+------------------------------------------------------------------+

    \* External dependencies for Windows binaries: 
    
    - msvcp140.dll 
    - vcruntime140.dll

    These dependencies can be installed as a part of `Visual C++ Redistributable for Visual Studio 2015 <https://www.microsoft.com/en-us/download/details.aspx?id=48145>`__

Step 2 - Configure environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Open Terminal.
2. Check that all the tools which are listed in the `Build prerequisites`_ are available there.
3. Set environment variables according to the table above in `Step 1 - Choose target language`_.

Step 3 - Get source code
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: shell

    > git clone https://github.com/VirgilSecurity/virgil-crypto.git

Step 4 - Build
~~~~~~~~~~~~~~

Replace ``{{LANG}}`` placeholder to the corresponding value from the table above in `Step 1 - Choose target language`_.

.. code:: shell

    > cd virgil-crypto
    > cmake -H. -B_build -DCMAKE_INSTALL_PREFIX=_install -DLANG={{LANG}}
    > cmake --build _build --target install

Note, if you are using ``-DLANG=nodejs``, one of the next parameters can be appended:

    -  ``-DLANG_VERSION=0.12.7``
    -  ``-DLANG_VERSION=4.1.0``

Multiarch build
---------------

This section describes how to build Virgil Crypto Library for multi
architecture targets, which are packed inside the specific package:

-  Apple OS X Framework
-  Apple iOS Framework
-  Apple WatchOS Framework
-  Apple TVOS Framework
-  Android Bundle as Jar archive
-  Windows Bundle, as structured

Step 1 - Choose target language and platform
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Table 2 - Supported languages and platforms

+------------+----------+---------+-------------------+---------------------+-------------+
| Language   | Platform | Host    | Dependencies      | Build parameters    | Environment |
+============+==========+=========+===================+=====================+=============+
| C++        | OS X     | OS X    |                   | TARGET=osx          |             |
+------------+----------+---------+-------------------+---------------------+-------------+
| C++        | iOS      | OS X    |                   | TARGET=ios          |             |
+------------+----------+---------+-------------------+---------------------+-------------+
| C++        | WatchOS  | OS X    |                   | TARGET=applewatchos |             |
+------------+----------+---------+-------------------+---------------------+-------------+
| C++        | TVOS     | OS X    |                   | TARGET=appletvos    |             |
+------------+----------+---------+-------------------+---------------------+-------------+
| C++        | Windows  | Windows | msvcp140.dll\*,   | TARGET=cpp          |             | 
|            |          |         | vcruntime140.dll* |                     |             |
+------------+----------+---------+-------------------+---------------------+-------------+
| .NET       | iOS      | OS X    | mono 2.0          | TARGET=net\_ios     |             |
+------------+----------+---------+-------------------+---------------------+-------------+
| .NET       | WatchOS  | OS X    | mono 2.0          | TARGET=             |             |
+------------+----------+---------+-------------------+---------------------+-------------+
| .NET       | TVOS     | OS X    | mono 2.0          | TARGET=net\_appletv |             |
+------------+----------+---------+-------------------+---------------------+-------------+
| .NET       | Android  | \*nix   | Android NDK,      | TARGET=net\_android | ANDROID\_NDK|
|            |          |         | mono 2.0          |                     |             |
+------------+----------+---------+-------------------+---------------------+-------------+
| .NET       | Windows  | Windows | .NET 2.0,         | TARGET=net          |             |
|            |          |         | msvcp140.dll*,    |                     |             |
|            |          |         | vcruntime140.dll* |                     |             |
+------------+----------+---------+-------------------+---------------------+-------------+
| Java       | Android  | \*nix   | Android NDK       | TARGET=java\_androi | ANDROID\_NDK|
+------------+----------+---------+-------------------+---------------------+-------------+
| Java       | Windows  | Windows | Java JDK,         | TARGET=java         | JAVA\_HO    |
|            |          |         | msvcp140.dll*,    |                     |             |
|            |          |         | vcruntime140.dll* |                     |             |
+------------+----------+---------+-------------------+---------------------+-------------+
| NodeJS 0.12| Windows  | Windows | msvcp140.dll\*,   | TARGET=nodejs-0.12. |             |
|            |          |         | vcruntime140.dll* |                     |             |
+------------+----------+---------+-------------------+---------------------+-------------+
| NodeJS 4.1 | Windows  | Windows | msvcp140.dll\*,   | TARGET=nodejs-4.1.0 |             |
|            |          |         | vcruntime140.dll* |                     |             |
+------------+----------+---------+-------------------+---------------------+-------------+

    \* These dependencies can be installed as a part of `Visual C++ Redistributable for Visual Studio 2015 <https://www.microsoft.com/en-us/download/details.aspx?id=48145>`__

Step 2 - Configure environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Open Terminal.
2. Check that all tools which are listed in the `Build prerequisites`_ are available there.

-  for Windows compiler should be MSVC;
-  for OS X build toolchain should be Xcode Toolchain.

1. Check that all dependencies from the table above in `Step 1 - Choose target language and platform`_ are
   accessible.
2. Set environment variables according to the table above in `Step 1 - Choose target language and platform`_.

Step 3 - Get source code
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: shell

    > git clone https://github.com/VirgilSecurity/virgil-crypto.git

Step 4 - Build
~~~~~~~~~~~~~~

Replace ``{{TARGET}}`` placeholder to the corresponding value from the table above in `Step 1 - Choose target language and platform`_.

Unix-like OS:

.. code:: shell

    > cd virgil-crypto
    > ./utils/build.sh {{TARGET}}
    > ls ./install/{{TARGET}}

Windows OS:

.. code:: shell

    > set MSVC_ROOT=c:\path\to\msvc\root
    > set JAVA_HOME=c:\path\to\jdk
    > cd virgil-crypto
    > .\utils\build.bat {{TARGET}}
    > dir .\install\{{TARGET}}

