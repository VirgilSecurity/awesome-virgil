
# Virgil Crypto iOS SDK

- [Generate Keys](#generate-keys)
- [Encrypt and Decrypt data using password](#encrypt-and-decrypt-data-using-password)
- [Encrypt and Decrypt data using Key](#encrypt-and-decrypt-data-using-key)
	- [Encrypt and Decrypt data using Key with password](#encrypt-and-decrypt-data-using-key-with-password)
	- [Encrypt and Decrypt data using Key without password](#encrypt-and-decrypt-data-using-key-without-password)
- [Sign and Verify data using Key](#sign-and-verify-data-using-key)
	- [Sign and Verify data using Key with password](#sign-and-verify-data-using-key-with-password)
	- [Sign and Verify data using Key without password](#sign-and-verify-data-using-key-without-password)
	
## Generate keys

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

## Encrypt and Decrypt data using password

##### Objective-C
```objective-c
//...
#import <VirgilCryptoiOS/VirgilCryptoiOS.h>
//...

NSString *password = <#Password to encrypt/decrypt data with#>;
// Assuming that we have some initial string message.
NSString *message = @"This is a secret message which should be encrypted with password-based encryption.";
// Convert it to the NSData
NSData *toEncrypt = [message dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
// Assuming that we have some key pair generated earlier.
// Create a new VSSCryptor instance
VSSCryptor *cryptor = [[VSSCryptor alloc] init];
// Now we should add a password recepient
[cryptor addPasswordRecipient:password];
// And now we can encrypt the plain data
NSData *encryptedData = [cryptor encryptData:toEncrypt embedContentInfo:@YES];
// After data has been encrypted it is possible to decrypt it
// Let's use another instance of VSSCryptor
VSSCryptor *decryptor = [[VSSCryptor alloc] init];
// Decrypt data
NSData* decryptedData = [decryptor decryptData:encryptedData password:password];
// Compose initial message from the plain decrypted data
NSString *initialMessage = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding]; 
```

##### Swift
```swift
//...
let password = <#Password to encrypt/decrypt data with#>;
// Assuming that we have some initial string message.
let message = NSString(string: "This is a secret message which should be encrypted.")
// Convert it to the NSData
let toEncrypt = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
// Create a cryptor instance
let cryptor = VSSCryptor()
// Add a password recepient to enable password-based encryption
cryptor.addPasswordRecipient(password)
// Encrypt the data
let encryptedData = cryptor.encryptData(toEncrypt, embedContentInfo: true)
// After data has been encrypted it is possible to decrypt it
if let encData = encryptedData {
    // Let's use another instance of VSSCryptor
    let decryptor = VSSCryptor()
    // Decrypt data
    // Assume that encrypted data actually exist and not nil 
    let plainData = decryptor.decryptData(encData, password:password)
    // Compose initial message from the plain decrypted data
    if let data = plainData {
	   var initialMessage = NSString(data: data, encoding: NSUTF8StringEncoding)
    }
}
//...
```

## Encrypt and Decrypt data using Key

### Encrypt and Decrypt data using Key with password

##### Objective-C
```objective-c
//...
#import <VirgilCryptoiOS/VirgilCryptoiOS.h>
//...

// Password for private key:
NSString *keyPassword = <#Password for protecting private key#>;
// Key pair is generated using the password
VSSKeyPair *keyPair = [[VSSKeyPair alloc] initWithPassword:keyPassword];
//...
// Assuming that we have some initial string message.
NSString *message = @"This is a secret message which should be encrypted.";
// Convert it to the NSData
NSData *toEncrypt = [message dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
// Assuming that we have some key pair generated earlier.
// Create a new VSSCryptor instance
VSSCryptor *cryptor = [[VSSCryptor alloc] init];
// Now we should add a key recepient
[cryptor addKeyRecepient:<#Public Key ID (e.g. UUID)#> publicKey:keyPair.publicKey];
// And now we can easily encrypt the plain data
NSData *encryptedData = [cryptor encryptData:toEncrypt embedContentInfo:@YES];
// Create a decryptor VSSCryptor instance
VSSCryptor *decryptor = [[VSSCryptor alloc] init];
// Decrypt data
NSData *plainData = [decryptor decryptData:encryptedData publicKeyId:<#Public Key ID (e.g. UUID)#> privateKey:keyPair.privateKey keyPassword:keyPassword];
// Compose initial message from the plain decrypted data
NSString *initialMessage = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
```

##### Swift
```swift
//...

// Password for private key:
let keyPassword = <#Password for protecting private key#>
// Key pair is generated using the password
let keyPair = VSSKeyPair(password:keyPassword)
//... 
// Assuming that we have some initial string message.
let message = NSString(string: "This is a secret message which should be encrypted.")
// Convert it to the NSData
let toEncrypt = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
// Assuming that we have some key pair generated earlier.
// Create a new VSSCryptor instance
let cryptor = VSSCryptor()
// Now we should add a key recepient
cryptor.addKeyRecepient(<#Public Key ID (e.g. UUID)#>, publicKey:keyPair.publicKey())
// And now we can easily encrypt the plain data
var encryptedData = cryptor.encryptData(toEncrypt, embedContentInfo: true)
if let encData = encryptedData {
    // Create a new VSSCryptor instance
    let decryptor = VSSCryptor()
    // Decrypt data
    var plainData = decryptor.decryptData(encData, publicKeyId: <#Public Key ID (e.g. UUID)#>, privateKey: keyPair.privateKey(), keyPassword: keyPassword)
    // Compose initial message from the plain decrypted data
    if let data = plainData {
	   var initialMessage = NSString(data: data, encoding: NSUTF8StringEncoding)
    }
}
//...
```

### Encrypt and Decrypt data using Key without password

##### Objective-C
```objective-c
//...
#import <VirgilCryptoiOS/VirgilCryptoiOS.h>
//...

// Key pair is generated without a password
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init];
//...
// Assuming that we have some initial string message.
NSString *message = @"This is a secret message which should be encrypted.";
// Convert it to the NSData
NSData *toEncrypt = [message dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
// Assuming that we have some key pair generated earlier.
// Create a new VSSCryptor instance
VSSCryptor *cryptor = [[VSSCryptor alloc] init];
// Now we should add a key recepient
[cryptor addKeyRecepient:<#Public Key ID (e.g. UUID)#> publicKey:keyPair.publicKey];
// And now we can easily encrypt the plain data
NSData *encryptedData = [cryptor encryptData:toEncrypt embedContentInfo:@YES];
// Create a decryptor VSSCryptor instance
VSSCryptor *decryptor = [[VSSCryptor alloc] init];
// Decrypt data
NSData *plainData = [decryptor decryptData:encryptedData publicKeyId:<#Public Key ID (e.g. UUID)#> privateKey:keyPair.privateKey keyPassword:nil];
// Compose initial message from the plain decrypted data
NSString *initialMessage = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
```

##### Swift
```swift
//...

// Key pair is generated without a password
let keyPair = VSSKeyPair()
//... 
// Assuming that we have some initial string message.
let message = NSString(string: "This is a secret message which should be encrypted.")
// Convert it to the NSData
let toEncrypt = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
// Assuming that we have some key pair generated earlier.
// Create a new VSSCryptor instance
let cryptor = VSSCryptor()
// Now we should add a key recepient
cryptor.addKeyRecepient(<#Public Key ID (e.g. UUID)#>, publicKey:keyPair.publicKey())
// And now we can easily encrypt the plain data
var encryptedData = cryptor.encryptData(toEncrypt, embedContentInfo: true)
if let encData = encryptedData {
    // Create a new VSSCryptor instance
    let decryptor = VSSCryptor()
    // Decrypt data
    var plainData = decryptor.decryptData(encData, publicKeyId: <#Public Key ID (e.g. UUID)#>, privateKey: keyPair.privateKey(), keyPassword: nil)
    // Compose initial message from the plain decrypted data
    if let data = plainData {
	   var initialMessage = NSString(data: data, encoding: NSUTF8StringEncoding)
    }
}
//...
```

## Sign and Verify data using Key

Although it is possible to send an encrypted message to some particular recipient, it is still important to make the recepient sure that this encrypted message is sent exactly by you. This can be achieved with a concept of a signatures. 

Signature is basically a piece of data which is composed using a particular user's private key and it can be validated (or verified) later using this user's public key.

### Sign and Verify data using Key with password

##### Objective-C
```objective-c
//...
#import <VirgilCryptoiOS/VirgilCryptoiOS.h>
//...

// Password for private key:
NSString *keyPassword = <#Password for protecting private key#>;
// Key pair is generated using the password
VSSKeyPair *keyPair = [[VSSKeyPair alloc] initWithPassword:keyPassword];
//...
// Assuming that we have some initial string message that we want to sign.
NSString *message = @"This is a secret message which should be signed.";
// Convert it to the NSData
NSData *toSign = [message dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
// Assuming that we have some key pair generated earlier.
// Create a new VSSSigner instance
VSSSigner *signer = [[VSSSigner alloc] init];
// Sign the initial data
NSData *signature = [signer signData:toSign privateKey:keyPair.privateKey keyPassword:keyPassword];
// Create a new VSSSigner instance for verification
VSSSigner *verifier = [[VSSSigner alloc] init];
// Verify the signature.
BOOL verified = [verifier verifySignature:signature data:toSign publicKey:keyPair.publicKey];
if (verified) {
	// Signature seems OK.
}
```

##### Swift
```swift
//...
// Password for private key:
let keyPassword = <#Password for protecting private key#>
// Key pair is generated using the password
let keyPair = VSSKeyPair(password:keyPassword)
//...
// Assuming that we have some initial string message.
let message = NSString(string: "This is a secret message which should be signed.")
// Convert it to the NSData
let toSign = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
// Create the signer
let signer = VSSSigner()
// Compose the signature
var signature = signer.signData(toSign, privateKey: keyPair.privateKey(), keyPassword: keyPassword)
if sign = signature {
    // Create a new VSSSigner instance for verification
    let verifier = VSSSigner()
    // Verify the signature.
    let verified = verifier.verifySignature(sign, data: toSign, publicKey:keyPair.publicKey())
    if verified {
	   // Signature seems OK.
    }
}
//...
```

### Sign and Verify data using Key without password

##### Objective-C
```objective-c
//...
#import <VirgilCryptoiOS/VirgilCryptoiOS.h>
//...

// Key pair is generated without a password
VSSKeyPair *keyPair = [[VSSKeyPair alloc] init;
//...
// Assuming that we have some initial string message that we want to sign.
NSString *message = @"This is a secret message which should be signed.";
// Convert it to the NSData
NSData *toSign = [message dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
// Assuming that we have some key pair generated earlier.
// Create a new VSSSigner instance
VSSSigner *signer = [[VSSSigner alloc] init];
// Sign the initial data
NSData *signature = [signer signData:toSign privateKey:keyPair.privateKey keyPassword:nil];
// Create a new VSSSigner instance for verification
VSSSigner *verifier = [[VSSSigner alloc] init];
// Verify the signature.
BOOL verified = [verifier verifySignature:signature data:toSign publicKey:keyPair.publicKey];
if (verified) {
	// Signature seems OK.
}
```

##### Swift
```swift
//...
// Key pair is generated without a password
let keyPair = VSSKeyPair()
//...
// Assuming that we have some initial string message.
let message = NSString(string: "This is a secret message which should be signed.")
// Convert it to the NSData
let toSign = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
// Create the signer
let signer = VSSSigner()
// Compose the signature
var signature = signer.signData(toSign, privateKey: keyPair.privateKey(), keyPassword: nil)
if sign = signature {
    // Create a new VSSSigner instance for verification
    let verifier = VSSSigner()
    // Verify the signature.
    let verified = verifier.verifySignature(sign, data: toSign, publicKey:keyPair.publicKey())
    if verified {
	   // Signature seems OK.
    }
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
