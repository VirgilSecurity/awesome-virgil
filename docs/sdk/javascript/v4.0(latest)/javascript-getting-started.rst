Getting started
===============

The goal of Virgil Javascript SDK Documentation is to give a developer the knowledge and understanding required to implement security into his application using Virgil Security system.

Virgil SDK is a communication gateway between your application and :doc:`../../../services/services`. 

Setting up your project
-----------------------

The Virgil SDK is provided as a package named ``virgil-sdk``. The package
is distributed via `npm <https://www.npmjs.com/>`__ package management
system.

Target environments
~~~~~~~~~~~~~~~~~~~~~

-  SDK targets ECMAScript 5 compatible browsers and Node.js

Installing the package
~~~~~~~~~~~~~~~~~~~~~~

You can install Virgil SDK with npm:

.. note::

    Note that since SDK is still in beta you have to explicitly indicate that you want a beta version when installing from npm.

.. code:: sh

    npm install virgil-sdk@beta

Or get it from CDN:

.. code:: html

    <script src="https://cdn.virgilsecurity.com/packages/javascript/sdk/4.0.0-beta.0/virgil-sdk.min.js" crossorigin="anonymous"></script>

Or `download the source code <https://github.com/VirgilSecurity/virgil-sdk-javascript/releases>`__

User and App Credentials
------------------------

When you register an application on Virgil developer's `dashboard <https://developer.virgilsecurity.com/dashboard>`_, we provide you with an ``appID``, ``appKey`` and ``accessToken``.

-  ``appID`` uniquely identifies your application in our services, it is also used to identify the Public key generated in a pair with ``appKey``. Example:
   ``af6799a2f26376731abb9abf32b5f2ac0933013f42628498adb6b12702df1a87``

-  ``appKey`` is a Private key that is used to perform creation and revocation of **Virgil Cards** (Public key) in Virgil services. Also the ``appKey`` can be used for cryptographic operations to take part in application logic. The ``appKey`` is generated at the time of application creation and must be saved in secure place.

-  ``accessToken`` is a unique string value that provides an authenticated secure access to the Virgil services and is passed with each API call. The *accessToken* also allows the API to associate your app’s requests with your Virgil developer’s account.

Connecting to Virgil
--------------------

To start using Virgil services in your app, you must call a ``client`` factory function available through ``virgil`` namespace to create a ``client`` object that you can then use to create, revoke, search and get **Virgil Cards** (Public keys) from Virgil Services.


Initializing an API Client
~~~~~~~~~~~~~~~~~~~~~~~~~~

The ``client`` factory function requires your application's
*accessToken* as its first parameter

.. code-block:: javascript

    var client = virgil.client("[YOUR_ACCESS_TOKEN_HERE]");

it also has an optional second parameter ``options`` that you can use to
overwrite default URLs of Virgil Services

.. code-block:: javascript
    :linenos:

    var client = virgil.client("[YOUR_ACCESS_TOKEN_HERE]", {
      cardsBaseUrl: "https://cards.virgilsecurity.com",  // Virgil Cards service (Create, Revoke cards)
      cardsReadBaseUrl: "https://cards-ro.virgilsecurity.com", // Virgil Cards Read-Only service (Search, Get cards)
      identityBaseUrl: "https://identity.virgilsecurity.com" // Identity Service (Currently not in use)
    });

Using Crypto
~~~~~~~~~~~~~~~~~~~

The ``crypto`` object available through ``virgil`` namespace provides implementation of cryptographic operations such as hashing, signature generation and verification as well as encryption and decryption. It is initialized automatically when SDK is loaded. All api functions of ``virgil.crypto`` accept and return byte arrays as Node.js ``Buffer``s. For browsers an implementation of ``Buffer`` module is provided by `this library <https://github.com/feross/buffer>`__ and is available through ``virgil`` namespace ``Buffer`` property.

.. code-block:: javascript
    :linenos:

    var crypto = virgil.crypto;
