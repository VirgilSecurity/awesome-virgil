//
//  VSSPrivateKey.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 1/29/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSPrivateKey.h"
#import "VSSModelCommons.h"
#import "NSObject+VSSUtils.h"

@interface VSSPrivateKey ()

@property (nonatomic, copy, readwrite) NSData * __nonnull key;
@property (nonatomic, copy, readwrite) NSString * __nullable password;

@end

@implementation VSSPrivateKey

@synthesize key = _key;
@synthesize password = _password;

#pragma mark - Lifecycle

- (instancetype)initWithKey:(NSData *)key password:(NSString *)password {
    self = [super init];
    if (self == nil) {
        return nil;
    }

    _key = [key copy];
    _password = [password copy];
    return self;
}

- (instancetype)init {
    return [self initWithKey:[[NSData alloc] init] password:nil];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    return [(VSSPrivateKey *)[[self class] alloc] initWithKey:self.key password:self.password];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSData *key = [[aDecoder decodeObjectForKey:kVSSModelPrivateKey] as:[NSData class]];
    NSString *pass = [[aDecoder decodeObjectForKey:kVSSModelPassword] as:[NSString class]];

    return [self initWithKey:key password:pass];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];

    if (self.key != nil) {
        [aCoder encodeObject:self.key forKey:kVSSModelPrivateKey];
    }
    if (self.password != nil) {
        [aCoder encodeObject:self.password forKey:kVSSModelPassword];
    }
}

#pragma mark - VSSSerializable

+ (instancetype)deserializeFrom:(NSDictionary *)candidate {
    NSString *keyB64String = [candidate[kVSSModelPrivateKey] as:[NSString class]];
    NSData *key = [[NSData alloc] initWithBase64EncodedString:keyB64String options:0];

    return [[self alloc] initWithKey:key password:nil];
}

@end
