//
//  VSSPrivateKeysBaseRequest.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/17/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSPrivateKeysBaseRequest.h"
#import "VSSPrivateKeysError.h"
#import "NSObject+VSSUtils.h"

@implementation VSSPrivateKeysBaseRequest

#pragma mark - Overrides

- (NSError *)handleError:(NSObject *)candidate {
    NSError *error = [super handleError:candidate];
    if (error != nil) {
        return error;
    }
    
    VSSPrivateKeysError *vpkError = [VSSPrivateKeysError deserializeFrom:[candidate as:[NSDictionary class]]];
    return vpkError.nsError;
}

@end
