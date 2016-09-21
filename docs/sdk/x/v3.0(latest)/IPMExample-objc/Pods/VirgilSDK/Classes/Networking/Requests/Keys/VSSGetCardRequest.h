//
//  VSSGetCardRequest.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 2/3/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSKeysBaseRequest.h"
#import "VSSModelCommons.h"

@class VSSCard;

@interface VSSGetCardRequest : VSSKeysBaseRequest

@property (nonatomic, strong, readonly) VSSCard * __nullable card;

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context cardId:(GUID * __nonnull)cardId NS_DESIGNATED_INITIALIZER;

@end
