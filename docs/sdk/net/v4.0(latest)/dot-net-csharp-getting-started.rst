Getting started
===============

The goal of Virgil .NET/C# Cards SDK Documentation is to give a
developer the knowledge and understanding required to implement security
into his application using Virgil Security ecosystem.

Virgil Cards SDK is a communication gateway between your application and
`Virgil
services <https://stg.virgilsecurity.com/docs/services/services>`__. 

Setting up your project
-----------------------

The Virgil SDK is provided as a package named *Virgil.SDK*. The package
is distributed through NuGet package management system.

Target frameworks
~~~~~~~~~~~~~~~~~

-  .NET Framework 4.0 and newer.

Prerequisites
~~~~~~~~~~~~~

-  Visual Studio 2013 RTM Update 2 and newer (Windows)
-  Xamarin Studio 5.x and newer (Windows, Mac)
-  MonoDevelop 4.x and newer (Windows, Mac, Linux)

Installing the package
~~~~~~~~~~~~~~~~~~~~~~

1. Use NuGet Package Manager (Tools -> Library Package Manager ->
   Package Manager Console)
2. Run ``PM> Install-Package Virgil.SDK``

User and App Credentials
------------------------

When you register an application on the Virgil developer
`dashboard <https://developer.virgilsecurity.com/dashboard>`__, we
provide you with an *appID*, *appKey* and *accessToken*.

-  **appID** is uniquely identifies your application in our services, it
   also uses to identify the Public key generated in a pair with
   *appKey*, for example:
   ``af6799a2f26376731abb9abf32b5f2ac0933013f42628498adb6b12702df1a87``
-  **appKey** is a Private key that uses to perform creation and
   revocation a *Virgil Cards* (Public key) in Virgil services. Also the
   *appKey* can be used for cryptographic operations to take a part in
   application logic. The *appKey* generated at the time of creation
   application and have to be saved in secure place.
-  **accessToken** is a unique string value that provides an
   authenticated secure access to the Virgil services and is passed with
   each API call. The *accessToken* also allows the API to associate
   your app’s requests with your Virgil developer’s account.

Connecting to Virgil
--------------------

Before you can make use of any Virgil services features in your app, you
must first initialize ``VirgilClient`` class. You use the
``VirgilClient`` object to get access to Create, Revoke and Search a
*Virgil Cards* (Public keys).

Initializing an API Client
~~~~~~~~~~~~~~~~~~~~~~~~~~

To create an instance of a *VirgilClient* class, just call its
constructor with your application *accessToken* you generated on
developer deshboard.

Namespace: ``Virgil.SDK.Client``

.. code:: csharp

    var client = new VirgilClient("[YOUR_ACCESS_TOKEN_HERE]");

you also can customize initialization using your own parameters

.. code:: csharp

    var parameters = new VirgilClientParams("[YOUR_ACCESS_TOKEN_HERE]");

    parameters.SetCardsServiceAddress("https://cards.virgilsecurity.com");
    parameters.SetReadOnlyCardsServiceAddress("https://cards-ro.virgilsecurity.com");
    parameters.SetIdentityServiceAddress("https://identity.virgilsecurity.com");

    var client = new VirgilClient(parameters);

Initializing Crypto
~~~~~~~~~~~~~~~~~~~

The *VirgilCrypto* class provides cryptographic operations in
applications, such as hashing, signature generation and verification,
and encryption and decryption.

Namespace: ``Virgil.SDK.Cryptography``

.. code:: csharp

    var crypto = new VirgilCrypto();
