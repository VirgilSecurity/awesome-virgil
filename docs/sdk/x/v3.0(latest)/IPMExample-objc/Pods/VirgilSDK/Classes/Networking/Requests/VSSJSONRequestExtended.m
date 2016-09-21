//
//  VSSJSONRequestExtended.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/12/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSJSONRequestExtended.h"
#import "VSSRequestContextExtended.h"
#import "VSSModelCommons.h"
#import "VSSPublicKey.h"
#import "VSSPrivateKey.h"
#import "NSObject+VSSUtils.h"

@implementation VSSJSONRequestExtended

#pragma mark - Overrides

- (void)setRequestBodyWithObject:(NSObject *)dto {
    if (dto == nil) {
        dto = @{};
    }
    
    NSDictionary *dtoDict = nil;
    if (![NSJSONSerialization isValidJSONObject:dto]) {
        VSSRDLog(@"Invalid object for JSON serialization of the request body: '%@'", [dto description]);
        return;
    }

    /// If request context contains password
    /// it should be injected into request body object (which in this case should be dictionary)
    /// And this password should be used later during response decryption.
    if (self.extendedContext.password.length > 0) {
        if (![dto isKindOfClass:[NSDictionary class]]) {
            VSSRDLog(@"Impossible to add response_password to the request body. Invalid object for the request body: '%@'", [dto description]);
        }
        else {
            NSMutableDictionary *candidate = [[NSMutableDictionary alloc] initWithDictionary:[dto as:[NSDictionary class]]];
            candidate[kVSSModelResponsePassword] = self.extendedContext.password;
            dtoDict = candidate;
        }
    }
    
    NSError *serializationError = nil;
    NSData *body = [NSJSONSerialization dataWithJSONObject:(dtoDict.count == 0) ? dto : dtoDict options:0 error:&serializationError];
    if (serializationError != nil) {
        VSSRDLog(@"Unable to serialize request body: '%@'", [serializationError localizedDescription]);
        return;
    }

    [self setRequestBody:body];
    [self setRequestHeaders:@{ @"Content-Type": @"application/json" }];
    
    /// If there is a private key given in context
    /// Then request should be signed.
    if (self.extendedContext.privateKey.key.length > 0) {
        NSError *error = [self sign];
        if (error != nil) {
            VSSRDLog(@"Unable to compose signature for the request body: '%@'", [error localizedDescription]);
            return;
        }
    }
    
    /// After serialization of the request body
    /// Check if the context require request encryption. In this case
    /// request body should be encrypted with service key and response will be decrypted with context's password
    if ([self.extendedContext.requestEncrypt boolValue]) {
        VSSRDLog(@"Request body before encryption:");
        VSSRDLog(@"%@", [[NSString alloc] initWithData:self.request.HTTPBody encoding:NSUTF8StringEncoding]);
        
        NSError *error = [self encrypt];
        if (error != nil) {
            VSSRDLog(@"Unable to encrypt request body: '%@'", [error localizedDescription]);
            return;
        }
        /// Set content-type.
        [self setRequestHeaders:@{ @"Content-Type": @"text/plain;charset=UTF-8" }];
    }
}

- (NSObject *)parseResponse {
    /// First of all we need to check the response headers for service's signature if context requires it.
    /// and verify it if possible. We will only do this if serviceKey is set in the request context.
    /// Otherwise we will not be able to verify signature anyway.
    if ([self.extendedContext.responseVerify boolValue]) {
        NSError *error = [self verify];
        if (error != nil) {
            VSSRDLog(@"Unable to verify the response signature: '%@'", [error localizedDescription]);
            return error;
        }
    }
    
    // If there is no response body data at all - nothing to process.
    if (self.responseBody == nil) {
        return nil;
    }

    // If response data exists, but empty - nothing to process,
    if (self.responseBody.length == 0) {
        // return empty JSON object
        return @{};
    }

    /// Check if the request context contains password.
    /// If YES - it means that response data should contain encrypted base64 encoded response
    /// which have to be decrypted before using it.
    if (self.extendedContext.password.length > 0) {
        NSError *error = [self decrypt];
        if (error != nil) {
            VSSRDLog(@"Unable to decrypt the response body: '%@'", [error localizedDescription]);
            return error;
        }
    }
    
    /// At this point the responseBody will contain plain JSON data (decrypted or just as is).
    NSError *parseError = nil;
    NSObject *candidate = [NSJSONSerialization JSONObjectWithData:self.responseBody options:NSJSONReadingAllowFragments error:&parseError];
    if (parseError != nil) {
        return parseError;
    }
    
    return candidate;
}

@end
