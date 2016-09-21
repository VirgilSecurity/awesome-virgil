//
//  VSSPBKDF+Base64.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 4/28/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSPBKDF+Base64.h"

@implementation VSSPBKDF (Base64)

- (NSString *)base64KeyFromPassword:(NSString *)password size:(size_t)size error:(NSError **)error {
    NSData *keyData = [self keyFromPassword:password size:size error:error];
    return [keyData base64EncodedStringWithOptions:0];
}

@end
