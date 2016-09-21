//
//  VSSVirgilVersion.h
//  VirgilFoundation
//
//  Created by Pavel Gorb on 2/3/15.
//  Copyright (c) 2015 VirgilSecurity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 * Gets version of the low-level Virgil cryptographic library.
 * This version is different from the version of the VirgilFoundation pod itself.
 * 
 * In general major and minor versions for the low-level library and VirgilFoundation 
 * should be the same, but it is not always the case.
 *
 * This is utility class which might come in handy when some bugs are observed and it is
 * crucial to know exact versions of every single component used in the application.
 */
@interface VSSVirgilVersion : NSObject

///-------------------------
/// @name Version
///-------------------------

/** 
 * Returns string version of the low-level virgil cryptographic library. E.g. `1.0.0` 
 */
- (NSString * __nonnull)versionString;

/** 
 * Returns numeric representation of the low-level virgil cryptographic library: (major << 16) | (minor << 8) | patch. 
 */
- (size_t)version;

/** 
 * Returns numeric representation of the major version of low-level virgil cryptographic library. 
 */
- (size_t)majorVersion;

/** 
 * Returns numeric representation of the minor version of low-level virgil cryptographic library. 
 */
- (size_t)minorVersion;

/** 
 * Returns numeric representation of the patch version low-level virgil cryptographic library. 
 */
- (size_t)patchVersion;

@end
