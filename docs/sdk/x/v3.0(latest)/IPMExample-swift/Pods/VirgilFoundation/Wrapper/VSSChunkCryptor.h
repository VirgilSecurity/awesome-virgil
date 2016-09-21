//
//  VSSChunkCryptor.h
//  VirgilCypto
//
//  Created by Pavel Gorb on 3/1/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSBaseCryptor.h"

/** 
 * Error domain constant for the VSSChunkCryptor errors.
 */
extern NSString * __nonnull const kVSSChunkCryptorErrorDomain;

/**
 * Class for performing encryption/decryption of relatively small parts of data.
 */
@interface VSSChunkCryptor : VSSBaseCryptor

///---------------------------
/// @name Setup
///---------------------------

/** 
 * Performs all necessary setup for the encryption process, using preferred chunk size.
 *
 * @param chunkSize Preferred size of a single data chunk. In case of 0 - default chunk size will be used (1MiB - 1b for padding).
 * @param error Pointer to `NSError` object in case of error, `nil` - otherwise.
 *
 * @return Actual chunk size which will be used. In case of error 0 will be returned.
 */
- (size_t)startEncryptionWithPreferredChunkSize:(size_t)chunkSize error:(NSError * __nullable * __nullable)error;

/** 
 * Performs all necessary setup for the key-based decryption process.
 *
 * @param recipientId Recipient identifier used for encryption of the data.
 * @param privateKey Data object containing the private key for decryption (should correspond the public key used for encryption).
 * @param keyPassword Password string used to generate the key pair or `nil`.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return Actual chunk size which will be used. In case of error 0 will be returned.
 */
- (size_t)startDecryptionWithRecipientId:(NSString * __nonnull)recipientId privateKey:(NSData * __nonnull)privateKey keyPassword:(NSString * __nullable)keyPassword error:(NSError * __nullable * __nullable)error;

/** 
 * Performs all necessary setup for the password-based decryption process.
 *
 * @param password Password which was used to encrypt the data.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return Actual chunk size which will be used. In case of error 0 will be returned.
 */
- (size_t)startDecryptionWithPassword:(NSString * __nonnull)password error:(NSError * __nullable * __nullable)error;

///---------------------------
/// @name Data processing
///---------------------------

/** 
 * Depending on the type of setup (encryption or decryption) performs one data chunk processing.
 *
 * @param chunk Data object containing the data chunk which have to be processed.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 * 
 * @return Data with a result of the chunk processing.
 */
- (NSData * __nullable)processDataChunk:(NSData * __nonnull)chunk error:(NSError * __nullable * __nullable)error;

///---------------------------
/// @name Cleanup
///---------------------------

/** Finalizes encryption or decryption process.
 * @warning **Important** This method **MUST** be called to avoid any possible security issues related to data chunks processing.
 * 
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 * 
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)finishWithError:(NSError * __nullable * __nullable)error;

@end
