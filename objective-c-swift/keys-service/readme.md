
# Vigil Keys Service - iOS SDK

- [Obtaining an Application Token](#obtaining-an-application-token)
- [Register a New User](#register-a-new-user)
- [Get a User's Public Key](#get-a-users-public-key)
- [Search a Public Key](#search-a-public-key)
- [Search a Public Key Signed](#search-a-public-key-signed)
- [Update a Public Key](#update-a-public-key)
- [Delete a Public Key](#delete-a-public-key)
- [Reset a Public Key](#reset-a-public-key)
- [Confirm a Public Key](#confirm-a-public-key)
- [Create User Data](#create-user-data)
- [Delete a User Data](#delete-a-user-data)
- [Confirm a User Data](#confirm-a-user-data)
- [Resend a User's Confirmation Code](#resend-a-users-confirmation-code)

## Obtaining an Application Token

The app token provides access to Virgil’s Services and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

1. [Create](https://api.virgilsecurity.com/signup) a free **Virgil Security** account.
2. [Sign in](https://api.virgilsecurity.com/signin) and generate a token for your application.
3. Use your app token to access Virgil Services using our iOS frameworks.

## Register a New User

:information_source:

> A Virgil Account will be created when the first Public Key is uploaded. An application can only get information about Public Keys created for the current application. When the application uploads a new Public Key and there is an Account created for another application with the same UDID, the Public Key will be implicitly attached it to the existing Account instance.

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

/// We have a key pair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
//...
/// Create a user data instance
VSSUserData *userData = [[VSSUserData alloc] initWithDataClass:UDCUserId dataType:UDTEmail value:<#Email address#>];
/// Create a public key model container
VSSPublicKey *publicKey = [[VSSPublicKey alloc] initWithKey:keyPair.publicKey userDataList:@[ userData ]];
/// Create a private key model container
VSSPrivateKey *privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey password:nil];
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient createPublicKey:publicKey privateKey:privateKey completionHandler:^(VSSPublicKey *pubKey, NSError *error) {
    if (error != nil) {
        NSLog(@"Error creating public key instance at the Virgil Keys Service: %@", [error localizedDescription]);
        return;
    }
    
    /// Public key instance created at the Virgil Keys Service and model object returned as pubKey in the callback.
}];
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have a key pair:
let keyPair = VSSKeyPair()
//...
/// Create a user data instance 
let userData = VSSUserData(dataClass: .UDCUserId, dataType: .UDTEmail, value: <#Email address#>)
/// Create a public key model container
let publicKey = VSSPublicKey(key: keyPair.publicKey(), userDataList: [userData])
/// Create a private key model container
let privateKey = VSSPrivateKey(key: keyPair.privateKey(), password: nil)
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.createPublicKey(publicKey, privateKey: privateKey) { pubKey, error in
    if error != nil {
        print("Error creating public key at the Virgil Keys Service: \(error!.localizedDescription)")
        return
    }

    /// Public key instance created at the Virgil Keys Service and model object returned as pubKey in the callback.
}
//...
```

## Get a User's Public Key

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

/// We have a key pair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
//...
/// We have some public key id
GUID* publicKeyId = <#Public Key UUID#>;
/// We have a private key container
VSSPrivateKey *privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey password:nil];
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient getPublicKeyId:publicKeyId completionHandler:^(VSSPublicKey *pubKey, NSError *error) {
    if (error != nil) {
        NSLog(@"Error getting the key from the Virgil Keys Service: '%@'", [error localizedDescription]);
        return;
    }
    
    /// Use VSSPublicKey model object returned from the service.
}];
//...
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have a key pair:
let keyPair = VSSKeyPair()
//...
/// We have a public key id
let publicKeyId =  <#Public Key UUID#>;
/// We have a private key model container
let privateKey = VSSPrivateKey(key: keyPair.privateKey(), password: nil)
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.getPublicKeyId(publicKeyId) { pubKey, error in
    if error != nil {
        print("Error getting the public key from the Virgil Keys Service: \(error!.localizedDescription)")
        return
    }
    /// Use VSSPublicKey model object returned from the service.
}
//...
```

## Search a Public Key

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

//...
/// We have some user data value
NSString* userDataValue = <#User data value#>;
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient searchPublicKeyUserIdValue:userDataValue completionHandler:^(VSSPublicKey *pubKey, NSError *error) {
    if (error != nil) {
        NSLog(@"Error searching the public key: %@", [error localizedDescription]);
        return;
    }
    
    /// Use VSSPublicKey returned from the service.
}];
//...
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have some user data value
let userDataValue =  <#User data value#>;
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.searchPublicKeyUserIdValue(userDataValue) { pubKey, error in
    if error != nil {
        print("Error searching the public key: \(error!.localizedDescription)")
        return
    }
    
    /// Use VSSPublicKey returned from the service.
}
//...
```

## Search a Public Key Signed

:information_source:

> If a signed version of the action is used, the Public Key will be returned with all of the user_data items for this Public Key.

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

//...
/// We have our public key id
GUID* publicKeyId = <#Public Key UUID#>;
/// We have our private key
VSSPrivateKey *privateKey = [[VSSPrivateKey alloc] initWithKey:<#VSSKeyPair.privateKey#>];
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient searchPublicKeyId:publicKeyId privateKey:privateKey completionHandler:^(VSSPublicKey *pubKey, NSError *error) {
    if (error != nil) {
        NSLog(@"Error searching the public key: %@", [error localizedDescription]);
        return;
    }
    
    /// Use VSSPublicKey returned from the service.
}];
//...
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have our public key id
let publicKeyId =  <#Public Key UUID#>
/// We have our private key
let privateKey = VSSPrivateKey(key: <#VSSKeyPair.privateKey()#>)
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.searchPublicKeyId(<#T##publicKeyId: String##String#>, privateKey: <#T##VSSPrivateKey#>) { pubKey, error in
    if error != nil {
        print("Error searching the public key: \(error!.localizedDescription)")
        return
    }
    
    /// Use VSSPublicKey returned from the service.
}
//...
```

## Update a Public Key

:information_source:

> Public Key modification takes place immediately after action invocation.

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

//...
/// We have our public key id
GUID* publicKeyId = <#Public Key UUID#>;
/// We have our private key
VSSPrivateKey *privateKey = [[VSSPrivateKey alloc] initWithKey:<#VSSKeyPair.privateKey#>];
/// We have a new key pair to update key with
VSSKeyPair *newKeyPair = [[VSSKeyPair alloc] initWithPassword:<#Key password or nil#>];
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient updatePublicKeyId:publicKeyId privateKey:privateKey newKeyPair:newKeyPair newKeyPassword:<#Key password or nil#> completionHandler:^(VSSPublicKey *pubKey, NSError *error) {
    if (error != nil) {
        NSLog(@"Error updating the public key: %@", [error localizedDescription]);
        return;
    }
    
    /// Use VSSPublicKey returned from the service.
}];
//...
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have our public key id
let publicKeyId =  <#Public Key UUID#>
/// We have our private key
let privateKey = VSSPrivateKey(key: <#VSSKeyPair.privateKey()#>)
/// We have a new key pair to update key with
let newKeyPair = VSSKeyPair(password: <#Key password or nil#>)
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.updatePublicKeyId(publicKeyId, privateKey: privateKey, newKeyPair: newKeyPair, newKeyPassword: <#Key password or nil#>) { pubKey, error in
    if error != nil {
        print("Error updating the public key: \(error!.localizedDescription)")
        return
    }
    
    /// Use VSSPublicKey returned from the service.
}
//...
```

## Delete a Public Key

:information_source:

> This is a signed version of the action. The Public Key will be removed immediately after invocation without any additional actions.

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

//...
/// We have our public key id
GUID* publicKeyId = <#Public Key UUID#>;
/// We have our private key
VSSPrivateKey *privateKey = [[VSSPrivateKey alloc] initWithKey:<#VSSKeyPair.privateKey#>];
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient deletePublicKeyId:publicKeyId privateKey:privateKey completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error deletion of the public key: %@", [error localizedDescription]);
        return;
    }
    
    /// Public key is deleted.
}];
//...
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have our public key id
let publicKeyId =  <#Public Key UUID#>
/// We have our private key
let privateKey = VSSPrivateKey(key: <#VSSKeyPair.privateKey()#>)
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.deletePublicKeyId(publicKeyId, privateKey: privateKey) { error in
    if error != nil {
        print("Error deletion of the public key: \(error!.localizedDescription)")
        return
    }
    
    /// Public key is deleted.
}
//...
```

## Delete a Public Key

:information_source:

> This is an unsigned version of the action, so confirmation is required. 
> The action will return an VSSActionToken object and will send confirmation tokens to all of the Public Key’s confirmed UDIDs. 
> The list of masked UDID’s will be returned in user_ids response object property. 
> To commit a Public Key deletion it is necessary to call persistPublicKeyId:... method with VSSActionToken object which contains the list of confirmation codes.

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

//...
/// We have our public key id
GUID* publicKeyId = <#Public Key UUID#>;
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient deletePublicKeyId:publicKeyId completionHandler:^(VSSActionToken *actionToken, NSError *error) {
    if (error != nil) {
        NSLog(@"Error deletion of the public key: %@", [error localizedDescription]);
        return;
    }
    
    /// Public key deletion should be confirmed using returned VSSActionToken.
}];
//...
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have our public key id
let publicKeyId =  <#Public Key UUID#>
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.deletePublicKeyId(publicKeyId) { actionToken, error in
    if error != nil {
        print("Error deletion of the public key: \(error!.localizedDescription)")
        return
    }
    
   /// Public key deletion should be confirmed using returned VSSActionToken.
}
//...
```

## Reset a Public Key

:information_source:

> After an invocation the user will receive the confirmation tokens on all his confirmed UDIDs. 
> The Public Key data won’t be updated until the call persistPublicKeyId:... is made with the token value from this step and confirmation codes sent to UDIDs. 

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

//...
/// We have our public key id
GUID* publicKeyId = <#Public Key UUID#>;
/// We have a new key pair to reset key with
VSSKeyPair *newKeyPair = [[VSSKeyPair alloc] initWithPassword:<#Key password or nil#>];
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient resetPublicKeyId:publicKeyId keyPair:newKeyPair keyPassword:<#Key password or nil#> completionHandler:^(VSSActionToken *actionToken, NSError *error) {
    if (error != nil) {
        NSLog(@"Error resetting public key: %@", [error localizedDescription]);
        return;
    }
    
    /// Use action token to confirm the process.
}];
//...
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have our public key id
let publicKeyId =  <#Public Key UUID#>
/// We have a new key pair to reset key with
let newKeyPair = VSSKeyPair(password:<#Key password or nil#>)
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.resetPublicKeyId(publicKeyId, keyPair: newKeyPair, keyPassword: <#Key password or nil#>) { actionToken, error in
    if error != nil {
        print("Error resetting public key: \(error!.localizedDescription)")
        return
    }
    
    /// Use action token to confirm the process.
}
//...
```

## Confirm a Public Key

:information_source:

> The confirmation code will be sent to the email/phone etc. Usually the client application should provide opportunities for collecting the appropriate confirmation codes.

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

//...
/// We have our public key id
GUID* publicKeyId = <#Public Key UUID#>;
/// When some important action is taking place (e.g. reset of the public key)
/// Virgil Keys Service will send VSSActionToken instance in response. 
/// This object will contain action token id and user data values list which should be confirmed with a token.
/// Virgil Keys Service will send the token code to each of these user data.
actionToken.confirmationCodeList = <#Array with confirmation tokens for each user data in this action token#>;
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient persistPublicKeyId:publicKeyId actionToken:actionToken completionHandler:^(VSSPublicKey *pubKey, NSError *error) {
    if (error != nil) {
        NSLog(@"Error confirmation the public key: %@", [error localizedDescription]);
        return;
    }
    
    /// Success. Use new VSSPublicKey.
}];
//...
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have our public key id
let publicKeyId =  <#Public Key UUID#>
/// When some important action is taking place (e.g. reset of the public key)
/// Virgil Keys Service will send VSSActionToken instance in response. 
/// This object will contain action token id and user data values list which should be confirmed with a token.
/// Virgil Keys Service will send the token code to each of these user data.
actionToken.confirmationCodeList = <#Array with confirmation tokens for each user data in this action token#>;
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.persistPublicKeyId(publicKeyId, actionToken: actionToken) { pubKey, error in
    if error != nil {
        print("Error confirmation public key: \(error!.localizedDescription)")
        return
    }
    
    /// Success. Use new VSSPublicKey.
}
//...
```

## Create User Data

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

//...
/// We have our keyPair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
//...
/// Create new user data candidate object which we want to add to the public key.
VSSUserData *userData = [[VSSUserData alloc] initWithDataClass:<#User data class#> dataType:<#User data type#> value:<#User data value#>];
/// We have our public key id
GUID *publicKeyId = <#Public key UUID#>;
/// We have our private key
VSSPrivateKey *privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey password:nil];
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient createUserData:userData publicKeyId:publicKeyId privateKey:privateKey completionHandler:^(VSSUserDataExtended *uData, NSError *error) {
    if (error != nil) {
        NSLog(@"Error adding the user data: %@", [error localizedDescription]);
        return;
    }
    
    /// Returned object is instance of VSSUserDataExtended class, which contains also id bundle and confirmed/not confirmed flag.
}];
//...
```
        
##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have our keyPair
let keyPair = VSSKeyPair()
//...
/// Create new user data candidate object which we want to add to the public key.
let userData = VSSUserData(dataClass: <#User data class#>, dataType: <#User data type#>, value: <#User data value#>)
/// We have our public key id
let publicKeyId = <#Public key UUID#>
/// We have our private key
let privateKey = VSSPrivateKey(key: keyPair.privateKey(), password: nil)
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.createUserData(userData, publicKeyId: publicKeyId, privateKey: privateKey) { uDataEx, error in
    if error != nil {
        print("Error creating the user data: \(error!.localizedDescription)")
        return
    }
    
    /// Returned object is instance of VSSUserDataExtended class, which contains also id bundle and confirmed/not confirmed flag.
}
//...
```

## Delete a User Data

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

//...
/// We have our keyPair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
//...
/// We have our user data id
NSString *userDataId = <#User data UUID#>;
/// We have our public key id
GUID *publicKeyId = <#Public key UUID#>;
/// We have our private key
VSSPrivateKey *privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey password:nil];
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient deleteUserDataId:userDataId publicKeyId:publicKeyId privateKey:privateKey completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error deletion the user data: %@", [error localizedDescription]);
        return;
    }
    
    /// User data is successfully deleted.
}];
//...
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have our keyPair
let keyPair = VSSKeyPair()
//...
/// We have our user data id
let userDataId = <#User data UUID#>
/// We have our public key id
let publicKeyId = <#Public key UUID#>
/// We have our private key
let privateKey = VSSPrivateKey(key: keyPair.privateKey(), password: nil)
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.deleteUserDataId(userDataId, publicKeyId: publicKeyId, privateKey: privateKey) { error in
    if error != nil {
        print("Error deletion the user data: \(error!.localizedDescription)")
        return
    }
    
    /// User data is successfully deleted.
}
//...
```

## Confirm a User Data

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

//...
/// We have our user data id
NSString *userDataId = <#User data UUID#>;
/// We have user data confirmation token code
NSString *code = <#Confirmation code#>;
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient persistUserDataId:userDataId confirmationCode:code completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error confirmation the user data: %@", [error localizedDescription]);
        return;
    }
    
    /// User data is now confirmed and can be used for any activities.
}];
//...
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have our user data id
let userDataId = <#User data UUID#>
/// We have user data confirmation token code
let code = <#Confirmation code#>
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.persistUserDataId(userDataId, confirmationCode: code) { error in
    if error != nil {
        print("Error confirmation the user data: \(error!.localizedDescription)")
        return
    }
    
    /// User data is now confirmed and can be used for any activities.
}
//...
```

## Resend a User's Confirmation Code

##### Objective-C:
```objective-c
//...
#import <VirgilKeysiOS/VirgilKeysiOS.h>
//...
@property (nonatomic, strong) VSSKeysClient *keysClient;
//...

//...
/// We have our keyPair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
//...
/// We have our user data id
NSString *userDataId = <#User data UUID#>;
/// We have our public key id
GUID *publicKeyId = <#Public key UUID#>;
/// We have our private key
VSSPrivateKey *privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey password:nil];
/// Create network client instance
self.keysClient = [[VSSKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#>];
/// Make the request
[self.keysClient resendConfirmationUserDataId:userDataId publicKeyId:publicKeyId privateKey:privateKey completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error sending confirmation code: %@", [error localizedDescription]);
        return;
    }
    
    /// Confirmation code has been sent to the specified user data.
}];
//...
```

##### Swift:
```swift
//...
private var keysClient: VSSKeysClient! = nil
//...
/// We have our keyPair
let keyPair = VSSKeyPair()
//...
/// We have our user data id
let userDataId = <#User data UUID#>
/// We have our public key id
let publicKeyId = <#Public key UUID#>
/// We have our private key
let privateKey = VSSPrivateKey(key: keyPair.privateKey(), password: nil)
/// Create network client instance for Virgil Keys Service
self.keysClient = VSSKeysClient(applicationToken: <#Virgil Application Token#>)
/// Make the request
self.keysClient.resendConfirmationUserDataId(userDataId, publicKeyId:publicKeyId, privateKey: privateKey) { error in
    if error != nil {
        print("Error sending confirmation code: \(error!.localizedDescription)")
        return
    }
    
    /// Confirmation code has been sent to the specified user data.
}
//...
```
</div>
</div>

<div class="col-md-12 col-md-offset-2 hidden-md hidden-xs hidden-sm">
<div class="docs-menu" data-ui="affix-docs">

<div class="menu-items-wrapper" data-ui="menu-items-wrapper"></div>
</div>
</div>
</div>
</div>
</section>
