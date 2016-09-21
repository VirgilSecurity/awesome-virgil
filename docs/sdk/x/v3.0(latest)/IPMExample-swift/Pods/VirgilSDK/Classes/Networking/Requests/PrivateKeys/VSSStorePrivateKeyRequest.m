//
//  VSSStorePrivateKeyRequest.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/17/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSStorePrivateKeyRequest.h"
#import "NSObject+VSSUtils.h"

@implementation VSSStorePrivateKeyRequest

- (instancetype)initWithContext:(VSSRequestContext *)context privateKey:(NSData *)privateKey cardId:(GUID *)cardId {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }
    
    NSMutableDictionary *body = [[NSMutableDictionary alloc] init];
    if (privateKey.length > 0) {
        NSString *b64 = [privateKey base64EncodedStringWithOptions:0];
        if (b64.length > 0) {
            body[kVSSModelPrivateKey] = b64;
        }
    }
    if (cardId.length > 0) {
        body[kVSSModelVirgilCardId] = cardId;
    }
    [self setRequestBodyWithObject:body];
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context {
    return [self initWithContext:context privateKey:[NSData data] cardId:@""];
}

#pragma mark - Overrides

- (NSString *)methodPath {
    return @"private-key";
}

@end
