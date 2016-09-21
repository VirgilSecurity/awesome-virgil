//
//  XAsyncTask.h
//  XAsyncSample
//
//  Created by Pavel Gorb on 4/13/16.
//  Copyright © 2016 Orbitum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XAsyncTask;

/**
 * Type representing the actual async task action.
 */
typedef void (^XAsyncTaskAction)(XAsyncTask __weak * _Nullable task);

NS_ASSUME_NONNULL_BEGIN

/**
 * Wrapper class for asyncronous actions.
 * Calls to methods of this class allow to perform synchronous non-blocking wait for completion
 * of the particular operation in background thread.
 * This makes the code much better structured and much easier to read and maintain.
 */
@interface XAsyncTask : NSObject

/**
 * Action which should be performed asyncronously.
 */
@property (nonatomic, copy, readonly) XAsyncTaskAction action;

/**
 * Container for the resulting value. Might be nil.
 */
@property (nonatomic, strong) id _Nullable result;

/**
 * Convenient method for checking if the result of the action is error or not.
 *
 * @return error If result property of the task contains NSError - it will be returned. Otherwise - nil will be returned.
 */
- (NSError * _Nullable)error;

/**
 * Designated initializer.
 *
 * Creates instance of the XAsyncTask class containing the given action.
 *
 * @param action Actual action which needs to be performed asynchronously in syncronous non-blocking manner.
 *
 * @return Instance of the Async Task.
 */
- (instancetype)initWithAction:(XAsyncTaskAction)action NS_DESIGNATED_INITIALIZER;

/**
 * Convenience constructor.
 *
 * Creates instance of the XAsyncTask class containing the given action.
 *
 * @param action Actual action which needs to be performed asynchronously in syncronous non-blocking manner.
 *
 * @return Instance of the Async Task.
 */
+ (instancetype)taskWithAction:(XAsyncTaskAction)action;

/**
 * Waits until the action of the current task is completed in background. Waiting does not block the event loop.
 */
- (void)await;

/**
 * Waits until all tasks in given task pool are completed.
 * The order of starting/finishing tasks is not determined.
 *
 * @param pool Set of tasks which need to be waited for.
 */
+ (void)awaitAll:(NSSet<XAsyncTask *> *)pool;

/**
 * Waits until any first task in given task pool is completed.
 * The order of starting/finishing tasks is not determined.
 * This method stops waiting after any one task is completed. This however is **NOT** preventing/cancelling other tasks.
 *
 * @param pool Set of tasks one of which needs to be waited for.
 */
+ (void)awaitAny:(NSSet<XAsyncTask *> *)pool;

/**
 * Waits until all tasks in given sequence is completed.
 * Tasks will start and finish in the same order which they are in the initial sequence.
 * 
 * @param sequence Array of tasks which all need to be executed before proceeding to other functionality.
 */
+ (void)awaitSequence:(NSArray <XAsyncTask *> *)sequence;

/**
 * Waits until underlying action fires the signal.
 * This is useful when action is also asyncronous (e.g. waiting response from the service.).
 * The action of the current task **MUST** call fireSignal method to stop waiting. 
 * Otherwise waiting will last forever.
 */
- (void)awaitSignal;

/**
 * Fires signal to stop waiting after calling to awaitSignal.
 * This method **MUST** be called to stop waiting after call to awaitSignal.
 * Otherwise waiting will last forever.
 */
- (void)fireSignal;

@end

NS_ASSUME_NONNULL_END
