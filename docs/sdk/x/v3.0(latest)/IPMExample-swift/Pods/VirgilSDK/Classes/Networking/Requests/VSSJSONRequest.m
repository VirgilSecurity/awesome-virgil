//
//  VSSJSONRequest.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/11/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSJSONRequest.h"
#import "NSObject+VSSUtils.h"

@implementation VSSJSONRequest

#pragma mark - Class logic

- (void)setRequestBodyWithObject:(NSObject *)dto {
    if (![NSJSONSerialization isValidJSONObject:dto]) {
        VSSRDLog(@"Invalid object for JSON serialization of the request body: '%@'", [dto description]);
        return;
    }
    
    NSError *serializationError = nil;
    NSData *body = [NSJSONSerialization dataWithJSONObject:dto options:0 error:&serializationError];
    if (serializationError != nil) {
        VSSRDLog(@"Unable to serialize request body: '%@'", [serializationError localizedDescription]);
        return;
    }
    
    [self setRequestBody:body];
    [self setRequestHeaders:@{ @"Content-Type": @"application/json" }];
}

#pragma mark - Overrides

- (NSObject *)parseResponse {
    // If there is no response body data at all - nothing to parse.
    if (self.responseBody == nil) {
        return nil;
    }
    // If response data exists, but empty - nothing to parse,
    if (self.responseBody.length == 0) {
        // return empty JSON object
        return @{};
    }
    
    NSError *parseError = nil;
    NSObject *candidate = [NSJSONSerialization JSONObjectWithData:self.responseBody options:NSJSONReadingAllowFragments error:&parseError];
    if (parseError != nil) {
        return parseError;
    }
    
    return candidate;
}

@end
