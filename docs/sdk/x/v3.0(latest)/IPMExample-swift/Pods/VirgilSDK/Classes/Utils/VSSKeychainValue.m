//
//  VSSKeychainValue.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 12/18/15.
//  Copyright © 2015 VirgilSecurity, Inc. All rights reserved.
//

#import "VSSKeychainValue.h"
#import "NSObject+VSSUtils.h"

NSString *const kVSSServiceName = @"VirgilSecurityServices";

@interface VSSKeychainValue ()

@property (nonatomic, strong) NSString * __nonnull identifier;
@property (nonatomic, strong) NSMutableDictionary * __nonnull value;

@property (nonatomic, strong) NSString * __nullable accessGroup;

- (NSDictionary * __nonnull)query;
- (NSDictionary * __nonnull)container;
- (void)write;

@end

@implementation VSSKeychainValue

@synthesize identifier = _identifier;
@synthesize value = _value;
@synthesize accessGroup = _accessGroup;

#pragma mark - Lifecycle

- (instancetype)initWithId:(NSString *)idfr accessGroup:(NSString *)accessGroup {
    if (idfr.length == 0) {
        return nil;
    }

    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _identifier = idfr;
    _accessGroup = accessGroup;

    NSDictionary *container = [self container];
    if (container.count > 0) {
        self.value = [[NSMutableDictionary alloc] initWithDictionary:container];
    }
    else {
        self.value = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (instancetype)init {
    return [self initWithId:kVSSServiceName accessGroup:nil];
}

- (void)reset {
    OSStatus kcError = errSecSuccess;
    NSMutableDictionary *query = [[NSMutableDictionary alloc] initWithDictionary:[self query]];
    
    [query removeObjectForKey:(__bridge id _Nonnull)kSecMatchLimit];
    kcError = SecItemDelete((__bridge CFDictionaryRef)query);
    if (kcError != errSecSuccess) {
        if (kcError != errSecItemNotFound) {
            NSLog(@"Error deleting item from the keychain: %d", (int)kcError);
            return;
        }
    }
    
    self.value = [[NSMutableDictionary alloc] init];
}

- (void)setObject:(NSObject<NSCoding> *)candidate forKey:(NSObject<NSCopying> *)aKey {
    if (aKey == nil) {
        return;
    }
    
    if (candidate == nil) {
        [self.value removeObjectForKey:aKey];
    }
    else {
        [self.value setObject:candidate forKey:aKey];
    }
    
    [self write];
}

- (NSObject *)objectForKey:(NSObject <NSCopying>*) aKey {
    if (aKey == nil) {
        return nil;
    }
    
    return self.value[aKey];
}

#pragma mark - Private class logic

- (NSDictionary *)query {
    NSMutableDictionary *query = [[NSMutableDictionary alloc] init];
    // All items will be stored as Generic Password items
    query[(__bridge id _Nonnull)kSecClass] = (__bridge id _Nonnull)kSecClassGenericPassword;
    // All items will have 'Virgil' label
    query[(__bridge id _Nonnull)kSecAttrService] = kVSSServiceName;
    // Set identifier as account
    query[(__bridge id _Nonnull)kSecAttrAccount] = self.identifier;
    query[(__bridge id _Nonnull)kSecAttrGeneric] = [self.identifier dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
#if TARGET_IPHONE_SIMULATOR
    // Ignore the access group if running on the iPhone simulator.
    //
    // Apps that are built for the simulator aren't signed, so there's no keychain access group
    // for the simulator to check. This means that all apps can see all keychain items when run
    // on the simulator.
    //
    // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
    // simulator will return -25243 (errSecNoAccessForItem).
#else
    if (self.accessGroup.length > 0) {
        query[(__bridge id _Nonnull)kSecAttrAccessGroup] = self.accessGroup;
    }
#endif
    return query;
}

- (NSDictionary *)attributes {
    OSStatus kcError = errSecSuccess;
    CFDictionaryRef attributes = NULL;
    
    NSMutableDictionary *query = [[NSMutableDictionary alloc] initWithDictionary:[self query]];
    query[(__bridge id _Nonnull)kSecMatchLimit] = (__bridge id _Nonnull)kSecMatchLimitOne;
    [query removeObjectForKey:(NSString *)kSecReturnData];
    query[(__bridge id _Nonnull)kSecReturnAttributes] = (__bridge id _Nonnull)(kCFBooleanTrue);
    
    kcError = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&attributes);
    if (kcError != errSecSuccess) {
        if (kcError != errSecItemNotFound) {
            NSLog(@"Error getting attributes from the keychain: %d", (int)kcError);
        }
        return @{};
    }
    
    return (__bridge NSDictionary *)attributes;
}

- (NSDictionary *)container {
    OSStatus kcError = errSecSuccess;
    CFDataRef data = NULL;
    
    NSMutableDictionary *query = [[NSMutableDictionary alloc] initWithDictionary:[self query]];
    // Each item search only for one particular item in the keychain
    query[(__bridge id _Nonnull)kSecMatchLimit] = (__bridge id _Nonnull)kSecMatchLimitOne;
    // Signal that we need item data instead of just attributes
    [query removeObjectForKey:(__bridge id _Nonnull)kSecReturnAttributes];
    query[(__bridge id _Nonnull)kSecReturnData] = (__bridge id _Nonnull)kCFBooleanTrue;
    
    kcError = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&data);
    if (kcError != errSecSuccess) {
        if (kcError  == errSecItemNotFound) {
            NSLog(@"Item is not found in the keychain");
        }
        else {
            NSLog(@"Error getting data from the keychain!");
        }
        return @{};
    }
    
    NSData *candidate = (__bridge NSData *)data;
    
    if (candidate == nil) {
        NSLog(@"There is nothing returned.");
        return @{};
    }
    
    return [(NSObject *)[NSKeyedUnarchiver unarchiveObjectWithData:candidate] as:[NSDictionary class]];
}

- (void)write {
    // Produce keychain item actual data from the self.value dictionary
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.value];

    OSStatus kcError = errSecSuccess;
    NSDictionary *attributes = [self attributes];
    if (attributes.count > 0) {
        // Item is in keychain. Need to update it.
        NSMutableDictionary *query = [[NSMutableDictionary alloc] initWithDictionary:attributes];
        query[(__bridge id _Nonnull)kSecClass] = [self query][(__bridge id _Nonnull)kSecClass];
        NSMutableDictionary *updateItem = [[NSMutableDictionary alloc] initWithDictionary:[self query]];
        [updateItem removeObjectForKey:(__bridge id _Nonnull)kSecClass];
#if TARGET_IPHONE_SIMULATOR
        // In case of SIMULATOR remove accessGroup just in case.
        [updateItem removeObjectForKey:(__bridge id _Nonnull)kSecAttrAccessGroup];
#endif
        updateItem[(__bridge id _Nonnull)kSecValueData] = data;

        kcError = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)updateItem);
        if (kcError != errSecSuccess) {
            NSLog(@"Error updating keychain item: %d", (int)kcError);
            return;
        }
    }
    else {
        // Compose keychain item
        NSMutableDictionary *item = [[NSMutableDictionary alloc] initWithDictionary:[self query]];
        // Set data
        item[(__bridge id _Nonnull)kSecValueData] = data;
        // Set accessible value
        item[(__bridge id _Nonnull)kSecAttrAccessible] = (__bridge id _Nonnull)kSecAttrAccessibleWhenUnlocked;
#if TARGET_IPHONE_SIMULATOR
        // In case of SIMULATOR remove accessGroup just in case.
        [item removeObjectForKey:(__bridge id _Nonnull)kSecAttrAccessGroup];
#endif
        kcError = SecItemAdd((__bridge CFDictionaryRef)item, NULL);
        if (kcError != errSecSuccess) {
            NSLog(@"Error adding keychain item: %d", (int)kcError);
            return;
        }
    }
}


@end
