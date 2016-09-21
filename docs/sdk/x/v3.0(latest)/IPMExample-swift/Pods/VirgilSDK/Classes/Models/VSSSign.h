//
//  VSSSign.h
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/3/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSBaseModel.h"
#import "VSSModelCommons.h"

/**
 * Wrapper for model representing the trusting signatures.
 * 
 * One user might want to explicitly state that he/she trusts another user.
 * In this case the first user signs the other user Virgil Card object.
 */
@interface VSSSign : VSSBaseModel

/**
 * Id of the Virgil Card which is marked as trusted.
 */
@property (nonatomic, copy, readonly) GUID * __nonnull signedCardId;

/**
 * Signature digest which might be checked.
 */
@property (nonatomic, copy, readonly) NSData * __nonnull digest;

/**
 * Id of the Virgil Card whose owner trusts other card (which Id is set in signedCardId).
 */
@property (nonatomic, copy, readonly) GUID * __nullable signerCardId;

/**
 * Custom key-value pairs data.
 */
@property (nonatomic, copy, readonly) NSDictionary * __nullable data;

///------------------------------------------
/// @name Lifecycle
///------------------------------------------

/**
 * Designated constructor.
 *
 * @param Id Unique identifier of the model.
 * @param createdAt Date when model was created.
 * @param signedId Id of the Virgil Card which is marked as trusted.
 * @param digest Signature digest which might be checked.
 * @param signerId Id of the Virgil Card whose owner trusts other card (which Id is set in signedId).
 * @param data Custom key-value pairs data.
 *
 * @return Instance of the Virgil Public Key wrapper object.
 */
- (instancetype __nonnull)initWithId:(GUID * __nonnull)Id createdAt:(NSDate * __nullable)createdAt signedCardId:(GUID * __nonnull)signedId digest:(NSData * __nonnull)digest signerCardId:(GUID * __nullable)signerId data:(NSDictionary * __nullable)data NS_DESIGNATED_INITIALIZER;

@end
