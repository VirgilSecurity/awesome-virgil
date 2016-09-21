//
//  VSSGetCardRequest.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 2/3/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSGetCardRequest.h"
#import "VSSCard.h"
#import "NSObject+VSSUtils.h"

@interface VSSGetCardRequest ()

@property (nonatomic, strong, readwrite) VSSCard * __nullable card;
@property (nonatomic, strong) GUID * __nonnull cardId;

@end

@implementation VSSGetCardRequest

@synthesize card = _card;
@synthesize cardId = _cardId;

- (instancetype)initWithContext:(VSSRequestContext *)context cardId:(GUID *)cardId {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }
    
    _cardId = cardId;
    [self setRequestMethod:GET];
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context {
    return [self initWithContext:context cardId:@""];
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
    
    /// Deserialize actual card
    self.card = [VSSCard deserializeFrom:[candidate as:[NSDictionary class]]];
    return nil;
}

@end
