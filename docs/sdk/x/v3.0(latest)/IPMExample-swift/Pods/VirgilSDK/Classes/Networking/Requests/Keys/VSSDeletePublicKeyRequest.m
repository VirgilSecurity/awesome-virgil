//
//  VSSDeletePublicKeyRequest.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/13/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSDeletePublicKeyRequest.h"
#import "NSObject+VSSUtils.h"
#import "VSSModelCommons.h"
#import "VSSIdentityInfo.h"

@interface VSSDeletePublicKeyRequest ()

@property (nonatomic, strong) GUID * __nonnull publicKeyId;

@end

@implementation VSSDeletePublicKeyRequest

@synthesize publicKeyId = _publicKeyId;

#pragma mark - Lifecycle

- (instancetype)initWithContext:(VSSRequestContext *)context publicKeyId:(GUID *)publicKeyId identityInfoList:(NSArray <VSSIdentityInfo*>*)identityInfoList {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }

    _publicKeyId = publicKeyId;
    
    [self setRequestMethod:DELETE];
    
    NSMutableArray *list = [NSMutableArray array];
    for (VSSIdentityInfo *identity in identityInfoList) {
        [list addObject:[identity asDictionary]];
    }
    if (list.count > 0) {
        NSDictionary *idtts = @{ kVSSModelIdentities: list };
        [self setRequestBodyWithObject:idtts];
    }
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context {
    return [self initWithContext:context publicKeyId:@"" identityInfoList:@[]];
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
    
    return nil;
}

@end
