//
//  IPMChannel.h
//  IPMExample-objc
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPMDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface IPMChannel : NSObject <IPMDataSource>

@property (nonatomic, strong, readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name token:(NSString *)token NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END