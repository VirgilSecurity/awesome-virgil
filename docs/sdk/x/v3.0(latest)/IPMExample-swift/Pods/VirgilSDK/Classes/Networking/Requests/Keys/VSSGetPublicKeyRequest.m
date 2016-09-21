//
//  VSSGetPublicKeyRequest.m
//  VirgilKeysSDK
//
//  Created by Pavel Gorb on 9/13/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSGetPublicKeyRequest.h"
#import "VSSRequest.h"
#import "VSSPublicKeyExtended.h"
#import "NSObject+VSSUtils.h"

@interface VSSGetPublicKeyRequest ()

@property (nonatomic, strong, readwrite) VSSPublicKeyExtended * __nullable publicKey;
@property (nonatomic, strong) GUID * __nonnull publicKeyId;

@end

@implementation VSSGetPublicKeyRequest

@synthesize publicKey = _publicKey;
@synthesize publicKeyId = _publicKeyId;

#pragma mark - Lifecycle

- (instancetype)initWithContext:(VSSRequestContext *)context publicKeyId:(GUID *)pkId {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }
    
    _publicKeyId = pkId;
    [self setRequestMethod:GET];
    
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context {
    return [self initWithContext:context publicKeyId:@""];
}

#pragma mark - Overrides

- (NSString *)methodPath {
    return [NSString stringWithFormat:@"public-key/%@", self.publicKeyId];
}

- (NSError *)handleResponse:(NSObject *)candidate {
    NSError *error = [super handleResponse:candidate];
    if (error != nil) {
        return error;
    }
    
    self.publicKey = [VSSPublicKeyExtended deserializeFrom:[candidate as:[NSDictionary class]]];
    return nil;
}

@end
