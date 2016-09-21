//
//  VSSStorePrivateKeyRequest.h
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/17/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSPrivateKeysBaseRequest.h"
#import "VSSModelCommons.h"

@interface VSSStorePrivateKeyRequest : VSSPrivateKeysBaseRequest

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context privateKey:(NSData * __nonnull)privateKey cardId:(GUID * __nonnull)cardId NS_DESIGNATED_INITIALIZER;

@end
