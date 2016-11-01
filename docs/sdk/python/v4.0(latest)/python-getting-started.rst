Getting started
===============

The goal of Virgil Python SDK Documentation is to give a developer the knowledge and understanding required to implement security into his application using Virgil Security system.

Virgil SDK is a communication gateway between your application and :doc:`../../../services/services`. 

Setting up your project
-----------------------

The Virgil SDK is provided as a package named **virgil-sdk**. The package
is distributed via pip package manager.

Target frameworks
~~~~~~~~~~~~~~~~~

-  Python 2.7+
-  Python 3.3+


Installing the package
~~~~~~~~~~~~~~~~~~~~~~

To install package use the command below:

::

    python setup.py install

or you can use pip to download and install package automatically:

::

    python -m pip install virgil_sdk

User and App Credentials
------------------------

When you register an application on Virgil developer's `dashboard <https://developer.virgilsecurity.com/dashboard>`_, we provide you with an ``app_id``, ``app_key`` and ``access_token``.

-  ``app_id`` uniquely identifies your application in our services, it is also used to identify the Public key generated in a pair with ``app_key``. Example:
   ``af6799a2f26376731abb9abf32b5f2ac0933013f42628498adb6b12702df1a87``

-  ``app_key`` is a Private key that is used to perform creation and revocation of **Virgil Cards** (Public key) in Virgil services. Also the ``app_key`` can be used for cryptographic operations to take part in application logic. The ``app_key`` is generated at the time of application creation and must be saved in secure place.

-  ``access_token`` is a unique string value that provides an authenticated secure access to the Virgil services and is passed with each API call. The ``access_token`` also allows the API to associate your app’s requests with your Virgil developer’s account.

Connecting to Virgil
--------------------

Before you can use any Virgil services features in your app, you must first initialize ``VirgilClient`` class from ``virgil_sdk.client`` module. 

You will use the ``VirgilClient`` object to get access to Create, Revoke and Search for *Virgil Cards* (Public keys).

Initializing an API Client
~~~~~~~~~~~~~~~~~~~~~~~~~~

To create an instance of ``VirgilClient`` class, just call its constructor with your application's **access\_token** which you generated on developer's dashboard.

Module: ``virgil_sdk.client``

.. code-block:: python
    :linenos:

    virgil_client = VirgilClient("[YOUR_ACCESS_TOKEN_HERE]")

you can also customize initialization using your own parameters

.. code-block:: python
    :linenos:

    virgil_client = VirgilClient(
        "[YOUR_ACCESS_TOKEN_HERE]",
        cards_service_url="https://cards.virgilsecurity.com",
        cards_read_only_service_url="https://cards-ro.virgilsecurity.com",
    )

Initializing Crypto
~~~~~~~~~~~~~~~~~~~

The ``VirgilCrypto`` class provides cryptographic operations in applications, such as hashing, signature generation and verification, encryption and decryption.

Module: ``virgil_sdk.cryptography``

.. code-block:: python
    :linenos:

    crypto = new VirgilCrypto()