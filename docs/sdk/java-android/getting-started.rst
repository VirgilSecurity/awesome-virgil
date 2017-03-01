Getting Started
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
            <version>4.3.0</version>
        </dependency>
        <dependency>
            <groupId>com.virgilsecurity.sdk</groupId>
            <artifactId>sdk</artifactId>
            <version>4.3.0</version>
        </dependency>
    </dependencies>

Gradle
^^^^^^

Use this packages for Android projects.

::

    compile 'com.virgilsecurity.sdk:crypto-android:4.3.0@aar'
    compile 'com.virgilsecurity.sdk:sdk-android:4.3.0@aar'
    compile 'com.google.code.gson:gson:2.7'

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

To initialize the SDK Api, you need the *token* that you created for 
your application on [Virgil Developer Portal](https://developer.virgilsecurity.com/)

This inializes a VirgilApi class without application *token* (works only with global Virgil Cards)

.. code-block:: java

    VirgilApi virgil = new VirgilApiImpl();

.. code-block:: java 

    VirgilApi virgil = new VirgilApiImpl("[YOUR_ACCESS_TOKEN_HERE]");

Initialize high-level SDK using context class

.. code-block:: java 

    AppCredentials credentials = new AppCredentials();
    credentials.setAppId("[YOUR_APP_ID_HERE]");
    credentials.setAppKey(VirgilBuffer.from("[YOUR_APP_KEY_HERE]"));
    credentials.setAppKeyPassword("[YOUR_APP_KEY_PASSWORD_HERE]");

    VirgilApiContext context = new VirgilApiContext("[YOUR_ACCESS_TOKEN_HERE]");
    context.setCredentials(credentials);

    VirgilApi virgil = new VirgilApiImpl(context);

    context.setCrypto(new VirgilCrypto());
    context.setDeviceManager(new DefaultDeviceManager()):
    context.setKeyStorage(new VirgilKeyStorage());

    var virgil = new VirgilApi(context);

At this point you can start creating and publishing *Virgil Cards* for your
users.


