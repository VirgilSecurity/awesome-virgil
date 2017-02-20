Getting started
===============

The goal of Virgil Ruby SDK Documentation is to give a developer the knowledge and understanding required to implement security into his application using Virgil Security system.

Virgil SDK is a communication gateway between your application and :doc:`../../../services/services`. 

Setting up your project
-----------------------

The Virgil SDK is provided as a gem named **virgil-sdk**. The gem is distributed via Gems package management system.

Target frameworks
~~~~~~~~~~~~~~~~~

-  Ruby 2.0+

Installation
~~~~~~~~~~~~~~~~~~~~~~

To install package use the command below:

::

	gem install virgil-sdk --pre
  
  
or add the following line to your Gemfile:
  
::

  gem 'virgil-sdk', '~> 4.0.0b'
  

User and App Credentials
------------------------

When you register an application on Virgil developer's `dashboard <https://developer.virgilsecurity.com/dashboard>`_, we provide you with an ``appID``, ``appKey`` and ``accessToken``.

-  ``appID`` uniquely identifies your application in our services, it is also used to identify the Public key generated in a pair with ``appKey``. Example:
   ``af6799a2f26376731abb9abf32b5f2ac0933013f42628498adb6b12702df1a87``

-  ``appKey`` is a Private key that is used to perform creation and revocation of **Virgil Cards** (Public key) in Virgil services. Also the ``appKey`` can be used for cryptographic operations to take part in application logic. The ``appKey`` is generated at the time of application creation and must be saved in secure place.

-  ``accessToken`` is a unique string value that provides an authenticated secure access to the Virgil services and is passed with each API call. The *accessToken* also allows the API to associate your app’s requests with your Virgil developer’s account.

Connecting to Virgil
--------------------

Before you can use any Virgil services features in your app, you must first initialize ``VirgilClient`` class from ``Virgil::SDK::Client`` module. 
You use the ``VirgilClient`` object to get access to Create, Revoke and Search for Virgil Cards (Public keys).

Initializing an API Client
~~~~~~~~~~~~~~~~~~~~~~~~~~

To create an instance of ``VirgilClient`` class, just call its constructor with your application's **access_token** which you generated on developer's deshboard.

Module: ``Virgil::SDK::Client``

.. code-block:: csharp
    :linenos:

    require 'virgil/sdk'

    client = Virgil::SDK::Client::VirgilClient.new("[YOUR_ACCESS_TOKEN_HERE]")

you can also customize initialization using your own parameters

.. code-block:: csharp
    :linenos:

    client = Virgil::SDK::Client::VirgilClient.new(
        "[YOUR_ACCESS_TOKEN_HERE]",
        https://cards.virgilsecurity.com",
        https://cards-ro.virgilsecurity.com"
    )

Initializing Crypto
~~~~~~~~~~~~~~~~~~~

``VirgilCrypto`` class provides cryptographic operations in applications, such as hashing, signature generation and verification, and encryption and decryption.

Module: ``Virgil::SDK::Cryptography``

.. code-block:: csharp
    :linenos:

    require 'virgil/sdk'

    crypto = Virgil::SDK::Cryptography::VirgilCrypto.new
