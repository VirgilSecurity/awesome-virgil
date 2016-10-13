Getting started
===============

The goal of Virgil Objective C/Swift SDK Documentation is to give a developer the knowledge and understanding required to implement security into his application using Virgil Security system.

Virgil SDK is a communication gateway between your application and :doc:`../../../services/services`. 

Requirements
------------

iOS 7.0+

Installation
------------

CocoaPods
~~~~~~~~~

`CocoaPods <http://cocoapods.org>`__ is a dependency manager for Cocoa projects. You can install it with the following command:

.. code-block:: bash
    :linenos:

    $ gem install cocoapods

To integrate VirgilSDK into your Xcode project using CocoaPods, specify it in your ``Podfile``:

.. code-block:: ruby
    :linenos:

    source 'https://github.com/CocoaPods/Specs.git'
    platform :ios, '10.0'
    use_frameworks!

    target '<Your Target Name>' do
        pod 'VirgilSDK', '~> 4.0'
    end

Then, run the following command:

.. code-block:: bash
    :linenos:

    $ pod install

CocoaPods 0.36+ is required to build VirgilSDK 4.0.0+.

Swift note
~~~~~~~~~~~

Although VirgilSDK pod is using Objective-C as its primary language it
might be quite easily used in a Swift application. After pod is
installed as described above it is necessary to perform the following:

-  Create a new header file in the Swift project.
-  Name it something like ``BridgingHeader.h``
-  Put there the following lines:

Objective-C

.. code-block:: objectivec
    :linenos:

    @import VirgilCrypto;
    @import VirgilSDK;

In the Xcode build settings find the setting called ``Objective-C Bridging Header`` and set the path to your ``BridgingHeader.h`` file. Be aware that this path is relative to your Xcode project's folder. After adding bridging header setting you should be able to use the SDK.

You can find more information about using Objective-C and Swift in the same project `here <https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html>`__.

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

To create an instance of ``VirgilClient`` class, just call its constructor with your application **accessToken** you generated on developer's dashboard.

Objective-C

.. code-block:: objectivec
    :linenos:

    @import VirgilCrypto;
    @import VirgilSDK;

    //...
    @property (nonatomic) VSSClient * __nonnull client;
    //...
    self.client = [[VSSClient alloc] initWithApplicationToken:<#Virgil App Token#>];
    //...

Swift
     
.. code-block:: swift
    :linenos:

    //...
    private var client: VSSClient!
    //..
    self.client = VSSClient(applicationToken: <#Virgil App token#>)
    //...

Initializing Crypto
~~~~~~~~~~~~~~~~~~~

``VirgilCrypto`` class provides cryptographic operations in applications, such as hashing, signature generation and verification, and encryption and decryption.

Objective-C

.. code-block:: objectivec
    :linenos:

    @import VirgilCrypto;
    @import VirgilSDK;

    //...
    @property (nonatomic) VSSCrypto * __nonnull crypto;
    //...
    self.crypto = [[VSSCrypto alloc] init];
    //...

Swift

.. code-block:: swift
    :linenos:

    //...
    private var crypto: VSSCrypto!
    //..
    self.crypto = VSSCrypto()
    //...