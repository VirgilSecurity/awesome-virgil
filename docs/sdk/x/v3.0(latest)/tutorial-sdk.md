# Tutorial Objective-C/Swift SDK 

- [Introduction](#introduction)
- [Install](#install)
- [Swift note](#swift-note)
- [Obtaining an Access Token](#obtaining-an-access-token)
- [Cards and Public Keys](#cards-and-public-keys)
  - [Publish a Virgil Card](#publish-a-virgil-card)
  - [Search for Cards](#search-for-cards)
  - [Revoke a Virgil Card](#revoke-a-virgil-card)
  - [Get a Public Key](#get-a-public-key)
- [Private Keys](#private-keys)
  - [Store a Private Key](#store-a-private-key)
  - [Get a Private Key](#get-a-private-key)
  - [Destroy a Private Key](#destroy-a-private-key)
- [Identities](#identities)
  - [Obtaining a global validation token](#obtaining-a-global-validation-token)
  - [Obtaining a private validation token](#obtaining-a-private-validation-token)
- [See Also](#see-also)    

##Introduction

This tutorial explains how to use the Virgil Security Services with SDK library in Objective-C/Swift applications. 

##Install

You can easily add SDK dependency to your project using CocoaPods. So, if you are not familiar with this dependency manager it is time to install CocoaPods. Open your terminal window and execute the following line:
```
$ sudo gem install cocoapods
``` 
It will ask you about the password and then will install latest release version of CocoaPods. CocoaPods is built with Ruby and it will be installed with the default Ruby available in OS X.
If you encounter any issues during this installation, please take a look at [cocoapods.org](https://guides.cocoapods.org/using/getting-started.html) for more information.

Now it is possible to add VirgilSDK to the particular application. So:

- Open Xcode and create a new project (in the Xcode menu: File->New->Project), or navigate to an existing Xcode project using:

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
 
At this point you should be able to use VirgilSDK pod in your code. If you encountered any issues with CocoaPods installations, try to find more information at [cocoapods.org](https://guides.cocoapods.org/using/getting-started.html).

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

## Obtaining an Access Token

First you must create a free Virgil Security developer's account by signing up [here](https://developer.virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://developer.virgilsecurity.com/account/signin) and generate an access token for your application.

The access token provides an authenticated secure access to the Virgil Security Services and is passed with each API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Simply add your access token to the client constuctor as an application token.

###### Objective-C
```objective-c
//...
@property (nonatomic, strong) VSSClient * __nonnull client;
//...
self.client = [[VSSClient alloc] 
				initWithApplicationToken:<# Virgil Access Token #>];
//...
```

###### Swift
```swift
//...
private var client: VSSClient! = nil
//...
let client = VSSClient(applicationToken: <# Virgil Access Token #>)
//...
```

## Cards and Public Keys

A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.

The Virgil Card might be *global* and *private*. The difference is whether Virgil Services take part in [the Identity verification](#identities). 

*Global Cards* are created with the validation token received after verification in Virgil Identity Service. Any developer with Virgil account can create a global Virgil Card and you can be sure that the account with a particular email has been verified and the email owner is really the Identity owner.

*Private Cards* are created when a developer is using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app's Private Key created on our [Developer portal](https://developer.virgilsecurity.com/dashboard/).

#### Publish a Virgil Card

Creating a *private* Virgil Card with a newly generated key pair and **validation token**. See how to obtain a **validation token** [here...](#obtaining-a-private-validation-token)

###### Objective-C
```objective-c
//...
@import VirgilFoundation;
@import VirgilSDK;
//...
// Generate a new key pair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
// Compose identity information object
VSSIdentityInfo *identity = 
    [[VSSIdentityInfo alloc] initWithType:<# NSString: custom string #> 
                                    value:<# NSString: Identity value #> 
                          validationToken:<# NSString: Generated validation token for the custom identity #>];
// Compose VSSPrivateKey container
VSSPrivateKey *privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey password:nil];
// Send request for the creation of the Virgil Card.                          
[self.client 
	createCardWithPublicKey:keyPair.publicKey 
	           identityInfo:identity 
                       data:<# Custom NSDictionary or nil #>  
	             privateKey:privateKey 
	      completionHandler:^(VSSCard *card, NSError *error) {
	    if (error != nil) {
	        NSLog(@"Error creating Virgil Card: %@", 
	        	[error localizedDescription]);
	        return;
	    }
    
    //Virgil Card has been saved at Virgil Keys Service.
    // Use card object for further references.
    //...
}];
//...
```

###### Swift
```swift
//...
// Generate a new key pair
let keyPair = VSSKeyPair()
// Compose identity information object 
let identity = VSSIdentityInfo(type: <# String: Custom identity type #>, 
    value: <# String: Identity value #>, 
    validationToken: <# String: Generated validation token for the custom identity #>)
// Compose VSSPrivateKey container
let privateKey = VSSPrivateKey(key: keyPair.privateKey(), password: nil)
// Send request for the creation of the Virgil Card.
self.client.createCardWithPublicKey(keyPair.publicKey(), 
	identityInfo: identity, 
	data: nil,  
	privateKey: privateKey, 
	completionHandler: { (card, error) -> Void in
	    if error != nil {
	        print("Error creating Virgil Card: \(error!.localizedDescription)")
	        return
	    }
    
    //Virgil Card has been saved at Virgil Keys Service.
    // Use card object for further references.
    //...
})
//...
```

Creating an unauthorized *private* Virgil Card without **validation token**.

###### Objective-C
```objective-c
//...
@import VirgilFoundation;
@import VirgilSDK;
//...
// Generate a new key pair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
// Compose identity information object
VSSIdentityInfo *identity = 
    [[VSSIdentityInfo alloc] initWithType:<# NSString: custom string #> 
                                    value:<# NSString: Identity value #>];
// Compose VSSPrivateKey container
VSSPrivateKey *privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey password:nil];                                                                        
// Send request for the creation of the Virgil Card.                          
[self.client 
	createCardWithPublicKey:keyPair.publicKey 
	           identityInfo:identity 
                       data:<# Custom NSDictionary or nil #>  
	             privateKey:privateKey 
	      completionHandler:^(VSSCard *card, NSError *error) {
	    if (error != nil) {
	        NSLog(@"Error creating Virgil Card: %@", 
	        	[error localizedDescription]);
	        return;
	    }
    
    //Virgil Card has been saved at Virgil Keys Service.
    // Use card object for further references.
    //...
}];
//...
```

###### Swift
```swift
//...
// Generate a new key pair
let keyPair = VSSKeyPair()
// Compose identity information object 
let identity = VSSIdentityInfo(type: <# String: Custom identity type #>, 
    value: <# String: Identity value #>)
// Compose VSSPrivateKey container
let privateKey = VSSPrivateKey(key: keyPair.privateKey(), password: nil)    
// Send request for the creation of the Virgil Card.
self.client.createCardWithPublicKey(keyPair.publicKey(), 
	identityInfo: identity, 
	data: <# Custom Dictionary<String, String> or nil #>,  
	privateKey: privateKey, 
	completionHandler: { (card, error) -> Void in
	    if error != nil {
	        print("Error creating Virgil Card: \(error!.localizedDescription)")
	        return
	    }
    
    //Virgil Card has been saved at Virgil Keys Service.
    // Use card object for further references.
    //...
})
//...
```

Creating a *global* Virgil Card. See how to obtain a **validation token** [here...](#obtaining-a-global-validation-token)

###### Objective-C
```objective-c
//...
@import VirgilFoundation;
@import VirgilSDK;
//...
// Generate a new key pair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
// Compose VSSPrivateKey container
VSSPrivateKey *privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey password:nil];
// Initiate verification procedure with the Identity Service
[self.client 
    verifyEmailIdentityWithValue:<# NSString: email address #> 
                     extraFields:nil 
               completionHandler:^(GUID * _Nullable actionId, NSError * _Nullable error) {
        if (error != nil) {
	        NSLog(@"Error: %@", 
	        	[error localizedDescription]);
	        return;
	    }
        // Store actionId as it is necessary to complete confirmation 
        // and get the validation token. 
}];
//...
// Get the confirmation code from the email and 
// complete the email verification procedure:
[self.client 
    confirmEmailIdentityWithActionId:<# NSString: actionId received on the previous call to verify #> 
                                code:<# NSString: Confirmation code from email #> 
                            tokenTtl:0 
                            tokenCtl:0 
                   completionHandler:^(VSSIdentityInfo * _Nullable identityInfo, NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Error: %@", 
            [error localizedDescription]);
        return;
    }
    // Use the identityInfo object. It should contain all necessary fields,
    // including the validation token.
    // Send request for the creation of the Virgil Card.                          
    [self.client 
        createCardWithPublicKey:keyPair.publicKey 
                    identityInfo:identityInfo 
                            data:<# Custom NSDictionary or nil #>  
                        privateKey:privateKey 
                completionHandler:^(VSSCard *card, NSError *error) {
        if (error != nil) {
            NSLog(@"Error creating Virgil Card: %@", 
                [error localizedDescription]);
            return;
        }

        // Virgil Card has been saved at Virgil Keys Service.
        // Use card object for further references.
        //...
    }];
}]; 
//...
```

###### Swift
```swift
//...
// Generate a new key pair
let keyPair = VSSKeyPair()
// Compose VSSPrivateKey container
let privateKey = VSSPrivateKey(key: keyPair.privateKey(), password: nil)
// Initiate verification procedure with the Identity Service
self.client.verifyEmailIdentityWithValue(<# String: email address #>, 
    extraFields: nil) { (actionId, error) in
    if error != nil {
        print("Error: \(error!.localizedDescription)")
        return
    }
    
    // Store actionId as it is necessary to complete confirmation 
    // and get the validation token.
}
//...
// Get the confirmation code from the email and 
// complete the email verification procedure:
self.client.confirmEmailIdentityWithActionId(<# String: actionId received on the previous call to verify #>, 
    code: <# Confirmation code from email #>, tokenTtl: 0, tokenCtl: 0) { (identityInfo, error) in
    if error != nil {
        print("Error: \(error!.localizedDescription)")
        return
    }
     
    // Use the identityInfo object. It should contain all necessary fields,
    // including the validation token.
    // Send request for the creation of the Virgil Card.
    self.client.createCardWithPublicKey(keyPair.publicKey(), 
        identityInfo: identityInfo!, 
        data: <# Custom Dictionary or nil #>, 
        privateKey: privateKey) { (card, error) in
        if error != nil {
	        print("Error creating Virgil Card: \(error!.localizedDescription)")
	        return
	    }
    
    //Virgil Card has been saved at Virgil Keys Service.
    // Use card object for further references.
    //...
    }
}
//...
```

#### Search for Cards

Search for a *global* Virgil Card.

###### Objective-C
```objective-c
//...
// Search for the email cards:
[self.client 
    searchEmailCardWithIdentityValue:<# NSString: email address #> 
                   completionHandler:^(NSArray<VSSCard *> * _Nullable cards, NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Error: %@",
            [error localizedDescription]);
        return;
    } 
    // cards contains an array of VSSCard objects which fit given parameters.
    // Quite often it might be only one VSSCard in the array.
    //... 
}];
//...
// Search for the app cards:
// Pay attention: identity value for this call might contain wildcard as the last part of reverse url notation,
// e.g. 'com.virgilsecurity.*' -> performs search for all the applications registered by Virgil Security, Inc.
[self.client 
    searchAppCardWithIdentityValue:<# NSString: Identity value #> 
                 completionHandler:^(NSArray<VSSCard *> * _Nullable cards, NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Error: %@",
            [error localizedDescription]);
        return;
    }
    // cards contains an array of VSSCard objects which fit given parameters.
    // In case identity value contains a particular single value without a wildcard,
    // e.g. 'com.virgilsecurity.keys', the cards array most likely contains only one single card. 
    //... 
}];
//...
```

###### Swift
```swift
//...
// Search for the email cards:
self.client.searchEmailCardWithIdentityValue(<# String: email address #>) { (cards, error) in
    if error != nil {
        print("Error searching for Virgil Cards: 
            \(error!.localizedDescription)")
        return
    }
    // cards contains an array of VSSCard objects which fit given parameters.
    // Quite often it might be only one VSSCard in the array.
    //...   
}
//...
// Search for the app cards:
// Pay attention: identity value for this call might contain wildcard as the last part of reverse url notation,
// e.g. 'com.virgilsecurity.*' -> performs search for all the applications registered by Virgil Security, Inc.
self.client.searchAppCardWithIdentityValue(<# String: Identity value #>) { (cards, error) in
    if error != nil {
        print("Error searching for Virgil Cards: 
            \(error!.localizedDescription)")
        return
    }
    // cards contains an array of VSSCard objects which fit given parameters.
    // In case identity value contains a particular single value without a wildcard,
    // e.g. 'com.virgilsecurity.keys', the cards array most likely contains only one single card. 
    //...    
}
//...
```

Search for a *private* Virgil Card.

###### Objective-C
```objective-c
//...
// First parameter contains value of the identity associated with required card.
// Parameter type is allowed to be nil.
// In case when unauthorized = NO the array of cards in callback will NOT contain cards
// which have been created with identities that haven't provided validation token.
// If you need to have all cards (authorized or not) you have to set unauthorized to YES.
[self.client 
    searchCardWithIdentityValue:<# NSString: Identity value #> 
                           type:<# NSString: Identity type or nil #> 
                   unauthorized:<# YES or NO #> 
              completionHandler:^(NSArray<VSSCard *> * _Nullable cards, NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Error: %@",
            [error localizedDescription]);
        return;
    }
    // cards contains an array of VSSCard objects which fit given parameters.        
}];
//...
```

###### Swift
```swift
//...
// First parameter contains value of the identity associated with required card.
// Parameter type is allowed to be nil.
// In case when unauthorized = false the array of cards in callback will NOT contain cards
// which have been created with identities that haven't provided validation token.
// If you need to have all cards (authorized or not) you have to set unauthorized to true.
self.client.searchCardWithIdentityValue(<# String: Identity value #>, 
    type: <# String: Identity type or nil #>, 
    unauthorized: false) { (cards, error) in
    if error != nil {
        print("Error searching for Virgil Cards: 
            \(error!.localizedDescription)")
        return
    }
    // cards contains an array of VSSCard objects which fit given parameters.
}
//...
```

#### Revoke a Virgil Card

This operation is used to delete the Virgil Card from the search and mark it as deleted. 

###### Objective-C
```objective-c
//...
// It is not necessary to compose identity information for the 
// unauthorized Virgil Cards. Just pass nil.
VSSIdentityInfo *identity = 
    [[VSSIdentityInfo alloc] initWithType:<# NSString: Identity type #> 
                                    value:<# NSString: Identity value #> 
                          validationToken:<# NSString: Validation token #>];
[self.client deleteCardWithCardId:<# GUID: Virgil Card id #>
                identityInfo:identity // Or nil for unauthorized card.
                    privateKey:<# VSSPrivateKey: private key container #>
        completionHandler:^(NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Error: %@",
                [error localizedDescription]);
        return;
    }
    //...
}];
//...
```

###### Swift
```swift
//...
// It is not necessary to compose identity information for the 
// unauthorized Virgil Cards. Just pass nil.
let identity = VSSIdentityInfo(type: <#String: Identity type#>, 
    value: <# String: Identity value #>, validationToken: <# String: Validation token #>)
self.client.deleteCardWithCardId(<# GUID: Virgil Card id #>, 
    identityInfo: identity, // Or nil for unauthorized card.
    privateKey: <# VSSPrivateKey: private key container #>) { (error) in
    if error != nil {
        print("Error: 
            \(error!.localizedDescription)")
        return
    }
    //...
}
//...
```

#### Get a Public Key

Gets a public key from the Public Keys Service by the specified ID.

###### Objective-C
```objective-c
//...
[self.client getPublicKeyWithId:<# GUID: Public key id #> 
         completionHandler:^(VSSPublicKey * _Nullable key, NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Error getting Public key: %@", 
            [error localizedDescription]);
        return;
    }
    //...
}];
//...
```

###### Swift
```swift
//...
self.client.getPublicKeyWithId(<# GUID: Public key id #>) { (publicKey, error) in
    if error != nil {
        print("Error: \(error!.localizedDescription)")
        return
    }
    //...
}
//...
```

## Private Keys

The security of private keys is crucial for the public key cryptosystems. Anyone who can obtain a private key can use it to impersonate the rightful owner during all communications and transactions on intranets or on the internet. Therefore, private keys must be in the possession only of authorized users, and they must be protected from unauthorized use.

Virgil Security provides a set of tools and services for storing private keys in a safe storage which lets you synchronize your private keys between the devices and applications.

Usage of this service is optional.

#### Store a Private Key

Private key can be added for storage only in case you have already registered a public key on the Public Keys Service.

Use the public key identifier on the Public Keys Service to save the private keys. 

The Private Keys Service stores private keys the original way as they were transferred. That's why we strongly recommend to trasfer the keys which were generated with a password.

###### Objective-C
```objective-c
//...
[self.client 
    storePrivateKey:<# VSSPrivateKey: Private key container #> 
             cardId:<# GUID: Virgil card id #> 
  completionHandler:^(NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Error: %@",
                [error localizedDescription]);
        return;
    }
    //...
}];
//...
```

###### Swift
```swift
//...
self.client.storePrivateKey(<# VSSPrivateKey: private key container #>, 
    cardId: <# GUID: Virgil card id #>) { (error) in
    if error != nil {
        print("Error: \(error!.localizedDescription)")
        return;
    }
    //...
}
//...
```

#### Get a Private Key

To get a private key you need to pass identity information of the  Virgil Card associated with your public key. This identity information object must contain a **validation token**. To obtain the **validation token** you should use either [global way](#obtaining-a-global-validation-token) or [private way](#obtaining-a-private-validation-token) depending on your Virgil Card. 
  
###### Objective-C
```objective-c
//...
VSSIdentityInfo *identity = 
    [[VSSIdentityInfo alloc] initWithType:<# NSString: Identity type #> 
                                    value:<# NSString: Identity value #> 
                          validationToken:<# NSString: Validation token #>];
// password parameter represents a password which will be used 
// by Virgil Service to encrypt the response. 
// If this parameter is nil, VSSClient will generate password automatically. 
// This password is generated from scratch every time this request takes place. 
// VSSClient will never use the same password twice.                          
[self.client 
    getPrivateKeyWithCardId:<# GUID: Virgil Card id #> 
               identityInfo:identity 
                   password:nil 
          completionHandler:^(NSData * _Nullable keyData, GUID * _Nullable cardId, NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Error: %@", 
            [error localizedDescription]);
        return;
    }
    // keyData contains the NSData object with private key in the same form
    // as it was stored (e.g. it might be in password-protected form).
    //...
}];
//...
```

###### Swift
```swift
//...
let identity = VSSIdentityInfo(type: <# String: Identity type #>, 
    value: <# Stirng: Identity value #>, validationToken: <# String: Validation token #>)
// password parameter represents a password which will be used 
// by Virgil Service to encrypt the response. 
// If this parameter is nil, VSSClient will generate password automatically. 
// This password is generated from scratch every time this request takes place. 
// VSSClient will never use the same password twice.    
self.client.getPrivateKeyWithCardId(<# GUID: Virgil card id #>, 
    identityInfo: identity, password: nil) { (keyData, cardId, error) in
    if error != nil {
        print("Error: \(error!.localizedDescription)")
        return
    }
    // keyData contains the NSData object with private key in the same form
    // as it was stored (e.g. it might be in password-protected form).
    //...
}
//...
```

#### Destroy a Private Key

This operation deletes the private key from the service without a possibility to be restored. 
  
###### Objective-C
```objective-c
//...
[self.client 
    deletePrivateKey:<# VSSPrivateKey: private key container #> 
              cardId:<# GUID: Virgil Card id #> 
   completionHandler:^(NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Error: %@", 
            [error localizedDescription]);
        return;
    }
    //...
}];
//...
```

###### Swift
```swift
//...
self.client.deletePrivateKey(<# VSSPrivateKey: private key container #>, 
    cardId: <# GUID: Virgil Card id #>) { (error) in
    if error != nil {
        print("Error: \(error!.localizedDescription)")
        return
    }
    //...
}
//...
```

## Identities

#### Obtaining a global validation token

The *global* **validation token** is used for creating *global Cards*. The *global* **validation token** can be obtained only by checking the ownership of the Identity on Virgil Identity Service.

In the example below you can see how to obtain a **validation token** for creating a *global* Virgil Card.

###### Objective-C
```objective-c
//...
[self.client 
    verifyEmailIdentityWithValue:<# NSString: email address #> 
                     extraFields:nil 
               completionHandler:^(GUID * _Nullable actionId, NSError * _Nullable error) {
        if (error != nil) {
	        NSLog(@"Error: %@", 
	        	[error localizedDescription]);
	        return;
	    }
        // Store actionId as it is necessary to complete confirmation 
        // and get the validation token. 
}];
//...
// Get the confirmation code from the email and 
// complete the email verification procedure:
[self.client 
    confirmEmailIdentityWithActionId:<# NSString: actionId received on the previous call to verify #> 
                                code:<# NSString: Confirmation code from email #> 
                            tokenTtl:0 
                            tokenCtl:0 
                   completionHandler:^(VSSIdentityInfo * _Nullable identityInfo, NSError * _Nullable error) {
    if (error != nil) {
        NSLog(@"Error: %@", 
            [error localizedDescription]);
        return;
    }
    // Use the identityInfo object. It should contain all necessary fields,
    // including the validation token.
}];
//...
```

###### Swift
```swift
//...
self.client.verifyEmailIdentityWithValue(<# String: email address #>, 
    extraFields: nil) { (actionId, error) in
    if error != nil {
        print("Error: \(error!.localizedDescription)")
        return
    }
    
    // Store actionId as it is necessary to complete confirmation 
    // and get the validation token.
}
//...
// Get the confirmation code from the email and 
// complete the email verification procedure:
self.client.confirmEmailIdentityWithActionId(<# String: actionId received on the previous call to verify #>, 
    code: <# Confirmation code from email #>, tokenTtl: 0, tokenCtl: 0) { (identityInfo, error) in
    if error != nil {
        print("Error: \(error!.localizedDescription)")
        return
    }
     
    // Use the identityInfo object. It should contain all necessary fields,
    // including the validation token.
}
//...
```

#### Obtaining a private validation token

The *private* **validation token** is used for creating *private cards*. The *private* **validation token** can be generated on developer's side using his own service for verification instead of Virgil Identity Service or to avoid verification at all. In this case validation token is generated using app's Private Key created on our [Developer portal](https://developer.virgilsecurity.com/dashboard/).   

In the example below you can see, how to generate a **validation token** using the SDK library.

###### Objective-C
```objective-c
//...
NSError *error = nil;
NSString *validationToken = 
    [VSSValidationTokenGenerator validationTokenForIdentityType:<# NSString: Identity type #> 
                                                          value:<# NSString: Identity value #> 
                                                     privateKey:<# VSSPrivateKey: Container with app private key #> 
                                                          error:&error];
if (error != nil) {
    NSLog(@"Error: %@", [error localizedDescription]);
    return;
}
// Use validation token.
//...
```

###### Swift
```swift
//...
var validationToken: String? = nil
do {
    validationToken = try VSSValidationTokenGenerator.validationTokenForIdentityType(<# String: Identity type#>, 
        value: <# String: Identity value #>, privateKey: <# VSSPrivateKey: Container with app private key #>)
}
catch let error as NSError {
    print("Error: \(error.localizedDescription)")
}
// Use validation token
//...
```

## See Also

* [Quickstart](quickstart.md)
* [Virgil SDK API Reference](http://virgilsecurity.github.io/virgil-sdk-x/)
