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

To start using Virgil Services you first have to create an account at `Virgil 
Developer Portal <https://developer.virgilsecurity.com/account/signup>`__.

After you create an account, or if you already have an account, sign in and 
create a new application. Make sure you save the *appKey* that is 
generated for your application at this point as you will need it later. 
After your application is ready, create a *token* that your app will 
use to make authenticated requests to Virgil Services. One more thing that 
you're going to need is your application's *appID* which is an identifier 
of your application's Virgil Card.

Initializing
------------------------

To use this SDK you need to [sign up for an account](https://developer.virgilsecurity.com/account/signup) and create your first __application__. Make sure to save the __app id__, __private key__ and it's __password__. After this, create an __application token__ for your application to make authenticated requests from your clients.

To initialize the SDK on the client side you will only need the __access token__ you created.

.. code-block:: go

    api, err := virgilapi.New("[YOUR_ACCESS_TOKEN_HERE]")

To initialize the SDK on the server side we will need the __access token__, __app id__ and the __App Key__ you created on the [Developer Dashboard](https://developer.virgilsecurity.com/).

.. code-block:: go

    api, err := virgilapi.NewWithConfig(virgilapi.Config{
        Token: "[YOUR_ACCESS_TOKEN_HERE]",
        Credentials: &virgilapi.AppCredentials{
            AppId:      appCardID,
            PrivateKey: virgilapi.BufferFromString("[YOUR_APP_KEY]")
            PrivateKeyPassword: "[YOUR_APP_KEY_PASSWORD_HERE]"
        }
    })

At this point you can start creating and publishing *Virgil Cards* for your
users.