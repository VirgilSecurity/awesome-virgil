//
//  VSSVerifyIdentityRequest.h
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/16/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSIdentityBaseRequest.h"
#import "VSSModelCommons.h"

@class VSSIdentityInfo;

@interface VSSVerifyIdentityRequest : VSSIdentityBaseRequest

@property (nonatomic, strong, readonly) GUID * __nullable actionId;

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context type:(NSString * __nonnull)type value:(NSString * __nonnull)value;
- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context type:(NSString * __nonnull)type value:(NSString * __nonnull)value extraFields:(NSDictionary * __nullable)extraFields NS_DESIGNATED_INITIALIZER;

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context identityInfo:(VSSIdentityInfo * __nonnull)identityInfo extraFields:(NSDictionary * __nullable)extraFields;

@end
