
- [Introduction](#introduction)
- [Obtaining an Access Token](#obtaining-an-access-token)
- [Install](#install)
- [Swift note](#swift-note)
- [Use case](#use-case)
    - [Initialization](#initialization)
    - [Step 1. Create and Publish the Keys](#step-1-create-and-publish-the-keys)
    - [Step 2. Encrypt and Sign](#step-2-encrypt-and-sign)
    - [Step 3. Get sender's Public Key](#step-3-get-senders-public-key)
    - [Step 4. Verify and Decrypt](#step-4-verify-and-decrypt)

## Introduction

This guide will help you get started using the Crypto Library and Virgil Security Services for the most popular platforms and languages.
This branch focuses on the Objective-C/Swift library implementation and covers its usage.

Let's go through an encrypted message exchange steps as one of the possible [use cases](#use-case) of Virgil Security Services. ![Use case mail](https://raw.githubusercontent.com/VirgilSecurity/virgil/master/images/Email-diagram-short.jpg)

## Obtaining an Access Token

First you must create a free Virgil Security developer's account by signing up [here](https://developer.virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://developer.virgilsecurity.com/account/signin) and generate an access token for your application.

The access token provides authenticated secure access to Virgil Security Services and is passed with each API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Use this token to initialize the SDK client [here](#initialization).

## Install

You can easily add SDK dependency to your project using CocoaPods. So, if you are not familiar with this dependency manager, it is time to install CocoaPods. Open your terminal window and execute the following line:
```
$ sudo gem install cocoapods
``` 
It will ask you about the password and then will install latest release version of CocoaPods. CocoaPods is built with Ruby and it will be installed with the default Ruby available in OS X.
If you encounter any issues during this installation, please take a look at [cocoapods.org](https://guides.cocoapods.org/using/getting-started.html) for more information.

Now it is possible to add VirgilSDK to the particular application. So:

- Open Xcode and create a new project (in the Xcode menu: File->New->Project), or navigate to existing Xcode project using:

```
$ cd <Path to Xcode project folder>
```

- In the Xcode project's folder create a new file, give it a name *Podfile* (with a capital *P* and without any extension). The following example shows how to compose the Podfile for an iOS application. If you are planning to use another platform, the process will be quite similar. You only need to change a platform to the correspondent value. [Here](https://guides.cocoapods.org/syntax/podfile.html#platform) you can find more information about the platform values.

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Put your Xcode target name here>' do
	pod 'VirgilSDK'
end
```

- Get back to your terminal window and execute the following line:

```
$ pod install
```
 
- Close Xcode project (if it is still opened). For any further development purposes you should use Xcode *.xcworkspace* file created for you by CocoaPods.
 
At this point you should be able to use VirgilSDK pod in your code. If you encountered any issues with CocoaPods installations try to find more information at [cocoapods.org](https://guides.cocoapods.org/using/getting-started.html).

## Swift note

Although VirgilSDK pod is using Objective-C as its primary language it might be quite easily used in a Swift application.
After pod is installed as described above it is necessary to perform the following:

- Create a new header file in the Swift project.
- Name it something like *BridgingHeader.h*
- Put there the following lines:

###### Objective-C
``` objective-c
@import VirgilFoundation;
@import VirgilSDK;
```

- In the Xcode build settings find the setting called *Objective-C Bridging Header* and set the path to your *BridgingHeader.h* file. Be aware that this path is relative to your Xcode project's folder. After adding bridging header setting you should be able to use the SDK.

You can find more information about using Objective-C and Swift in the same project [here](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html).

## Use Case
**Secure any data end to end**: users need to securely exchange information (text messages, files, audio, video etc) while enabling both in transit and at rest protection. 

- Application generates public and private key pairs using Virgil Crypto library and use Virgil Keys service to enable secure end to end communications:
    - public key on Virgil Public Keys Service;
    - private key on Virgil Private Keys Service or locally.
- Sender’s information is encrypted in Virgil Crypto Library with the recipient’s public key.
- Sender’s encrypted information is signed with his private key in Virgil Crypto Library.
- Application securely transfers the encrypted data, sender’s digital signature and UDID to the recipient without any risk to be revealed.
- Application on the recipient’s side verifies that the signature of transferred data is valid using the signature and sender’s public key in Virgil Crypto Library.
- Received information is decrypted with the recipient’s private key using Virgil Crypto Library.
- Decrypted data is provided to the recipient.

## Initialization

###### Objective-C
```objective-c
@import VirgilFoundation;
@import VirgilSDK;

//...
@property (nonatomic, strong) VSSClient * __nonnull client;
//...
self.client = 
	[[VSSClient alloc] initWithApplicationToken:<# Virgil App Token#> 
	serviceConfig:nil];
[self.client setupClientWithCompletionHandler:^(NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Failed to setup VSSClient properly: %@", 
        	[error localizedDescription]);
        return;
    }
    
    NSLog(@"VSSClient has been set up and ready to work.");
    //...
}];
//...
```

###### Swift
```swift
//...
private var client: VSSClient! = nil
//..
self.client = VSSClient(applicationToken:<# Virgil App token#>,
	 serviceConfig: nil)
self.client.setupClientWithCompletionHandler { (error) -> Void in
    if error != nil {
        print("Failed to setup VSSClient properly: 
        	\(error!.localizedDescription)")
        return
    }    
    
    print("VSSClient has been set up and ready to work.")
    //...
}
//...
```

## Step 1. Create and Publish the Keys
First a mail exchange application is generating the keys and publishing them to the Public Keys Service where they are available in an open access for other users (e.g. recipient) to verify and encrypt the data for the key owner.

The following code example creates a new public/private key pair.

###### Objective-C
```objective-c
//...
// The private key's password is optiona here.
VSSKeyPair *keyPair = 
	[[VSSKeyPair alloc] initWithPassword:<#Private key password or nil#>];
//...
```

###### Swift
```swift
//...
// The private key's password is optiona here.
let keyPair = VSSKeyPair(password:<#Private key password or nil#>)
//...
```
The app is verifying whether the user really owns the provided email address and getting a temporary token for public key registration on the Public Keys Service.

###### Objective-C
```objective-c
//...
[self.client verifyIdentityWithType:VSSIdentityTypeEmail 
	value:<# Email address #> 
	completionHandler:^(GUID * _Nullable actionId, NSError * _Nullable error) 
	{
    if (error != nil) {
        NSLog(@"Error verifying identity: %@", [error localizedDescription]);
        return;
    }
    
    // Store actionId somewhere. It will be necessary to confirm 
    // the email address.
    //...
}];
//...
// Get the confirmation code from email box given in 
// verifyIdentityWithType:value:completionHandler call
// Use this code for email confirmation
[self.client confirmIdentityWithActionId:<# Action Id #> 
	code:<# Confirmation code from email #> 
	ttl:nil 
	ctl:nil 
	completionHandler:^(VSSIdentityType type, 
		NSString * _Nullable value, 
		NSString * _Nullable validationToken, 
		NSError * _Nullable error) {
    		if (error != nil) {
        		NSLog(@"Error identity confirmation: %@", 
        		[error localizedDescription]);
        return;
    }
    
    // Store validationToken. It will be used for creating 
    // Virgil Card object later.
    //...
}];
//...
```

###### Swift
```swift
//...
self.client.verifyIdentityWithType(.Email, value: <# Email address #>) 
{ (actionId, error) -> Void in
    if error != nil {
        print("Error verifying identity: \(error!.localizedDescription)")
        return
    }
    
    // Store actionId somewhere. It will be necessary to confirm 
    // the email address.
    //...
}
//...
// Get the confirmation code from email box given in 
// verifyIdentityWithType:value:completionHandler call
// Use this code for email confirmation
self.client.confirmIdentityWithActionId(<# Action Id #>, 
	code: <# Confirmation code from email #>, 
	ttl: nil, 
	ctl: nil) { (type, value, validationToken, error) -> Void in
    if error != nil {
        print("Error identity confirmation: \(error!.localizedDescription)")
        return
    }
    
    // Store validationToken. It will be used for creating 
    // Virgil Card object later.
    //...
}
//...
```

The app is registering a Virgil Card which includes a public key and an email address identifier. The card will be used for the public key identification and searching for it in the Public Keys Service.

###### Objective-C
```objective-c
//...
NSDictionary *identity = @{ 
	kVSSModelType: [VSSIdentity stringFromIdentityType:VSSIdentityTypeEmail],
	kVSSModelValue: <# Email address #>,
	kVSSModelValidationToken: <# Validation token #> };
VSSPrivateKey *privateKey = [[VSSPrivateKey alloc] 
	initWithKey:[<# VSSKeyPair #> privateKey] 
	password:<# Private key password or nil #>];
[self.client createCardWithPublicKey:[<# VSSKeyPair #> publicKey] 
	identity:identity 
	data:nil 
	signs:nil 
	privateKey:privateKey 
	completionHandler:^(VSSCard * _Nullable card, NSError * _Nullable error)
	 {
    if (error != nil) {
        NSLog(@"Error creating Virgil Card: %@", [error localizedDescription]);
        return;
    }
    
    // VSSCard instance represents Virgil Card. It will be used later.
    //...
}];
//...
```

###### Swift
```swift
//...
let identity = [
    kVSSModelType: VSSIdentity.stringFromIdentityType(.Email),
    kVSSModelValue: <# Email address #>,
    kVSSModelValidationToken: <# Validation token #>
]
let privateKey = VSSPrivateKey(key: <# VSSKeyPair #>.privateKey(), 
	password: <# Private key password or nil #)
self.client.createCardWithPublicKey(<# VSSKeyPair #>.publicKey(), 
	identity: identity, 
	data: nil, 
	signs: nil, 
	privateKey: privateKey) { (card, error) -> Void in
    if error != nil {
        print("Error creating Virgil Card: \(error!.localiedDescription)")
        return
    }
    
    // VSSCard card represents Virgil Card. It will be used later.
    //...
}
//...
```

## Step 2. Encrypt and Sign
The app is searching for the recipient’s public key on the Public Keys Service to encrypt a message for him. The app is signing the encrypted message with sender’s private key so that the recipient can make sure the message had been sent from the declared sender.

###### Objective-C
```objective-c
//...
NSString *message = <# Secret message which should be encryped #>;
[self.client 
	searchCardWithIdentityValue:<# Recepient email address #> 
	type:VSSIdentityTypeEmail 
	relations:nil 
	unconfirmed:nil 
	completionHandler:^(NSArray<VSSCard *> * _Nullable cards, 
		NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Error searching for Virgil Card: %@", 
        	[error localizedDescription]);
        return;
    }
    
    if (cards.count > 0) {
        VSSCryptor *cryptor = [[VSSCryptor alloc] init];
        for (VSSCard *card in cards) {
            [cryptor addKeyRecepient:card.Id publicKey:card.publicKey.key];
        }
        NSData *encryptedMessage = 
        [cryptor encryptData:[message dataUsingEncoding:NSUTF8StringEncoding 
        allowLossyConversion:NO] 
        embedContentInfo:@YES];
        
        VSSSigner *signer = [[VSSSigner alloc] init];
        NSData *signature = 
	        [signer signData:encryptedMessage 
	        privateKey:[<# Sender VSSKeyPair #> privateKey] 
	        keyPassword:nil];
        // Now encryptedMessage contains encrypted data of initial 
        // secret message which can only be decrypted
        // using private key of recipient's key pair.
        // And signature contains actual signature of sender 
        // composed using sender's private key and it
        // can be easily verified only using sender's public key 
        // which is available on Virgil Keys Service.
        // So, encryptedMessage and signature can now be sent to 
        // recipient using any desirable way (e.g. email).
        //...
    }
    else {
        // No recipient's cards found. 
    }
}];
//...
```

###### Swift
```swift
//...
let message: NSString = <# Secret message which should be encryped #>
self.client.searchCardWithIdentityValue(<# Recepient email address #>, 
	type: .Email, 
	relations: nil, 
	unconfirmed: nil) { (cards, error) -> Void in
    if error != nil {
        print("Error searching for Virgil Card: 
        	\(error!.localizedDescription)")
        return
    }
    
    if cards?.count > 0 {
        let cryptor = VSSCryptor()
        for card: VSSCard in cards {
            cryptor.addKeyRecepient(card.Id, publicKey: card.publicKey.key)
        }
        let encryptedMessage = 	
	   	   cryptor.encryptData(message.dataUsingEncoding(NSUTF8StringEncoding, 
	        allowLossyConversion: false), 
	        embedContentInfo: true)
        
        let signer = VSSSigner()
        let signature = signer.signData(encryptedMessage, 
        	privateKey: <# Sender VSSKeyPair #>.privateKey(), 
        	keyPassword: nil)
        // Now encryptedMessage contains encrypted data of initial 
        // secret message which can only be decrypted
        // using private key of recipient's key pair.
        // And signature contains actual signature of sender composed 
        // using sender's private key and it
        // can be easily verified only using sender's public key 
        // which is available on Virgil Keys Service.
        // So, encryptedMessage and signature can now be sent to recipient using any desirable way (e.g. email).
        //...
    }
    else {
        // No recipient's cards found.
    }
}
//...
```

## Step 3. Get sender's Public Key
In order to decrypt the received data the app on recipient’s side needs to get sender’s Virgil Card from the Public Keys Service.

###### Objective-C
```objective-c
//...
[self.client searchCardWithIdentityValue:<# Sender email address #> 
type:VSSIdentityTypeEmail 
relations:nil 
unconfirmed:nil 
completionHandler:^(NSArray<VSSCard *> 
 * _Nullable cards, 
 * NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Error searching for Virgil Card: %@", 
        	[error localizedDescription]);
        return;
    }
    
    // NSArray cards contains Vrigil Card objects which fit given 
    // search parameters.
    // Most likely this array will contain only one Virgil Card, 
    // which we are interested in.
    if (cards.count > 0) {
        // Take first card:
        VSSCard *senderCard = [cards[0] as:[VSSCard class]];
        // Use the card for further operations.
        // ...
    else {
        // No sender's cards found. 
    }
}];
//...
```

###### Swift
```swift
//...
self.client.searchCardWithIdentityValue(<# Sender email address #>, 
	type: .Email, 
	relations: nil, 
	unconfirmed: nil) { (cards, error) -> Void in
    if error != nil {
        print("Error searching for Virgil Card: 
        	\(error!.localizedDescription)")
        return
    }
    
    // NSArray cards contains Vrigil Card objects which fit given 
    // search parameters.
    // Most likely this array will contain only one Virgil Card, 
    // which we are interested in.
    if cards?.count > 0 {
        // Take first card:
        let senderCard = cards![0]
        // Use the card for further operations.
        // ...
    else {
        // No sender's cards found.
    }
}
//...
```

## Step 4. Verify and Decrypt 
We are making sure the data came from the declared sender by verifying his signature using his Virgil Card from Public Keys Service. In case of success we are decrypting the letter using the recipient's private key.

###### Objective-C
```objective-c
//...
NSData *encryptedMessage = <# Encrypted message received from sender user #>;
NSData *signature = <# Composed signature of sender user #>;
//...
VSSSigner *verifier = [[VSSSigner alloc] init];
// Try to verify sender's signature
BOOL verified = [verifier verifySignature:signature 
	data:encryptedMessage 
	publicKey:<# VSSCard: sender card from previous step #>.publicKey.key];
if (!verified) {
    NSLog(@"Error verification sender's signature.");
    return;
}

VSSCryptor *decryptor = [[VSSCryptor alloc] init];
// Try to decrypt encrypted message
NSData *decryptedMessage = [decryptor decryptData:encryptedMessage 
	publicKeyId:<# Recepient VSSCard #>.Id 
	privateKey:[<# Recepient VSSKeyPair #> privateKey] 
	keyPassword:<# Private key password or nil #>];
if (decryptedMessage.length == 0) {
    NSLog(@"Error decrypting sender's message");
    return;
}

NSString *message = [[NSString alloc] 
	initWithData:decryptedMessage 
	encoding:NSUTF8StringEncoding];
// message contains readable decrypted message which was sent 
// by another user referred as sender.
//...
```

###### Swift
```swift
//...
let encryptedMessage = <# NSData: Encrypted message received from sender user #>
let signature = <# NSData: Composed signature of sender user #>
//...
let verifier = VSSSigner()
// Try to verify signature
let verified = verifier.verifySignature(signature, 
	data: encryptedMessage, 
	publicKey: <# VSSCard: sender card from previous step #>.publicKey.key)
if !verified {
    print("Error verification sender's signature.")
    return;
}

let decryptor = VSSCryptor()
let decryptedMessage = decryptor.decryptData(encryptedMessage, 
	publicKeyId: <# Recepient VSSCard #>.Id, 
	privateKey: <# Recepient VSSKeyPair #>.privateKey(), 
	keyPassword: <# Private key password or nil #>)
if let messageData = decryptedMessage, 
	message = NSString(data: messageData, 
	encoding: NSUTF8StringEncoding) {
    // message contains readable decrypted message which was sent 
    // by another user referred as sender.
    //...
}
else {
    print("Error decrypting sender's message.")
    return
}
//...
```