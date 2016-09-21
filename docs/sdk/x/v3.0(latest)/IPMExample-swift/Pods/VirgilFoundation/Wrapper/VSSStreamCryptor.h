//
//  VSSStreamCryptor.h
//  VirgilCypto
//
//  Created by Pavel Gorb on 2/25/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSBaseCryptor.h"

/**
 * Error domain constant for the VSSStreamCryptor errors.
 */
extern NSString * __nonnull const kVSSStreamCryptorErrorDomain;

/**
 * Class for performing encryption/decryption using `NSInputStream` as a source of the data and `NSOutputStream` as a receiver.
 */
@interface VSSStreamCryptor : VSSBaseCryptor

///---------------------------
/// @name Encryption
///---------------------------

/** 
 * Encrypts the given data using added recepients. Allows to embed info about the recipients so it will be easier to setup decryption.
 *
 * @param source Input stream object representing the data which needs to be encrypted.
 * @param destination Output stream object representing the encrypted data location.
 * @param embedContentInfo `YES` in case when some amount of data with recipients info will be added to the result data, `NO` - otherwise.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)encryptDataFromStream:(NSInputStream * __nonnull)source toStream:(NSOutputStream * __nonnull)destination embedContentInfo:(BOOL)embedContentInfo error:(NSError * __nullable * __nullable)error;

///---------------------------
/// @name Decryption
///---------------------------

/** 
 * Decrypts data using key-based decryption.
 *
 * @param source Input stream object representing the data which needs to be decrypted.
 * @param destination Output stream object representing the plain data location.
 * @param recipientId Recipient identifier used for encryption of the data.
 * @param privateKey Data object containing the private key for decryption (should correspond the public key used for encryption).
 * @param keyPassword Password string used to generate the key pair or `nil`.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)decryptFromStream:(NSInputStream * __nonnull)source toStream:(NSOutputStream * __nonnull)destination recipientId:(NSString * __nonnull)recipientId privateKey:(NSData * __nonnull)privateKey keyPassword:(NSString * __nullable)keyPassword error:(NSError * __nullable * __nullable)error;

/** 
 * Decrypts data using password-based decryption.
 *
 * @param source Input stream object representing the data which needs to be decrypted.
 * @param destination Output stream object representing the plain data location.
 * @param password Password which was used to encrypt the data.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)decryptFromStream:(NSInputStream * __nonnull)source toStream:(NSOutputStream * __nonnull)destination password:(NSString * __nonnull)password error:(NSError * __nullable * __nullable)error;

@end
