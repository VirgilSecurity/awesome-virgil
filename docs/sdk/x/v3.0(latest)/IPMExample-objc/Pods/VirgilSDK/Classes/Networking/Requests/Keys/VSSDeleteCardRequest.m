//
//  VSSDeleteCardRequest.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/4/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSDeleteCardRequest.h"
#import "VSSIdentityInfo.h"

@interface VSSDeleteCardRequest ()

@property (nonatomic, strong) GUID * __nonnull cardId;

@end

@implementation VSSDeleteCardRequest

@synthesize cardId = _cardId;

- (instancetype)initWithContext:(VSSRequestContext *)context cardId:(GUID *)cardId identityInfo:(VSSIdentityInfo *)identityInfo {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }
    
    _cardId = cardId;
    [self setRequestMethod:DELETE];
    NSDictionary *identityDict = [identityInfo asDictionary];
    if (identityDict.count > 0) {
        [self setRequestBodyWithObject:@{ kVSSModelIdentity: identityDict }];
    }
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context {
    return [self initWithContext:context cardId:@"" identityInfo:[[VSSIdentityInfo alloc] init]];
}

#pragma mark - Overrides

- (NSString *)methodPath {
    return [NSString stringWithFormat:@"virgil-card/%@", self.cardId];
}

- (NSError *)handleResponse:(NSObject *)candidate {
    NSError *error = [super handleResponse:candidate];
    if (error != nil) {
        return error;
    }
    
    return nil;
}

@end
