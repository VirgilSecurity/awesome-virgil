Getting Started
===============

The goal of Virgil PHP SDK Documentation is to give a developer the knowledge and understanding required to implement security into his application using Virgil Security system.

Virgil SDK is a communication gateway between your application and :doc:`../../../services/services`. 

Setting up your project
-----------------------

The Virgil SDK is provided as a package named *virgil/sdk*. The package is distributed via **composer** package management system.

You need to install php virgil crypto extension *ext-virgil_crypto_php* as one of dependency otherwise you will get `the requested PHP extension virgil_crypto_php is missing from your system` error during composer install.

In general to install virgil crypto extension follow next steps:
 * Download proper extension package for your platform from [cdn](https://cdn.virgilsecurity.com/virgil-crypto/php/) like **virgil-crypto-2.0.4-php-5.6-linux-x86_64.tgz**.
 * Type following command to unpack extension in terminal:

 ```
 $ tar -xvzf virgil-crypto-2.0.4-php-5.6-linux-x86_64.tgz
 ```

 * Place unpacked **virgil_crypto_php.so** under php extension path.
 * Add virgil extension to your **php.ini** configuration file like **extension = virgil_crypto_php.so**.

 ```
 $ echo "extension=virgil_crypto_php.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"`
 ```

All necessary information about where **php.ini** or **extension_dir** are you can get from **php_info()** in case run php on server or
call **php -i | grep php\.ini** or **php -i | grep extension_dir** from CLI.

Prerequisites
~~~~~~~~~~~~~
-  PHP 5.6.*
-  [Composer](https://getcomposer.org/download)
-  [virgil_crypto_php.so](https://cdn.virgilsecurity.com/virgil-crypto/php)

Installing the package
~~~~~~~~~~~~~~~~~~~~~~

1. Go to the your project root directory.
2. Run

::

	$ composer require virgil/sdk

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

To initialize the SDK Client, you need the *token* that you created for
your application on [Virgil Developer Portal](https://developer.virgilsecurity.com/)

To create an instance of *VirgilClient* class, just call its static method with your application's *accessToken* which you generated on developer's dashboard.

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Client\VirgilClient;

        $client = VirgilClient::create("[ACCESS_TOKEN_HERE]");

note that application's *AccessToken* is not necessary parameter if you are going to work only with global cards:

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Client\VirgilClient;

        $client = VirgilClient::create();

you can also customize initialization using your own parameters

.. code-block:: php
    :linenos:

        use Virgil\Sdk\Client\VirgilClient;
        use Virgil\Sdk\Client\VirgilClientParams;

        $parameters = new VirgilClientParams("[ACCESS_TOKEN_HERE]");

        $parameters->setCardsServiceAddress("https://cards.virgilsecurity.com");
        $parameters->setReadCardsServiceAddress("https://cards-ro.virgilsecurity.com");
        $parameters->setIdentityServiceAddress("https://identity.virgilsecurity.com");
        $parameters->setRegistrationAuthorityService("https://ra.virgilsecurity.com");

        $client = new VirgilClient($parameters);


At this point you can start creating and publishing *Virgil Cards* for your
users.


