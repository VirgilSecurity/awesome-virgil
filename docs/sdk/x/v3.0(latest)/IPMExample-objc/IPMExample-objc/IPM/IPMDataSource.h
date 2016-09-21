//
//  IPMDataSource.h
//  IPMExample-objc
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@import XAsync;

@class IPMSecureMessage;

typedef void (^IPMDataSourceListener)(IPMSecureMessage * _Nonnull message, NSString * _Nonnull sender);

@protocol IPMDataSource <NSObject>

- (void)startListeningWithHandler:(IPMDataSourceListener _Nonnull)handler;
- (void)stopListening;

- (NSArray * _Nullable)getParticipants;
- (NSError * _Nullable)sendMessage:(IPMSecureMessage * _Nonnull)message;

@end
