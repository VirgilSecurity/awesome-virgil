//
//  NSString+VFXMLEscape.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/7/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Helper category for adding/removing percent escaping in strings.
 */
@interface NSString (VSSXMLEscape)

/**
 * Adds percent escapes for the symbols =,!$&'()*+;@?\n\"<>#\t :/ to the srcString. Composes new string as a result.
 * 
 * @param srcString String which needs to be percent escaped.
 *
 * @return New string composed as a srcString with percent escapes of the required symbols.
 */
+ (NSString * __nonnull)stringWithPercentEscapesForString:(NSString * __nonnull)srcString;

/**
 * Removes percent escapes from the srcString. Composes new string as a result.
 *
 * @param srcString String which needs to remove percent escapes
 *
 * @return New string composed as a srcString without percent escapes.
 */
+ (NSString * __nonnull)stringRemovePercentEscapesForString:(NSString* __nonnull)srcString;

@end
