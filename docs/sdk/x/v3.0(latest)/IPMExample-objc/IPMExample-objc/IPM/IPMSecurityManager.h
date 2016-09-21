//
//  IPMSecurityManager.h
//  IPMExample-objc
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@import VirgilSDK;
@import XAsync;

NS_ASSUME_NONNULL_BEGIN

@interface IPMSecurityManager : NSObject

@property (nonatomic, strong, readonly) NSString *identity;
@property (nonatomic, strong, readonly) VSSPrivateKey *privateKey;

- (instancetype)initWithIdentity:(NSString *)identity NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)cacheCardForIdentities:(NSArray *)identities;

- (BOOL)checkSignature:(NSData *)signature data:(NSData *)data identity:(NSString *)identity;
- (NSData * _Nullable)encryptData:(NSData *)data identities:(NSArray *)identities;
- (NSData * _Nullable)decryptData:(NSData *)data;
- (NSData * _Nullable)composeSignatureOnData:(NSData *)data;

- (NSError * _Nullable)signin;
- (NSError * _Nullable)signup;

@end

NS_ASSUME_NONNULL_END
