============
Quickstart Objective-C/Swift
============

- `Introduction`_
- `Obtaining an Access Token`_
- `Install`_
- `Swift note`_
- `Use case`_ 
    - `Step 0. Initialization`_
    - `Step 1. Create and Publish the Keys`_
    - `Step 2. Encrypt and Sign`_
    - `Step 3. Send a Message`_
    - `Step 4. Receive a Message`_
    - `Step 5. Verify and Decrypt`_

*********
Introduction
*********

This guide will help you get started using the Crypto Library and Virgil Security Services for the most popular platforms and languages.
This branch focuses on the Objective-C/Swift library implementation and covers its usage.

Let's go through an encrypted message exchange steps as one of the possible [use cases](#use-case) of Virgil Security Services. 

.. image:: Images/IPMessaging.jpg

*********
Obtaining an Access Token
*********

First you must create a free Virgil Security developer's account by signing up `here <https://developer.virgilsecurity.com/account/signup>`_. Once you have your account you can `sign in <https://developer.virgilsecurity.com/account/signin>`_ and generate an access token for your application.

The access token provides authenticated secure access to Virgil Security Services and is passed with each API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Use this token to initialize the SDK client here `Step 0. Initialization`_.

*********
Install
*********

You can easily add SDK dependency to your project using CocoaPods. So, if you are not familiar with this dependency manager, it is time to install CocoaPods. Open your terminal window and execute the following line:

.. code-block:: html

    $ sudo gem install cocoapods

It will ask you about the password and then will install latest release version of CocoaPods. CocoaPods is built with Ruby and it will be installed with the default Ruby available in OS X.
If you encounter any issues during this installation, please take a look at `cocoapods.org <https://guides.cocoapods.org/using/getting-started.html>`_ for more information.

Now it is possible to add VirgilSDK to the particular application. So:

- Open Xcode and create a new project (in the Xcode menu: File->New->Project), or navigate to existing Xcode project using:

.. code-block:: html

    $ cd <Path to Xcode project folder>


- In the Xcode project's folder create a new file, give it a name *Podfile* (with a capital *P* and without any extension). The following example shows how to compose the Podfile for an iOS application. If you are planning to use another platform, the process will be quite similar. You only need to change a platform to the correspondent value. `Here <https://guides.cocoapods.org/syntax/podfile.html#platform>`_ you can find more information about the platform values.

.. code-block:: html

    source 'https://github.com/CocoaPods/Specs.git'
    platform :ios, '8.0'
    use_frameworks!
    
    target '<Put your Xcode target name here>' do
        pod 'VirgilSDK', '~> 3.0'
    end

If you are using any other pods, just add VirgilSDK to the list of them in the Podfile.

- Get back to your terminal window and execute the following line:

.. code-block:: html

    $ pod install

 
- Close Xcode project (if it is still opened). For any further development purposes you should use Xcode *.xcworkspace* file created for you by CocoaPods.
 
At this point you should be able to use VirgilSDK pod in your code.  If you encountered any issues with CocoaPods installations try to find more information at `cocoapods.org <https://guides.cocoapods.org/using/getting-started.html>`_.

.. note:: 

    The following code snippets use parts of the IP Messaging example apps for Objective-C and Swift. Some components and calls are not the parts of the VirgilSDK. You can find links to the example apps `here <https://github.com/VirgilSecurity/virgil-sdk-x/tree/v3/Docs>`_.   

*********
Swift note
*********

Although VirgilSDK pod is using Objective-C as its primary language it might be quite easily used in a Swift application.
After pod is installed as described above it is necessary to perform the following:

- Create a new header file in the Swift project.
- Name it something like *BridgingHeader.h*
- Put there the following lines:

Objective-C
---------
.. code-block:: objective-c

    @import VirgilFoundation;
    @import VirgilSDK;


- In the Xcode build settings find the setting called *Objective-C Bridging Header* and set the path to your *BridgingHeader.h* file. Be aware that this path is relative to your Xcode project's folder. After adding bridging header setting you should be able to use the SDK.

You can find more information about using Objective-C and Swift in the same project `here <https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html>`_.

*********
Use Case
*********
**Secure any data end to end**: users need to securely exchange information (text messages, files, audio, video etc) while enabling both in transit and at rest protection. 

- Application generates public and private key pairs using Virgil Crypto Library and uses Virgil Keys Service to enable secure end to end communications:
    - public key on Virgil Public Keys Service;
    - private key on Virgil Private Keys Service or locally.
