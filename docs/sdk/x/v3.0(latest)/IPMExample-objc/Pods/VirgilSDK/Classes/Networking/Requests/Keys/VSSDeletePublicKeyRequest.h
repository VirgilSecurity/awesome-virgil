//
//  VSSDeletePublicKeyRequest.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/13/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSKeysBaseRequest.h"
#import "VSSModelCommons.h"

@class VSSIdentityInfo;

@interface VSSDeletePublicKeyRequest : VSSKeysBaseRequest

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context publicKeyId:(GUID * __nonnull)publicKeyId identityInfoList:(NSArray <VSSIdentityInfo*>* __nonnull)identityInfoList NS_DESIGNATED_INITIALIZER;

@end
