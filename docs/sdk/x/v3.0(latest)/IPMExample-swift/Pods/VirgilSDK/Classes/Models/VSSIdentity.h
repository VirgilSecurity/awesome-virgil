//
//  VSSIdentity.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 1/20/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSBaseModel.h"
#import "VSSModelCommons.h"

@class VSSIdentityInfo;

/**
 * Class representing the Virgil Identity.
 *
 * In general instances of this class are returned by the Virgil Keys Service.
 * The instances contain unique Id and createdAt date.
 * 
 * Identity is the unique (and in general public) information which belongs to user.
 * It is associated with a particular Virgil Card, and later it is possible to search
 * for the Virgil Card by the identity.  
 * 
 * Each Virgil Identity has type and value (these are the most important fields). 
 */
@interface VSSIdentity : VSSBaseModel

/**
 * Type of the current identity.
 */
@property (nonatomic, copy, readonly) NSString * __nonnull type;

/**
 * String value of the identity.
 */
@property (nonatomic, copy, readonly) NSString * __nonnull value;

///------------------------------------------
/// @name Lifecycle
///------------------------------------------

/**
 * Designated constructor.
 *
 * @param Id Unique identifier of the model.
 * @param createdAt Date when model was created.
 * @param type String identity type.
 * @param value String identity value.
 *
 * @return Instance of the Virgil Identity.
 */
- (instancetype __nonnull)initWithId:(GUID * __nonnull)Id createdAt:(NSDate *__nullable)createdAt type:(NSString * __nonnull)type value:(NSString * __nonnull)value NS_DESIGNATED_INITIALIZER;

///------------------------------------------
/// @name Utility
///------------------------------------------

/**
 * Converts current instance to the VSSIdentityInfo
 * which is required by the SDK in most cases.
 *
 * @return Instance of VSSIdentityInfo corresponding the current instance.
 */
- (VSSIdentityInfo * __nonnull)asIdentityInfo;

@end
