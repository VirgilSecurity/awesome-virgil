//
//  VSSCreateCardRequest.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 2/3/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//


#import "VSSKeysBaseRequest.h"
#import "VSSModelCommons.h"

@class VSSPublicKey;
@class VSSCard;
@class VSSIdentityInfo;

@interface VSSCreateCardRequest : VSSKeysBaseRequest

@property (nonatomic, strong, readonly) VSSCard * __nullable card;

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context publicKeyId:(GUID * __nonnull)pkId identityInfo:(VSSIdentityInfo * __nonnull)identityInfo data:(NSDictionary * __nullable)data NS_DESIGNATED_INITIALIZER;

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context publicKey:(NSData * __nonnull)publicKey identityInfo:(VSSIdentityInfo * __nonnull)identityInfo data:(NSDictionary * __nullable)data NS_DESIGNATED_INITIALIZER;

@end
