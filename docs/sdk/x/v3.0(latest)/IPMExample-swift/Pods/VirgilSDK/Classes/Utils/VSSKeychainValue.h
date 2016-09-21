//
//  VSSKeychainValue.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 12/18/15.
//  Copyright © 2015 VirgilSecurity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Constant service name for the Virgil Services.
 */
extern NSString * __nonnull const kVSSServiceName;

/**
 * Helper class for the Keychain operations.
 *
 */
@interface VSSKeychainValue : NSObject

/**
 * Designated constructor.
 *
 * @param idfr String identifier of the current keychain value.
 * @param accessGroup String identifier for the keychain access group (allows to share items between the apps).
 * In case of nil there is no access group assigned and item will only be accessible by the same app.
 *
 * @return Instance of the Keychain Value.
 */
- (instancetype __nonnull)initWithId:(NSString * __nonnull)idfr accessGroup:(NSString * __nullable)accessGroup NS_DESIGNATED_INITIALIZER;

/**
 * Clears all the information for the current keychain value item. Removes all related objects from the keychain.
 * Use this method to remove all the information for all the keys at once.
 */
- (void)reset;

/**
 * Changes value for the given key in the keychain.
 * In case when candidate object is not nil - this object will be set for the key as a new value.
 * In case when candidate is nil - value for the given key will be removed from the keychain.
 *
 * @param candidate Object to store in the keychain. The object **MUST** conform to NSCoding protocol.
 * @param aKey Object to use as a key. This object **MUST** confirm to NSCopying  protocol.
 */
- (void)setObject:(NSObject<NSCoding> * __nullable)candidate forKey:(NSObject<NSCopying> * __nonnull)aKey;

/**
 * Returns object stored in the keychain value for the given key.
 * In case when there is no object stored for the given key - returns nil.
 *
 * @param aKey Object to use as a key. This object **MUST** confirm to NSCopying protocol.
 *
 * @return Object stored in the keychain for the given key or nil.
 */
- (NSObject * __nullable)objectForKey:(NSObject <NSCopying>* __nonnull)aKey;

@end
