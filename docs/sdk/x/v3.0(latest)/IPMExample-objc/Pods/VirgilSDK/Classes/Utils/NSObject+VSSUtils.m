//
//  NSObject+VFUtils.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/7/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "NSObject+VSSUtils.h"

@implementation NSObject (VSSUtils)

- (id)as:(Class)expectedClass {
    if ([self isKindOfClass:expectedClass]) {
        return self;
    }
    return nil;
}

@end
