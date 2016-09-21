# XAsync

- [Introduction](#introduction)
- [Install](#install)
- [Swift note](#swift-note)
- [Usage](#usage)
    - [Wait for completion of a single task](#wait-for-completion-of-a-single-task)
    - [Wait for completion of a single task with result](#wait-for-completion-of-a-single-task-with-result)
    - [Wait for completion of a sequence of tasks](#wait-for-completion-of-a-sequence-of-tasks)
    - [Wait for completion of all tasks from a set](#wait-for-completion-of-all-tasks-from-a-set)
    - [Wait for completion of any task from a set](#wait-for-completion-of-any-task-from-a-set)
    - [Wait for a signal raised by a particular task](#wait-for-a-signal-raised-by-a-particular-task)
- [License](#license)
- [See also](#see-also)

## Introduction

Working with asyncronous operations might be tedious. In general there are two ways of doing this: using blocks and GCD (NSOperations are here as well) and using delegation. When the code performs a lot of such asynchronous operations it becomes very hard at some point to read this code. Obviously, synchronous code is much more convenient to read and maintain. This is where XAsync comes into play. It allows to call asynchronous opertion and stop further execution of current method until asynchronous operation is done. It is implemented in non-blocking manner, so other events can be (and will be) handled on the caller's thread when asynchronous operation is executing.
    
XAsync functionality inspired by C#'s await code constructions.

## Install

The easiest and recommended way to install XAsync for Objective-C/Swift applcations is to install and maintain it using CocoaPods.
 
- First of all you need to install CocoaPods to your computer. It might be done by executing the following line in terminal:

```
$ sudo gem install cocoapods
``` 
CocoaPods is built with Ruby and it will be installable with the default Ruby available on OS X.

- Open Xcode and create a new project (in the Xcode menu: File->New->Project), or navigate to existing Xcode project using:

```
$ cd <Path to Xcode project folder>
```

- In the Xcode project's folder create a new file, give it a name *Podfile* (with a capital *P* and without any extension). The following example shows how to compose the Podfile for an OSX application. If you are planning to use other platform the process will be quite similar. You only need to change platform to correspondent value. [Here](https://guides.cocoapods.org/syntax/podfile.html#platform) you can find more information about platform values.

```
source 'https://github.com/CocoaPods/Specs.git'
platform :osx, '10.10'
use_frameworks!

target '<Put your Xcode target name here>' do
	pod 'XAsync', '~>2.0'
end
```

- Get back to your terminal window and execute the following line:

```
$ pod install
```
 
- Close Xcode project (if it is still opened). For any further development purposes you should use Xcode *.xcworkspace* file created for you by CocoaPods.

You should be all set.
If you encountered any issues with CocoaPods installations try to find more information at [cocoapods.org](https://guides.cocoapods.org/using/getting-started.html).

## Swift note

Although XAsync is using Objective-C as its primary language it might be quite easily used in a Swift application. After XAsync is installed as described in the [Install](#install) section it is necessary to perform the following:

- Create a new header file in the Swift project.
- Name it something like *BridgingHeader.h*
- Put there the following line:

``` objective-c
@import XAsync;
```

- In the Xcode build settings find the setting called *Objective-C Bridging Header* and set the path to your BridgingHeader.h file. Be aware that this path is relative to your Xcode project's folder.

You can find more information about using Objective-C and Swift in the same project [here](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html).  

## Usage

Below you can find a the examples for using XAsync functionality in a synchronous manner.

### Wait for completion of a single task

Waiting for one single task without any results:

###### Objective-C
```objective-c
//...
@import XAsync;
//...
XAsyncTask *t1 = [XAsyncTask taskWithAction:^(XAsyncTask * __weak _Nonnull task) {
    NSLog(@"Task 1 has been started.");
    for (NSInteger i = 0; i < 1000000000; i++) {
    }
    NSLog(@"Task 1 is about to end.");
}];
NSLog(@"About to start async task 1.");
[t1 await];
NSLog(@"Async task 1 has been done.");
//...
```

###### Swift
```swift
//...
let t1 = XAsyncTask { (task) in
    print("Task 1 has been started.")
    for _ in 0..<1000000000 {
    }
    print("Task 1 is about to end.")
}
print("Task 1 is about to start.")
t1.await()
print("Task 1 has been done.")
//...
```    

### Wait for completion of a single task with result

Example of waiting for the single task which expected to return some result:

###### Objective-C
```objective-c
///...
XAsyncTask *t2 = [XAsyncTask taskWithAction:^(XAsyncTask * __weak _Nonnull task) {
        NSLog(@"Task 2 has been started.");
        NSInteger i = 0;
        for (i = 0; i < 1000000000; i++) {
        }
        NSLog(@"Task 2 is about to end.");
        task.result = [NSNumber numberWithInteger:i];
}];
NSLog(@"About to start async task 2.");
[t2 await];
NSLog(@"Async task 2 has been done with result: %@", [(NSNumber *)t2.result stringValue]);
///...
```    

###### Swift
```swift
///...
let t2 = XAsyncTask { (task) in
    print("Task 2 has been started.")
    var i = 0
    for _ in 0..<1000000000 {
        i += 1;
    }
    print("Task 2 is about to end.")
    task?.result = i;
}
print("Task 2 is about to start.")
t2.await()
print("Task 2 has been done with result: \(t2.result)")
///...
```

### Wait for completion of a sequence of tasks

Example below shows how to wait until all tasks from given sequence finished. The tasks will start and finish in the same order as they are given in the initial sequence.

###### Objective-C:
```objective-c
///...
XAsyncTask *one_s = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
    NSLog(@"Sequence task 1 has been started.");
    for (NSInteger i = 0; i < 100000000; i++) {
    }
    NSLog(@"Sequence task 1 is about to end.");
}];
XAsyncTask *two_s = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
    NSLog(@"Sequence task 2 has been started.");
    for (NSInteger i = 0; i < 100000000; i++) {
    }
    NSLog(@"Sequence task 2 is about to end.");
}];
XAsyncTask *three_s = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
    NSLog(@"Sequence task 3 has been started.");
    for (NSInteger i = 0; i < 100000000; i++) {
    }
    NSLog(@"Sequence task 3 is about to end.");
}];
NSLog(@"About to start sequence.");
[XAsyncTask awaitSequence:@[ one_s, two_s, three_s ]];
NSLog(@"Sequence has been finished.");
///...
```

###### Swift:
```swift
///...
let one_s = XAsyncTask { (task) in
    print("Sequence task 1 has been started.")
    for _ in 0..<100000000 {
    }
    print("Sequence task 1 is about to end.")
}
let two_s = XAsyncTask { (task) in
    print("Sequence task 2 has been started.")
    for _ in 0..<100000000 {
    }
    print("Sequence task 2 is about to end.")
}
let three_s = XAsyncTask { (task) in
    print("Sequence task 3 has been started.")
    for _ in 0..<100000000 {
    }
    print("Sequence task 3 is about to end.")
}
print("About to start sequence.")
XAsyncTask.awaitSequence([one_s, two_s, three_s])
print("Sequence has been finished.")
///...
```

### Wait for completion of all tasks from a set

There are cases when it is just necessary to complete a number of tasks but execution or finishing order does not matter. What matters is that all tasks are completed. In this situation the following example might come in handy.

###### Objective-C:
```objective-c
///...
XAsyncTask *one_all = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
    NSLog(@"Pool task 1 has been started.");
    for (NSInteger i = 0; i < 100000000; i++) {
    }
    NSLog(@"Pool task 1 is about to end.");
}];
XAsyncTask *two_all = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
    NSLog(@"Pool task 2 has been started.");
    for (NSInteger i = 0; i < 100000000; i++) {
    }
    NSLog(@"Pool task 2 is about to end.");
}];
XAsyncTask *three_all = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
    NSLog(@"Pool task 3 has been started.");
    for (NSInteger i = 0; i < 100000000; i++) {
    }
    NSLog(@"Pool task 3 is about to end.");
}];
NSSet *poolAll = [NSSet setWithObjects:one_all, two_all, three_all, nil];
NSLog(@"About to start pool of tasks.");
[XAsyncTask awaitAll:poolAll];
NSLog(@"All tasks have been finished.");
///...
```

###### Swift:
```swift
///...
let one_all = XAsyncTask { (task) in
    print("Pool task 1 has been started.")
    for _ in 0..<100000000 {
    }
    print("Pool task 1 is about to end.")
}
let two_all = XAsyncTask { (task) in
    print("Pool task 2 has been started.")
    for _ in 0..<100000000 {
    }
    print("Pool task 2 is about to end.")
}
let three_all = XAsyncTask { (task) in
    print("Pool task 3 has been started.")
    for _ in 0..<100000000 {
    }
    print("Pool task 3 is about to end.")
}
print("About to start all tasks' pool.")
XAsyncTask.awaitAll(Set(arrayLiteral: one_all, two_all, three_all))
print("All tasks have been finished.")
///...
```

### Wait for completion of any task from a set

In some cases it is important to wait until at least one task from a particular group has been completed. See example below:

###### Objective-C:
```objective-c
///...
XAsyncTask *one_any = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
    NSLog(@"Pool task 1 has been started.");
    for (NSInteger i = 0; i < 100000000; i++) {
    }
    NSLog(@"Pool task 1 is about to end.");
}];
XAsyncTask *two_any = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
    NSLog(@"Pool task 2 has been started.");
    for (NSInteger i = 0; i < 100000000; i++) {
    }
    NSLog(@"Pool task 2 is about to end.");
}];
XAsyncTask *three_any = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
    NSLog(@"Pool task 3 has been started.");
    for (NSInteger i = 0; i < 100000000; i++) {
    }
    NSLog(@"Pool task 3 is about to end.");
}];
NSSet *poolAny = [NSSet setWithObjects:one_any, two_any, three_any, nil];
NSLog(@"About to start a pool.");
[XAsyncTask awaitAny:poolAny];
NSLog(@"Waiting has been finished.");
///...
```

###### Swift:
```swift
///...
let one_any = XAsyncTask { (task) in
    print("Pool task 1 has been started.")
    for _ in 0..<100000000 {
    }
    print("Pool task 1 is about to end.")
}
let two_any = XAsyncTask { (task) in
    print("Pool task 2 has been started.")
    for _ in 0..<100000000 {
    }
    print("Pool task 2 is about to end.")
}
let three_any = XAsyncTask { (task) in
    print("Pool task 3 has been started.")
    for _ in 0..<100000000 {
    }
    print("Pool task 3 is about to end.")
}
print("About to start a pool.")
XAsyncTask.awaitAny(Set(arrayLiteral: one_all, two_all, three_all))
print("Waiting has been finished.")
///...
```

### Wait for a signal raised by a particular task

What if the task which is necessary to be done is also asynchronous and depends on some other circumstances (e.g. getting response from the service)? The answer is: use awaitSignal method as shown below: 

###### Objective-C:
```objective-c
///...
XAsyncTask *ts = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nonnull task) {
    NSLog(@"Signal task has been started.");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSInteger i = 0;
        for (i = 0; i < 1000000000; i++) {
        }
        task.result = [NSNumber numberWithInteger:i];
        [task fireSignal];
    });
    NSLog(@"Signal task is about to end.");
}];
NSLog(@"About to start signal task.");
[ts awaitSignal];
NSLog(@"Signal task has been done: %@", [(NSNumber *)ts.result stringValue]);
///...
```

###### Swift:
```swift
///...
let ts = XAsyncTask { (task) in
    print("Signal task has been started.");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
        var i = 0;
        for _ in 0..<1000000000 {
            i += 1
        }
        task?.result = i
        task?.fireSignal()
    }
    print("Signal task is about to end.")
}
print("About to start signal task.")
ts.awaitSignal()
print("Signal task has been done: \(ts.result)")

///...
```

## License

Usage is provided under the [MIT License](https://opensource.org/licenses/MIT). See LICENSE for the full details.