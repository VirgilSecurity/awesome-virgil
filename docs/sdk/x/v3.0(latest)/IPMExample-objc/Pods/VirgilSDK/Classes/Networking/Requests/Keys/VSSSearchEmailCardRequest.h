//
//  VSSSearchEmailCardRequest.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 5/2/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSKeysBaseRequest.h"

@class VSSCard;

@interface VSSSearchEmailCardRequest : VSSKeysBaseRequest

@property (nonatomic, strong, readonly) NSArray <VSSCard *>* __nullable cards;

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context value:(NSString * __nonnull)value NS_DESIGNATED_INITIALIZER;

@end
