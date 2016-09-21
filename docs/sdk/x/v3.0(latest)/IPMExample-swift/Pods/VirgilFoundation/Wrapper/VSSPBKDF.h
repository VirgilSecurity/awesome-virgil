//
//  VSSPBKDF.h
//  VirgilCypto
//
//  Created by Pavel Gorb on 4/26/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 * Default size of the securely random data.
 */
extern const size_t kVSSDefaultRandomBytesSize;
/** 
 * Error domain constant for the `VSSPBKDF` errors. 
 */
extern NSString * __nonnull const kVSSPBKDFErrorDomain;

/** 
 * Enum for the type of an algorithm for a key derivation function. 
 */
typedef NS_ENUM(NSInteger, VSSPBKDFAlgorithm) {
    /** 
     * Unknown algorithm for a key derivation.
     */
    VSSPBKDFAlgorithmNone = 0,
    /** 
     * PBKDF2 algorithm for a key derivation. 
     */
    VSSPBKDFAlgorithmPBKDF2
};

/** 
 * Enum for the type of a hash function. 
 */
typedef NS_ENUM(NSInteger, VSSPBKDFHash) {
    /** 
     * SHA1 hash function. 
     */
    VSSPBKDFHashSHA1 = 1,
    /** 
     * SHA224 hash function. 
     */
    VSSPBKDFHashSHA224,
    /** 
     * SHA256 hash function. 
     */
    VSSPBKDFHashSHA256,
    /** 
     * SHA384 hash function. 
     */
    VSSPBKDFHashSHA384,
    /** 
     * SHA512 hash function. 
     */
    VSSPBKDFHashSHA512
};

/** 
 * Wrapper object for the key derivation functionality. 
 */
@interface VSSPBKDF : NSObject

/** 
 * Data containing the salt for key derivation. 
 */
@property (nonatomic, strong, readonly) NSData * __nonnull salt;
/** 
 * Number of iterations for the key derivation function. 
 */
@property (nonatomic, assign, readonly) unsigned int iterations;

/** 
 * Algorithm used for the key derivation.
 * @see `VSSPBKDFAlgorithm`
 */
@property (nonatomic, assign) VSSPBKDFAlgorithm algorithm;

/** 
 * Hash function used for the key derivation.
 * @see `VSSPBKDFHash`
 */
@property (nonatomic, assign) VSSPBKDFHash hash;

///-------------------------
/// @name Lifecycle
///-------------------------

/** 
 * Designated constructor.
 * Creates PBKDF wrapper object. By default algoritm is set to `VSSPBKDFAlgorithmPBKDF2` and hash is set to `VSSPBKDFHashSHA384`.
 *
 * @param salt Data with salt for key derivation. In case when salt.length == 0 default salt will be generated atomatically.
 * @param iterations Count of iterations for key derivation function. In case of 0 - default iterations count will be used automatically.
 *
 * @return Instance of the `VSSPBKDF` wrapper.
 */
- (instancetype __nonnull)initWithSalt:(NSData * __nullable)salt iterations:(unsigned int)iterations NS_DESIGNATED_INITIALIZER;

///-------------------------
/// @name Configuration
///-------------------------

/** 
 * Involves security check for used parameters.
 * @warning Enabled by default.
 *
 * @param error Pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case of success, `NO` - otherwise.
 */
- (BOOL)enableRecommendationsCheckWithError:(NSError * __nullable * __nullable)error;

/** 
 * Ignores security check for used parameters.
 * @warning It's strongly recommended to not disable recommendations check.
 *
 * @param error Pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return `YES` in case of success, `NO` - otherwise.
 */
- (BOOL)disableRecommendationsCheckWithError:(NSError * __nullable * __nullable)error;

///-------------------------
/// @name Key derivation
///-------------------------

/** 
 * Derive key from the given password.
 *
 * @param password Password to use when generating key.
 * @param size Size of the output sequence, if 0 - then size of the underlying hash will be used.
 * @param error Pointer to get an object in case of error, `nil` - otherwise.
 *
 * @return Data with derived key.
 */
- (NSData * __nullable)keyFromPassword:(NSString * __nonnull)password size:(size_t)size error:(NSError * __nullable * __nullable)error;

///-------------------------
/// @name Utility
///-------------------------

/** 
 * Generates cryptographically secure random bytes with required length.
 *
 * @param size Required size in bytes of the generated array. When given size equals 0 then `kVSSDefaultRandomBytesSize` will be used instead.
 *
 * @return Data with cryptographically secure random bytes.
 */
+ (NSData * __nonnull)randomBytesOfSize:(size_t)size;

@end
