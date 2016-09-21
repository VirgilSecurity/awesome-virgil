//
//  VSSRequest.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/7/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSRequest.h"
#import "VSSRequest_Private.h"
#import "VSSRequestContext.h"
#import "NSString+VSSXMLEscape.h"
#import "NSObject+VSSUtils.h"

const NSTimeInterval kVSSRequestDefaultTimeout = 45.0f;
NSString *const kVSSRequestDefaultMethod = @"POST";
NSString *const kVSSRequestErrorDomain = @"VSSRequestErrorDomain";
const NSInteger kVSSRequestClientErrorCode = -9090;
const NSInteger kVSSRequestCancelledErrorCode = -1000;
NSString *const kVSSRequestCancelledErrorDescription = @"Cancelled";

NSString *const kVSSAccessTokenHeader = @"X-VIRGIL-ACCESS-TOKEN";
NSString *const kVSSRequestIDHeader = @"X-VIRGIL-REQUEST-ID";
NSString *const kVSSRequestSignHeader = @"X-VIRGIL-REQUEST-SIGN";
NSString *const kVSSRequestSignCardIDHeader = @"X-VIRGIL-REQUEST-SIGN-VIRGIL-CARD-ID";

NSString *const kVSSResponseSignHeader = @"X-VIRGIL-RESPONSE-SIGN";
NSString *const kVSSResponseIDHeader = @"X-VIRGIL-RESPONSE-ID";

@interface VSSRequest ()

+ (NSString * __nonnull)HTTPMethodNameForMethod:(HTTPRequestMethod)method;
+ (HTTPRequestMethod)methodForHTTPMethodName:(NSString * __nullable)name;

@end

@implementation VSSRequest

@synthesize request = _request;
@synthesize response = _response;
@synthesize error = _error;
@synthesize responseBody = _responseBody;
@synthesize completionHandler = _completionHandler;

#pragma mark - Getters/Setters implementation

- (NSURLRequest *)request {
    if(_request != nil) {
        return _request;
    }
    
    NSString *serviceURL = [self.context serviceUrl];
    if (![serviceURL hasSuffix:@"/"]) {
        serviceURL = [NSString stringWithFormat:@"%@/", serviceURL];
    }
    NSString *methodPath = [self methodPath];
    if ([methodPath hasPrefix:@"/"]) {
        methodPath = [methodPath substringFromIndex:1];
    }
    
    NSURL *url = [NSURL URLWithString:[serviceURL stringByAppendingString:methodPath]];

    NSMutableURLRequest* r = [NSMutableURLRequest requestWithURL:url];
    [r setTimeoutInterval:kVSSRequestDefaultTimeout];
    [r setHTTPMethod:kVSSRequestDefaultMethod];
    _request = r;
    return _request;
}

- (VSSRequestCompletionHandler)completionHandler {
    VSSRequestCompletionHandler blk = nil;
    @synchronized(self) {
        blk = [_completionHandler copy];
    }
    return blk;
}

- (void)setCompletionHandler:(VSSRequestCompletionHandler)completionHandler {
    @synchronized(self) {
        _completionHandler = [completionHandler copy];
    }
}

#pragma mark - Initialization and configuration stuff

- (instancetype)initWithContext:(VSSRequestContext *)context; {
    self = [super init];
    if (self == nil) {
        return nil;
    }

    _context = context;
    return self;
}

- (instancetype)init {
    return [self initWithContext:[[VSSRequestContext alloc] init]];
}

#pragma mark - Methods to be overloaded by the descendent classes

- (NSString *)methodPath {
    return @"";
}

- (NSObject *)parseResponse {
    return nil;
}

- (NSError *)handleError:(NSObject *)candidate {
    return [candidate as:[NSError class]];
}

- (NSError *)handleResponse:(NSObject *)candidate {
    return [candidate as:[NSError class]];
}

#pragma mark - Public class logic

- (void)setRequestMethod:(HTTPRequestMethod)method {
    NSMutableURLRequest *r = [self.request as:[NSMutableURLRequest class]];
    r.HTTPMethod = [[self class] HTTPMethodNameForMethod:method];
}

- (void)setRequestHeaders:(NSDictionary *)headers {
    for (NSString *header in [headers allKeys]) {
        NSString *value = [headers[header] as:[NSString class]];
        if (value != nil) {
            NSMutableURLRequest *r = [self.request as:[NSMutableURLRequest class]];
            [r setValue:value forHTTPHeaderField:header];
        }
    }
}

