//
//  VSSKeyPair.h
//  VirgilFoundation
//
//  Created by Pavel Gorb on 2/3/15.
//  Copyright (c) 2015 VirgilSecurity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 * Error domain constant for the `VSSKeyPair` errors.
 */
extern NSString * __nonnull const kVSSKeyPairErrorDomain;

/** 
 * Class for generating asymmetric key pairs using a number of alghorithms. 
 */
@interface VSSKeyPair : NSObject

///---------------------------
/// @name Lifecycle
///---------------------------

/** 
 * Generates a new key pair using curve 25519 without a password. 
 */
- (instancetype __nonnull)init;

/**
 * Generates a new key pair using curve 25519 with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 * 
 * @return instance of the `VSSKeyPair`.
 */
- (instancetype __nonnull)initWithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using 192-bits NIST curve with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)ecNist192WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using 224-bits NIST curve with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)ecNist224WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using 256-bits NIST curve with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)ecNist256WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using 384-bits NIST curve with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair` class.
 */
+ (VSSKeyPair * __nonnull)ecNist384WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using 521-bits NIST curve with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)ecNist521WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using 256-bits Brainpool curve with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)ecBrainpool256WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using 384-bits Brainpool curve with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)ecBrainpool384WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using 512-bits Brainpool curve with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)ecBrainpool512WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using 192-bits "Koblitz" curve with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)ecKoblitz192WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using 224-bits "Koblitz" curve with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)ecKoblitz224WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using 256-bits "Koblitz" curve with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)ecKoblitz256WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using RSA 256-bits with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)rsa256WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using RSA 512-bits with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)rsa512WithPassword:(NSString * __nullable)password;

/** Generates key pair using RSA 1024-bits with given password.
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)rsa1024WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using RSA 2048-bits with given password.
 *
 * @param password Password for encrypting the private key of the key pair or nil.
 *
 * @return instance of the VSSKeyPair.
 */
+ (VSSKeyPair * __nonnull)rsa2048WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using RSA 4096-bits with given password.
 *
 * @param password Password for encrypting the private key of the key pair or nil.
 *
 * @return instance of the VSSKeyPair.
 */
+ (VSSKeyPair * __nonnull)rsa4096WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using curve 25519 with given password. Similar to `curve25519WithPassword:`
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)m255WithPassword:(NSString * __nullable)password;

/** 
 * Generates key pair using curve 25519 with given password. Similar to `m255WithPassword:`
 *
 * @param password Password for encrypting the private key of the key pair or `nil`.
 *
 * @return instance of the `VSSKeyPair`.
 */
+ (VSSKeyPair * __nonnull)curve25519WithPassword:(NSString * __nullable)password;

///---------------------------
/// @name Obtaining the key data
///---------------------------

/** 
 * Getter for the public key's data.
 *
 * @return Data object containing the generated public key data.
 */
- (NSData * __nonnull)publicKey;

/** 
 * Getter for the private key's data.
 *
 * @return Data object containing the generated private key data. 
 * In case of not `nil` password used in `initWithPassword:` initializer,
 * private key data will be encrypted using given password.
 */ 
- (NSData * __nonnull)privateKey;

///---------------------------
/// @name Utility
///---------------------------

/** Checks if given private key is actually encrypted.
 *
 * @param keyData Data representing the private key which needs to be checked.
 *
 * @return `YES` if the private key is encrypted, `NO` - otherwise.
 */
+ (BOOL)isEncryptedPrivateKey:(NSData * __nonnull)keyData;

/** Checks if given private key and given password match each other.
 *
 * @param keyData Data representing the private key.
 * @param password String with private key password candidate.
 *
 * @return `YES` if the private key and the password match, `NO` - otherwise.
 */
+ (BOOL)isPrivateKey:(NSData * __nonnull)keyData matchesPassword:(NSString * __nonnull)password;

/** Checks if a public key matches private key, so that they are actual key pair.
 *
 * @param publicKeyData Data representing a public key.
 * @param privateKeyData Data representing a private key.
 * @param password Private key password or nil.
 *
 * @return `YES` in case when given public key matches given private key, `NO` - otherwise.
 */
+ (BOOL)isPublicKey:(NSData * __nonnull)publicKeyData matchesPrivateKey:(NSData * __nonnull)privateKeyData withPassword:(NSString * __nullable)password;

/** Changes password for the given private key by re-encrypting given private key with a new password.
 *
 * @param password Current password for the private key.
 * @param newPassword Password which should be used for the private key protection further.
 * @param keyData Data object containing the private key.
 * @param error Pointer to `NSError` object in case of error, `nil` - otherwise.
 *
 * @return Data object containing the private key that is encrypted with the new password or `nil` if error has happened.
 */
+ (NSData * __nullable)resetPassword:(NSString * __nonnull)password toPassword:(NSString * __nonnull)newPassword forPrivateKey:(NSData * __nonnull)keyData error:(NSError * __nullable * __nullable)error;

@end
