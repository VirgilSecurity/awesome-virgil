//
//  VSSError.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/12/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSModel.h"
#import "VSSModelCommons.h"

/**
 * Wrapper object for managing errors returned by the Virgil Services.
 */
@interface VSSError : VSSModel

/**
 * Error code returned by the Virgil Service.
 */
@property (nonatomic, assign, readonly) NSInteger code;

///------------------------------------------
/// @name Lifecycle
///------------------------------------------

/**
 * Designated constructor.
 *
 * @param code Error code.
 * 
 * @return Instance of the Virgil Error wrapper.
 */
- (instancetype __nonnull)initWithCode:(NSInteger)code NS_DESIGNATED_INITIALIZER;

///------------------------------------------
/// @name Utility
///------------------------------------------

/**
 * Convenient method for getting the actual error message based on the current error code.
 *
 * @return String meaning of the error code.
 */
- (NSString * __nullable)message;

/**
 * Convenient method for getting the NSError object from the VSSError.
 *
 * @return NSError representation of the current error.
 */
- (NSError * __nullable)nsError;

@end
