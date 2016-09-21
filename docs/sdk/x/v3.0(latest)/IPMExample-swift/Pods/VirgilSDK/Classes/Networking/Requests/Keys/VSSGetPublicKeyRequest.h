//
//  VSSGetPublicKeyRequest.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/13/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSKeysBaseRequest.h"
#import "VSSModelCommons.h"

@class VSSPublicKeyExtended;

@interface VSSGetPublicKeyRequest : VSSKeysBaseRequest

@property (nonatomic, strong, readonly) VSSPublicKeyExtended * __nullable publicKey;

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context publicKeyId:(GUID * __nonnull)pkId NS_DESIGNATED_INITIALIZER;

@end