- Sender’s information is encrypted in Virgil Crypto Library with the recipient’s public key.
- Sender’s encrypted information is signed with his private key in Virgil Crypto Library.
- Application securely transfers the encrypted data, sender’s digital signature and UDID to the recipient without any risk to be revealed.
- Application on the recipient’s side verifies that the signature of transferred data is valid using the signature and sender’s public key from Virgil Keys Service.
- Received information is decrypted with the recipient’s private key using Virgil Crypto Library.
- Decrypted data is provided to the recipient.

Step 0. Initialization
=========

Objective-C
---------
.. code-block:: objective-c
    @import VirgilFoundation;
    @import VirgilSDK;
    
    //...
    @property (nonatomic, strong) VSSClient *client;
    //...
    self.client = 
        [[VSSClient alloc] initWithApplicationToken:<# Virgil App Token#>];
    //...

Swift
---------
.. code-block:: swift
    //...
    private var client: VSSClient! = nil
    //..
    self.client = VSSClient(applicationToken:<# Virgil App token#>)
    //...

Step 1. Create and Publish the Keys
=========
First a mail exchange application is generating the keys and publishing them to the Public Keys Service where they are available in an open access for other users (e.g. recipient) to verify and encrypt the data for the key owner.

The following code example creates a new public/private key pair.

Objective-C
---------
.. code-block:: objective-c
    //...
    // The private key's password is optional here.
    VSSKeyPair *keyPair = 
        [[VSSKeyPair alloc] initWithPassword:<#Private key password or nil#>];
    //...

Swift
---------
.. code-block:: swift

    //...
    // The private key's password is optional here.
    let keyPair = VSSKeyPair(password:<#Private key password or nil#>)
    //...

The app is registering a Virgil Card which includes a public key and an email address identifier. The Card will be used for the public key identification and searching for it in the Public Keys Service. You can create a Virgil Card with or without identity verification. Example of creating the Virgil Card with identity verification:

Objective-C
---------
.. code-block:: objective-c
    //...
    // For 'confirmed' Virgil Card you should compose identity information
    // object with correct validation token parameter.
    VSSIdentityInfo *identity = 
        [[VSSIdentityInfo alloc] initWithType:kVSSIdentityTypeEmail 
                                        value:<# Email address #> 
                              validationToken:<# Identity verification token #>]; 
    VSSPrivateKey *privateKey = 
        [[VSSPrivateKey alloc] initWithKey:[<# VSSKeyPair #> privateKey] 
                                  password:<# Private key password or nil #>];
    [self.client createCardWithPublicKey:[<# VSSKeyPair #> publicKey] 
                            identityInfo:identity 
                                    data:nil  
                              privateKey:privateKey 
                       completionHandler:^(VSSCard * _Nullable card,
     NSError * _Nullable error)
         {
        if (error != nil) {
            // Handle error for creation of the Virgil Card.
            return;
        }
        
        // VSSCard instance represents Virgil Card.
        //...
    }];
    //...

Swift
---------
.. code-block:: swift
    //...
    // For 'confirmed' Virgil Card you should compose identity information 
    // object with correct validation token parameter.
    let identity = VSSIdentityInfo(type: kVSSIdentityTypeEmail, 
    value: <# Email address #>, 
    validationToken: <# Validation token #>)
    let privateKey = VSSPrivateKey(key: <# VSSKeyPair #>.privateKey(), 
        password: <# Private key password or nil #)
    self.client.createCardWithPublicKey(<# VSSKeyPair #>.publicKey(), 
        identityInfo: identity, 
        data: nil, 
        privateKey: privateKey) { (card, error) -> Void in
        if error != nil {
            // Handle error for creation of the Virgil Card.
            return
        }
        
        // VSSCard card represents Virgil Card.
        //...
    }
    //...

The following code snippets show how to create a new Virgil Card without identity verification:

Objective-C
---------
.. code-block:: objective-c

    //...
    // For 'unconfirmed' Virgil Card identity object contains 
    // only 'type' and 'value'.
    VSSIdentityInfo *identity = 
        [[VSSIdentityInfo alloc] initWithType:kVSSIdentityTypeEmail 
                                        value:<# Email address #> 
                              validationToken:nil]; 
    VSSPrivateKey *privateKey = 
        [[VSSPrivateKey alloc] initWithKey:[<# VSSKeyPair #> privateKey] 
                                  password:<# Private key password or nil #>];
    [self.client createCardWithPublicKey:[<# VSSKeyPair #> publicKey] 
                            identityInfo:identity 
                                    data:nil  
                              privateKey:privateKey 
                       completionHandler:^(VSSCard * _Nullable card, 
    NSError * _Nullable error)
         {
        if (error != nil) {
            // Handle error for creation of the Virgil Card.
            return;
        }
        
        // VSSCard instance represents Virgil Card.
        //...
    }];
    //...

Swift
---------
.. code-block:: swift

    //...
    // For 'unconfirmed' Virgil Card identity object contains 
    // only 'type' and 'value'.
    let identity = VSSIdentityInfo(type: kVSSIdentityTypeEmail, 
    value: <# Email address #>, 
    validationToken: nil)
    let privateKey = VSSPrivateKey(key: <# VSSKeyPair #>.privateKey(), 
        password: <# Private key password or nil #)
    self.client.createCardWithPublicKey(<# VSSKeyPair #>.publicKey(), 
        identityInfo: identity, 
        data: nil, 
        privateKey: privateKey) { (card, error) -> Void in
        if error != nil {
            // Handle error for creation of the Virgil Card.
            return
        }
        
        // VSSCard card represents Virgil Card.
        //...
    }
    //...

Step 2. Encrypt and Sign
=========

The app is searching for all channel members' public keys on the Keys Service to encrypt a message for them. The app is signing the encrypted message with sender’s private key so that the recipient can make sure the message had been sent by the declared sender.
The example app we are discussing here uses IPMSecurityManager helper class (`IPMSecurityManager.m <https://github.com/VirgilSecurity/virgil-sdk-x/blob/v3/Docs/IPMExample-objc/IPMExample-objc/IPM/IPMSecurityManager.m>`_ or `IPMSecurityManager.swift <https://github.com/VirgilSecurity/virgil-sdk-x/blob/v3/Docs/IPMExample-swift/IPMExample-swift/IPM/IPMSecurityManager.swift>`_) which manages all security related activities. Also you can find calls to `XAsync <https://github.com/p-orbitum/XAsync>`_, which helps to manage asynchronous calls.

Objective-C
---------
.. code-block:: objective-c

    //...
    // IPMSecurityManager is a custom helper class which wraps 
    // all the security related activities
    // for this particular example application.
    @property (nonatomic, strong) IPMSecurityManager *ipmSecurity;
    //...
    // Get all channel's participants
    NSObject *result = [XAsync awaitResult:[self.ipmClient.channel 
    getParticipants]];
    if ([result as:[NSError class]] != nil) {
        // Error getting participants.
        return;
    }
    NSArray *participants = [result as:[NSArray class]];
    //...
    NSData *encrypted = [self.ipmSecurity encryptData:[
    <#NSString: Message which needs to be secured#> 
    dataUsingEncoding:NSUTF8StringEncoding 
    allowLossyConversion:NO] identities:participants];
    if (encrypted.length == 0) {
        // Message encryption error.
        return;
    }
    //...
    // Now we have the encrypted message. Let's compose a signature on it,
    // to make recipient sure about the sender.
    NSData *signature = [self.ipmSecurity composeSignatureOnData:encrypted];
    if (signature.length == 0) {
        // Error composing the signature.
        return;
    }
    // At this point we have NSData *encrypted with encrypted message 
    // and NSData *signature with sender's signature. 
    // These two NSData objects now can be sent to the channel.
    //...

Swift
---------
.. code-block:: swift

    //...
    // IPMSecurityManager is a custom helper class 
    // which wraps all the security related activities
    // for this particular example application.
    private var ipmSecurity: IPMSecurityManager! = nil
    //...
    let result = XAsync.awaitResult(self.ipmClient.channel.getParticipants())
    if let error = result as? NSError {
        // Error getting participants.
        return
    }
    
    if let participants = result as? Array<String> 
    where participants.count > 0 {
        if let plainData = <#NSString: Message which needs to be secured#>.
    dataUsingEncoding(NSUTF8StringEncoding, 
    allowLossyConversion: false) {
            if let encryptedData = self.ipmSecurity.encryptData(plainData, 
    identities: participants) {
                if let signature = self.ipmSecurity.
    composeSignatureOnData(encryptedData) { 
                    // At this point we have encrypted: NSData with encrypted 
                   //  message and signature: NSData with sender's signature. 
                  // These two NSData objects now can be sent to the channel. 
                }
            }
        }
    }
    // Handle errors, etc.        
    //...

Step 3. Send a Message
=========

The application uses IPMSecureMessage class (`IPMSecureMessage.m <https://github.com/VirgilSecurity/virgil-sdk-x/blob/v3/Docs/IPMExample-objc/IPMExample-objc/IPM/IPMSecureMessage.m>`_ or `IPMSecureMessage.swift <https://github.com/VirgilSecurity/virgil-sdk-x/blob/v3/Docs/IPMExample-swift/IPMExample-swift/IPM/IPMSecureMessage.swift>`_) as a convenient container for encrypted message data and sender's signature data. Objects of this class also have a functionality to serialize them to proper JSON data, which then can be sent to the channel. 

.. note::

The example app uses our custom IP Messaging Server, so it will be necessary to adjust the following functionality in a real world project. See details of the IPMChannelClient class (`IPMChannelClient.m <https://github.com/VirgilSecurity/virgil-sdk-x/blob/v3/Docs/IPMExample-objc/IPMExample-objc/IPM/IPMChannelClient.m>`_ or `IPMChannelClient.swift <https://github.com/VirgilSecurity/virgil-sdk-x/blob/v3/Docs/IPMExample-swift/IPMExample-swift/IPM/IPMChannelClient.swift>`_).

Objective-C
---------
.. code-block:: objective-c

    //...
    // IPMClient object contains handling of the IP Messaging channel
    // for the app.
    @property (nonatomic, strong) IPMChannelClient *ipmClient;
    //...
    IPMSecureMessage *sm = [[IPMSecureMessage alloc] 
    initWithMessage:encrypted signature:signature];
    NSError *error = [XAsync awaitResult:[self.ipmClient.channel 
    sendMessage:sm]];
    if (error != nil) {
        // Error sending the message to the channel.
        return;
    }
    //...

Swift
---------
.. code-block:: swift

    //...
    // IPMClient object contains handling of the IP Messaging channel
    // for the app.
    private var ipmClient: IPMChannelClient! = nil
    //...
    let ipm = IPMSecureMessage(message: encryptedData, 
    signature: signature)
    if let error = XAsync.awaitResult(self.ipmClient.channel.
    sendMessage(ipm)) as? NSError {
        // Error sending the message to the channel.
        return
    }
    //... 

Step 4. Receive a Message
=========
An encrypted message is received on the recipient’s side using the IPMDataSourceListener handler. This handler is registered during the channel creation and get called every time the channel discovers a new message. You can see its declaration in `IPMDataSource.h <https://github.com/VirgilSecurity/virgil-sdk-x/blob/v3/Docs/IPMExample-objc/IPMExample-objc/IPM/IPMDataSource.h>`_ or `IPMDataSource.swift <https://github.com/VirgilSecurity/virgil-sdk-x/blob/v3/Docs/IPMExample-swift/IPMExample-swift/IPM/IPMDataSource.swift>`_

Objective-C
---------
.. code-block:: objective-c

    //...
    IPMDataSourceListener listener = ^(IPMSecureMessage * _Nonnull content, 
    NSString * _Nonnull sender) {
        // Handler receives two parameters: container with encrypted data and 
        // sender's signature and sender's email address (identity value).
    };
    //...

Swift
---------
.. code-block:: swift

    //...
    let listener: IPMDataSourceListener = { secureMessage, sender in
        // Handler receives two parameters: container with encrypted data 
        // and sender's signature and sender's email address (identity value).
    }
    //...

Step 5. Verify and Decrypt 
=========
We are making sure the data came from the declared sender by verifying his signature using his Virgil Card from Public Keys Service. In case of success we are decrypting the message using the recipient's private key.

Objective-C
---------
.. code-block:: objective-c

    //...
    BOOL ok = [self.ipmSecurity checkSignature:
    content.signature data:content.message identity:sender];
    if (!ok) {
        // Error validating the sender's signature.
        return;
    }
    
    NSData *plainData = [self.ipmSecurity decryptData:content.message];
    if (plainData.length == 0) {
        // Error decryption of the message.
        return;
    }
    // Compose plain text from the decrypted message
    NSString *text = [[NSString alloc] initWithData:plainData 
    encoding:NSUTF8StringEncoding];
    // Handle the plain message, e.g. show it on the screen, etc.
    // Warning: This code is likely called on the background thread.
    //...

Swift
---------
.. code-block:: swift

    //...
    if !self.ipmSecurity.checkSignature(secureMessage.signature, 
    data: secureMessage.message, identity: sender) {
        // Error validating the sender's signature.
        return
    }
    
    // Here we are trying to decrypt received message and right after that
    // - compose plain text from the decrypted data.
    if let plainData = self.ipmSecurity.decryptData(secureMessage.message),
            text = NSString(data: plainData, encoding: NSUTF8StringEncoding) {
        // Handle the plain message, e.g. show it on the screen, etc.
        // Warning: This code is likely called on the background thread.
        return
    }
    // Handle decryption error
    //...
