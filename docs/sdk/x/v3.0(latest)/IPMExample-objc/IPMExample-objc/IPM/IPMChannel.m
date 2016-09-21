//
//  IPMChannel.m
//  IPMExample-objc
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

#import "IPMChannel.h"
#import "IPMConstants.h"
#import "IPMSecureMessage.h"

@import VirgilSDK;

NS_ASSUME_NONNULL_BEGIN

@interface IPMChannel ()

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong) NSString *token;

@property (nonatomic, copy) IPMDataSourceListener _Nullable listener;
@property (nonatomic, strong) dispatch_source_t _Nullable timer;
@property (nonatomic, strong) NSString * _Nonnull lastMessageId;

@property (nonatomic, strong) NSURLSession *session;

- (void)startTimer;
- (void)dropTimer;

@end

NS_ASSUME_NONNULL_END

@implementation IPMChannel

@synthesize name = _name;
@synthesize token = _token;

@synthesize listener = _listener;
@synthesize timer = _timer;
@synthesize lastMessageId = _lastMessageId;
@synthesize session = _session;

- (instancetype)initWithName:(NSString *)name token:(NSString *)token {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _name = name;
    _token = token;
    _timer = nil;
    _lastMessageId = @"";
    
    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    return self;
}

- (instancetype)init {
    return [self initWithName:@"" token:@""];
}

- (void)dealloc {
    [self stopListening];
}

#pragma mark - Class logic 

- (NSError *)sendMessage:(IPMSecureMessage *)message {
    XAsyncTask *send = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable async) {
        NSString *urlString = [NSString stringWithFormat:@"%@/channels/%@/messages", kBaseURL, self.name];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[message toJSON]];
        [request setValue:self.token forHTTPHeaderField:kIdentityTokenHeader];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSURLSessionTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                async.result = error;
                [async fireSignal];
                return;
            }
            
            NSHTTPURLResponse *r = [response as:[NSHTTPURLResponse class]];
#ifdef DEBUG
            NSLog(@"%@: response URL: %@", NSStringFromClass(self.class), r.URL);
            NSLog(@"%@: response HTTP status code: %ld", NSStringFromClass(self.class), (long)r.statusCode);
            NSLog(@"%@: response headers: %@", NSStringFromClass(self.class), r.allHeaderFields);
            if( data.length != 0 )
            {
                NSString *bodyStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@: response body: %@", NSStringFromClass(self.class), bodyStr);
            }
#endif
            if (r.statusCode >= 400) {
                NSError *httpError = [NSError errorWithDomain:@"HTTPError" code:r.statusCode userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString([NSHTTPURLResponse localizedStringForStatusCode:r.statusCode], @"No comments") }];
                async.result = httpError;
                [async fireSignal];
                return;
            }
            
            async.result = nil;
            [async fireSignal];
        }];
#ifdef DEBUG
        NSLog(@"%@: request URL: %@", NSStringFromClass(self.class), request.URL);
        NSLog(@"%@: request method: %@", NSStringFromClass(self.class), request.HTTPMethod);
        if (request.HTTPBody.length) {
            NSString *logStr = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
            NSLog(@"%@: request body: %@", NSStringFromClass(self.class), logStr);
        }
        NSLog(@"%@: request headers: %@", NSStringFromClass(self.class), request.allHTTPHeaderFields);
        
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSArray *cookies = [cookieStorage cookiesForURL:request.URL];
        for (NSHTTPCookie *cookie in cookies) {
            NSLog(@"*******COOKIE: %@: %@", [cookie name], [cookie value]);
        }
#endif
        [task resume];
    }];
    [send awaitSignal];
    
    return send.error;
}

- (NSArray *)getParticipants {
    XAsyncTask *participants = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable async) {
        NSString *urlString = [NSString stringWithFormat:@"%@/channels/%@/members", kBaseURL, self.name];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"GET"];
        [request setValue:self.token forHTTPHeaderField:kIdentityTokenHeader];
        
        NSMutableArray *members = [[NSMutableArray alloc] init];
        
        NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                async.result = error;
                [async fireSignal];
                return;
            }
            NSHTTPURLResponse *r = [response as:[NSHTTPURLResponse class]];
#ifdef DEBUG
            NSLog(@"%@: response URL: %@", NSStringFromClass(self.class), r.URL);
            NSLog(@"%@: response HTTP status code: %ld", NSStringFromClass(self.class), (long)r.statusCode);
            NSLog(@"%@: response headers: %@", NSStringFromClass(self.class), r.allHeaderFields);
            if( data.length != 0 )
            {
                NSString *bodyStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@: response body: %@", NSStringFromClass(self.class), bodyStr);
            }
