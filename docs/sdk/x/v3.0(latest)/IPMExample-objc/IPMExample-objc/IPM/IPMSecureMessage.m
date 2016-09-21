//
//  IPMSecureMessage.m
//  IPMExample-objc
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

#import "IPMSecureMessage.h"

@import VirgilSDK;

static NSString * _Nonnull const kDTOMessage = @"message";
static NSString * _Nonnull const kDTOSignature = @"signature";

NS_ASSUME_NONNULL_BEGIN

@interface IPMSecureMessage ()

@property (nonatomic, strong, readwrite) NSData *message;
@property (nonatomic, strong, readwrite) NSData *signature;

@end

NS_ASSUME_NONNULL_END

@implementation IPMSecureMessage

@synthesize message = _message;
@synthesize signature = _signature;

- (instancetype)initWithMessage:(NSData *)message signature:(NSData *)signature {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _message = message;
    _signature = signature;
    
    return self;
}

- (instancetype)init {
    return [self initWithMessage:[NSData data] signature:[NSData data]];
}

#pragma mark - class logic

- (NSDictionary *)toDTO {
    NSMutableDictionary *dto = [[NSMutableDictionary alloc] init];
    dto[kDTOMessage] = [self.message base64EncodedStringWithOptions:0];
    dto[kDTOSignature] = [self.signature base64EncodedStringWithOptions:0];
    return dto;
}

+ (IPMSecureMessage *)fromDTO:(NSDictionary *)dto {
    if (dto.count == 0) {
        return nil;
    }
    
    NSString *message64 = [dto[kDTOMessage] as:[NSString class]];
    if (message64.length == 0) {
        return nil;
    }
    NSData *message = [[NSData alloc] initWithBase64EncodedString:message64 options:0];
    
    NSString *signature64 = [dto[kDTOSignature] as:[NSString class]];
    if (signature64.length == 0) {
        return nil;
    }
    NSData *signature = [[NSData alloc] initWithBase64EncodedString:signature64 options:0];
    
    return [[self alloc] initWithMessage:message signature:signature];
}

- (NSData *)toJSON {
    NSDictionary *dto = [self toDTO];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dto options:0 error:nil];
    return data;
}

+ (IPMSecureMessage * _Nullable)fromJSON:(NSData *)jsonData {
    NSDictionary *dto = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    if (![dto isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    return [self fromDTO:dto];
}

@end
