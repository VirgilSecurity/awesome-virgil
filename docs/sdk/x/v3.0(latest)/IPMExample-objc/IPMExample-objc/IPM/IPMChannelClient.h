//
//  IPMChannelClient.h
//  IPMExample-objc
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPMDataSource.h"

@import XAsync;

NS_ASSUME_NONNULL_BEGIN

@interface IPMChannelClient : NSObject

@property (nonatomic, strong, readonly) NSString *userId;
@property (nonatomic, strong, readonly) id<IPMDataSource> _Nullable channel;

- (instancetype)initWithUserId:(NSString *)userId NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (NSError * _Nullable)joinChannelWithName:(NSString *)name channelListener:(IPMDataSourceListener)listener;
- (void)leaveChannel;

@end

NS_ASSUME_NONNULL_END
