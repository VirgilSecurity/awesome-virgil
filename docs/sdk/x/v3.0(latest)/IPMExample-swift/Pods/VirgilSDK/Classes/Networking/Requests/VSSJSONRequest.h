//
//  VSSJSONRequest.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/11/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSRequestExtended.h"

/**
 * Class which manages the JSON-based requests.
 * Takes care about the serialization/deserialization and proper content-type header.
 */
@interface VSSJSONRequest : VSSRequestExtended

/**
 * Serializes the given object to the request data.
 * 
 * @param candidate Object to be serialized to the request body.
 */
- (void)setRequestBodyWithObject:(NSObject * __nonnull)candidate;

@end
