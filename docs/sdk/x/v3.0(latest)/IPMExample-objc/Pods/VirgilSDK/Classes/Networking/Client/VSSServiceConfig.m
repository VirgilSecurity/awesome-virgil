//
//  VSSServiceConfig.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/9/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSServiceConfig.h"

NSString *const kVSSServiceIDKeys = @"VSSServiceIDKeys";
NSString *const kVSSServiceIDPrivateKeys = @"VSSServiceIDPrivateKeys";
NSString *const kVSSServiceIDIdentity = @"VSSServiceIDIdentity";

@implementation VSSServiceConfig

+ (VSSServiceConfig *)serviceConfig {
    return [[self alloc] init];
}

- (NSArray <NSString *>*)serviceIDList {
    return @[ kVSSServiceIDKeys, kVSSServiceIDPrivateKeys, kVSSServiceIDIdentity];
}

- (NSString *)serviceURLForServiceID:(NSString *)serviceID {
    if ([serviceID isEqualToString:kVSSServiceIDKeys]) {
        return @"https://keys.virgilsecurity.com/v3";
    }
    else if ([serviceID isEqualToString:kVSSServiceIDPrivateKeys]) {
        return @"https://keys-private.virgilsecurity.com/v3";
    }
    else if ([serviceID isEqualToString:kVSSServiceIDIdentity]) {
        return @"https://identity.virgilsecurity.com/v1";
    }
    
    return @"";
}

- (NSString *)serviceCardValueForServiceID:(NSString *)serviceID {
    if ([serviceID isEqualToString:kVSSServiceIDKeys]) {
        return @"com.virgilsecurity.keys";
    }
    else if ([serviceID isEqualToString:kVSSServiceIDPrivateKeys]) {
        return @"com.virgilsecurity.private-keys";
    }
    else if ([serviceID isEqualToString:kVSSServiceIDIdentity]) {
        return @"com.virgilsecurity.identity";
    }
    
    return @"";
}

@end
