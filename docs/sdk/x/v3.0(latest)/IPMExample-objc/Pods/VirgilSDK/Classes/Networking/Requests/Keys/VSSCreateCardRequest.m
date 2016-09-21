//
//  VSSCreateCardRequest.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 2/3/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSCreateCardRequest.h"
#import "VSSModelCommons.h"
#import "VSSPublicKey.h"
#import "VSSCard.h"
#import "VSSIdentityInfo.h"
#import "NSObject+VSSUtils.h"

@interface VSSCreateCardRequest ()

@property (nonatomic, strong, readwrite) VSSCard * __nullable card;

@end

@implementation VSSCreateCardRequest

@synthesize card = _card;

#pragma mark - Lifecycle

- (instancetype)initWithContext:(VSSRequestContext *)context publicKeyId:(GUID *)pkId identityInfo:(VSSIdentityInfo *)identityInfo data:(NSDictionary *)data {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }
    
    NSMutableDictionary *body = [[NSMutableDictionary alloc] init];
    if (pkId.length > 0) {
        body[kVSSModelPublicKeyId] = pkId;
    }
    NSDictionary *identityDict = [identityInfo asDictionary];
    if (identityDict.count > 0) {
        body[kVSSModelIdentity] = identityDict;
    }
    if (data.count > 0) {
        body[kVSSModelData] = data;
    }
    [self setRequestBodyWithObject:body];
    
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context publicKey:(NSData *)publicKey identityInfo:(VSSIdentityInfo *)identityInfo data:(NSDictionary *)data {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }
    
    NSMutableDictionary *body = [[NSMutableDictionary alloc] init];
    if (publicKey.length > 0) {
        NSString *base64 = [publicKey base64EncodedStringWithOptions:0];
        if (base64.length > 0) {
            body[kVSSModelPublicKey] = base64;
        }
    }
    NSDictionary *identityDict = [identityInfo asDictionary];
    if (identityDict.count > 0) {
        body[kVSSModelIdentity] = identityDict;
    }
    if (data.count > 0) {
        body[kVSSModelData] = data;
    }
    [self setRequestBodyWithObject:body];
    
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context {
    return [self initWithContext:context publicKey:[[NSData alloc] init] identityInfo:[[VSSIdentityInfo alloc] init] data:nil];
}

#pragma mark - Overrides

- (NSString *)methodPath {
    return @"virgil-card";
}

- (NSError *)handleResponse:(NSObject *)candidate {
    NSError *error = [super handleResponse:candidate];
    if (error != nil) {
        return error;
    }
    
    /// Deserialize actual card
    self.card = [VSSCard deserializeFrom:[candidate as:[NSDictionary class]]];
    return nil;
}


@end
