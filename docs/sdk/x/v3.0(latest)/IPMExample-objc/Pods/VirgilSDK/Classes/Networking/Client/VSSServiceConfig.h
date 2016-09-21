//
//  VSSServiceConfig.h
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/9/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The string identifier for the Virgil Keys Service.
 */
extern NSString * __nonnull const kVSSServiceIDKeys;

/**
 * The string identifier for the Virgil Private Keys Service.
 */
extern NSString * __nonnull const kVSSServiceIDPrivateKeys;

/**
 * The string identifier for the Virgil Identity Service.
 */
extern NSString * __nonnull const kVSSServiceIDIdentity;

/**
 * Helper class for services configuration.
 */
@interface VSSServiceConfig : NSObject

/**
 * Convenient constructor.
 */
+ (VSSServiceConfig * __nonnull)serviceConfig;

/**
 * Returns list of the service IDs which can be used to get the particular info about each service.
 * 
 * @return Array of the service ids.
 */
- (NSArray <NSString *>* __nonnull)serviceIDList;

/**
 * Returns the base URL for each service by the service ID.
 *
 * @param serviceID Identifier of the service.
 *
 * @return String with base URL for the given service.
 */
- (NSString * __nonnull)serviceURLForServiceID:(NSString * __nonnull)serviceID;

/**
 * Returns service card's identity value which might be used to search the actual Virgil Card
 * on the Virgil Keys Service.
 *
 * @param serviceID Identifier of the service.
 *
 * @return String containing identity value which can be used to search for the Virgil Card.
 */
- (NSString * __nonnull)serviceCardValueForServiceID:(NSString * __nonnull)serviceID;

@end
