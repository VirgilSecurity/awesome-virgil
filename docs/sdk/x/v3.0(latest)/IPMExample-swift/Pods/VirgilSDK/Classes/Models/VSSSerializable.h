//
//  VSSSerializable.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/7/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Protocol for deserialization NSDictionaries to VSSModel descendants.
 *
 * Each VSSModel and its descendants implement this protocol.
 */
@protocol VSSSerializable <NSObject>

@required
/**
 * Performs deserialization of the given dictionary into VSSModel.
 *
 * @param candidate Dictionary with data transfer object which should be converted into VSSModel.
 * 
 * @return Instance of VSSModel or its particular descendant.
 */
+ (instancetype __nonnull)deserializeFrom:(NSDictionary * __nonnull)candidate;

@end
