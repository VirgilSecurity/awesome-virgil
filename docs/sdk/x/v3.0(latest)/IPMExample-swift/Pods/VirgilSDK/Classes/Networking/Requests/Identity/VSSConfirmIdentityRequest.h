//
//  VSSConfirmIdentityRequest.h
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/16/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSIdentityBaseRequest.h"
#import "VSSModelCommons.h"

@class VSSIdentityInfo;

@interface VSSConfirmIdentityRequest : VSSIdentityBaseRequest

@property (nonatomic, strong, readonly) VSSIdentityInfo * __nullable identityInfo;

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context actionId:(GUID * __nonnull)actionId code:(NSString * __nonnull)code ttl:(NSUInteger)ttl ctl:(NSUInteger)ctl NS_DESIGNATED_INITIALIZER;

@end
