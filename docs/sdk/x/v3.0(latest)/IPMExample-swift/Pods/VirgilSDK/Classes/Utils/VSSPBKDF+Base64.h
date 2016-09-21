//
//  VSSPBKDF+Base64.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 4/28/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>
@import VirgilFoundation;

/**
 * Helper category to compose Base64 encoded password-based derived key.
 */
@interface VSSPBKDF (Base64)

/**
 * Composes a key using PBKDF from the given password. Resulting key (before base64) will have required size.
 *
 * @param password Stirng password which is used to generate a key.
 * @param size Required size of the key.
 * @param error NSError pointer to return an error.
 * 
 * @return Base64 encoded key data in case of success. If error happened - returns nil and NSError object as a last parameter.
 */
- (NSString * __nullable)base64KeyFromPassword:(NSString * __nonnull)password size:(size_t)size error:(NSError * __nullable * __nullable)error;

@end
