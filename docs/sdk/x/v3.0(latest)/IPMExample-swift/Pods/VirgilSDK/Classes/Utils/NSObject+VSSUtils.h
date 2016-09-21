//
//  NSObject+VFUtils.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/7/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Helper category for convenient type casting.
 */
@interface NSObject (VSSUtils)

/**
 * Returns object casted to required class or nil if source object can not be casted.
 *
 * @param expectedClass Class to which the object needs to be casted.
 * 
 * @return Object of required class or nil.
 */
- (id __nullable)as:(Class __nonnull)expectedClass;

@end
