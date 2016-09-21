//
//  VSSDeletePrivateKeyRequest.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/17/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSDeletePrivateKeyRequest.h"
#import "NSObject+VSSUtils.h"

@implementation VSSDeletePrivateKeyRequest

- (instancetype)initWithContext:(VSSRequestContext *)context cardId:(GUID *)cardId {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }

    if (cardId.length > 0) {
        [self setRequestBodyWithObject:@{ kVSSModelVirgilCardId: cardId }];
    }
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context {
    return [self initWithContext:context cardId:@""];
}

#pragma mark - Overrides

- (NSString *)methodPath {
    return @"private-key/actions/delete";
}

@end
