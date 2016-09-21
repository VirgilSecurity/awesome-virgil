//
//  VSSBaseModel.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/11/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSModel.h"
#import "VSSModelCommons.h"

/**
 * More concrete base model class for all models
 * which contain Id and createdAt fields.
 */
@interface VSSBaseModel : VSSModel

/**
 * Unique identifier of the model received from Virgil Service.
 */
@property (nonatomic, copy, readonly) GUID * __nonnull Id;

/**
 * Date when this particular model was created by Virgil Service.
 */
@property (nonatomic, copy, readonly) NSDate * __nullable createdAt;

///------------------------------------------
/// @name Lifecycle
///------------------------------------------

/**
 * Designated constructor.
 *
 * @param Id Unique identifier of the model.
 * @param createdAt Date when model was created.
 *
 * @return Instance of the model.
 */
- (instancetype __nonnull)initWithId:(GUID * __nonnull)Id createdAt:(NSDate * __nullable)createdAt NS_DESIGNATED_INITIALIZER;

@end
