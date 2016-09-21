//
//  VSSUnsignCardRequest.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 2/3/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSUnsignCardRequest.h"

@interface VSSUnsignCardRequest ()

@property (nonatomic, strong) GUID * __nonnull signerId;

@end

@implementation VSSUnsignCardRequest

@synthesize signerId = _signerId;

- (instancetype)initWithContext:(VSSRequestContext *)context signerCardId:(GUID *)signerId signedCardId:(GUID *)signedId {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }
    
    _signerId = signerId;
    if (signedId.length > 0) {
        [self setRequestBodyWithObject:@{ kVSSModelSignedVirgilCardId: signedId }];
    }
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context {
    return [self initWithContext:context signerCardId:@"" signedCardId:@""];
}

#pragma mark - Overrides

- (NSString *)methodPath {
    return [NSString stringWithFormat:@"virgil-card/%@/actions/unsign", self.signerId];
}

- (NSError *)handleResponse:(NSObject *)candidate {
    NSError *error = [super handleResponse:candidate];
    if (error != nil) {
        return error;
    }
    
    return nil;
}

@end
