//
//  NSString+VFXMLEscape.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/7/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "NSString+VSSXMLEscape.h"

@implementation NSString (VSSXMLEscape)

+ (NSString *)stringWithPercentEscapesForString:(NSString *)srcString {
    if (nil == srcString) {
        return nil;
    }
    NSString *result = [srcString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"￼=,!$&'()*+;@?\n\"<>#\t :/"]];
    return result;
}

+ (NSString *)stringRemovePercentEscapesForString:(NSString *)srcString {
    if (nil == srcString) {
        return nil;
    }
    
    NSString *result = [srcString stringByRemovingPercentEncoding];
    return result;
}

@end
