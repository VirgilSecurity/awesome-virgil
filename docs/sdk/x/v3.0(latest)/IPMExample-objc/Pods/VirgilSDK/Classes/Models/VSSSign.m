//
//  VSSSign.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/3/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSSign.h"
#import "NSObject+VSSUtils.h"

@interface VSSSign()

@property (nonatomic, copy, readwrite) GUID * __nonnull signedCardId;
@property (nonatomic, copy, readwrite) NSData * __nonnull digest;

@property (nonatomic, copy, readwrite) GUID * __nullable signerCardId;
@property (nonatomic, copy, readwrite) NSDictionary * __nullable data;

@end


@implementation VSSSign

@synthesize signedCardId = _signedCardId;
@synthesize digest = _digest;
@synthesize signerCardId = _signerCardId;
@synthesize data = _data;

#pragma mark - Lifecycle

- (instancetype)initWithId:(GUID *)Id createdAt:(NSDate *)createdAt signedCardId:(GUID *)signedId digest:(NSData *)digest signerCardId:(GUID *)signerId data:(NSDictionary *)data {
    self = [super initWithId:Id createdAt:createdAt];
    if (self == nil) {
        return nil;
    }
    
    _signedCardId = [signedId copy];
    _digest = [_digest copy];
    _signerCardId = [signerId copy];
    _data = [data copy];
    
    return self;
}

- (instancetype)initWithId:(GUID *)Id createdAt:(NSDate *)createdAt {
    return [self initWithId:Id createdAt:createdAt signedCardId:@"" digest:[[NSData alloc] init] signerCardId:nil data:nil];
}

#pragma mark - NSCopying protocol implementation

- (instancetype)copyWithZone:(NSZone *)zone {
    return [(VSSSign *) [[self class] alloc] initWithId:self.Id createdAt:self.createdAt signedCardId:self.signedCardId digest:self.digest signerCardId:self.signerCardId data:self.data];
}

#pragma mark - NSCoding protocol implementation

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    GUID *gid = [[aDecoder decodeObjectForKey:kVSSModelId] as:[GUID class]];
    NSDate *cat = [[aDecoder decodeObjectForKey:kVSSModelCreatedAt] as:[NSDate class]];
    GUID *signedId = [[aDecoder decodeObjectForKey:kVSSModelSignedVirgilCardId] as:[GUID class]];
    NSData *digest = [[aDecoder decodeObjectForKey:kVSSModelSignedDigest] as:[NSData class]];
    GUID *signerId = [[aDecoder decodeObjectForKey:kVSSModelSignerVirgilCardId] as:[GUID class]];
    NSDictionary *data = [[aDecoder decodeObjectForKey:kVSSModelData] as:[NSDictionary class]];
    
    return [self initWithId:gid createdAt:cat signedCardId:signedId digest:digest signerCardId:signerId data:data];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    if (self.signedCardId != nil) {
        [aCoder encodeObject:self.signedCardId forKey:kVSSModelSignedVirgilCardId];
    }
    if (self.digest != nil) {
        [aCoder encodeObject:self.digest forKey:kVSSModelSignedDigest];
    }
    if (self.signerCardId != nil) {
        [aCoder encodeObject:self.signerCardId forKey:kVSSModelSignerVirgilCardId];
    }
    if (self.data != nil) {
        [aCoder encodeObject:self.data forKey:kVSSModelData];
    }
}

#pragma mark - VSSSerializable

+ (instancetype)deserializeFrom:(NSDictionary *)candidate {
    VSSSign *sign = [super deserializeFrom:candidate];
    
    GUID *signedId = [candidate[kVSSModelSignedVirgilCardId] as:[GUID class]];
    sign.signedCardId = signedId;
    
    NSString *digestB64String = [candidate[kVSSModelSignedDigest] as:[NSString class]];
    sign.digest = [[NSData alloc] initWithBase64EncodedString:digestB64String options:0];
    
    GUID *signerId = [candidate[kVSSModelSignerVirgilCardId] as:[GUID class]];
    sign.signerCardId = signerId;
    
    NSDictionary *data = [candidate[kVSSModelData] as:[NSDictionary class]];
    sign.data = data;

    return sign;
}

@end
