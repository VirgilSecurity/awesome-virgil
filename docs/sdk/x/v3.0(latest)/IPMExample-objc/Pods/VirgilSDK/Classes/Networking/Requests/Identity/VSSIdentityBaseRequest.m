//
//  VSSIdentityBaseRequest.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/16/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSIdentityBaseRequest.h"
#import "VSSIdentityError.h"
#import "NSObject+VSSUtils.h"

@implementation VSSIdentityBaseRequest

#pragma mark - Overrides

- (NSError *)handleError:(NSObject *)candidate {
    NSError *error = [super handleError:candidate];
    if (error != nil) {
        return error;
    }
    
    VSSIdentityError *viError = [VSSIdentityError deserializeFrom:[candidate as:[NSDictionary class]]];
    return viError.nsError;
}

@end
