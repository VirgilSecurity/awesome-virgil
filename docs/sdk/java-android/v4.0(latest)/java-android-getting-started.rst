Getting started
===============

The goal of Virgil Java/Android SDK Documentation is to give a developer the knowledge and understanding required to implement security into his application using Virgil Security system.

Virgil SDK is a communication gateway between your application and :doc:`../../../services/services`. 

Setting up your project
-----------------------

The Virgil SDK is provided as a set of packages named **com.virgilsecurity.sdk**. Packages are distributed via Maven repository.

Target frameworks
~~~~~~~~~~~~~~~~~

-  Java 7+
-  Android API 16+

Prerequisites
~~~~~~~~~~~~~

-  Java Development Kit (JDK) 7+
-  Maven 3+

Installing the package
~~~~~~~~~~~~~~~~~~~~~~

You can easily add SDK dependency to your project, just follow the examples below:

Maven
^^^^^

Use this packages for Java projects.

::

    <dependencies>
      <dependency>
        <groupId>com.virgilsecurity.sdk</groupId>
        <artifactId>crypto</artifactId>
        <version>4.0.0</version>
      </dependency>
      <dependency>
        <groupId>com.virgilsecurity.sdk</groupId>
        <artifactId>client</artifactId>
        <version>4.0.0</version>
      </dependency>
    </dependencies>

Gradle
^^^^^^

Use this packages for Android projects.

::

    compile 'com.virgilsecurity.sdk:android:4.0.0@aar'
    compile 'com.google.code.gson:gson:2.7'
    compile 'org.apache.httpcomponents:httpclient-android:4.3.5.1'

User and App Credentials
------------------------

When you register an application on Virgil developer's `dashboard <https://developer.virgilsecurity.com/dashboard>`_, we provide you with an ``appID``, ``appKey`` and ``accessToken``.

-  ``appID`` uniquely identifies your application in our services, it is also used to identify the Public key generated in a pair with ``appKey``. Example:
   ``af6799a2f26376731abb9abf32b5f2ac0933013f42628498adb6b12702df1a87``

-  ``appKey`` is a Private key that is used to perform creation and revocation of **Virgil Cards** (Public key) in Virgil services. Also the ``appKey`` can be used for cryptographic operations to take part in application logic. The ``appKey`` is generated at the time of application creation and must be saved in secure place.

-  ``accessToken`` is a unique string value that provides an authenticated secure access to the Virgil services and is passed with each API call. The *accessToken* also allows the API to associate your app’s requests with your Virgil developer’s account.

Connecting to Virgil
--------------------

Before you can make use of any Virgil services features in your app, you must initialize ``VirgilClient`` class. 

You use the ``VirgilClient`` object to get access to create, revoke and search for **Virgil Cards** (Public keys).

Initializing an API Client
~~~~~~~~~~~~~~~~~~~~~~~~~~

To create an instance of ``VirgilClient`` class, just call its constructor
with your application's **accessToken** which you generated on developer's
dashboard.

.. code-block:: java
    :linenos:

    VirgilClient client = new VirgilClient("[YOUR_ACCESS_TOKEN_HERE]");

you can also customize initialization using your own context

.. code-block:: java
    :linenos:

    VirgilClientContext ctx = new VirgilClientContext("[YOUR_ACCESS_TOKEN_HERE]");
    ctx.setCardsServiceAddress("https://cards.virgilsecurity.com");
    ctx.setReadOnlyCardsServiceAddress("https://cards-ro.virgilsecurity.com");
    ctx.setIdentityServiceAddress("https://identity.virgilsecurity.com");

    VirgilClient client = new VirgilClient(ctx);

Initializing Crypto
~~~~~~~~~~~~~~~~~~~

``VirgilCrypto`` class provides cryptographic operations in applications, such as hashing, signature generation and verification, and encryption and decryption.

.. code-block:: java
    :linenos:

    Crypto crypto = new VirgilCrypto();