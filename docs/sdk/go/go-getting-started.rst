Getting started
===============

The goal of Virgil Go SDK Documentation is to give a developer the knowledge and understanding required to implement security into his application using Virgil Security system.

Virgil SDK is a communication gateway between your application and :doc:`../../../services/services`. 

Setting up your project
-----------------------

The Virgil SDK is provided as a package named ``virgil``. The package is
distributed via github.

Prerequisites
~~~~~~~~~~~~~

-  Go 1.7.1 or newer

Installing the package
~~~~~~~~~~~~~~~~~~~~~~

::

    go get -u github.com/VirgilSecurity/virgil-sdk-go


User and App Credentials
------------------------

When you register an application on Virgil developer's `dashboard <https://developer.virgilsecurity.com/dashboard>`_, we provide you with an ``appID``, ``appKey`` and ``accessToken``.

-  ``appID`` uniquely identifies your application in our services, it is also used to identify the Public key generated in a pair with ``appKey``. Example:
   ``af6799a2f26376731abb9abf32b5f2ac0933013f42628498adb6b12702df1a87``

-  ``appKey`` is a Private key that is used to perform creation and revocation of **Virgil Cards** (Public key) in Virgil services. Also the ``appKey`` can be used for cryptographic operations to take part in application logic. The ``appKey`` is generated at the time of application creation and must be saved in secure place.

-  ``accessToken`` is a unique string value that provides an authenticated secure access to the Virgil services and is passed with each API call. The *accessToken* also allows the API to associate your app’s requests with your Virgil developer’s account.

Connecting to Virgil
--------------------

Before you can use any Virgil services features in your app, you must
first initialize ``virgil.Client`` class. You use the ``virgil.Client``
object to get access to Create, Revoke and Search for **Virgil Cards**
(Public keys).

Initializing an API Client
~~~~~~~~~~~~~~~~~~~~~~~~~~

To create an instance of ``virgil.Client`` class, just call
virgil.NewClient() with your application's ``accessToken`` which you
generated on developer's dashboard.

.. code-block:: go
    :linenos:

    client := virgil.NewClient("[YOUR_ACCESS_TOKEN_HERE]")

you can also customize initialization using your own parameters

.. code-block:: go
    :linenos:

    virgil.DefaultClientParams = &virgil.VirgilClientParams{
            CardsServiceAddress:         "https://cards.virgilsecurity.com",
            ReadonlyCardsServiceAddress: "https://cards-ro.virgilsecurity.com",
        }

Initializing Crypto
~~~~~~~~~~~~~~~~~~~

The ``VirgilCrypto`` class provides cryptographic operations in
applications, such as hashing, signature generation and verification,
and encryption and decryption.

.. code-block:: go
    :linenos:

    crypto := virgil.Crypto()

High level API
--------------

This API provides a simple way of managing :term:`Virgil Cards <Virgil Card>`, encrypting data
and verifying signatures.

Global configuration
~~~~~~~~~~~~~~~~~~~~

.. code-block:: go
    :linenos:

    virgil.InitConfig("[YOUR_TOKEN_HERE]")

That's it.