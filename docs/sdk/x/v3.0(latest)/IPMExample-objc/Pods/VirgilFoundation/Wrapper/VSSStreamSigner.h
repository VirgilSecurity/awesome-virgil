//
//  VSSStreamSigner.h
//  VirgilCypto
//
//  Created by Pavel Gorb on 3/2/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSSFoundationCommons.h"

/** 
 * Error domain constant for the `VSSStreamSigner` errors.
 */
extern NSString * __nonnull const kVSSStreamSignerErrorDomain;

/** 
 * Wrapper for the functionality for composing/verifying signatures.
 * 
 * This wrapper works with `NSInputStream` instead of `NSData` objects.
 */
@interface VSSStreamSigner : NSObject

///------------------------
/// @name Lifecycle
///------------------------

/** 
 * Designated constructor.
 *
 * @param hash Name of the preferred hash function. In case of `nil` default hash function will be used (SHA384).
 * One of the following names should be used: `kHashNameMD5`, `kHashNameSHA256`, `kHashNameSHA384`, `kHashNameSHA512`.
 *
 * @return Instance of the `VSSSigner`.
 */
- (instancetype __nonnull)initWithHash:(NSString * __nullable)hash NS_DESIGNATED_INITIALIZER;

///---------------------------
/// @name Compose a signature
///---------------------------

/** 
 * Creates a signature data for the data from given stream using a private key.
 *
 * @param source Input stream object containing the data which needs to be signed.
 * @param privateKey Data object containing user's private key.
 * @param keyPassword Password which was used to create key pair object or `nil`.
 * @param error Pointer with `NSError` object if signing process finished with exception. May be `nil`.
 *
 * @return Signature data object.
 */
- (NSData * __nullable)signStreamData:(NSInputStream * __nonnull)source privateKey:(NSData * __nonnull)privateKey keyPassword:(NSString * __nullable)keyPassword error:(NSError * __nullable * __nullable)error;

///---------------------------
/// @name Verify a signature
///---------------------------

/** 
 * Performs verification of a signature based on the data from given stream using a public key.
 *
 * @param signature Data object containing a signature.
 * @param source Input Stream object containing the data which was used to compose the signature on.
 * @param publicKey Data object containing a public key data of a user whose signature needs to be verified.
 * @param error Pointer with `NSError` object if signing process finished with exception. May be `nil`.
 *
 * @return `YES` if signature is verified and can be trusted, `NO` - otherwise.
 */
- (BOOL)verifySignature:(NSData * __nonnull)signature fromStream:(NSInputStream * __nonnull)source publicKey:(NSData * __nonnull)publicKey error:(NSError * __nullable * __nullable)error;

@end
