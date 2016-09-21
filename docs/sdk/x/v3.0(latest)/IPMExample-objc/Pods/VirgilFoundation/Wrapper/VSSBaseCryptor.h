//
//  VSSBaseCryptor.h
//  VirgilCypto
//
//  Created by Pavel Gorb on 2/23/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 * Error domain constant for the VSSBaseCryptor errors. 
 */
extern NSString * __nonnull const kVSSBaseCryptorErrorDomain;

/**
 * Base class for `VSSCryptor`, `VSSStreamCryptor` and `VSSChunkCryptor`. 
 * 
 * Contains utility functionality for adding/removing the recipients and content info management.
 */
@interface VSSBaseCryptor : NSObject

///---------------------------
/// @name Properties
///---------------------------

/** 
 * Internal cryptor object 
 */
@property (nonatomic, assign, readonly) void * __nullable llCryptor;

///---------------------------
/// @name Setup
///---------------------------

/** 
 * Adds given public key as a recipient for an encryption.
 *
 * This method should be called before methods: 
 *
 * - `[VSSCryptor encryptData:embedContentInfo:error:]`
 * - `[VSSStreamCryptor encryptDataFromStream:toStream:embedContentInfo:error:]`
 * - `[VSSChunkCryptor startEncryptionWithPreferredChunkSize:error:]`
 *
 * in case of using key-based encryption.
 *
 * @param recipientId Identifier for the public key used for encryption.
 * @param publicKey Data object containing public key which will be used for encryption.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)addKeyRecipient:(NSString * __nonnull)recipientId publicKey:(NSData * __nonnull)publicKey error:(NSError * __nullable * __nullable)error;

/** 
 * Removes a public key with given identifier from the recipients list for an encryption.
 *
 * @param recipientId Identifier for the public key which should be removed.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)removeKeyRecipient:(NSString * __nonnull)recipientId error:(NSError * __nullable * __nullable)error;

/** 
 * Adds given password as a recipient for an encryption.
 *
 * This method should be called before methods:
 *
 * - `[VSSCryptor encryptData:embedContentInfo:error:]`
 * - `[VSSStreamCryptor encryptDataFromStream:toStream:embedContentInfo:error:]`
 * - `[VSSChunkCryptor startEncryptionWithPreferredChunkSize:error:]`
 *
 * in case of using password-based encryption.
 *
 * @param password Password which will be used for an encryption.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)addPasswordRecipient:(NSString * __nonnull)password error:(NSError * __nullable * __nullable)error;

/** 
 * Removes given password from the recipients list for an encryption.
 *
 * @param password Password which should be removed.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 * 
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)removePasswordRecipient:(NSString * __nonnull)password error:(NSError * __nullable * __nullable)error;

/** 
 * Removes all recepients which would be used for an encryption.
 *
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)removeAllRecipientsWithError:(NSError * __nullable * __nullable)error;

/** 
 * Allows to get the content info data.
 * 
 * The content info contains information about the encryption recipients
 * in case of parameter embedContentInfo of the methods
 *
 * - `[VSSCryptor encryptData:embedContentInfo:error:]`
 * - `[VSSStreamCryptor encryptDataFromStream:toStream:embedContentInfo:error:]`
 *
 * was set to `NO`.
 *
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return Data object with content info for the encryption data or `nil` in case of error or if no content info present.
 */
- (NSData * __nullable)contentInfoWithError:(NSError * __nullable * __nullable)error;

/** 
 * Allows to set the content info data with information about the encryption recipients.
 *
 * This method should be called before methods:
 *
 * - `[VSSCryptor decryptData:recipientId:privateKey:keyPassword:error:]`
 * - `[VSSCryptor decryptData:password:error:]`
 * - `[VSSStreamCryptor decryptFromStream:toStream:recipientId:privateKey:keyPassword:error:]`
 * - `[VSSStreamCryptor decryptFromStream:toStream:password:error:]`
 * - `[VSSChunkCryptor startDecryptionWithRecipientId:privateKey:keyPassword:error:]`
 * - `[VSSChunkCryptor startDecryptionWithPassword:error:]`
 *
 * @param contentInfo Data object with content info for the data decryption.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)setContentInfo:(NSData * __nonnull)contentInfo error:(NSError * __nullable * __nullable)error;

/** 
 * Calculates content info size which is a part of the given data.
 *
 * @param data Data object with content info.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return Size of the content info if it exists, 0 - otherwise.
 */
