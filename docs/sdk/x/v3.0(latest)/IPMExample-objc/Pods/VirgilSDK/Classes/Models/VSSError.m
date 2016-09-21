//
//  VSSError.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/12/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSError.h"
#import "NSObject+VSSUtils.h"

@interface VSSError ()

@property (nonatomic, assign, readwrite) NSInteger code;

@end

@implementation VSSError

@synthesize code = _code;

#pragma mark - Lifecycle

- (instancetype)initWithCode:(NSInteger)code {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _code = code;
    return self;
}

- (instancetype)init {
    return [self initWithCode:kVSSNoErrorValue];
}

#pragma mark - Class logic

- (NSString *)message {
    if (self.code == kVSSNoErrorValue) {
        return nil;
    }
    return kVSSUnknownError;
}

- (NSError *)nsError {
    if (self.code == kVSSNoErrorValue) {
        return nil;
    }

    NSString *descr = [self message];
    if (descr == nil) {
        descr = kVSSUnknownError;
    }
    
    return [NSError errorWithDomain:kVSSErrorDomain code:self.code userInfo:@{ NSLocalizedDescriptionKey : descr }];
}

#pragma mark - Overrides

- (NSNumber *)isValid {
    return [NSNumber numberWithBool:(self.code != kVSSNoErrorValue)];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initWithCode:self.code];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSInteger code = [aDecoder decodeIntegerForKey:kVSSModelCode];
    return [self initWithCode:code];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeInteger:self.code forKey:kVSSModelCode];
}

#pragma mark - VSSSerialization

+ (instancetype)deserializeFrom:(NSDictionary *)candidate {
    NSNumber *code = [candidate[kVSSModelCode] as:[NSNumber class]];
    return [[self alloc] initWithCode:[code integerValue]];
}

@end