- (void)setRequestBody:(NSData *)body {
    if (body != nil) {
        NSMutableURLRequest *r = [self.request as:[NSMutableURLRequest class]];
        r.HTTPBody = body;
    }
}

- (void)setRequestQuery:(NSDictionary *)params {
    if (params == nil) {
        return;
    }
    
    NSMutableString *queryString = [[NSMutableString alloc] init];
    for (NSString *name in [params allKeys]) {
        NSString *value = [params[name] as:[NSString class]];
        if (value != nil) {
            [queryString appendFormat:@"&%@=%@", name, value];
        }
    }
    NSString *query = [queryString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"& "]];
    if (query.length == 0) {
        return;
    }
    
    NSMutableURLRequest *r = [self.request as:[NSMutableURLRequest class]];
    NSString *url = r.URL.absoluteString;
    r.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", url, query]];
}

- (NSURLSessionDataTask * __nonnull)taskForSession:(NSURLSession * __nonnull)session {
    NSURLSessionDataTask *task = [session dataTaskWithRequest:self.request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (self.completionHandler != nil) {
            __weak VSSRequest *weakRequest = self;
            if (error != nil) {
                self.error = error;
                self.completionHandler(weakRequest);
                return;
            }
            
            NSHTTPURLResponse *httpResponse = [response as:[NSHTTPURLResponse class]];
#if USE_SERVICE_REQUEST_DEBUG
            VSSRDLog(@"%@: response URL: %@", NSStringFromClass(self.class), httpResponse.URL);
            VSSRDLog(@"%@: response HTTP status code: %ld", NSStringFromClass(self.class), (long)httpResponse.statusCode);
            VSSRDLog(@"%@: response headers: %@", NSStringFromClass(self.class), httpResponse.allHeaderFields);
            if( data.length != 0 )
            {
                NSString *bodyStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                VSSRDLog(@"%@: response body: %@", NSStringFromClass(self.class), bodyStr);
            }
#endif
            self.response = httpResponse;
            self.responseBody = data;
            
            switch (httpResponse.statusCode) {
                case 200:
                    break;
                default:
                    self.error = [NSError errorWithDomain:kVSSRequestErrorDomain code:httpResponse.statusCode userInfo:nil];
                    break;
            }
            
            /// Fisrt of all we want to check if there is an error in response then we want to get
            /// an business logic error code from it to make the error much more detailed then just http status 400
            /// or whatever.
            NSObject *parsedResponse = [self parseResponse];
            // In any case we should check if response object contains some kind of service error.
            NSError *logicError = [self handleError:parsedResponse];
            if (logicError != nil) {
                /// Prioritize logic error over the HTTP Status code.
                self.error = logicError;
            }
            else {
                /// At this point we might still have generic error based on HTTP response status code and
                /// there is no handled error from service in the response body.
                /// In this case it is not necessary to handle the response (because handleResponse represents
                /// actually successful response without any kind of errors).
                if (self.error != nil) {
                    self.completionHandler(weakRequest);
                    return;
                }
                
                /// If there is no error so far, try to handle the response.
                /// This might also trigger an error.
                NSError *handlingError = [self handleResponse:parsedResponse];
                if (handlingError != nil) {
                    /// Prioritize handling error over anything that was before.
                    self.error = handlingError;
                }
            }
            
            self.completionHandler(weakRequest);
        }
    }];
    
    return task;
}

#pragma mark - Private class logic

+ (NSString *)HTTPMethodNameForMethod:(HTTPRequestMethod)method {
    NSString *name = nil;
    switch (method) {
        case GET:
            name = @"GET";
            break;
        case POST:
            name = @"POST";
            break;
        case PUT:
            name = @"PUT";
            break;
        case DELETE:
            name = @"DELETE";
            break;
        default:
            name = kVSSRequestDefaultMethod;
            break;
    }
    return name;
}

+ (HTTPRequestMethod)methodForHTTPMethodName:(NSString *)name {
    HTTPRequestMethod method = POST;
    if ([name isEqualToString:@"GET"]) {
        method = GET;
    }
    else if ([name isEqualToString:@"PUT"]) {
        method = PUT;
    }
    else if ([name isEqualToString:@"DELETE"]) {
        method = DELETE;
    }
    
    return method;
}

@end
