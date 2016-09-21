//
//  VSSConfirmIdentityRequest.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/16/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSConfirmIdentityRequest.h"
#import "VSSIdentityInfo.h"
#import "NSObject+VSSUtils.h"

@interface VSSConfirmIdentityRequest ()

@property (nonatomic, strong, readwrite) VSSIdentityInfo * __nullable identityInfo;

@end

@implementation VSSConfirmIdentityRequest

@synthesize identityInfo = _identityInfo;

- (instancetype)initWithContext:(VSSRequestContext *)context actionId:(GUID *)actionId code:(NSString *)code ttl:(NSUInteger)ttl ctl:(NSUInteger)ctl {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }
    
    NSMutableDictionary *body = [[NSMutableDictionary alloc] init];
    
    if (actionId.length > 0) {
        body[kVSSModelActionId] = actionId;
    }
    if (code.length > 0) {
        body[kVSSModelConfirmationCode] = code;
    }
    NSMutableDictionary *token = [[NSMutableDictionary alloc] init];
    if (ttl > 0) {
        token[kVSSModelTTL] = [NSNumber numberWithUnsignedInteger:ttl];
    }
    if (ctl > 0) {
        token[kVSSModelCTL] = [NSNumber numberWithUnsignedInteger:ctl];
    }
    if (token.count > 0) {
        body[kVSSModelToken] = token;
    }
    
    [self setRequestBodyWithObject:body];
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context {
    return [self initWithContext:context actionId:@"" code:@"" ttl:0 ctl:0];
}

#pragma mark - Overrides

- (NSString *)methodPath {
    return @"confirm";
}

- (NSError *)handleResponse:(NSObject *)candidate {
    NSError *error = [super handleResponse:candidate];
    if (error != nil) {
        return error;
    }
    
    NSDictionary *confirmed = [candidate as:[NSDictionary class]];
    self.identityInfo = [VSSIdentityInfo deserializeFrom:confirmed];
    return nil;
}

@end
