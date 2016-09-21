//
//  VSSVirgilVersion.mm
//  VirgilFoundation
//
//  Created by Pavel Gorb on 2/3/15.
//  Copyright (c) 2015 VirgilSecurity, Inc. All rights reserved.
//

#import "VSSVirgilVersion.h"
#import <VirgilCrypto/virgil/crypto/VirgilVersion.h>

using virgil::crypto::VirgilVersion;

@interface VSSVirgilVersion ()

@property(nonatomic, assign) VirgilVersion *frameworkVersion;

@end

@implementation VSSVirgilVersion

@synthesize frameworkVersion = _frameworkVersion;

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    try {
        _frameworkVersion = new VirgilVersion();
    }
    catch(...) {
        _frameworkVersion = NULL;
    }

    return self;
}

- (void)dealloc {
    if (_frameworkVersion != NULL) {
        delete _frameworkVersion;
        _frameworkVersion = NULL;
    }
}

#pragma mark - Class logic

- (NSString *)versionString {
    if (self.frameworkVersion == NULL) {
        return @"";
    }
    NSString *version = nil;
    try {
        std::string ver = self.frameworkVersion->asString();
        version = [[NSString alloc] initWithCString:ver.c_str() encoding:NSUTF8StringEncoding];
    }
    catch(...) {
        version = @"";
    }
    
    return version;
}

- (size_t)version {
    if (self.frameworkVersion == NULL) {
        return 0;
    }
    size_t version = 0;
    try {
        version = self.frameworkVersion->asNumber();
    }
    catch(...) {
        version = 0;
    }
    
    return version;
}

- (size_t)majorVersion {
    if (self.frameworkVersion == NULL) {
        return 0;
    }
    
    size_t version = 0;
    try {
        version = self.frameworkVersion->majorVersion();
    }
    catch(...) {
        version = 0;
    }
    
    return version;
}

- (size_t)minorVersion {
    if (self.frameworkVersion == NULL) {
        return 0;
    }
    
    size_t version = 0;
    try {
        version = self.frameworkVersion->minorVersion();
    }
    catch(...) {
        version = 0;
    }
    
    return version;
}

- (size_t)patchVersion {
    if (self.frameworkVersion == NULL) {
        return 0;
    }
    
    size_t version = 0;
    try {
        version = self.frameworkVersion->patchVersion();
    }
    catch(...) {
        version = 0;
    }
    
    return version;
}

@end
