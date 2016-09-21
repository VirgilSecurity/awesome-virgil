//
//  XAsyncTask.m
//  XAsyncSample
//
//  Created by Pavel Gorb on 4/13/16.
//  Copyright © 2016 Orbitum. All rights reserved.
//

#import "XAsyncTask.h"
#import <libkern/OSAtomic.h>
#import <pthread.h>

static void __taskPerform(void *info);

NS_ASSUME_NONNULL_BEGIN

@interface XAsyncTask ()

@property (nonatomic, copy, readwrite) XAsyncTaskAction action;
@property (atomic, strong) dispatch_semaphore_t _Nullable signal;

@end

@interface XAsyncManager : NSObject

@property (atomic, assign) CFRunLoopSourceRef source;

+ (XAsyncManager *)sharedManager;

- (void)awaitAll:(NSSet <XAsyncTask *> *)pool;
- (void)awaitAny:(NSSet <XAsyncTask *> *)pool;

- (void)awaitSequence:(NSArray <XAsyncTask *> *)sequence;

- (void)await:(XAsyncTask *)task;

@end

NS_ASSUME_NONNULL_END

@implementation XAsyncManager

@synthesize source = _source;

- (instancetype)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    CFRunLoopSourceContext context;
    memset(&context, 0, sizeof(context));
    context.perform = __taskPerform;
    context.info = NULL;
    
    _source = CFRunLoopSourceCreate(NULL, 0, &context);
    return self;
}

+ (XAsyncManager *)sharedManager {
    static XAsyncManager *__xa_manager = nil;
    static dispatch_once_t __xa_manager_token;
    dispatch_once(&__xa_manager_token, ^{
        __xa_manager = [[XAsyncManager alloc] init];
    });
    return __xa_manager;
}


- (void)awaitAll:(NSSet<XAsyncTask *> *)pool {
    if (pool.count == 0) {
        return;
    }
    
    CFRunLoopRef callerRunLoop = CFRunLoopGetCurrent();
    if (!CFRunLoopContainsSource(callerRunLoop, self.source, kCFRunLoopCommonModes)) {
        CFRunLoopAddSource(callerRunLoop, self.source, kCFRunLoopCommonModes);
    }
    
    int64_t __block number = (int64_t)[pool count];
    bool __block complete = false;
    for (XAsyncTask *task in pool) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            task.action(task);
            if (OSAtomicDecrement64(&number) == 0) {
                complete = true;
                CFRunLoopSourceSignal(self.source);
                CFRunLoopWakeUp(callerRunLoop);
            }
        });
    }
    
    while(!complete) {
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true);
    }
}

- (void)awaitAny:(NSSet<XAsyncTask *> *)pool {
    if (pool.count == 0) {
        return;
    }
    
    CFRunLoopRef callerRunLoop = CFRunLoopGetCurrent();
    if (!CFRunLoopContainsSource(callerRunLoop, self.source, kCFRunLoopCommonModes)) {
        CFRunLoopAddSource(callerRunLoop, self.source, kCFRunLoopCommonModes);
    }
    
    int32_t __block done = 0;
    for (XAsyncTask *task in pool) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            task.action(task);
            if (OSAtomicCompareAndSwap32(0, 1, &done)) {
                CFRunLoopSourceSignal(self.source);
                CFRunLoopWakeUp(callerRunLoop);
            }
        });
    }
    
    while(!done) {
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true);
    }
}

- (void)await:(XAsyncTask *)task {
    [self awaitAll:[NSSet setWithObject:task]];
}

- (void)awaitSequence:(NSArray <XAsyncTask *> *)sequence {
    if (sequence.count == 0) {
        return;
    }
    
    for (XAsyncTask *task in sequence) {
        [self await:task];
    }
}

@end


@implementation XAsyncTask

@synthesize action = _action;
@synthesize result = _result;
@synthesize signal = _signal;

#pragma mark - Convenience getter

- (NSError * _Nullable)error {
    if ([self.result isKindOfClass:[NSError class]]) {
        return self.result;
    }
    
    return nil;
}

#pragma mark - Lifecycle

- (instancetype)initWithAction:(XAsyncTaskAction)action {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _action = [action copy];
    return self;
}

- (instancetype)init {
    return [self initWithAction:^(XAsyncTask * __weak _Nonnull task){}];
}

+ (instancetype)taskWithAction:(XAsyncTaskAction)action {
    return [[self alloc] initWithAction:action];
}

#pragma mark - Class logic

- (void)await {
    [[XAsyncManager sharedManager] await:self];
}

+ (void)awaitAll:(NSSet<XAsyncTask *> *)pool {
    [[XAsyncManager sharedManager] awaitAll:pool];
}

+ (void)awaitAny:(NSSet<XAsyncTask *> *)pool {
    [[XAsyncManager sharedManager] awaitAny:pool];
}

+ (void)awaitSequence:(NSArray <XAsyncTask *> *)sequence {
    [[XAsyncManager sharedManager] awaitSequence:sequence];
}

- (void)awaitSignal {
    dispatch_semaphore_t s = dispatch_semaphore_create(0);
    if (s == NULL) {
        return;
    }
    
    self.signal = s;
    [[XAsyncManager sharedManager] await:self];
    dispatch_semaphore_wait(self.signal, DISPATCH_TIME_FOREVER);
    self.signal = nil;
}

- (void)fireSignal {
    if (!self.signal) {
        return;
    }
    
    dispatch_semaphore_signal(self.signal);
}

@end

static void __taskPerform(void *info) {
    
}
