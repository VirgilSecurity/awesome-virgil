
#Virgil Security iOS SDK 

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Virgil SDK API](#virgil-sdk-api)
    - [Obtaining an Application Token](#obtaining-an-application-token)
    - [Generate Keys](#generate-keys)
    - [Register User](#register-user)
    - [Store a Private Key](#store-a-private-key)
    - [Get a Public Key](#get-a-public-key)
    - [Encrypt Data](#encrypt-data)
    - [Sign Data](#sign-data)
    - [Verify Data](#verify-data)
    - [Decrypt Data](#decrypt-data)

##Introduction

This guide will help you get started using the Crypto Library and Virgil Services for the Apple iOS platform. To be able to use Virgil iOS frameworks you should have a MacOS X (10.10+), Xcode (6.4+) and iOS devices (iOS 8.0+).

## Prerequisites

- [Mac OS X El Capitan](https://itunes.apple.com/ua/app/os-x-el-capitan/id1018109117?mt=12) 
- [Xcode 7](https://itunes.apple.com/ua/app/xcode/id497799835?mt=12)
- [Cocoapods](https://cocoapods.org/)

## Installation

The most simple and recommended way to use Viril iOS frameworks is to install them via the CocoaPods. First of all you need to install the CocoaPods if you don't have it yet. This is very simple, just open your terminal and execute the following line:
```sh
$ sudo gem install cocoapods
```
It will ask you about the password and then will install latest release version of CocoaPods. CocoaPods is built with Ruby and it will be installable with the default Ruby available on OS X.

To simplify any efforts for work with Virgil Keys and Virgil Private Keys service there are two iOS frameworks *VirgilKeysiOS* and *VirgilPrivateKeysiOS* available as pods. To integrate them into the Xcode project you should create a file in the Xcode project's folder and name it *Podfile* (capital *P* and without any extension). This file contains instructions for CocoaPods about which pods you want to use. In the simplest case you probably want to use both VirgilKeys and VirgilPrivateKeys iOS frameworks, so your Podfile should contain the following 4 lines of code:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
pod 'VirgilKeysiOS'
pod 'VirgilPrivateKeysiOS'
```
If you need to use only *VirgilKeysiOS* framework then just remove the last line from the podfile, so your podfile might look as following:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
pod 'VirgilKeysiOS'
```

Both *VirgilKeysiOS* and *VirgilPrivateKeysiOS* have dependencies on *VirgilCryptoiOS* lower-level framework. These dependencies are managed by cocoapods for you, because of that you don't need to include any direct references to *VirgilCryptoiOS* in your podfile. But in case when you need only low-level cryptographic functionality without any Virgil Services interactions then you can use only *VirgilCryptoiOS* framework. Just compose your podfile as following:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
pod 'VirgilCryptoiOS'
```

After you decided which functionality you want to use it is time to get back to the Terminal. Navigate to the Xcode project's folder:
```sh
$ cd <Path to Xcode project folder>
```
Install the Virgil pods:
```sh
$ pod install
```
This will automatically get and install latest available versions of Virgil pods. Also, after this command finishes its execution Xcode workspace will be created in the project's folder. Now for all development purposes you will need to open .xcworkspace file instead of .xcodeproj.

If you encountered any issues during the installation process or if you want to know more about the CocoaPods, Podfile and so on then you can find a lot of information at the [cocoapods.org](https://cocoapods.org/).

## Usage

The Virgil iOS frameworks (or Virgil pods) are written in Objective-C. It is absolutely OK to use them in any particular application written in Objective-C as well. However if your target application is written in Swift it is very easy to make Virgil pods be available in Swift code.

For developing in Swift you still need to install the Virgil pods as described in [Installation](#installation) section of this guide. After that perform the following actions:

- Create a new header file in your project at any convenient for you location within project's folder.
- Name this new header as something like *BridgingHeader.h*.
- Put the follwing lines inside *BridgingHeader.h*.

```objective-c
#import <VirgilKeysiOS/VirgilKeysiOS.h>
#import <VirgilPrivateKeysiOS/VirgilPrivateKeysiOS.h>
```

- Open Xcode build setting for this project. 
- Find the setting called *Objective-C Bridging Header* and set the path to your *BridgingHeader.h* file. Be aware that this path is relative to your Xcode project's folder.

You can find more information about mixing the Objective-C and Swift code in the same project in this [Apple guide](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html).

## Virgil SDK API

### Obtaining an Application Token

The app token provides access to Virgil’s Services and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

1. [Create](https://api.virgilsecurity.com/signup) a free **Virgil Security** account.
2. [Sign in](https://api.virgilsecurity.com/signin) and generate a token for your application.
3. Use your app token to access Virgil Services using our iOS frameworks.

### Generate keys

Working with the Virgil Security Services requires the creation of both a public key and a private key. The public key can be made available to anyone using the Virgil Keys Service. The private key must be available only to the owner who will decrypt the data encrypted with the public key and compose the signature using this private key to make other participants sure about the identity of this particular person.

:warning:
Private keys should never be stored verbatim or in plain text on a local computer, phone or other device. If you need to store a private key, you should use a secure storage offered by the platform installed on your particular device (e.g. iOS/MacOS X offers the Keychain as a secure storage for any kind of secure data such as certificates, private keys, passwords). You also can use the Virgil Private Keys Service to store and synchronize all of yours private keys. This allows you to easily synchronize all the private keys between any clients’ devices and particular applications. Please read more about the [Virgil Private Keys Service](https://api.virgilsecurity.com/documents/csharp/keys-private-service).

The following code example creates a new key pair. If you need to maximize the security level of your private keys then it is possible to set a password for the private key of the generated key pair. In this case private key will be already encrypted with a password given as a parameter to the VSSKeyPair initializer. The advantage of this is obviously higher security, but the disadvantage is that you always need to pass this password for any operation that involves using this private key (e.g. composing a signature, decrypting some received data, etc.).

##### Objective-C:
```objective-c
//...
#import <VirgilCryptoiOS/VirgilCryptoiOS.h>
//...
VSSKeyPair *keyPair = [[VSSKeyPair alloc] initWithPassword:<#Password or nil#>];
//...
```

##### Swift:
```swift
//...
let keyPair = VSSKeyPair(password: <#Password or nil#>)
//...
```

### Register User

Once you've created a public key you may push it to Virgil’s Keys Service. This will allow other users to send you encrypted data using your public key.

This example shows how to upload a public key and register a new account on Virgil’s Keys Service.

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
@property (nonatomic, strong) VSSPublicKey *publicKey;
@property (nonatomic, strong) VSSPrivateKey *privateKey;
//...

//...
/// Create a user data instance
VSSUserData *userData = [[VSSUserData alloc] initWithDataClass:UDCUserId dataType:UDTEmail value:<#Email address#>];
/// Create a public key model container
VSSPublicKey *candidateKey = [[VSSPublicKey alloc] initWithKey:keyPair.publicKey userDataList:@[ userData ]];
/// Create a private key model container
self.privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey password:<#Password for this key or nil#>];
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient createPublicKey:candidateKey privateKey:self.privateKey completionHandler:^(VSSPublicKey *pubKey, NSError *error) {
    if (error != nil) {
        NSLog(@"Error creating public key instance at the Virgil Keys Service: %@", [error localizedDescription]);
        return;
    }
    
    /// Public key instance created at the Virgil Keys Service and model object returned as pubKey in the callback.
    self.publicKey = pubKey;
}];
```

Confirm the **User Data**:

```objective-c
//...
/// We have user data confirmation token code
NSString *code = <#Confirmation code#>;
/// Get the user data Id:
VSSUserDataExtended *udEx = [self.publicKey.userDataList objectAtIndex:0];
/// Make the request
[self.keysClient persistUserDataId:udEx.idb.userDataId confirmationCode:code completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error confirmation the user data: %@", [error localizedDescription]);
        return;
    }
    
    /// User data is now confirmed and can be used for any activities.
}];

```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
private var publicKey: VSSPublicKey! = nil
private var publicKey: VSSPrivateKey! = nil
//...
/// We have a key pair:
let keyPair = VSSKeyPair()
//...
/// Create a user data instance 
let userData = VSSUserData(dataClass: .UDCUserId, dataType: .UDTEmail, value: <#Email address#>)
/// Create a public key model container
let candidateKey = VSSPublicKey(key: keyPair.publicKey(), userDataList: [userData])
/// Create a private key model container
self.privateKey = VSSPrivateKey(key: keyPair.privateKey(), password: nil)
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.createPublicKey(candidateKey, privateKey: self.privateKey) { pubKey, error in
    if error != nil {
        print("Error creating public key at the Virgil Keys Service: \(error!.localizedDescription)")
        return
    }

    /// Public key instance created at the Virgil Keys Service and model object returned as pubKey in the callback.
    self.publicKey = pubKey
}
//...
```

Confirm the **User Data**:

```swift
//...
/// We have user data confirmation token code
let code = <#Confirmation code#>
/// Get the user data Id:
let udEx = self.publicKey.userDataList[0] as! VSSUserDataExtended
/// Make the request
self.keysClient.persistUserDataId(udEx.idb.userDataId!, confirmationCode: code) { error in
    if error != nil {
        print("Error confirmation the user data: \(error!.localizedDescription)")
        return
    }
    
    /// User data is now confirmed and can be used for any activities.
}
//...
```

### Store a Private Key

This example shows how to store private keys on Virgil Private Keys service using SDK, this step is optional and you can use your own secure storage.

##### Objective-C:
```objective-c
//...
#import <VirgilPrivateKeysiOS/VirgilPrivateKeysiOS.h>
//...
@property (nonatomic, strong) VSSPrivateKeysClient* privateKeysClient;
//...

/// Compose credentials for the Virgil Private Keys Service
VSSCredentials *credentials = [[VSSCredentials alloc] initWithUserData:userData password:<#User password#>];
/// Create a client
self.privateKeysClient = [[VSSPrivateKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#> credentials:credentials];
/// Compose the container object
/// It is possible to choose between two options
/// CTEasy   - Virgil Private Keys Service will keep your private keys encrypted with
///          a password used for credentials object (user password). All keys should be sent to the service
///          encrypted with this password. Also, this type of container allows to change the password with Virgil Private Keys Serivce.
/// CTNormal - Virgil Private Keys Service will as is. Storage of the private keys is your responsibility and security
///          of your data will be at your own risk.
VSSContainer *container = [[VSSContainer alloc] initWithContainerType:CTEasy];
/// Create the container
[self.pKeysClient initializeContainer:container publicKeyId:self.publicKey.idb.publicKeyId privateKey:self.privateKey completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error Private Keys container initialization: %@", [error localizedDescription]);
        return;
    }
    
    /// In case when container has been initialized successfully just push private key there.
    /// In case of CTNormal container type 'password' parameter should contain the password 
    /// which should be used to encrypt the keys before sending them to the service. 
    [self.pKeysClient pushPrivateKeyPublicKeyId:self.publicKey.idb.publicKeyId privateKey:self.privateKey password:nil completionHandler:^(NSError *pushError) {
        if (pushError != nil) {
            NSLog(@"Error pushing the key to the container: %@", [pushError localizedDescription]);
            return;
        }
        
        /// Private key has been stored at Virgil Private Keys Service.
    }];
}];
//...
```

##### Swift:
```swift
//...
private var privateKeysClient: VSSPrivateKeysClient! = nil
//...

/// Compose credentials for the Virgil Private Keys Service
let credentials = VSSCredentials(userData: userData, password: <#User password#>)
/// Create a client
self.privateKeysClient = VSSPrivateKeysClient(applicationToken: <#Virgil Application Token#>, credentials: credentials)
/// Compose the container object
/// It is possible to choose between two options
/// CTEasy   - Virgil Private Keys Service will keep your private keys encrypted with
///          a password used for credentials object (user password). All keys should be sent to the service
///          encrypted with this password. Also, this type of container allows to change the password with Virgil Private Keys Serivce.
/// CTNormal - Virgil Private Keys Service will as is. Storage of the private keys is your responsibility and security
///          of your data will be at your own risk.
let container = VSSContainer(containerType: .CTEasy)
/// Create the container
self.pKeysClient.initializeContainer(container, publicKeyId: self.publicKey.idb.publicKeyId!, privateKey: self.privateKey) { error in
    if error != nil {
        print("Error Private Keys Container initialization: \(error!.localizedDescription)")
        return
    }
    
    /// In case when container has been initialized successfully just push private key there.
    /// In case of .CTNormal container type 'password' parameter should contain the password 
    /// which should be used to encrypt the keys before sending them to the service.
    self.pKeysClient.pushPrivateKeyPublicKeyId(self.publicKey.idb.publicKeyId!, privateKey: self.privateKey, password: nil) { pushError in
        if pushError != nil {
            print("Error saving private key in the Private Keys container: \(pushError!.localizedDescription)")
            return
        }
        
        /// Private key has been stored at Virgil Private Keys Service.
    }
}
```

### Get a Public Key

Get some user's public key from the Virgil Keys Service. This allows you to encrypt a data for this user using his public key later.

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
@property (nonatomic, strong) VSSPublicKey *recipientPublicKey;
//...

//...
/// We have some user data value
NSString* userDataValue = <#User data value#>; // E.g. user's email address.
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient searchPublicKeyUserIdValue:userDataValue completionHandler:^(VSSPublicKey *pubKey, NSError *error) {
    if (error != nil) {
        NSLog(@"Error searching the public key: %@", [error localizedDescription]);
        return;
    }
    
    /// Use VSSPublicKey returned from the service.
    self.recipientPublicKey = pubKey;
}];
//...
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
private var recipientPublicKey: VSSPublicKey! = nil
//...
/// We have some user data value
let userDataValue =  <#User data value#>; // E.g. user's email address
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.searchPublicKeyUserIdValue(userDataValue) { pubKey, error in
    if error != nil {
        print("Error searching the public key: \(error!.localizedDescription)")
        return
    }
    
    /// Use VSSPublicKey returned from the service.
    self.recipientPublicKey = pubKey
}
//...
```

### Encrypt Data

To encrypt a data for other user you should use this user's public key. Then he/she will be able to decrypt this data using hes/her private key.

##### Objective-C
```objective-c
//...
#import <VirgilCryptoiOS/VirgilCryptoiOS.h>
//...

NSData *toEncrypt = <#Plain NSData which should be encrypted#>;
/// Create a new VSSCryptor instance
VSSCryptor *cryptor = [[VSSCryptor alloc] init];
/// Now we should add a key recepient
[cryptor addKeyRecepient:self.recipientPublicKey.idb.publicKeyId publicKey:self.recepientPublicKey.key];
/// And now we can easily encrypt the plain data
NSData *encryptedData = [cryptor encryptData:toEncrypt embedContentInfo:@YES];
if (encryptedData.length > 0) {
    /// Data has been encrypted successfully.
}
//...
```

##### Swift
```swift
//...

let toEncrypt = <#Plain NSData which should be encrypted#>
/// Create a new VSSCryptor instance
let cryptor = VSSCryptor()
/// Now we should add a key recepient
cryptor.addKeyRecepient(self.recipientPublicKey.idb.publicKeyId!, publicKey:self.recipientPublicKey.key)
/// And now we can easily encrypt the plain data
if let encryptedData = cryptor.encryptData(toEncrypt, embedContentInfo: true) {
    /// Data has been encrypted successfully.    
}
//...
```

### Sign Data

Although it is possible to send an encrypted message to some particular recipient, it is still important to make the recepient sure that this encrypted message is sent exactly by you and the message has not been changed after you signed it. This can be achieved with a concept of a signatures. 

Signature is basically a piece of data which is composed using a particular user's private key and it can be validated (or verified) later using this user's public key.

##### Objective-C:
```objective-c
//...
/// Create a new VSSSigner instance
VSSSigner *signer = [[VSSSigner alloc] init];
/// Sign the encrypted data
NSData *signature = [signer signData:encryptedData privateKey:self.privateKey.key keyPassword:self.privateKey.password];
if (signature.length > 0) {
    /// Signature composed.
}
//...
```

##### Swift:
```swift
//...
/// Create a new VSSSigner instance
let signer = VSSSigner()
/// Sign the encrypted data
if let signature = signer.signData(encryptedData, privateKey: privateKey.key, keyPassword: privateKey.password) {
    /// Signature composed.
}
//...
```

### Verify Data

To verify that data was signed by a particular user, you must have the following information:

- The public key of the user that signed the data.
- The digital signature.
- The data that was signed.

The following example verifies a digital signature which was signed by the sender.

##### Objective-C
```objective-c
//...
/// We have got the public key of the sender
VSSPublicKey *senderKey = <#Some sender's VSSPublicKey#>;
/// We have sender's data
NSData *senderData = <#NSData object, most likely encrypted#>;
/// We have sender's signature.
NSData *senderSignature = <#NSData object with sender's signature#>;
/// Create a VSSSigner instance for verification
VSSSigner *verifier = [[VSSSigner alloc] init];
/// Verify the signature.
BOOL verified = [verifier verifySignature:senderSignature data:senderData publicKey:senderKey.key];
if (verified) {
	/// Signature seems OK.
    /// This means that data came to us unchanged and exactly from the user we expect. 
}
```

##### Swift
```swift
//...
/// We have got the public key of the sender
let senderKey = <#Some sender's VSSPublicKey#>
/// We have sender's data
let senderData = <#NSData object, most likely encrypted#>
/// We have sender's signature.
let senderSignature = <#NSData object with sender's signature#>
/// Create a VSSSigner instance for verification
let verifier = VSSSigner()
/// Verify the signature.
let verified = verifier.verifySignature(senderSignature, data: senderData, publicKey:senderKey.key)
if verified {
    /// Signature seems OK.
    /// This means that data came to us unchanged and exactly from the user we expect.
}
//...
```

### Decrypt Data

When it is confirmed that data has been sent by the user you expect it is time to decrypt the data and use it.

To decrypt the data you should use your private key.

##### Objective-C
```objective-c
//...
/// Create a decryptor VSSCryptor instance
VSSCryptor *decryptor = [[VSSCryptor alloc] init];
/// Decrypt data
NSData *plainData = [decryptor decryptData:senderData publicKeyId:self.publicKey.idb.publicKeyId privateKey:self.privateKey.key keyPassword:self.privateKey.password];
if (plainData.length > 0) {
    /// Data has been decrypted and may be used.
}
///...
```

##### Swift
```swift
//...
/// Create a new VSSCryptor instance
let decryptor = VSSCryptor()
/// Decrypt data
if let plainData = decryptor.decryptData(senderData, publicKeyId: self.publicKey.idb.publicKeyId!, privateKey: self.privateKey.key, keyPassword: self.privateKey.password) {
    /// Data has been decrypted and may be used.
}
//...
```
</div>
</div>

<div class="col-md-12 col-md-offset-2 hidden-md hidden-xs hidden-sm">
<div class="docs-menu" data-ui="affix-docs">
<div class="title">Quick Navigation</div>

<div class="menu-items-wrapper" data-ui="menu-items-wrapper"></div>
</div>
</div>
</div>
</div>
</section>