#endif
            if (r.statusCode >= 400) {
                NSError *httpError = [NSError errorWithDomain:@"HTTPError" code:r.statusCode userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString([NSHTTPURLResponse localizedStringForStatusCode:r.statusCode], @"No comments") }];
                async.result = httpError;
                [async fireSignal];
                return;
            }
            
            if (data.length == 0) {
                /// There is no participants.
                async.result = nil;
                [async fireSignal];
                return;
            }
            
            NSError *jsonError = nil;
            NSArray <NSDictionary *> *participants = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (jsonError != nil) {
                async.result = jsonError;
                [async fireSignal];
                return;
            }
            
            for (NSDictionary *participant in participants) {
                NSString *sender = [participant[kSenderIdentifier] as:[NSString class]];
                if (sender != nil) {
                    [members addObject:sender];
                }
            }
            async.result = members;
            [async fireSignal];
        }];
        [task resume];
    }];
    [participants awaitSignal];
    
    if (participants.error != nil) {
        NSLog(@"Error getting chat participants: %@", [participants.error localizedDescription]);
        return nil;
    }
    return [participants.result as:[NSArray class]];
}

- (void)startListeningWithHandler:(IPMDataSourceListener)handler {
    [self stopListening];
    self.listener = handler;
    
    [self startTimer];
}

- (void)stopListening {
    [self dropTimer];
    self.listener = nil;
}

#pragma mark - Timer handler

- (void)startTimer {
    [self dropTimer];
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    if( timer != nil ) {
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, kTimerInterval * NSEC_PER_SEC, 1ull * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^(void) {
            NSString *query = (self.lastMessageId.length == 0) ? @"" : [NSString stringWithFormat:@"?last_message_id=%@", self.lastMessageId];
            NSString *urlString = [NSString stringWithFormat:@"%@/channels/%@/messages%@", kBaseURL, self.name, query];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
            [request setHTTPMethod:@"GET"];
            [request setValue:self.token forHTTPHeaderField:kIdentityTokenHeader];
            
            NSURLSessionTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error != nil) {
                    NSLog(@"Error getting messages from datasource:");
                    NSLog(@"%@", [error localizedDescription]);
                    return;
                }
                
                NSHTTPURLResponse *r = [response as:[NSHTTPURLResponse class]];
#ifdef DEBUG
                NSLog(@"%@: response URL: %@", NSStringFromClass(self.class), r.URL);
                NSLog(@"%@: response HTTP status code: %ld", NSStringFromClass(self.class), (long)r.statusCode);
                NSLog(@"%@: response headers: %@", NSStringFromClass(self.class), r.allHeaderFields);
                if( data.length != 0 )
                {
                    NSString *bodyStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"%@: response body: %@", NSStringFromClass(self.class), bodyStr);
                }
#endif
                if (r.statusCode >= 400) {
                    NSLog(@"HTTP Error with status code '%ldl':", (long)r.statusCode);
                    NSLog(@"%@", [NSHTTPURLResponse localizedStringForStatusCode:r.statusCode]);
                    return;
                }
                if (data.length == 0) {
                    /// There is no new messages received.
                    NSLog(@"There is no new messages found.");
                    return;
                }
                NSError *jsonError = nil;
                NSArray <NSDictionary *> *messages = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                if (jsonError != nil) {
                    NSLog(@"Error deserializing messages from datasource's response:");
                    NSLog(@"%@", [jsonError localizedDescription]);
                    return;
                }
                
                NSString *messageId = [[messages lastObject] as:[NSDictionary class]][kMessageId];
                if (messageId.length > 0) {
                    self.lastMessageId = messageId;
                }

                if (self.listener != nil) {
                    for (NSDictionary* message in messages) {
                        IPMSecureMessage *content = [IPMSecureMessage fromDTO:message];
                        if (content == nil) {
                            /// Maybe other message format. We can not read these.
                            continue;
                        }
                        NSString *sender = [message[kMessageSender] as:[NSString class]];
                        if (sender == nil) {
                            sender = @"";
                        }
                        self.listener(content, sender);
                    }
                }
            }];
#ifdef DEBUG
            NSLog(@"%@: request URL: %@", NSStringFromClass(self.class), request.URL);
            NSLog(@"%@: request method: %@", NSStringFromClass(self.class), request.HTTPMethod);
            if (request.HTTPBody.length) {
                NSString *logStr = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
                NSLog(@"%@: request body: %@", NSStringFromClass(self.class), logStr);
            }
            NSLog(@"%@: request headers: %@", NSStringFromClass(self.class), request.allHTTPHeaderFields);
            
            NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSArray *cookies = [cookieStorage cookiesForURL:request.URL];
            for (NSHTTPCookie *cookie in cookies) {
                NSLog(@"*******COOKIE: %@: %@", [cookie name], [cookie value]);
            }
#endif
            [task resume];
        });
        dispatch_resume(timer);
        self.timer = timer;
    }
}

- (void)dropTimer {
    if (self.timer != nil) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

@end