- (size_t)contentInfoSizeInData:(NSData * __nonnull)data error:(NSError * __nullable * __nullable)error;

/** 
 * Allows to set integer value for custom parameter name as a part of the content info in unencrypted form.
 *
 * @param value Value which have to be stored for parameter name given as a key.
 * @param key String custom parameter name. The same parameter name can be used also for:
 *
 * - `setString:forKey:error:`
 * - `setData:forKey:error:`
 *
 * to save 3 different values at the same time.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 * 
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)setInt:(int)value forKey:(NSString * __nonnull)key error:(NSError * __nullable * __nullable)error;

/** 
 * Gets integer value for custom parameter name which has been set earlier.
 *
 * @param key String custom parameter name.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return Value for given parameter name. In case of error returns 0 and `NSError` in error parameter.
 */
- (int)intForKey:(NSString * __nonnull)key error:(NSError * __nullable * __nullable)error;

/** 
 * Removes int value for custom parameter which has been set earlier.
 *
 * @param key String custom parameter name. If there is no given int parameter present - just does nothing and returns `YES`.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)removeIntForKey:(NSString * __nonnull)key error:(NSError * __nullable * __nullable)error;

/** 
 * Allows to set string value for custom parameter name as a part of the content info in unencrypted form.
 *
 * @param value String value which have to be stored for parameter name given as a key.
 * @param key String custom parameter name. The same parameter name can be used also for:
 *
 * - `setInt:forKey:error:`
 * - `setData:forKey:error:`
 *
 * to save 3 different values at the same time.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)setString:(NSString * __nonnull)value forKey:(NSString * __nonnull)key error:(NSError * __nullable * __nullable)error;

/** 
 * Gets string value for custom parameter name which has been set earlier.
 *
 * @param key String custom parameter name.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return String value for given parameter name. In case of error returns `nil` and `NSError` in error parameter.
 */
- (NSString * __nullable)stringForKey:(NSString * __nonnull)key error:(NSError * __nullable * __nullable)error;

/** 
 * Removes string value for custom parameter which has been set earlier.
 *
 * @param key String custom parameter name. If there is no given string parameter present - just does nothing and returns `YES`.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)removeStringForKey:(NSString * __nonnull)key error:(NSError * __nullable * __nullable)error;

/** Allows to set data value for custom parameter name as a part of the content info in unencrypted form.
 *
 * @param value Data value which have to be stored for parameter name given as a key.
 * @param key String custom parameter name. The same parameter name can be used also for:
 *
 * - `setInt:forKey:error:`
 * - `setString:forKey:error:`
 *
 * to save 3 different values at the same time.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)setData:(NSData * __nonnull)value forKey:(NSString * __nonnull)key error:(NSError * __nullable * __nullable)error;

/** 
 * Gets data value for custom parameter name which has been set earlier.
 *
 * @param key String custom parameter name.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return Data value for given parameter name. In case of error returns `nil` and `NSError` in error parameter.
 */
- (NSData * __nullable)dataForKey:(NSString * __nonnull)key error:(NSError * __nullable * __nullable)error;

/** 
 * Removes data value for custom parameter which has been set earlier.
 *
 * @param key String custom parameter name. If there is no given data parameter present - just does nothing and returns `YES`.
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise.
 */
- (BOOL)removeDataForKey:(NSString * __nonnull)key error:(NSError * __nullable * __nullable)error;

/** 
 * Checks if there are any custom parameters set.
 *
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `NO` in case there is no any parameter. `YES` - otherwise. In case of error - returns `YES` and `NSError` object in error parameter.
 */
- (BOOL)isEmptyCustomParametersWithError:(NSError * __nullable * __nullable)error;

/** 
 * Removes all custom parameters.
 *
 * @param error `NSError` pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case when operation completed successfully, `NO` - otherwise. In case of error - returns `NO` and `NSError` object in error parameter.
 */
- (BOOL)clearCustomParametersWithError:(NSError * __nullable * __nullable)error;

///---------------------------
/// @name Deprecated functionality
///---------------------------

