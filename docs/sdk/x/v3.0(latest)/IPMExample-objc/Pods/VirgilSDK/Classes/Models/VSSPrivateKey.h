//
//  VSSPrivateKey.h
//  VirgilKeys
//
//  Created by Pavel Gorb on 1/29/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSModel.h"

/**
 * Wrapper object for user's private key. Similarly to VSSPublicKey contains actual private key data.
 * Also might contain the password which was used to protect the private key.
 */
@interface VSSPrivateKey : VSSModel

/**
 * Actual private key's data.
 */
@property (nonatomic, copy, readonly) NSData * __nonnull key;

/**
 * Password used for private key's prorection. Might be nil.
 */
@property (nonatomic, copy, readonly) NSString * __nullable password;

///------------------------------------------
/// @name Lifecycle
///------------------------------------------

/**
 * Designated constructor.
 *
 * @param key Actual private key's data.
 * @param password Password used for private key's prorection or nil.
 *
 * @return Instance of the Virgil Public Key wrapper object.
 */
- (instancetype __nonnull)initWithKey:(NSData * __nonnull)key password:(NSString * __nullable)password NS_DESIGNATED_INITIALIZER;

@end
