//
//  VSSSigner.h
//  VirgilFoundation
//
//  Created by Pavel Gorb on 2/3/15.
//  Copyright (c) 2015 VirgilSecurity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSSFoundationCommons.h"

/** 
 * Error domain constant for the `VSSSigner` errors.
 */
extern NSString * __nonnull const kVSSSignerErrorDomain;

/** 
 * Wrapper for the functionality of composing/verifying signatures.
 */
@interface VSSSigner : NSObject

///---------------------------
/// @name Lifecycle
///---------------------------

/** 
 * Designated constructor.
 *
 * @param hash NSString name of the preferred hash function. In case of `nil` default hash function will be used (SHA384).
 * One of the following names should be used: `kHashNameMD5`, `kHashNameSHA256`, `kHashNameSHA384`, `kHashNameSHA512`.
 *
 * @return Instance of the `VSSSigner`.
 */
- (instancetype __nonnull)initWithHash:(NSString * __nullable)hash NS_DESIGNATED_INITIALIZER;

///---------------------------
/// @name Compose a signature
///---------------------------

/** 
 * Composes a signature data for given data using a private key.
 *
 * @param data Data object which needs to be signed.
 * @param privateKey Data object containing user's private key.
 * @param keyPassword Password which was used to create key pair object or `nil`.
 * @param error Pointer to `NSError` object if signing process has finished with exception.
 *
 * @return Signature data object.
 */
- (NSData * __nullable)signData:(NSData * __nonnull)data privateKey:(NSData * __nonnull)privateKey keyPassword:(NSString * __nullable)keyPassword error:(NSError * __nullable * __nullable)error;

///---------------------------
/// @name Verify a signature
///---------------------------

/** 
 * Performs verification of a signature for given data using a public key.
 *
 * @param signature Data object containing a signature data.
 * @param data Data object which was used to compose the signature on.
 * @param publicKey Data object containing a public key data of the user whose signature needs to be verified.
 * @param error Pointer to `NSError` object if verification process has finished with exception.
 *
 * @return `YES` if signature is verified and can be trusted, `NO` - otherwise.
 */
- (BOOL)verifySignature:(NSData * __nonnull)signature data:(NSData * __nonnull)data publicKey:(NSData * __nonnull)publicKey error:(NSError * __nullable * __nullable)error;

///---------------------------
/// @name Deprecated functionality
///---------------------------

/** 
 * Composes a signature data for given data using a private key.
 *
 * **Deprecated:** Use `signData:privateKey:keyPassword:error:` instead.
 *
 * @param data Data object which needs to be signed.
 * @param privateKey Data object containing user's private key.
 * @param keyPassword Password which was used to create key pair object or `nil`.
 *
 * @return Signature data object.
 */
- (NSData * __nullable)signData:(NSData * __nonnull)data privateKey:(NSData * __nonnull)privateKey keyPassword:(NSString * __nullable)keyPassword __attribute__((deprecated("Use -signData:privateKey:keyPassword:error: instead.")));

/** 
 * Performs verification of a signature for given data using a public key.
 *
 * **Deprecated:** Use `verifySignature:data:publicKey:error:` instead.
 *
 * @param signature Data object containing a signature data.
 * @param data Data object which was used to compose the signature on.
 * @param publicKey Data object containing a public key data of the user whose signature needs to be verified.
 *
 * @return `YES` if signature is verified and can be trusted, `NO` - otherwise.
 */
- (BOOL)verifySignature:(NSData * __nonnull)signature data:(NSData * __nonnull)data publicKey:(NSData * __nonnull)publicKey __attribute__((deprecated("Use -verifySignature:data:publicKey:error instead.")));

@end
