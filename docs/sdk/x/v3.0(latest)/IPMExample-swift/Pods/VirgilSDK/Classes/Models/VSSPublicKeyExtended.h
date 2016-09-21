//
//  VSSPublicKeyExtended.h
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/5/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSPublicKey.h"

@class VSSCard;

/**
 * In some cases the responses from the Virgil Keys Service might contain not only
 * the particular public key but the list of Virgil Card objects associated with this key on the Virgil Keys Service.
 */
@interface VSSPublicKeyExtended : VSSPublicKey

/** 
 * The array with Virgil Card entities attached to (or associated with) this public key at the Virgil Keys Service.
 */
@property (nonatomic, copy, readonly) NSArray <VSSCard *>* __nonnull cards;

///------------------------------------------
/// @name Lifecycle
///------------------------------------------

/**
 * Designated constructor.
 *
 * @param Id Unique identifier of the model.
 * @param createdAt Date when model was created.
 * @param key Actual public key's data.
 * @param cards Array of VSSCard objects associated with given public key.
 *
 * @return Instance of the Virgil Public Key Extended wrapper object.
 */
- (instancetype __nonnull)initWithId:(GUID * __nonnull)Id createdAt:(NSDate * __nullable)createdAt key:(NSData * __nonnull)key cards:(NSArray <VSSCard*>* __nonnull)cards NS_DESIGNATED_INITIALIZER;

@end
