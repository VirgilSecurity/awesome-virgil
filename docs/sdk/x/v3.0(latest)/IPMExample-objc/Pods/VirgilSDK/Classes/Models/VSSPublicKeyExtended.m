//
//  VSSPublicKeyExtended.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/5/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSPublicKeyExtended.h"
#import "VSSModelCommons.h"
#import "VSSCard.h"
#import "NSObject+VSSUtils.h"

@interface VSSPublicKeyExtended ()

@property (nonatomic, copy, readwrite) NSArray <VSSCard *>* __nonnull cards;

@end

@implementation VSSPublicKeyExtended

@synthesize cards = _cards;

- (instancetype)initWithId:(GUID *)Id createdAt:(NSDate *)createdAt key:(NSData *)key cards:(NSArray <VSSCard *>*) cards {
    self = [super initWithId:Id createdAt:createdAt key:key];
    if (self == nil) {
        return nil;
    }
    /// Deep 1-level copy of VSSCard objects which conform to NSCopying protocol.
    _cards = [[NSArray alloc] initWithArray:cards copyItems:YES];
    return self;
}

- (instancetype)initWithId:(GUID *)Id createdAt:(NSDate *)createdAt key:(NSData *)key {
    return [self initWithId:Id createdAt:createdAt key:key cards:@[]];
}

#pragma mark - NSCopying protocol implementation

- (instancetype)copyWithZone:(NSZone *)zone {
    return [(VSSPublicKeyExtended *) [[self class] alloc] initWithId:self.Id createdAt:self.createdAt key:self.key cards:self.cards];
}

#pragma mark - NSCoding protocol implementation

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    GUID *gid = [[aDecoder decodeObjectForKey:kVSSModelId] as:[GUID class]];
    NSDate *cat = [[aDecoder decodeObjectForKey:kVSSModelCreatedAt] as:[NSDate class]];
    NSData *key = [[aDecoder decodeObjectForKey:kVSSModelPublicKey] as:[NSData class]];
    NSArray *cards = [[aDecoder decodeObjectForKey:kVSSModelCards] as:[NSArray class]];
    
    return [self initWithId:gid createdAt:cat key:key cards:cards];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    if (self.cards != nil) {
        [aCoder encodeObject:self.cards forKey:kVSSModelCards];
    }
}

#pragma mark - VSSSerializable

+ (instancetype)deserializeFrom:(NSDictionary *)candidate {
    VSSPublicKeyExtended *pkey = [super deserializeFrom:candidate];
    
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    NSArray *cardCandidates = [candidate[kVSSModelCards] as:[NSArray class]];
    for (NSDictionary *cc in cardCandidates) {
        VSSCard *card = [VSSCard deserializeFrom:cc];
        if (card != nil) {
            [cards addObject:card];
        }
    }
    pkey.cards = cards;
    return pkey;
}


@end
