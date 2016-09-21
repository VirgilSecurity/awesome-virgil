//
//  VSSClient.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/11/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSBaseClient.h"
#import "VSSRequest.h"
#import "VSSCard.h"
#import "VSSPrivateKey.h"
#import "VSSRequest_Private.h"
#import "NSObject+VSSUtils.h"

#import "VSSServiceConfig.h"

NSString *const kVSSClientErrorDomain = @"VSSClientErrorDomain";

@interface VSSBaseClient ()

@property (nonatomic, strong, readwrite) NSString * __nonnull token;
@property (nonatomic, strong) VSSServiceConfig * __nonnull serviceConfig;
@property (nonatomic, strong) NSOperationQueue * __nonnull queue;
@property (nonatomic, strong) NSURLSession * __nonnull urlSession;

@end

@implementation VSSBaseClient

@synthesize token = _token;
@synthesize queue = _queue;
@synthesize urlSession = _urlSession;

#pragma mark - Lifecycle

- (instancetype)initWithApplicationToken:(NSString *)token serviceConfig:(VSSServiceConfig *)serviceConfig {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _token = token;
    _serviceConfig = serviceConfig;
    if (_serviceConfig == nil) {
        _serviceConfig = [VSSServiceConfig serviceConfig];
    }
    
    _queue = [[NSOperationQueue alloc] init];
    _queue.maxConcurrentOperationCount = 10;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    _urlSession = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:_queue];
    
    return self;
}

- (instancetype)initWithApplicationToken:(NSString *)token {
    return [self initWithApplicationToken:token serviceConfig:nil];
}

- (instancetype)init {
    return [self initWithApplicationToken:@"" serviceConfig:nil];
}

- (void)dealloc {
    [_urlSession invalidateAndCancel];
    [_queue cancelAllOperations];
}

#pragma mark - Public class logic

- (void)setupClientWithCompletionHandler:(void(^ __nullable)(NSError * __nullable))completionHandler {
    /// Parent implementation just calls completionHandler with no error asynchronously.
    if (completionHandler != nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            completionHandler(nil);
        });
    }
}

- (void)send:(VSSRequest *)request {
    if (request == nil) {
        return;
    }
    
#if USE_SERVICE_REQUEST_DEBUG
    {
        VSSRDLog(@"%@: request URL: %@", NSStringFromClass(request.class), request.request.URL);
        VSSRDLog(@"%@: request method: %@", NSStringFromClass(request.class), request.request.HTTPMethod);
        if (request.request.HTTPBody.length) {
            NSString *logStr = [[NSString alloc] initWithData:request.request.HTTPBody encoding:NSUTF8StringEncoding];
            VSSRDLog(@"%@: request body: %@", NSStringFromClass(request.class), logStr);
        }
        VSSRDLog(@"%@: request headers: %@", NSStringFromClass(request.class), request.request.allHTTPHeaderFields);
        
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSArray *cookies = [cookieStorage cookiesForURL:request.request.URL];
        for (NSHTTPCookie *cookie in cookies) {
            VSSRDLog(@"*******COOKIE: %@: %@", [cookie name], [cookie value]);
        }
    }
#endif
    
    NSURLSessionDataTask *task = [request taskForSession:self.urlSession];
    [task resume];
}

@end
