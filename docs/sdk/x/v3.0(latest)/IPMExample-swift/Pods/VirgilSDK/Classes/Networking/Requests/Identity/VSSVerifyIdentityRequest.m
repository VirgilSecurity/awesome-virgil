//
//  VSSVerifyIdentityRequest.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/16/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSVerifyIdentityRequest.h"
#import "VSSIdentityInfo.h"
#import "NSObject+VSSUtils.h"

@interface VSSVerifyIdentityRequest ()

@property (nonatomic, strong, readwrite) GUID * __nullable actionId;

@end

@implementation VSSVerifyIdentityRequest

@synthesize actionId = _actionId;

- (instancetype)initWithContext:(VSSRequestContext *)context type:(NSString *)type value:(NSString *)value extraFields:(NSDictionary *)extraFields {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }
    
    NSMutableDictionary *body = [[NSMutableDictionary alloc] init];
    if (type.length > 0) {
        body[kVSSModelType] = type;
    }
    if (value.length > 0) {
        body[kVSSModelValue] = value;
    }
    if (extraFields.count > 0) {
        body[kVSSModelExtraFields] = extraFields;
    }
    [self setRequestBodyWithObject:body];
    
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context type:(NSString *)type value:(NSString *)value {
    return [self initWithContext:context type:type value:value extraFields:nil];
}

- (instancetype)initWithContext:(VSSRequestContext *)context identityInfo:(VSSIdentityInfo *)identityInfo extraFields:(NSDictionary *)extraFields {
    return [self initWithContext:context type:identityInfo.type value:identityInfo.value extraFields:extraFields];
}

- (instancetype)initWithContext:(VSSRequestContext *)context {
    return [self initWithContext:context type:@"" value:@""];
}

#pragma mark - Overrides

- (NSString *)methodPath {
    return @"verify";
}

- (NSError *)handleResponse:(NSObject *)candidate {
    NSError *error = [super handleResponse:candidate];
    if (error != nil) {
        return error;
    }
    
    self.actionId = [[candidate as:[NSDictionary class]][kVSSModelActionId] as:[GUID class]];
    return nil;
}

@end
