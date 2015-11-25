# Virgil Private Keys Service iOS SDK

- [Obtaining an Application Token](#obtaining-an-application-token)
- [Create a New Container](#create-a-new-container)
- [Get a Container](#get-a-container)
- [Delete a Container](#delete-a-container)
- [Update a Container](#update-a-container)
- [Reset a Container Password](#reset-a-container-password)
- [Persist a Container](#persist-a-container)
- [Create a Private Key](#create-a-private-key)
- [Get a Private Key](#get-a-private-key)
- [Delete a Private Key](#delete-a-private-key)

## Obtaining an Application Token

The app token provides access to Virgil’s Services and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

1. [Create](https://api.virgilsecurity.com/signup) a free **Virgil Security** account.
2. [Sign in](https://api.virgilsecurity.com/signin) and generate a token for your application.
3. Use your app token to access Virgil Services using our iOS frameworks.

:warning:

> Before any request is made to the Virgil Private Keys Service the following points should be done:

> The Virgil Security Application Token should be get, please follow the [Obtaining an Application Token](#obtaining-an-application-token) section above.

> The Private and Public Keys should be created using VSSKeyPair.

> The Public Key should be created at the Virgil Keys Service and its User Data object(s) should be confirmed.

> The same User Data (typically, email address) that has been used (and confirmed) for the Virgil Public Keys Service should be used for the Virgil Private Keys Service.

## Create a New Container

##### Objective-C:
```objective-c
//...
#import <VirgilPrivateKeysiOS/VirgilPrivateKeysiOS.h>
//...
@property (nonatomic, strong) VSSPrivateKeysClient *privateKeysClient;
//...

//...
/// We have our keyPair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
//...
/// We have our user data
VSSUserData *userData = [[VSSUserData alloc] initWithDataClass:<#User data class#> dataType:<#User data type#> value:<#User data value#>];
/// Compose credentials for the Virgil Private Keys Service
VSSCredentials *credentials = [[VSSCredentials alloc] initWithUserData:userData password:<#User password#>];
/// Create a client
self.privateKeysClient = [[VSSPrivateKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#> credentials:credentials];
/// We have our public key id
GUID *publicKeyId = <#Public Key UUID#>;
/// We have our private key
VSSPrivateKey* privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey];
/// Compose container details
VSSContainer *container = [[VSSContainer alloc] initWithContainerType:CTEasy];
/// Make a request
[self.privateKeysClient initializeContainer:container publicKeyId:publicKeyId privateKey:privateKey completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error creating the private keys container: %@", [error localizedDescription]);
        return;
    }
    
    /// Container has been created.
}];
//...
```

##### Swift:
```swift
//...
private var privateKeysClient: VSSPrivateKeysClient! = nil
//...
/// We have our key pair
let keyPair = VSSKeyPair()
/// We have our user data
let userData = VSSUserData(dataClass: <#User data class#>, dataType: <#User data type#>, value: <#User data value#>)
/// Compose credentials for the Virgil Private Keys Service
let credentials = VSSCredentials(userData: userData, password: <#User password#>)
/// Create a client
self.privateKeysClient = VSSPrivateKeysClient(applicationToken: <#Virgil Application Token#>, credentials: credentials)
/// We have our public key id
let publicKeyId = <#Public Key UUID#>
/// We have our private key
let privateKey = VSSPrivateKey(key: keyPair.privateKey())
/// Compose container details 
let container = VSSContainer(containerType: .CTEasy)
/// Make a request
self.privateKeysClient.initializeContainer(container, publicKeyId: publicKeyId, privateKey: privateKey) { error in
    if error != nil {
        print("Error creating the private keys container: \(error!.localizedDescription)")
        return
    }
    
    /// Container has been created.
}
//...
```

## Get a Container

##### Objective-C:
```objective-c
//...
#import <VirgilPrivateKeysiOS/VirgilPrivateKeysiOS.h>
//...
@property (nonatomic, strong) VSSPrivateKeysClient *privateKeysClient;
//...

/// We have our user data
VSSUserData *userData = [[VSSUserData alloc] initWithDataClass:<#User data class#> dataType:<#User data type#> value:<#User data value#>];
/// Compose credentials for the Virgil Private Keys Service
VSSCredentials *credentials = [[VSSCredentials alloc] initWithUserData:userData password:<#User password#>];
/// Create a client
self.privateKeysClient = [[VSSPrivateKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#> credentials:credentials];
/// We have our public key id
GUID *publicKeyId = <#Public Key UUID#>;
/// Make a request
[self.privateKeysClient getContainerDetailsPublicKeyId:publicKeyId completionHandler:^(VSSContainer *details, NSError *error) {
    if (error != nil) {
        NSLog(@"Error getting the private keys container details: %@", [error localizedDescription]);
        return;
    }
    
    /// Use VSSContainer returned from the service.
}];
//...
```

##### Swift:
```swift
//...
private var privateKeysClient: VSSPrivateKeysClient! = nil
//...
/// We have our user data
let userData = VSSUserData(dataClass: <#User data class#>, dataType: <#User data type#>, value: <#User data value#>)
/// Compose credentials for the Virgil Private Keys Service
let credentials = VSSCredentials(userData: userData, password: <#User password#>)
/// Create a client
self.privateKeysClient = VSSPrivateKeysClient(applicationToken: <#Virgil Application Token#>, credentials: credentials)
/// We have our public key id
let publicKeyId = <#Public Key UUID#>
/// Make a request
self.privateKeysClient.getContainerDetailsPublicKeyId(publicKeyId) { details, error in
    if error != nil {
        print("Error getting the private keys container details: \(error!.localizedDescription)")
        return
    }
    
    /// Use VSSContainer returned from the service.
}
//...
```

## Delete a Container

##### Objective-C:
```objective-c
//...
#import <VirgilPrivateKeysiOS/VirgilPrivateKeysiOS.h>
//...
@property (nonatomic, strong) VSSPrivateKeysClient *privateKeysClient;
//...

//...
/// We have our keyPair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
//...
/// We have our user data
VSSUserData *userData = [[VSSUserData alloc] initWithDataClass:<#User data class#> dataType:<#User data type#> value:<#User data value#>];
/// Compose credentials for the Virgil Private Keys Service
VSSCredentials *credentials = [[VSSCredentials alloc] initWithUserData:userData password:<#User password#>];
/// Create a client
self.privateKeysClient = [[VSSPrivateKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#> credentials:credentials];
/// We have our public key id
GUID *publicKeyId = <#Public Key UUID#>;
/// We have our private key
VSSPrivateKey* privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey];
/// Make a request
[self.privateKeysClient deleteContainerPublicKeyId:publicKeyId privateKey:privateKey completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error deletion of the private keys container: %@", [error localizedDescription]);
        return;
    }
    
    /// Container has been deleted without any required confirmation.
}];
//...
```

##### Swift:
```swift
//...
private var privateKeysClient: VSSPrivateKeysClient! = nil
//...
/// We have our key pair
let keyPair = VSSKeyPair()
/// We have our user data
let userData = VSSUserData(dataClass: <#User data class#>, dataType: <#User data type#>, value: <#User data value#>)
/// Compose credentials for the Virgil Private Keys Service
let credentials = VSSCredentials(userData: userData, password: <#User password#>)
/// Create a client
self.privateKeysClient = VSSPrivateKeysClient(applicationToken: <#Virgil Application Token#>, credentials: credentials)
/// We have our public key id
let publicKeyId = <#Public Key UUID#>
/// We have our private key
let privateKey = VSSPrivateKey(key: keyPair.privateKey())
/// Make a request
self.privateKeysClient.deleteContainerPublicKeyId(publicKeyId, privateKey: privateKey) { error in
    if error != nil {
        print("Error deletion of the private keys container: \(error!.localizedDescription)")
        return
    }
    
    /// Container has been deleted without any required confirmation.
}
//...
```

## Update a Container

##### Objective-C:
```objective-c
//...
#import <VirgilPrivateKeysiOS/VirgilPrivateKeysiOS.h>
//...
@property (nonatomic, strong) VSSPrivateKeysClient *privateKeysClient;
//...

//...
/// We have our keyPair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
//...
/// We have our user data
VSSUserData *userData = [[VSSUserData alloc] initWithDataClass:<#User data class#> dataType:<#User data type#> value:<#User data value#>];
/// Compose credentials for the Virgil Private Keys Service
VSSCredentials *credentials = [[VSSCredentials alloc] initWithUserData:userData password:<#User password#>];
/// Create a client
self.privateKeysClient = [[VSSPrivateKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#> credentials:credentials];
/// We have our public key id
GUID *publicKeyId = <#Public Key UUID#>;
/// We have our private key
VSSPrivateKey* privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey];
/// Compose container details
VSSContainer *newContainer = [[VSSContainer alloc] initWithContainerType:CTEasy];
/// Make a request
[self.privateKeysClient updateContainerDetails:mewContainer password:<#New user password#> publicKeyId:publicKeyId privateKey:privateKey completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error updating the private keys container details: %@", [error localizedDescription]);
        return;
    }
    
    /// Container details has been updated.
}];
//...
```

##### Swift:
```swift
//...
private var privateKeysClient: VSSPrivateKeysClient! = nil
//...
/// We have our key pair
let keyPair = VSSKeyPair()
/// We have our user data
let userData = VSSUserData(dataClass: <#User data class#>, dataType: <#User data type#>, value: <#User data value#>)
/// Compose credentials for the Virgil Private Keys Service
let credentials = VSSCredentials(userData: userData, password: <#User password#>)
/// Create a client
self.privateKeysClient = VSSPrivateKeysClient(applicationToken: <#Virgil Application Token#>, credentials: credentials)
/// We have our public key id
let publicKeyId = <#Public Key UUID#>
/// We have our private key
let privateKey = VSSPrivateKey(key: keyPair.privateKey())
/// Compose container details 
let newCcontainer = VSSContainer(containerType: .CTEasy)
/// Make a request
self.privateKeysClient.updateContainerDetails(newContainer, password:<#New user password#>, publicKeyId: publicKeyId, privateKey: privateKey) { error in
    if error != nil {
        print("Error updating the private keys container details: \(error!.localizedDescription)")
        return
    }
    
    /// Container details has been updated.
}
//...
```

## Reset a Container Password

:information_source:

> A user can reset his/her Private Key Container password only if the Container Type is Easy.

##### Objective-C:
```objective-c
//...
#import <VirgilPrivateKeysiOS/VirgilPrivateKeysiOS.h>
//...
@property (nonatomic, strong) VSSPrivateKeysClient *privateKeysClient;
//...

/// We have our user data
VSSUserData *userData = [[VSSUserData alloc] initWithDataClass:<#User data class#> dataType:<#User data type#> value:<#User data value#>];
/// Compose credentials for the Virgil Private Keys Service
VSSCredentials *credentials = [[VSSCredentials alloc] initWithUserData:userData password:<#User password#>];
/// Create a client
self.privateKeysClient = [[VSSPrivateKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#> credentials:credentials];
/// Make a request
[self.privateKeysClient resetContainerPassword:<#New password#> completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error resetting the private keys container: %@", [error localizedDescription]);
        return;
    }
    
    /// A token has been sent to the user data associated with the public key of the user.
    /// To complete the reset of the password it is necessary to call persistContainerChangesToken:...
}];
//...
```

##### Swift:
```swift
//...
private var privateKeysClient: VSSPrivateKeysClient! = nil
//...
/// We have our user data
let userData = VSSUserData(dataClass: <#User data class#>, dataType: <#User data type#>, value: <#User data value#>)
/// Compose credentials for the Virgil Private Keys Service
let credentials = VSSCredentials(userData: userData, password: <#User password#>)
/// Create a client
self.privateKeysClient = VSSPrivateKeysClient(applicationToken: <#Virgil Application Token#>, credentials: credentials)
/// Make a request
self.privateKeysClient.resetContainerPassword(<#New password#>) { error in
    if error != nil {
        print("Error resetting the private keys container: \(error!.localizedDescription)")
        return
    }
    
    /// A token has been sent to the user data associated with the public key of the user.
    /// To complete the reset of the password it is necessary to call persistContainerChangesToken(...)
}
//...
```

## Persist a Container

##### Objective-C:
```objective-c
//...
#import <VirgilPrivateKeysiOS/VirgilPrivateKeysiOS.h>
//...
@property (nonatomic, strong) VSSPrivateKeysClient *privateKeysClient;
//...

/// We have our user data
VSSUserData *userData = [[VSSUserData alloc] initWithDataClass:<#User data class#> dataType:<#User data type#> value:<#User data value#>];
/// Compose credentials for the Virgil Private Keys Service
VSSCredentials *credentials = [[VSSCredentials alloc] initWithUserData:userData password:<#User password#>];
/// Create a client
self.privateKeysClient = [[VSSPrivateKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#> credentials:credentials];
/// Make a request
[self.privateKeysClient persistContainerChangesToken:<#Confirmation token code#> completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error saving the private keys container changes: %@", [error localizedDescription]);
        return;
    }
    
    /// Changes commited successfully.
}];
//...
```

##### Swift:
```swift
//...
private var privateKeysClient: VSSPrivateKeysClient! = nil
//...
/// We have our user data
let userData = VSSUserData(dataClass: <#User data class#>, dataType: <#User data type#>, value: <#User data value#>)
/// Compose credentials for the Virgil Private Keys Service
let credentials = VSSCredentials(userData: userData, password: <#User password#>)
/// Create a client
self.privateKeysClient = VSSPrivateKeysClient(applicationToken: <#Virgil Application Token#>, credentials: credentials)
/// Make a request
self.privateKeysClient.persistContainerChangesToken(<#Confirmation token code#>) { error in
    if error != nil {
        print("Error saving the private keys container changes: \(error!.localizedDescription)")
        return
    }
    
    /// Changes commited successfully.
}
//...
```

## Create a Private Key

##### Objective-C:
```objective-c
//...
#import <VirgilPrivateKeysiOS/VirgilPrivateKeysiOS.h>
//...
@property (nonatomic, strong) VSSPrivateKeysClient *privateKeysClient;
//...

//...
/// We have our keyPair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
//...
/// We have our user data
VSSUserData *userData = [[VSSUserData alloc] initWithDataClass:<#User data class#> dataType:<#User data type#> value:<#User data value#>];
/// Compose credentials for the Virgil Private Keys Service
VSSCredentials *credentials = [[VSSCredentials alloc] initWithUserData:userData password:<#User password#>];
/// Create a client
self.privateKeysClient = [[VSSPrivateKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#> credentials:credentials];
/// We have our public key id
GUID *publicKeyId = <#Public Key UUID#>;
/// We have our private key
VSSPrivateKey* privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey];
/// Make a request
[self.privateKeysClient pushPrivateKeyPublicKeyId:publicKeyId privateKey:privateKey password:<#Password in case of Normal container type or nil otherwise#> completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error adding the private key to the container: %@", [error localizedDescription]);
        return;
    }
    
    /// Private key has been added successfully.
}];
//...
```

##### Swift:
```swift
//...
private var privateKeysClient: VSSPrivateKeysClient! = nil
//...
/// We have our key pair
let keyPair = VSSKeyPair()
/// We have our user data
let userData = VSSUserData(dataClass: <#User data class#>, dataType: <#User data type#>, value: <#User data value#>)
/// Compose credentials for the Virgil Private Keys Service
let credentials = VSSCredentials(userData: userData, password: <#User password#>)
/// Create a client
self.privateKeysClient = VSSPrivateKeysClient(applicationToken: <#Virgil Application Token#>, credentials: credentials)
/// We have our public key id
let publicKeyId = <#Public Key UUID#>
/// We have our private key
let privateKey = VSSPrivateKey(key: keyPair.privateKey())
/// Make a request
self.privateKeysClient.pushPrivateKeyPublicKeyId(publicKeyId, privateKey: privateKey, password: <#Password in case of Normal container type or nil otherwise#>) { error in
    if error != nil {
        print("Error adding the private key to the container: \(error!.localizedDescription)")
        return;
    }
    
    /// Private key has been added successfully.
}
//...
```

## Get a Private Key

##### Objective-C:
```objective-c
//...
#import <VirgilPrivateKeysiOS/VirgilPrivateKeysiOS.h>
//...
@property (nonatomic, strong) VSSPrivateKeysClient *privateKeysClient;
//...

/// We have our user data
VSSUserData *userData = [[VSSUserData alloc] initWithDataClass:<#User data class#> dataType:<#User data type#> value:<#User data value#>];
/// Compose credentials for the Virgil Private Keys Service
VSSCredentials *credentials = [[VSSCredentials alloc] initWithUserData:userData password:<#User password#>];
/// Create a client
self.privateKeysClient = [[VSSPrivateKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#> credentials:credentials];
/// We have our public key id
GUID *publicKeyId = <#Public Key UUID#>;
/// Make a request
[self.privateKeysClient getPrivateKeyPublicKeyId:publicKeyId password:<#Password in case of Normal container type or nil otherwise#> completionHandler:^(NSData *keyData, NSError *error) {
    if (error != nil) {
        NSLog(@"Error getting the private key from the container: %@", [error localizedDescription]);
        return;
    }

    /// Use returned keyData as decrypted data containing the private key.
}];
//...
```

##### Swift:
```swift
//...
private var privateKeysClient: VSSPrivateKeysClient! = nil
//...
/// We have our user data
let userData = VSSUserData(dataClass: <#User data class#>, dataType: <#User data type#>, value: <#User data value#>)
/// Compose credentials for the Virgil Private Keys Service
let credentials = VSSCredentials(userData: userData, password: <#User password#>)
/// Create a client
self.privateKeysClient = VSSPrivateKeysClient(applicationToken: <#Virgil Application Token#>, credentials: credentials)
/// We have our public key id
let publicKeyId = <#Public Key UUID#>
/// Make a request
self.privateKeysClient.getPrivateKeyPublicKeyId(publicKeyId, password: <#Password in case of Normal container type or nil otherwise#>) { keyData, error in
    if error != nil {
        print("Error getting the private key from the container: \(error!.localizedDescription)")
        return
    }
    
    /// Use returned keyData as decrypted data containing the private key.
}
//...
```

## Delete a Private Key

##### Objective-C:
```objective-c
//...
#import <VirgilPrivateKeysiOS/VirgilPrivateKeysiOS.h>
//...
@property (nonatomic, strong) VSSPrivateKeysClient *privateKeysClient;
//...

//...
/// We have our keyPair
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
//...
/// We have our user data
VSSUserData *userData = [[VSSUserData alloc] initWithDataClass:<#User data class#> dataType:<#User data type#> value:<#User data value#>];
/// Compose credentials for the Virgil Private Keys Service
VSSCredentials *credentials = [[VSSCredentials alloc] initWithUserData:userData password:<#User password#>];
/// Create a client
self.privateKeysClient = [[VSSPrivateKeysClient alloc] initWithApplicationToken:<#Virgil Application Token#> credentials:credentials];
/// We have our public key id
GUID *publicKeyId = <#Public Key UUID#>;
/// We have our private key
VSSPrivateKey* privateKey = [[VSSPrivateKey alloc] initWithKey:keyPair.privateKey];
/// Make a request
[self.privateKeysClient deletePrivateKeyPublicKeyId:publicKeyId privateKey:privateKey completionHandler:^(NSError *error) {
    if (error != nil) {
        NSLog(@"Error deletion the private key from the container: %@", [error localizedDescription]);
        return;
    }
    
    /// Private key has been deleted.
}];
//...
```

##### Swift:
```swift
//...
private var privateKeysClient: VSSPrivateKeysClient! = nil
//...
/// We have our key pair
let keyPair = VSSKeyPair()
/// We have our user data
let userData = VSSUserData(dataClass: <#User data class#>, dataType: <#User data type#>, value: <#User data value#>)
/// Compose credentials for the Virgil Private Keys Service
let credentials = VSSCredentials(userData: userData, password: <#User password#>)
/// Create a client
self.privateKeysClient = VSSPrivateKeysClient(applicationToken: <#Virgil Application Token#>, credentials: credentials)
/// We have our public key id
let publicKeyId = <#Public Key UUID#>
/// We have our private key
let privateKey = VSSPrivateKey(key: keyPair.privateKey())
/// Make a request
self.privateKeysClient.deletePrivateKeyPublicKeyId(publicKeyId, privateKey: privateKey) { error in
    if error != nil {
        print("Error deletion the private key from the container: \(error!.localizedDescription)")
        return
    }
    
    /// Private key has been deleted.
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
</div>
