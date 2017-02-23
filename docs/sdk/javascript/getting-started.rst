Getting Started
===============

The goal of Virgil JavaScript SDK Documentation is to give a developer the knowledge and understanding required to make security a feature of their application using Virgil Security system.

Virgil SDK is a communication gateway between your application and :doc:`../../../services/services`. 

Setting up your project
-----------------------

This library can be used both on the **frontend** in a web browser, and on the **backend** in a Node application with the same API.

On a server
~~~~~~~~~~~

This module requires Node.js 4.0+ and is available in npm as the `virgil-sdk <https://npm.im/virgil-sdk>`_ package.

::
    npm i virgil-sdk

In the browser
~~~~~~~~~~~~~~

The client-side SDK targets ECMAScript 5 compatible browsers. The library is `UMD <https://github.com/umdjs/umd>`_ compatible, it can be loaded as a CommonJS module, an AMD module or a ``\<script\>`` tag (creating a ``virgil`` global variable).

You can get the source code from our CDN\:::
    <script
    src="https://cdn.virgilsecurity.com/packages/javascript/sdk/4.1.0/virgil-sdk.min.js"
    crossorigin="anonymous"></script>

Or `download from GitHub <https://github.com/VirgilSecurity/virgil-sdk-javascript/releases>`_.


User and App Credentials
------------------------

To start using Virgil Services you first have to create an account at `Virgil 
Developer Portal <https://developer.virgilsecurity.com/account/signup>`__.

After you create an account, or if you already have an account, sign in and 
create a new application. Make sure you save the *appKey* that is 
generated for your application at this point as you will need it later. 
After your application is ready, create a *token* that you will 
use to make authenticated requests to Virgil Services. One more thing that 
you're going to need is your application's *appID* which is an identifier 
of your application's Virgil Card.


Initializing
------------------------

To initialize the SDK API, you need the *token* that you created for 
your application on [Virgil Developer Portal](https://developer.virgilsecurity.com/)

This inializes a VirgilAPI class without application *token* (works only with global Virgil Cards)

.. code-block:: javascript

    // var virgil = require("virgil-sdk");
    // or just use virgil if loaded via <script> tag

    var virgilAPI = virgil.API();

.. code-block:: javascript 

    var virgilAPI = virgil.API("[YOUR_ACCESS_TOKEN_HERE]");

Initialize high-level SDK using configuration object

.. code-block:: csharp 

    var appKeyData = require("fs").readFileSync("[YOUR_APP_KEY_PATH_HERE]");

    var config = {
        accessToken: "[YOUR_ACCESS_TOKEN_HERE]",
        // Credentials are required only in case of publish and revoke local Virgil Cards.
        appCredentials: {
            appId: "[YOUR_APP_ID_HERE]",
            appKeyData: appKeyData,
            appKeyPassword: "[YOUR_APP_KEY_PASSWORD_HERE]"
        },
        cardVerifiers: [{ 
            cardId: "[YOUR_CARD_ID_HERE]",
            publicKeyData: Buffer.from("[YOUR_PUBLIC_KEY_HERE]", "base64")
        }]
    };

    var virgilAPI = virgil.API(context);

At this point you can start creating and publishing *Virgil Cards* for your
users.

