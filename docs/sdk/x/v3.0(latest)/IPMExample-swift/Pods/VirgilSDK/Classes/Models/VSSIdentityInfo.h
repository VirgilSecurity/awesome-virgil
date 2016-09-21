//
//  VSSIdentityInfo.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 4/28/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSModel.h"
#import "VSSModelCommons.h"

/**
 * Helper class which represents identity that is not created yet by the Virgil Service.
 * It does not contain any kind of unique model ID, but only type and value. Might also contain
 * a validation token. Identity info is used by the SDK in some calls to services.
 */
@interface VSSIdentityInfo : VSSModel

/**
 * Type of the identity.
 */
@property (nonatomic, copy) NSString * __nonnull type;

/**
 * String value of the identity.
 */
@property (nonatomic, copy) NSString * __nonnull value;

/**
 * Validation token returned by the Virgil Identity Service. May be nil.
 */
@property (nonatomic, copy) NSString * __nullable validationToken;

///------------------------------------------
/// @name Lifecycle
///------------------------------------------

/**
 * Designated constructor.
 * 
 * @param type String identity type.
 * @param value String identity value.
 * @param validationToken Virgil validation token or nil.
 *
 * @return Instance of the Identity Info.
 */
- (instancetype __nonnull)initWithType:(NSString * __nonnull)type value:(NSString * __nonnull)value validationToken:(NSString * __nullable)validationToken NS_DESIGNATED_INITIALIZER;

/**
 * Convenience constructor.
 *
 * @param type String indentity type.
 * @param value String identity value.
 *
 * @return Instance of the Identity Info.
 */
- (instancetype __nonnull)initWithType:(NSString * __nonnull)type value:(NSString * __nonnull)value;

///------------------------------------------
/// @name Utility
///------------------------------------------

/**
 * Converts identity info instance into the NSDictionary.
 * Resulting dictionary will have keys kVSSModelType and kVSSModelValue.
 * In case when validationToken property is not nil - the dictionary will also contain kVSSModelValidationToken key.
 *
 * @return Dictionary representation of the current identity info.
 */
- (NSDictionary * __nonnull)asDictionary;

@end
