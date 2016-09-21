//
//  VSSValidationTokenGenerator.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 4/28/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSSModelCommons.h"

@class VSSPrivateKey;
@class VSSIdentityInfo;

/**
 * Utility class for generating validation tokens.
 *
 * Generated tokens might be used later to create privately confirmed Virgil Card objects.
 */
@interface VSSValidationTokenGenerator : NSObject

/**
 * Generates validation token for identity with given type, value and for given private key.
 *
 * @param type String identity type.
 * @param value String identity value (email address, etc.)
 * @param privateKey Private key container object which is used to generate the token.
 * @param error NSError pointer to return error.
 *
 * @return String validation token which might be used later to create privately confirmed Virgil Cards. In case of error - returns nil and NSError object 
 * through the last parameter.
 */
+ (NSString * __nullable)validationTokenForIdentityType:(NSString * __nonnull)type value:(NSString * __nonnull)value privateKey:(VSSPrivateKey * __nonnull)privateKey error:(NSError * __nullable * __nullable)error;

/**
 * Generates a validation token for given identity info object and sets it as a validationToken property of the given identity info object.
 * 
 * @param identityInfo Object containing identity type and value which are used to generate the validation token.
 * @param privateKey Private key container object which is used to generate the token.
 * @param error NSError pointer to return error.
 * 
 */
+ (void)setValidationTokenForIdentityInfo:(VSSIdentityInfo * __nonnull)identityInfo privateKey:(VSSPrivateKey * __nonnull)privateKey error:(NSError * __nullable * __nullable)error;

@end
