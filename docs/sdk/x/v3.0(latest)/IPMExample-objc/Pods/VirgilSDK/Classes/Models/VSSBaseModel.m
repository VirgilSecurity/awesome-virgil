//
//  VSSBaseModel.m
//  VirgilKeysSDK
//
//  Created by Pavel Gorb on 9/11/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSBaseModel.h"
#import "NSObject+VSSUtils.h"

@interface VSSBaseModel ()

@property (nonatomic, copy, readwrite) GUID * __nonnull Id;
@property (nonatomic, copy, readwrite) NSDate * __nonnull createdAt;

@end

@implementation VSSBaseModel

@synthesize Id = _Id;
@synthesize createdAt = _createdAt;

#pragma mark - Lifecycle

- (instancetype)initWithId:(GUID *)Id createdAt:(NSDate *)createdAt {
    self = [super init];
    if (self == nil) {
        return nil;
    }
 
    _Id = [Id copy];
    _createdAt = [createdAt copy];
    return self;
}

- (instancetype)init {
    return [self initWithId:@"" createdAt:nil];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    return [(VSSBaseModel *)[[self class] alloc] initWithId:self.Id createdAt:self.createdAt];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    GUID *gid = [[aDecoder decodeObjectForKey:kVSSModelId] as:[GUID class]];
    NSDate *cat = [[aDecoder decodeObjectForKey:kVSSModelCreatedAt] as:[NSDate class]];
    return [self initWithId:gid createdAt:cat];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    if (self.Id.length > 0) {
        [aCoder encodeObject:self.Id forKey:kVSSModelId];
    }
    if (self.createdAt != nil) {
        [aCoder encodeObject:self.createdAt forKey:kVSSModelCreatedAt];
    }
}

#pragma mark - VSSSerializable

+ (instancetype)deserializeFrom:(NSDictionary *)candidate {
    GUID *gid = [candidate[kVSSModelId] as:[GUID class]];

    NSDate *cat = nil;
    NSString *strDate = [candidate[kVSSModelCreatedAt] as:[NSString class]];
    if (strDate.length > 0) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd'T'kk:mm:ssZ"];
        cat = [df dateFromString:strDate];
    }

    return [[self alloc] initWithId:gid createdAt:cat];
}

#pragma mark - NSObject protocol implementation: Equality

- (BOOL)isEqual:(id)object {
    VSSBaseModel *candidate = [object as:[VSSBaseModel class]];
    return candidate == nil ? NO : [self.Id isEqualToString:candidate.Id];

}

- (NSUInteger)hash {
    return [self.Id hash];
}

@end
