//
//  VSSSignCardRequest.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 2/3/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSKeysBaseRequest.h"
#import "VSSModelCommons.h"

@class VSSSign;

@interface VSSSignCardRequest : VSSKeysBaseRequest

@property (nonatomic, strong, readonly) VSSSign * __nullable Sign;

- (instancetype __nonnull)initWithContext:(VSSRequestContext * __nonnull)context signerCardId:(GUID * __nonnull)signerId signedCardId:(GUID * __nonnull) signedId digest:(NSData * __nonnull)digest NS_DESIGNATED_INITIALIZER;

@end
