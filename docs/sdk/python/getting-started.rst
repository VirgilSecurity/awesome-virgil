Getting Started
===============

The goal of Virgil Ruby SDK Documentation is to give a developer the knowledge and understanding required to implement security into his application using Virgil Security system.

Virgil SDK is a communication gateway between your application and :doc:`../../../services/services`. 

Setting up your project
-----------------------

The Virgil SDK is provided as a gem named *virgil-sdk*. The package is distributed via *bundler* package manager.

Target platform
~~~~~~~~~~~~~~~~~

-  Ruby 2.1 and newer.

Prerequisites
~~~~~~~~~~~~~

- 

Installing the package
~~~~~~~~~~~~~~~~~~~~~~

To install the gem use the command below:

.. code-block:: ruby

    gem install virgil-sdk


or add the following line to your Gemfile:

.. code-block:: ruby

    gem 'virgil-sdk', '~> 4.2.0'



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

.. code-block:: ruby

    require "virgil/sdk"
    include Virgil::SDK::HighLevel

To initialize the SDK Api, you need the *token* that you created for 
your application on [Virgil Developer Portal](https://developer.virgilsecurity.com/)

This inializes a VirgilApi class without application *token* (works only with global Virgil Cards)

.. code-block:: ruby

    virgil = VirgilApi.new

.. code-block:: ruby 

    virgil = VirgilApi.new(access_token: "[YOUR_ACCESS_TOKEN_HERE]")

Initialize high-level SDK using context class

.. code-block:: ruby 

    context = VirgilContext.new(
        access_token: "[YOUR_ACCESS_TOKEN_HERE]",
        # Credentials are required only in case of publish and revoke local Virgil Cards.
        credentials: VirgilAppCredentials.new(app_id: "[YOUR_APP_ID_HERE]",
                                            app_key_data: VirgilBuffer.from_file("[YOUR_APP_KEY_PATH_HERE]"),
                                            app_key_password: "[YOUR_APP_KEY_PASSWORD_HERE]"),
        card_verifiers: [ VirgilCardVerifierInfo.new("[YOUR_CARD_ID_HERE]", 
                                                    VirgilBuffer.from_base64("[YOUR_PUBLIC_KEY_HERE]"))]
    )

    virgil = VirgilApi.new(context: context)

At this point you can start creating and publishing *Virgil Cards* for your
users.

