//
//  VSSRequestExtended.h
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/10/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSRequest.h"

@class VSSRequestContextExtended;

/**
 * The extended version of the VSSRequest class. 
 * Manages additional logic specific for the Virgil Services.
 */
@interface VSSRequestExtended : VSSRequest

/**
 * Performs all necessary operations to sign the request.
 * Signature is composed based on the request context.
 * The signature is added to the request headers.
 *
 * @return NSError object with error description (in this case there will be no signature in the headers). Nil - in case all is OK.
 */
- (NSError * __nullable)sign;

/**
 * Performs all necessary operations to verify the signature of the response.
 * Signature is taken from the response header.
 *
 * @return NSError object with error description. Nil - in case all is OK.
 */
- (NSError * __nullable)verify;

/**
 * Performs all necessary operations to encrypt the request.
 * Encryption data is composed based on the request context.
 * The encrypted data is used as a request body.
 *
 * @return NSError object with error description. Nil - in case all is OK.
 */
- (NSError * __nullable)encrypt;

/**
 * Performs all necessary operations to decrypt the response.
 * Response body will be decrypted based on the request context.
 * Decrypted data will be used as a response body.
 *
 * @return NSError object with error description. Nil - in case all is OK.
 */
- (NSError * __nullable)decrypt;

/**
 * Used to conveniently cast the request context to the extended version. 
 * 
 * @return Extended request context or nil.
 */
- (VSSRequestContextExtended * __nullable)extendedContext;

@end
