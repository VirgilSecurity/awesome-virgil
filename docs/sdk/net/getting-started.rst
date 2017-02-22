Getting Started
===============

The goal of Virgil .NET/C# SDK Documentation is to give a developer the knowledge and understanding required to implement security into his application using Virgil Security system.

Virgil SDK is a communication gateway between your application and :doc:`../../../services/services`. 

Setting up your project
-----------------------

The Virgil SDK is provided as a package named **Virgil.SDK**. The package is distributed via NuGet package management system.

Target frameworks
~~~~~~~~~~~~~~~~~

-  .NET Framework 4.0 and newer.

Prerequisites
~~~~~~~~~~~~~

-  Visual Studio 2013 RTM Update 2 and newer (Windows)

Installing the package
~~~~~~~~~~~~~~~~~~~~~~

1. Use NuGet Package Manager (Tools -> Library Package Manager -> Package Manager Console)
2. Run

::

	PM> Install-Package Virgil.SDK

User and App Credentials
------------------------

To start using Virgil Services you first have to create an account at `Virgil 
Developer Portal <https://developer.virgilsecurity.com/account/signup>`__.

After you create an account, or if you already have an account, sign in and 
create a new application. Make sure you save the *appKey* that is 
generated for your application at this point as you will need it later. 
After your application is ready, create a *token* that your app will 
use to make authenticated requests to Virgil Services. One more thing that 
you're going to need is your application's *appID* which is an identifier 
of your application's Virgil Card.

Usage
--------------------

Before you can make use of any Virgil Services features in your app, you must initialize ``VirgilApi`` class. 

Initializing
------------------------

Namespace: ``Virgil.SDK``

To initialize the SDK Api, you need the *token* that you created for 
your application on [Virgil Developer Portal](https://developer.virgilsecurity.com/)

This inializes a VirgilApi class without application *token* (works only with global Virgil Cards)

.. code-block:: csharp

    var virgil = new VirgilApi();

.. code-block:: csharp 

    var virgil = new VirgilApi("[YOUR_ACCESS_TOKEN_HERE]");

Initialize high-level SDK using context class

.. code-block:: csharp 

    var context = new VirgilApiContext
    {
        AccessToken = "[YOUR_ACCESS_TOKEN_HERE]",
        // Credentials are required only in case of publish and revoke local Virgil Cards.
        Credentials = new AppCredentials
        {
            AppId = "[YOUR_APP_ID_HERE]",
            AppKeyData = VirgilBuffer.FromFile("[YOUR_APP_KEY_PATH_HERE]"),
            AppKeyPassword = "[YOUR_APP_KEY_PASSWORD_HERE]"
        },
        CardVerifiers = new [] { 
            new CardVerifierInfo {
                CardId = "[YOUR_CARD_ID_HERE]",
                PublicKeyData = VirgilBuffer.From("[YOUR_PUBLIC_KEY_HERE]", StringEncoding.Base64)
            }
        }
    };

    var virgil = new VirgilApi(context);

At this point you can start creating and publishing *Virgil Cards* for your
users.


