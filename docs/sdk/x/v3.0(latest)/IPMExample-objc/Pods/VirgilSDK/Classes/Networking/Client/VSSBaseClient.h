//
//  VSSClient.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/11/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define USE_SERVICE_CLIENT_DEBUG 1
#endif

/// Debugging macro
#if USE_SERVICE_CLIENT_DEBUG
#  define VSSCLDLog(...) NSLog(__VA_ARGS__)
# else
#  define VSSCLDLog(...) /* nothing to log */
#endif

/**
 * Error domain for all the errors of the Virgil client.
 */
extern NSString * __nonnull const kVSSClientErrorDomain;

@class VSSRequest;
@class VSSCard;
@class VSSPrivateKey;

@class VSSServiceConfig;

/**
 * Base class for the Virgil Services client.
 *
 * Contains utility functionality to maintain all kinds of the requests to the services.
 */
@interface VSSBaseClient : NSObject

/**
 * String token which might be required by the service.
 */
@property (nonatomic, strong, readonly) NSString * __nonnull token;

/**
 * Service configuration object, which contains the information about the service URLs and/or service identifiers.
 */
@property (nonatomic, strong, readonly) VSSServiceConfig * __nonnull serviceConfig;

///------------------------------------------
/// @name Lifecycle
///------------------------------------------

/**
 * Designated constructor.
 * Creates instance of VSSClient particular class.
 *
 * @param token NSString containing application token received from https://developer.virgilsecurity.com/dashboard/
 * @param serviceConfig Object containing the service configuration. When nil - the default Virgil Service configuration will be used.
 *
 * @return Instance of the Virgil client.
 */
- (instancetype __nonnull)initWithApplicationToken:(NSString * __nonnull)token serviceConfig:(VSSServiceConfig * __nullable)serviceConfig NS_DESIGNATED_INITIALIZER;

/**
 * Convenient constructor.
 * Creates instance of VSSClient particular class. 
 * Call to this method is a shortcut for the initWithApplicationToken:serviceConfig: when serviceConfig is nil.
 *
 * @param token NSString containing application token received from https://developer.virgilsecurity.com/dashboard/
 *
 * @return Instance of the Virgil client.
 */
- (instancetype __nonnull)initWithApplicationToken:(NSString * __nonnull)token;

///------------------------------------------
/// @name Setup
///------------------------------------------

/**
 * Performs initial setup of the client.
 * 
 * Parent implementation is just calls the completion handler on the background thread.
 * 
 * @param completionHandler Callback to call when setup is done.
 */
- (void)setupClientWithCompletionHandler:(void(^ __nullable)(NSError * __nullable))completionHandler;

///------------------------------------------
/// @name Utility
///------------------------------------------

/**
 * Adds given request to the execution queue and sends it to service.
 *
 * @param request The particular request to be performed.
 */
- (void)send:(VSSRequest * __nonnull)request;

@end
