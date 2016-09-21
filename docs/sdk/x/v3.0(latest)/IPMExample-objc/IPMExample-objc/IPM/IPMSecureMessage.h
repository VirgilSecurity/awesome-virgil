//
//  IPMSecureMessage.h
//  IPMExample-objc
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPMSecureMessage : NSObject

@property (nonatomic, strong, readonly) NSData *message;
@property (nonatomic, strong, readonly) NSData *signature;

- (instancetype)initWithMessage:(NSData *)message signature:(NSData *)signature NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (NSDictionary *)toDTO;
+ (IPMSecureMessage * _Nullable)fromDTO:(NSDictionary *)dto;

- (NSData *)toJSON;
+ (IPMSecureMessage * _Nullable)fromJSON:(NSData *)jsonData;

@end

NS_ASSUME_NONNULL_END
