
- [Introduction](#introduction)
- [Install](#install)
- [Swift note](#swift-note)
- [Use case](#use-case)
    - [Creating a new key pair](#creating-a-new-key-pair)
    - [Encrypt and decrypt data](#encrypt-and-decrypt-data)
        - [Key-based encryption](#key-based-encryption)
        - [Key-based decryption](#key-based-decryption)
        - [Password-based encryption](#password-based-encryption)
        - [Password-based decryption](#password-based-decryption)
    - [Compose and verify a signature](#compose-and-verify-a-signature)
        - [Compose a signature](#compose-a-signature)
        - [Verify a signature](#verify-a-signature)
- [See also](#see-also)

## Introduction

Basic low-level framework which allows to perform some most important security operations. This framework is used in the other high-level Virgil frameworks, libraries and applications. Also it might be used as a standalone basic library for any security-concerned applications.

## Install

If you are about to use any of high-level Virgil frameworks such as VirgilSDK then you don't need to install VirgilFoundation directly. It will be installed with all necessary dependencies of high-level framework.

The rest of this chapter describes how to install VirgilFoundation framework directly. 
The easiest and recommended way to use VirgilFoundation framework for Objective-C/Swift applcations is to install and maintain it using CocoaPods.
 
- First of all you need to install CocoaPods to your computer. It might be done by executing the following line in terminal:

```
$ sudo gem install cocoapods
``` 
CocoaPods is built with Ruby and it will be installed with the default Ruby available in OS X.

- Open Xcode and create a new project (in the Xcode menu: File->New->Project), or navigate to an existing Xcode project using:

```
$ cd <Path to Xcode project folder>
```

- In the Xcode project's folder create a new file, give it a name *Podfile* (with a capital *P* and without any extension). The following example shows how to compose the Podfile for an iOS application. If you are planning to use another platform the process will be quite similar. You only need to change a platform to the correspondent value. [Here](https://guides.cocoapods.org/syntax/podfile.html#platform) you can find more information about platform values.

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Put your Xcode target name here>' do
	pod 'VirgilFoundation'
end
```

- Get back to your terminal window and execute the following line:

```
$ pod install
```
 
- Close Xcode project (if it is still opened). For any further development purposes you should use Xcode *.xcworkspace* file created for you by CocoaPods.
 
At this point you should be able to use Virgil cryptographic functionality in your code. See examples for most common tasks below.
If you encounter any issues with CocoaPods installation try to find more information at [cocoapods.org](https://guides.cocoapods.org/using/getting-started.html).

## Swift note

Although VirgilFoundation is using Objective-C as its primary language it might be quite easily used in a Swift application. After VirgilFoundation is installed as described in the *Getting started* section it is necessary to perform the following:

- Create a new header file in the Swift project.
- Name it something like *BridgingHeader.h*
- Put there the following line:

``` objective-c
@import VirgilFoundation;
```

- In the Xcode build settings find the setting called *Objective-C Bridging Header* and set the path to your BridgingHeader.h file. Be aware that this path is relative to your Xcode project's folder.

You can find more information about using Objective-C and Swift in the same project [here](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html).  

## Use case

Below you can find the examples for most common tasks which can be performed using VirgilFoundation framework.

### Creating a new key pair

VSSKeyPair instance should be used to generate a pair of keys. It is possible to generate a password-protected private key. In case if password is not given, private key will be generated as a plain data. 

###### Objective-C
```objective-c
//...
VSSKeyPair *keyPair = [[VSSKeyPair alloc] initWithPassword:<#Password or nil#>];
NSString *publicKey = [[NSString alloc] 
	initWithData:keyPair.publicKey encoding:NSUTF8StringEncoding];
NSLog(@"%@", publicKey);
NSString *privateKey = [[NSString alloc] 
	initWithData:keyPair.privateKey encoding:NSUTF8StringEncoding];
NSLog(@"%@", privateKey);
//...
```

###### Swift
```swift
//...
let keyPair = VSSKeyPair(password:<#Password or nil#>)
println(NSString(data: keyPair.publicKey(), encoding: NSUTF8StringEncoding))
println(NSString(data: keyPair.privateKey(), encoding: NSUTF8StringEncoding))
//...
```

### Encrypt and decrypt data

VSSCryptor objects can perform two ways of encryption/decryption:

- Key-based encryption/decryption.
- Password-based encryption/decryption.

#### Key-based encryption

###### Objective-C
```objective-c
//...
// Assuming that we have some initial string message.
NSString *message = @"This is a secret message which should be encrypted.";
// Convert it to the NSData
NSData *toEncrypt = [message dataUsingEncoding:NSUTF8StringEncoding 
	allowLossyConversion:NO];
// Assuming that we have some keypair generated earlier.
// Create a new VSSCryptor instance
VSSCryptor *cryptor = [[VSSCryptor alloc] init];
// Now we should add a key recepient
[cryptor addKeyRecepient:<#Public Key ID (e.g. UUID)#> 
	publicKey:<#keyPair.publicKey#>];
// And now we can easily encrypt the plain data
NSData *encryptedData = [cryptor encryptData:toEncrypt embedContentInfo:@YES];
//...
```

###### Swift
```swift
//...
// Assuming that we have some initial string message.
let message = NSString
	(string: "This is a secret message which should be encrypted.")
// Convert it to the NSData
let toEncrypt = message.dataUsingEncoding(NSUTF8StringEncoding, 
	allowLossyConversion: false)
// Assuming that we have some keypair generated earlier.
// Create a new VSSCryptor instance
let cryptor = VSSCryptor()
// Now we should add a key recepient
cryptor.addKeyRecepient(<#Public Key ID (e.g. UUID)#>, 
	publicKey:<#keyPair.publicKey()#>)
// And now we can easily encrypt the plain data
var encryptedData = cryptor.encryptData(toEncrypt, embedContentInfo: true)
//...
```

#### Key-based decryption

###### Objective-C
```objective-c
//...
// Assuming that we have received some key-based encrypted data.
// Assuming that we have some keypair generated earlier.
// Create a new VSSCryptor instance
VSSCryptor *decryptor = [[VSSCryptor alloc] init];
// Decrypt data
NSData *plainData = [decryptor decryptData:<#encryptedData#> 
	publicKeyId:<#Public Key ID (e.g. UUID)#> 
	privateKey:<#keyPair.privateKey#> 
	keyPassword:<#Private key password or nil#>];
// Compose initial message from the plain decrypted data
NSString *initialMessage = [[NSString alloc] initWithData:plainData 
	encoding:NSUTF8StringEncoding];
//...
```

###### Swift
```swift
//...
// Assuming that we have received some key-based encrypted data.
// Assuming that we have some keypair generated earlier.
// Create a new VSSCryptor instance
let decryptor = VSSCryptor()
// Decrypt data
var plainData = decryptor.decryptData(<#encryptedData#>, 
	publicKeyId: <#Public Key ID (e.g. UUID)#>, 
	privateKey: <#keyPair.privateKey()#>, 
	keyPassword: <#Private key password or nil#>)
// Compose initial message from the plain decrypted data
if let data = plainData {
	var initialMessage = NSString(data: data, encoding: NSUTF8StringEncoding)
}//...
```

#### Password-based encryption

###### Objective-C
```objective-c
//...
// Assuming that we have some initial string message.
NSString *message = @"This is a secret message which should be encrypted 
	with password-based encryption.";
// Convert it to the NSData
NSData *toEncrypt = [message dataUsingEncoding:NSUTF8StringEncoding 
	allowLossyConversion:NO];
// Assuming that we have some keypair generated earlier.
// Create a new VSSCryptor instance
VSSCryptor *cryptor = [[VSSCryptor alloc] init];
// Now we should add a password recepient
[cryptor addPasswordRecipient:<#Password to encrypt data with#>];
// And now we can encrypt the plain data
NSData *encryptedData = [cryptor encryptData:toEncrypt embedContentInfo:@YES];
//...
```

###### Swift
```swift
//...
// Assuming that we have some initial string message.
let message = NSString(string: "This is a secret message which 
	should be encrypted.")
// Convert it to the NSData
let toEncrypt = message.dataUsingEncoding(NSUTF8StringEncoding, 
	allowLossyConversion: false)
// Create a cryptor instance
let cryptor = VSSCryptor()
// Add a password recepient to enable password-based encryption
cryptor.addPasswordRecipient(<#Password to encrypt data with#>)
// Encrypt the data
var encryptedData = cryptor.encryptData(oEncrypt, embedContentInfo: true)
//...
```

#### Password-based decryption

###### Objective-C
```objective-c
//...
// Assuming that we have received some password-based encrypted data.
// Assuming that we have some keypair generated earlier.
// Create a new VSSCryptor instance
VSSCryptor *decryptor = [[VSSCryptor alloc] init];
// Decrypt data
NSData *plainData = [decryptor decryptData:<#NSData to decrypt#> 
	password:<#Password used to encrypt the data#>];
// Compose initial message from the plain decrypted data
NSString *initialMessage = [[NSString alloc] initWithData:plainData 
	encoding:NSUTF8StringEncoding];
//...
```

###### Swift
```swift
//...
// Assuming that we have received some password-based encrypted data.
// Assuming that we have some keypair generated earlier.
// Create a new VSSCryptor instance
let decryptor = VSSCryptor()
// Decrypt data
var plainData = decryptor.decryptData(<#encryptedData#>, 
	password:<#Password used to encrypt the data#>)
// Compose initial message from the plain decrypted data
if let data = plainData {
	var initialMessage = NSString(data: data, encoding: NSUTF8StringEncoding)
}
//...
```

### Compose and verify a signature

VSSSigner instances allow to sign some data with a given private key. This can be used to make sure that some message/data was really composed and sent by the holder of the private key.

#### Compose a signature

###### Objective-C
```objective-c
//...
#import <VirgilFoundation/VirgilFoundation.h>
//...

// Assuming that we have some initial string message that we want to sign.
NSString *message = @"This is a secret message which should be signed.";
// Convert it to the NSData
NSData *toSign = [message dataUsingEncoding:NSUTF8StringEncoding 
	allowLossyConversion:NO];
// Assuming that we have some key pair generated earlier.
// Create a new VSSSigner instance
VSSSigner *signer = [[VSSSigner alloc] init];
// Sign the initial data
NSData *signature = [signer signData:toSign 
	privateKey:<#keyPair.privateKey#> 
	keyPassword:<#Private key password or nil#>];
```

###### Swift
```swift
//...
// Assuming that we have some initial string message.
let message = NSString(string: "This is a secret message which 
	should be signed.")
// Convert it to the NSData
let toSign = message.dataUsingEncoding(NSUTF8StringEncoding, 
	allowLossyConversion: false)
// Create the signer
let signer = VSSSigner()
// Compose the signature
var signature = signer.signData(toSign, 
	privateKey: <#keyPair.privateKey()#>, 
	keyPassword: <#Private key password or nil#>)
//...
```

#### Verify a signature

To verify some signature it is necessary to have a public key of a user whose signature we want to verify. 

###### Objective-C
```objective-c
//...
// Assuming that we have the public key of a person whose signature 
// we need to verify
// Assuming that we have a NSData object with signed data.
// Assuming that we have a NSData object with a signature.
// Create a new VSSSigner instance
VSSSigner *verifier = [[VSSSigner alloc] init];
// Verify the signature.
BOOL verified = [verifier verifySignature:<#signature#> 
	data:toSign 
	publicKey:<#keyPair.publicKey#>];
if (verified) {
	// Signature seems OK.
}
```

###### Swift
```swift
//...
// Assuming that we have the public key of a person whose signature 
// we need to verify
// Assuming that we have a NSData object with signed data.
// Assuming that we have a NSData object with a signature.
// Create a new VSSSigner instance
let verifier = VSSSigner()
// Verify the signature.
let verified = verifier.verifySignature(<#signature#>, 
	data: toSign, 
	publicKey:<#keyPair.publicKey()#>)
if verified {
	// Signature seems OK.
}
//...
```

## See also

* [Quickstart](/api-docs/objective-c-swift/quickstart)
* [Tutorial Keys SDK](/api-docs/objective-c-swift/keys-sdk)