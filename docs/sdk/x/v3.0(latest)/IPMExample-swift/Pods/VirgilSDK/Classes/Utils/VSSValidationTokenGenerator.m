//
//  VSSValidationTokenGenerator.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 4/28/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSValidationTokenGenerator.h"

#import "VSSIdentityInfo.h"
#import "VSSPrivateKey.h"

@import VirgilFoundation;

@implementation VSSValidationTokenGenerator

+ (NSString *)validationTokenForIdentityType:(NSString *)type value:(NSString *)value privateKey:(VSSPrivateKey *)privateKey error:(NSError **)error {
    if (type.length == 0 || value.length == 0 || privateKey.key.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSErrorDomain code:-1900 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to generate validation token: required parameters are missing or incorrect.", @"Impossible to generate validation token: required parameters are missing or incorrect.") }];
        }
        return nil;
    }
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSString *sigString = [NSString stringWithFormat:@"%@%@%@", uuid, type, value];
    NSData *sigData = [sigString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    if (sigData.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSErrorDomain code:-1901 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to generate validation token: base64 conversion failed.", @"Impossible to generate validation token: base64 conversion failed.") }];
        }
        return nil;
    }
    
    VSSSigner *signer = [[VSSSigner alloc] init];
    NSData *signature = [signer signData:sigData privateKey:privateKey.key keyPassword:privateKey.password error:error];
    if (error && *error != nil) {
        return nil;
    }
    
    NSString *b64Signature = [signature base64EncodedStringWithOptions:0];
    NSString *tokenContent = [NSString stringWithFormat:@"%@.%@", uuid, b64Signature];
    NSData *token = [tokenContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    if (token.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSErrorDomain code:-1901 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to generate validation token: base64 conversion failed.", @"Impossible to generate validation token: base64 conversion failed.") }];
        }
        return nil;
    }
    
    if (error) {
        *error = nil;
    }
    return [token base64EncodedStringWithOptions:0];
}

+ (void)setValidationTokenForIdentityInfo:(VSSIdentityInfo *)identityInfo privateKey:(VSSPrivateKey *)privateKey error:(NSError **)error {
    identityInfo.validationToken = [self validationTokenForIdentityType:identityInfo.type value:identityInfo.value privateKey:privateKey error:error];
}

@end
