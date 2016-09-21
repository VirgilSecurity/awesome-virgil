//
//  VSSRequestContext.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/10/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSRequestContext.h"

@interface VSSRequestContext ()

@property (nonatomic, strong, readwrite) NSString * __nonnull uuid;
@property (nonatomic, strong, readwrite) NSString * __nonnull serviceUrl;

@end

@implementation VSSRequestContext

@synthesize uuid = _uuid;
@synthesize serviceUrl = _serviceUrl;

- (instancetype)initWithServiceUrl:(NSString *)serviceUrl {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _uuid = [[[NSUUID UUID] UUIDString] lowercaseString];
    _serviceUrl = serviceUrl;
    
    return self;
}

- (instancetype)init {
    return [self initWithServiceUrl:@""];
}

@end