/** 
 * Adds given public key as a recipient for an encryption.
 *
 * This method should be called before methods:
 *
 * - `[VSSCryptor encryptData:embedContentInfo:error:]`
 * - `[VSSStreamCryptor encryptDataFromStream:toStream:embedContentInfo:error:]`
 * - `[VSSChunkCryptor startEncryptionWithPreferredChunkSize:error:]`
 *
 * in case of using key-based encryption.
 *
 * **Deprecated:** Use `addKeyRecipient:publicKey:error:` instead.
 *
 * @param recipientId String containing identifier for the public key used for an encryption.
 * @param publicKey Data object containing public key which will be used for an encryption.
 */
- (void)addKeyRecipient:(NSString * __nonnull)recipientId publicKey:(NSData * __nonnull)publicKey __attribute__((deprecated("Use -addKeyRecipient:publicKey:error: instead.")));

/** 
 * Removes a public key with given identifier from the recipients list for an encryption.
 *
 * **Deprecated:** Use `removeKeyRecipient:error:` instead.
 *
 * @param recipientId Identifier for the public key which should be removed.
 */
- (void)removeKeyRecipient:(NSString * __nonnull)recipientId __attribute__((deprecated("Use -removeKeyRecipient:error: instead.")));

/** 
 * Adds given password as a recipient for an encryption.
 *
 * This method should be called before methods:
 *
 * - `[VSSCryptor encryptData:embedContentInfo:error:]`
 * - `[VSSStreamCryptor encryptDataFromStream:toStream:embedContentInfo:error:]`
 * - `[VSSChunkCryptor startEncryptionWithPreferredChunkSize:error:]`
 *
 * in case of using password-based encryption.
 *
 * **Deprecated:** Use `addPasswordRecipient:error:` instead.
 *
 * @param password Password which will be used for an encryption.
 */
- (void)addPasswordRecipient:(NSString * __nonnull)password __attribute__((deprecated("Use -addPasswordRecipient:error: instead.")));

/** 
 * Removes given password from the recipients list for an encryption.
 *
 * **Deprecated:** Use `removePasswordRecipient:error:` instead.
 *
 * @param password Password which should be removed.
 */
- (void)removePasswordRecipient:(NSString * __nonnull)password __attribute__((deprecated("Use -removePasswordRecipient:error: instead.")));

/** 
 * Removes all recepients which would be used for an encryption.
 *
 * **Deprecated:** Use `removeAllRecipientsWithError:` instead.
 */
- (void)removeAllRecipients __attribute__((deprecated("Use -removeAllRecipientsWithError: instead")));

/** 
 * Allows to get the content info data.
 * 
 * The content info contains information about the encryption recipients
 * in case of parameter embedContentInfo of the methods
 *
 * - `[VSSCryptor encryptData:embedContentInfo:error:]`
 * - `[VSSStreamCryptor encryptDataFromStream:toStream:embedContentInfo:error:]`
 *
 * was set to `NO`.
 *
 * **Deprecated:** Use `contentInfoWithError:` instead.
 *
 * @return Data object with content info for the encryption data or `nil` in case of error or if no content info present.
 */
- (NSData * __nullable)contentInfo __attribute__((deprecated("Use -contentInfoWithError: instead.")));

/** 
 * Allows to set the content info data with information about the encryption recipients.
 *
 * This method should be called before methods:
 *
 * - `[VSSCryptor decryptData:recipientId:privateKey:keyPassword:error:]`
 * - `[VSSCryptor decryptData:password:error:]`
 * - `[VSSStreamCryptor decryptFromStream:toStream:recipientId:privateKey:keyPassword:error:]`
 * - `[VSSStreamCryptor decryptFromStream:toStream:password:error:]`
 * - `[VSSChunkCryptor startDecryptionWithRecipientId:privateKey:keyPassword:error:]`
 * - `[VSSChunkCryptor startDecryptionWithPassword:error:]`
 *
 * **Deprecated:** Use setContentInfo:error: instead.
 *
 * @param contentInfo Data object with content info for the data decryption.
 */
- (void)setContentInfo:(NSData * __nonnull)contentInfo __attribute__((deprecated("Use -setContentInfo:error: instead.")));

@end
