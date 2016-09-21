//
//  LoadingViewController.m
//  IPMExample-objc
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()

@property (nonatomic, weak) IBOutlet UIView *vPanel;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *aiProcess;

@end

@implementation LoadingViewController

@synthesize vPanel = _vPanel;
@synthesize aiProcess = _aiProcess;

@end
