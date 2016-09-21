//
//  VSSRequestContextExtended.h
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/10/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSRequestContext.h"
#import "VSSModelCommons.h"

@class VSSCard;
@class VSSPrivateKey;

/**
 * Extended request context is used by the actual requests to fit the Virgil Services requirements.
 *
 * The Virgil Services require some additional values in the request headers. Some requests should be encrypted.
 * The extended context manages all the requirements for each request made to the Virgil Services.
 */
@interface VSSRequestContextExtended : VSSRequestContext

/**
 * Contains Virgil Card of the Virgil Service where request should be done.
 */
@property (nonatomic, strong, readonly) VSSCard* __nullable serviceCard;

/**
 * Contains flag which shows if request should be encrypted or not.
 */
@property (nonatomic, strong, readonly) NSNumber * __nullable requestEncrypt;

/**
 * Contains flag which tells if response is signed and should be verified by the SDK.
 */
@property (nonatomic, strong, readonly) NSNumber * __nullable responseVerify;

/**
 * Private key object wrapper which is used to compose the signature, etc.
 */
@property (nonatomic, strong, readonly) VSSPrivateKey * __nullable privateKey;

/**
 * Virgil Card identifier of the card which is used for the request.
 */
@property (nonatomic, strong, readonly) GUID * __nullable cardId;

/**
 * Custom password which should be used by the Virgil Service to encrypt the response, so it can be decrypted on the SDK side.
 */
@property (nonatomic, strong, readonly) NSString * __nullable password;

///------------------------------------------
/// @name Lifecycle
///------------------------------------------

/**
 * Designated constructor.
 *
 * @param serviceUrl Base (service) url which will be used by the request.
 * @param serviceCard Virgil Card of the Virgil Service
 * @param requestEncrypt Flag which shows if request should be encrypted or not.
 * @param responseVerify Flag which tells if response is signed and should be verified by the SDK.
 * @param privateKey Private key object wrapper which is used to compose the signature, etc.
 * @param cardId Virgil Card identifier of the card which is used for the request.
 * @param password Custom password which should be used by the Virgil Service to encrypt the response, so it can be decrypted on the SDK side.
 *
 * @return Instance of the Request context wrapper object.
 */
- (instancetype __nonnull)initWithServiceUrl:(NSString * __nonnull)serviceUrl serviceCard:(VSSCard * __nullable)serviceCard requestEncrypt:(NSNumber * __nullable)requestEncrypt responseVerify:(NSNumber * __nullable)responseVerify privateKey:(VSSPrivateKey * __nullable)privateKey cardId:(GUID * __nullable)cardId password:(NSString * __nullable)password NS_DESIGNATED_INITIALIZER;

@end
