//
//  VSSCryptor.h
//  VirgilFoundation
//
//  Created by Pavel Gorb on 2/3/15.
//  Copyright (c) 2015 VirgilSecurity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSSBaseCryptor.h"

/**
 * Error domain constant for the VSSCryptor errors.
 */
extern NSString * __nonnull const kVSSCryptorErrorDomain;

/**
 * Class for encryption/decryption functionality.
 */
@interface VSSCryptor : VSSBaseCryptor

///---------------------------
/// @name Encryption
///---------------------------

/** 
 * Encrypts the given data using added recepients. Allows to embed info about the recipients so it will be easier to setup decryption.
 *
 * @param plainData Data object which needs to be encrypted.
 * @param embedContentInfo `YES` in case when some amount of data with recipients info will be added to the result data.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return Data object with encrypted data or `nil` in case of error.
 */
- (NSData * __nullable)encryptData:(NSData * __nonnull)plainData embedContentInfo:(BOOL)embedContentInfo error:(NSError * __nullable * __nullable)error;

///---------------------------
/// @name Decryption
///---------------------------

/** 
 * Decrypts data using key-based decryption.
 *
 * @param encryptedData Data object containing encrypted data which needs to be decrypted.
 * @param recipientId Recipient identifier used for encryption of the data.
 * @param privateKey Data object containing the private key for decryption (should correspond the public key used for encryption).
 * @param keyPassword Password string used to generate the key pair or `nil`.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return Data object containing the decrypted data or `nil` in case of error.
 */
- (NSData * __nullable)decryptData:(NSData * __nonnull)encryptedData recipientId:(NSString * __nonnull)recipientId privateKey:(NSData * __nonnull)privateKey keyPassword:(NSString * __nullable)keyPassword error:(NSError *__nullable * __nullable)error;

/** 
 * Decrypts data using password-based decryption.
 *
 * @param encryptedData Data object containing encrypted data which needs to be decrypted.
 * @param password Password which was used to encrypt the data.
 * @param error NSError pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return Data object containing the decrypted data or `nil` in case of error.
 */
- (NSData * __nullable)decryptData:(NSData * __nonnull)encryptedData password:(NSString * __nonnull)password error:(NSError * __nullable * __nullable)error;

///---------------------------
/// @name Deprecated functionality
///---------------------------

/** 
 * Encrypts the given data using added recepients. Allows to embed info about the recipients so it will be easier to setup decryption.
 *
 * **Deprecated:** Use `encryptData:embedContentInfo:error:` instead.
 *
 * @param plainData Data object which needs to be encrypted.
 * @param embedContentInfo `NSNumber` wrapper for the boolean flag, if `@YES` then some amount of data with recipients info will be added to the result data.
 *
 * @return Data object with encrypted data or `nil` in case of error.
 */
- (NSData * __nullable)encryptData:(NSData * __nonnull)plainData embedContentInfo:(NSNumber * __nonnull)embedContentInfo __attribute__((deprecated("Use -encryptData:embedContentInfo:error: instead.")));

/** 
 * Decrypts data using key-based decryption.
 *
 * **Deprecated:** Use `decryptData:recipientId:privateKey:keyPassword:error:` instead.
 *
 * @param encryptedData Data object containing encrypted data which needs to be decrypted.
 * @param recipientId Recipient identifier used for encryption of the data.
 * @param privateKey Data object containing the private key for decryption (should correspond the public key used for encryption).
 * @param keyPassword Password string used to generate the key pair or `nil`.
 *
 * @return Data object containing the decrypted data or `nil` in case of error.
 */
- (NSData * __nullable)decryptData:(NSData * __nonnull)encryptedData recipientId:(NSString * __nonnull)recipientId privateKey:(NSData * __nonnull)privateKey keyPassword:(NSString * __nullable)keyPassword __attribute__((deprecated("Use -decryptData:recipientId:privateKey:keyPassword:error: instead.")));

/** Decrypts data using password-based decryption.
 *
 * **Deprecated:** Use `decryptData:password:error:` instead
 *
 * @param encryptedData Data object containing encrypted data which needs to be decrypted.
 * @param password Password which was used to encrypt the data.
 *
 * @return Data object containing the decrypted data or `nil` in case of error.
 */
- (NSData * __nullable)decryptData:(NSData * __nonnull)encryptedData password:(NSString * __nonnull)password __attribute__((deprecated("-decryptData:password:error: instead.")));

@end
