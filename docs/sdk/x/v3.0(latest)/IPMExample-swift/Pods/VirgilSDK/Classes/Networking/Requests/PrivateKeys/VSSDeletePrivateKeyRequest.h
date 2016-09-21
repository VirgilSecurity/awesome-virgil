//
//  VSSDeletePrivateKeyRequest.h
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/17/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSPrivateKeysBaseRequest.h"
#import "VSSModelCommons.h"

@interface VSSDeletePrivateKeyRequest : VSSPrivateKeysBaseRequest

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context cardId:(GUID * __nonnull)cardId NS_DESIGNATED_INITIALIZER;

@end
