//
//  VSSSearchCardRequest.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 2/4/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSKeysBaseRequest.h"

@class VSSCard;
@class VSSPublicKey;

@interface VSSSearchCardRequest : VSSKeysBaseRequest

@property (nonatomic, strong, readonly) NSArray <VSSCard *>* __nullable cards;

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context value:(NSString * __nonnull)value type:(NSString * __nullable)type unauthorized:(BOOL)unauthorized NS_DESIGNATED_INITIALIZER;

@end
