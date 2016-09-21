//
//  VSSKeysBaseRequest.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/12/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSKeysBaseRequest.h"
#import "VSSKeysError.h"
#import "NSObject+VSSUtils.h"

@implementation VSSKeysBaseRequest

#pragma mark - Overrides

- (NSError *)handleError:(NSObject *)candidate {
    NSError *error = [super handleError:candidate];
    if (error != nil) {
        return error;
    }
    
    VSSKeysError *vkError = [VSSKeysError deserializeFrom:[candidate as:[NSDictionary class]]];
    return vkError.nsError;
}

@end
