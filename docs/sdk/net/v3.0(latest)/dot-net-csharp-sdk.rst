============
Tutorial .NET/C# Keys SDK
============

-  `Introduction`_
-  `Install`_
-  `Obtaining an Access Token`_
-  `Cards and Public Keys`_
-  `Publish a Virgil Card`_
-  `Search for Cards`_
-  `Revoke a Virgil Card`_
-  `Get a Public Key`_
-  `Private Keys`_
-  `Stash a Private Key`_
-  `Get a Private Key`_
-  `Destroy a Private Key`_
-  `Identities`_
-  `Obtaining a global ValidationToken`_
-  `Obtaining a private ValidationToken`_

Introduction
------------

This tutorial explains how to use the Public Keys Service with SDK
library in .NET applications.

Install
-------

Use NuGet Package Manager (Tools -> Library Package Manager -> Package
Manager Console) to install Virgil.SDK package running the command:

::

    PM> Install-Package Virgil.SDK

Obtaining an Access Token
-------------------------

First you must create a Virgil Security developer’s account by signing
up `here`_. Once you have your account you can `sign in`_ and generate
an access token for your application.

The access token provides an authenticated secure access to the Public
Keys Service and is passed with each API call. The access token also
allows the API to associate your app’s requests with your Virgil
Security developer’s account.

Simply add your access token to the class builder.

.. code:: csharp

    var serviceHub = ServiceHub.Create("%ACCESS_TOKEN%");

Cards and Public Keys
---------------------

A Virgil Card is the main entity of the Public Keys Service, it includes
the information about the user and his public key. The Virgil Card
identifies the user by one of his available types, such as an email, a
phone number, etc.

The Virgil Card might be *global* and *private*. The difference is
whether Virgil Services take part in `the Identity verification`_.

*Global Cards* are created with the validation token received after
verification in Virgil Identity Service. Any developer with Virgil
account can create a global Virgil Card and you can be sure that the
account with a particular email has been verified and the email owner is
really the Identity owner.

*Private Cards* are created when a developer is using his own service
for verification instead of Virgil Identity Service or avoids
verification at all. In this case validation token is generated using
app’s Private Key created on our `Developer portal`_.

Publish a Virgil Card
^^^^^^^^^^^^^^^^^^^^^

Creating a *private* Virgil Card with a newly generated key pair and
**ValidationToken**. See how to obtain a **ValidationToken** `here…`_

\`\`\`csharp var keyPair = Virgil

.. _Introduction: #introduction
.. _Install: #install
.. _Obtaining an Access Token: #obtaining-an-access-token
.. _Cards and Public Keys: #cards-and-public-keys
.. _Publish a Virgil Card: #publish-a-virgil-card
.. _Search for Cards: #search-for-cards
.. _Revoke a Virgil Card: #revoke-a-virgil-card
.. _Get a Public Key: #get-a-public-key
.. _Private Keys: #private-keys
.. _Stash a Private Key: #stash-a-private-key
.. _Get a Private Key: #get-a-private-key
.. _Destroy a Private Key: #destroy-a-private-key
.. _Identities: #identities
.. _Obtaining a global ValidationToken: #obtaining-a-global-validationtoken
.. _Obtaining a private ValidationToken: #obtaining-a-private-validationtoken
.. _here: https://developer.virgilsecurity.com/account/signup
.. _sign in: https://developer.virgilsecurity.com/account/signin
.. _the Identity verification: #identities
.. _Developer portal: https://developer.virgilsecurity.com/dashboard/
.. _here…: #obtaining-a-private-validationtoken
