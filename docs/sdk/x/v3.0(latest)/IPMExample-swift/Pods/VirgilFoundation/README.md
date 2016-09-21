# Virgil Foundation Objective-C/Swift

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
    - [Derivation of a key from a password](#derivation-of-a-key-from-a-password)     
- [License](#license)
- [See also](#see-also)

## Introduction

Basic low-level framework which allows to perform some most important security operations. This framework is used in the other high-level Virgil frameworks, libraries and applications. Also it might be used as a standalone basic library for any security-concerned applications.

## Install

If you about to use any of high-level Virgil frameworks such as VirgilSDK then you don't need to install VirgilFoundation directly. It will be installed with all necessary dependencies of high-level framework.

The rest of this chapter describes how to install VirgilFoundation framework directly. 
The easiest and recommended way to use VirgilFoundation framework for Objective-C/Swift applcations is to install and maintain it using CocoaPods.
 
- First of all you need to install CocoaPods to your computer. It might be done by executing the following line in terminal:

```
$ sudo gem install cocoapods
``` 
CocoaPods is built with Ruby and it will be installable with the default Ruby available on OS X.

- Open Xcode and create a new project (in the Xcode menu: File->New->Project), or navigate to existing Xcode project using:

```
$ cd <Path to Xcode project folder>
```

- In the Xcode project's folder create a new file, give it a name *Podfile* (with a capital *P* and without any extension). The following example shows how to compose the Podfile for an iOS application. If you are planning to use other platform the process will be quite similar. You only need to change platform to correspondent value. [Here](https://guides.cocoapods.org/syntax/podfile.html#platform) you can find more information about platform values.

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
If you encountered any issues with CocoaPods installations try to find more information at [cocoapods.org](https://guides.cocoapods.org/using/getting-started.html).

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

VSSKeyPair instance should be used to generate a pair of keys. It is possible to generate a password-protected private key. In case of password is not given private key will be generated as a plain data. 

###### Objective-C
```objective-c
//...
VSSKeyPair *keyPair = [[VSSKeyPair alloc] initWithPassword:<#Password or nil#>];
NSString *publicKey = [[NSString alloc] initWithData:keyPair.publicKey encoding:NSUTF8StringEncoding];
NSLog(@"%@", publicKey);
NSString *privateKey = [[NSString alloc] initWithData:keyPair.privateKey encoding:NSUTF8StringEncoding];
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
NSData *toEncrypt = [message dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
// Assuming that we have some key pair generated earlier.
// Create a new VSSCryptor instance
VSSCryptor *cryptor = [[VSSCryptor alloc] init];
// Now we should add a key recipient
NSError *error = nil;
if (![cryptor addKeyRecipient:<# Recipient ID #> publicKey:<# keyPair.publicKey #> error:&error]) {
    NSLog(@"Error adding key recipient: %@", [error localizedDescription]);
    return;
}
// And now we can easily encrypt the plain data
NSData *encryptedData = [cryptor encryptData:toEncrypt embedContentInfo:YES error:&error];
if (error != nil) {
    NSLog(@"Error encrypting data: %@", [error localizedDescription]);
    return;
}
//...
```

###### Swift
```swift
//...
// Assuming that we have some initial string message.
let message = NSString(string: "This is a secret message which should be encrypted.")
// Convert it to the NSData
if let toEncrypt = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
    // Assuming that we have some key pair generated earlier.
    // Create a new VSSCryptor instance
    let cryptor = VSSCryptor()
    // Now we should add a key recipient
    var encryptedData = NSData()
    do {
        try cryptor.addKeyRecipient(<# Recipient ID #>, publicKey: <# keyPair.publicKey() #>, error: ())
        // And now we can easily encrypt the plain data
        encryptedData = try cryptor.encryptData(toEncrypt, embedContentInfo: true, error: ())
    }
    catch let error as NSError {
        print("Error: \(error.localizedDescription)")
    }
    //...
}
//...
```

#### Key-based decryption

###### Objective-C
```objective-c
//...
// Assuming that we have received some key-based encrypted data.
// Assuming that we have some key pair generated earlier.
// Create a new VSSCryptor instance
VSSCryptor *decryptor = [[VSSCryptor alloc] init];
// Decrypt data
NSError *error = nil;
NSData *plainData = [decryptor decryptData:<# NSData containing encrypted data #> recipientId:<# Recipient ID #> privateKey:<# keyPair.privateKey #> keyPassword:<# Private key password or nil #> error:&error];
if (error != nil) {
    NSLog(@"Error decrypting data: %@", [error localizedDescription]);
    return;
}
// Compose initial message from the plain decrypted data
NSString *initialMessage = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
//...
```

###### Swift
```swift
//...
// Assuming that we have received some key-based encrypted data.
// Assuming that we have some key pair generated earlier.
// Create a new VSSCryptor instance
let decryptor = VSSCryptor()
// Decrypt data
do {
    let plainData = try decryptor.decryptData(<# NSData with encrypted data #>, recipientId: <# Recipient ID #>, privateKey: <# keyPair.privateKey() #>, keyPassword: <# Private key password or nil #>, error: ())
    // Compose initial message from the plain decrypted data
    if let initialMessage = NSString(data: plainData, encoding: NSUTF8StringEncoding) {
        // Use initialMessage.
        //...
    }
}
catch let error as NSError {
    print("Error: \(error.localizedDescription)")
}
//...
```

#### Password-based encryption

###### Objective-C
```objective-c
//...
// Assuming that we have some initial string message.
NSString *message = @"This is a secret message which should be encrypted with password-based encryption.";
// Convert it to the NSData
NSData *toEncrypt = [message dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
// Assuming that we have some key pair generated earlier.
// Create a new VSSCryptor instance
VSSCryptor *cryptor = [[VSSCryptor alloc] init];
NSError *error = nil;
if (![cryptor addPasswordRecipient:<# Password to encrypt data with #> error:&error]) {
    NSLog(@"Error adding password recipient: %@", [error localizedDescription]);
    return;
}
// And now we can encrypt the plain data
NSData *encryptedData = [cryptor encryptData:toEncrypt embedContentInfo:YES error:&error];
if (error != nil) {
    NSLog(@"Error encrypting data: %@", [error localizedDescription]);
    return;
}
//...
```

###### Swift
```swift
//...
// Assuming that we have some initial string message.
let message = NSString(string: "This is a secret message which should be encrypted.")
// Convert it to the NSData
if let toEncrypt = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
    // Create a cryptor instance
    var encryptedData = NSData()
    let cryptor = VSSCryptor()
    do {
        try cryptor.addPasswordRecipient(<# Password to encrypt data with #>, error: ())
        encryptedData = try cryptor.encryptData(toEncrypt, embedContentInfo: true, error: ())
    }
    catch let error as NSError {
        print("Error: \(error.localizedDescription)")
    }
}
//...
```

#### Password-based decryption

###### Objective-C
```objective-c
//...
// Assuming that we have received some password-based encrypted data.
// Assuming that we have some key pair generated earlier.
// Create a new VSSCryptor instance
VSSCryptor *decryptor = [[VSSCryptor alloc] init];
// Decrypt data
NSError *error = nil;
NSData *plainData = [decryptor decryptData:<# NSData with encrypted data #> password:<# Password used for encryption #> error:&error];
if (error != nil) {
    NSLog(@"Error decrypting data: %@", [error localizedDescription]);
    return;
}
// Compose initial message from the plain decrypted data
NSString *initialMessage = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
//...
```

###### Swift
```swift
//...
// Assuming that we have received some password-based encrypted data.
// Assuming that we have some key pair generated earlier.
// Create a new VSSCryptor instance
let decryptor = VSSCryptor()
// Decrypt data
do {
    let plainData = try decryptor.decryptData(NSData(), password: "", error: ())
    // Compose initial message from the plain decrypted data
    if let initialMessage = NSString(data: plainData, encoding: NSUTF8StringEncoding) {
        // Use initialMessage.
        //...
    }
}
catch let error as NSError {
    print("Error: \(error.localizedDescription)")
}
//...
```

### Compose and verify a signature

VSSSigner instances allows to sign some data with a given private key. This can be used to make sure that some message/data was really composed and sent by the holder of the private key.

#### Compose a signature

###### Objective-C
```objective-c
//...
// Assuming that we have some initial string message that we want to sign.
NSString *message = @"This is a secret message which should be signed.";
// Convert it to the NSData
NSData *toSign = [message dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
// Assuming that we have some key pair generated earlier.
// Create a new VSSSigner instance
VSSSigner *signer = [[VSSSigner alloc] init];
// Sign the initial data
NSError *error = nil;
NSData *signature = [signer signData:toSign privateKey:<# keyPair.privateKey #> keyPassword:<# Private key password or nil #> error:&error];
if (error != nil) {
    NSLog(@"Error composing a signature: %@", [error localizedDescription]);
    return;
}
// Use the signature.
//...
```

###### Swift
```swift
//...
// Assuming that we have some initial string message.
let message = NSString(string: "This is a secret message which should be signed.")
// Convert it to the NSData
if let toSign = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
    // Create the signer
    let signer = VSSSigner()
    // Compose the signature
    do {
        let signature = try signer.signData(toSign, privateKey: <# keyPair.privateKey() #>, keyPassword: <# Private key password or nil #>, error: ())
        // Use the signature.
        //...
    }
    catch let error as NSError {
        print("Error composing a signature: \(error.localizedDescription)")
    }
}
//...
```

#### Verify a signature

To verify some signature it is necessary to have a public key of a user whose signature we want to verify. 

###### Objective-C
```objective-c
//...
// Assuming that we have the public key of a person whose signature we need to verify
// Assuming that we have a NSData object with signed data.
// Assuming that we have a NSData object with a signature.
// Create a new VSSSigner instance
VSSSigner *verifier = [[VSSSigner alloc] init];
// Verify the signature.
NSError *error = nil;
if (![verifier verifySignature:<# NSData containing the signature #> data:<# NSData used to compose the signature #> publicKey:<# keyPair.publicKey #> error:&error]) {
    NSLog(@"Error signature verification: %@", [error localizedDescription]);
    return;
}
// Signature seems OK.
//...
```

###### Swift
```swift
//...
// Assuming that we have the public key of a person whose signature we need to verify
// Assuming that we have a NSData object with signed data.
// Assuming that we have a NSData object with a signature.
// Create a new VSSSigner instance
let verifier = VSSSigner()
// Verify the signature.
do {
    try verifier.verifySignature(<# NSData containing the signature #>, data: <# NSData used to compose the signature #>, publicKey: <# keyPair.publicKey() #>, error: ())
    // Signature seems OK.
    //...
}
catch let error as NSError {
    print("Error signature verification: \(error.localizedDescription)")
}
//...
```

### Derivation of a key from a password

This functionality allows to generate sequences of bytes based on the given initial parameters so that the same parameters give the same sequence of bytes. This might come in handy when the application does not want to use some sensitive data in a plain form (saving password between sessions, or manipulating other pieces of user data, e.g. emails, phone numbers, etc.). In this situation the application can produce secure sequence based on the password or email address or any other plain data, so this data will not be exposed. It is not possible (or at least it is impossible in reasonable time) to restore initial plain data using the generated sequence of bytes. See examples below.

###### Objective-C
```objective-c
//...
// Assuming that we have some password which the application does not to expose in plain form.
NSString *password = <# NSString: user password in plain form#>;
// Create a new VSSPBKDF instance
// Salt parameter should contain the random sequence of bytes. In general, salt is public information. 
// If salt parameter is nil then VSSPBKDF will generate random salt automatically.
// If it is necessary to generate the same data later based on the user's input of the password
// it is recommended to generate salt data and store it for further use in VSSPBKDF instance creations:
NSData *salt = [VSSPBKDF randomBytesOfSize:<#size_t: size of the salt in bytes or 0 #>];       
// Iterations parameter should contain number of iterations for derivation function.
// If iterations == 0 then VSSPBKDF will use default number of iterations.
VSSPBKDF *pbkdf = [[VSSPBKDF alloc] initWithSalt:<#NSData: salt or nil for default new salt generation#> iterations:<#unsigned int: iterations count or 0 for default count #>];
NSError *error = nil;
// Derive secure sequence of bytes with required size based on the plain password.
NSData *data = [pbkdf keyFromPassword:password size:<# size_t: Desired length in bytes of the output data sequence #> error:&error];
if (error != nil) {
    NSLog(@"Error: %@", [error localizedDescription]);
    return;
} 
// Use the data instead of plain password.
//...
```

###### Swift
```swift
//...
// Assuming that we have some password which the application does not to expose in plain form.
let password = <# String: user password in plain form#>;
// Create a new VSSPBKDF instance
// Salt parameter should contain the random sequence of bytes. In general, salt is public information. 
// If salt parameter is nil then VSSPBKDF will generate random salt automatically.
// If it is necessary to generate the same data later based on the user's input of the password
// it is recommended to generate salt data and store it for further use in VSSPBKDF instance creations:
let salt = VSSPBKDF.randomBytesOfSize(<#size_t: size of the salt in bytes or 0 #>)       
// Iterations parameter should contain number of iterations for derivation function.
// If iterations == 0 then VSSPBKDF will use default number of iterations.
let pbkdf = VSSPBKDF(salt:<# NSData: salt or nil for default new salt generation #>, iterations: <#unsigned int: iterations count or 0 for default count #>)
do {
    // Derive secure sequence of bytes with required size based on the plain password.
    let data = try pbkdf.keyFromPassword(password, size: <# size_t: Desired length in bytes of the output data sequence #>)
    // Use the data instead of plain password.
}
catch (let error as NSError) {
    print("Error: \(error.localizedDescription)")
    return
}
//...
```

## License

Usage is provided under the [The BSD 3-Clause License](http://opensource.org/licenses/BSD-3-Clause). See LICENSE for the full details.


## See also

* [Virgil Foundation API Reference](http://virgilsecurity.github.io/virgil-foundation-x)
* [Virgil SDK Quickstart guide](https://github.com/VirgilSecurity/virgil-sdk-x/blob/v3/Docs/quickstart.md)