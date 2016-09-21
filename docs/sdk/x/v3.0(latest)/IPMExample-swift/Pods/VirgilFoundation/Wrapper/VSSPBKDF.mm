//
//  VSSPBKDF.m
//  VirgilCypto
//
//  Created by Pavel Gorb on 4/26/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSPBKDF.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonCrypto.h>

#import <VirgilCrypto/virgil/crypto/VirgilByteArray.h>
#import <VirgilCrypto/virgil/crypto/foundation/VirgilPBKDF.h>

using virgil::crypto::VirgilByteArray;
using virgil::crypto::foundation::VirgilPBKDF;

const size_t kVSSDefaultRandomBytesSize = 64;
NSString *const kVSSPBKDFErrorDomain = @"VSSPBKDFErrorDomain";

@interface VSSPBKDF ()

@property (nonatomic, assign) VirgilPBKDF *pbkdf;

@end

@implementation VSSPBKDF

@dynamic salt;
@dynamic iterations;
@dynamic algorithm;
@dynamic hash;

@synthesize pbkdf = _pbkdf;

#pragma mark - Getters/Setters

- (NSData * __nonnull)salt {
    if (self.pbkdf == NULL) {
        return [NSData data];
    }
    
    NSData *salt = nil;
    try {
        VirgilByteArray vbaSalt = self.pbkdf->getSalt();
        salt = [NSData dataWithBytes:vbaSalt.data() length:vbaSalt.size()];
    }
    catch (...) {
        salt = [NSData data];
    }
    return salt;
}

- (unsigned int)iterations {
    if (self.pbkdf == NULL) {
        return 0;
    }
    
    unsigned int iterations = 0;
    try {
        iterations = self.pbkdf->getIterationCount();
    }
    catch (...) {
        iterations = 0;
    }
    return iterations;
}

- (VSSPBKDFAlgorithm)algorithm {
    if (self.pbkdf == NULL) {
        return VSSPBKDFAlgorithmNone;
    }
    
    VirgilPBKDF::Algorithm alg = VirgilPBKDF::Algorithm_None;
    try {
        alg = self.pbkdf->getAlgorithm();
    } catch (...) {
        alg = VirgilPBKDF::Algorithm_None;
    }
    return (VSSPBKDFAlgorithm)alg;
}

- (void)setAlgorithm:(VSSPBKDFAlgorithm)algorithm {
    if (self.pbkdf == NULL) {
        return;
    }
    
    VirgilPBKDF::Algorithm alg = VirgilPBKDF::Algorithm_None;
    switch(algorithm) {
        case VSSPBKDFAlgorithmPBKDF2:
            alg = VirgilPBKDF::Algorithm_PBKDF2;
            break;
        default:
            break;
    }
    
    try {
        self.pbkdf->setAlgorithm(alg);
    }
    catch(...) {}
}

- (VSSPBKDFHash)hash {
    if (self.pbkdf == NULL) {
        return (VSSPBKDFHash)0;
    }
    
    VirgilPBKDF::Hash hsh = (VirgilPBKDF::Hash)0;
    try {
        hsh = self.pbkdf->getHash();
    }
    catch(...) {
        hsh = (VirgilPBKDF::Hash)0;
    }
    return (VSSPBKDFHash)hsh;
}

- (void)setHash:(VSSPBKDFHash)hash {
    if (self.pbkdf == NULL) {
        return;
    }
    
    VirgilPBKDF::Hash hsh = (VirgilPBKDF::Hash)0;
    switch(hash) {
        case VSSPBKDFHashSHA1:
            hsh = VirgilPBKDF::Hash_SHA1;
            break;
        case VSSPBKDFHashSHA224:
            hsh = VirgilPBKDF::Hash_SHA224;
            break;
        case VSSPBKDFHashSHA256:
            hsh = VirgilPBKDF::Hash_SHA256;
            break;
        case VSSPBKDFHashSHA384:
            hsh = VirgilPBKDF::Hash_SHA384;
            break;
        case VSSPBKDFHashSHA512:
            hsh = VirgilPBKDF::Hash_SHA512;
            break;
        default:
            break;
    }
    
    if (hsh == 0) {
        return;
    }
    
    try {
        self.pbkdf->setHash(hsh);
    }
    catch(...) {}
}

#pragma mark - Lifecycle

- (instancetype)initWithSalt:(NSData *)salt iterations:(unsigned int)iterations {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    if (salt.length == 0) {
        salt = [[self class] randomBytesOfSize:0];
    }
    
    if (iterations == 0) {
        iterations = VirgilPBKDF::kIterationCount_Default;
    }
    
    try {
        const unsigned char *saltBytes = static_cast<const unsigned char *>([salt bytes]);
        VirgilByteArray saltArray = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(saltBytes, [salt length]);
        _pbkdf = new VirgilPBKDF(saltArray, iterations);
    }
    catch(...) {
        _pbkdf = NULL;
    }
    
    return self;
}

- (instancetype)init {
    return [self initWithSalt:nil iterations:0];
}

- (void)dealloc {
    if (_pbkdf != NULL) {
        delete _pbkdf;
        _pbkdf = NULL;
    }
}

#pragma mark - Public class logic

- (BOOL)enableRecommendationsCheckWithError:(NSError * __nullable * __nullable)error {
    BOOL success = NO;
    try {
        if (self.pbkdf != NULL) {
            self.pbkdf->enableRecommendationsCheck();
            if (error) {
                *error = nil;
            }
            success = YES;
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSPBKDFErrorDomain code:-1002 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Unable to enable security checks. PBKDF object is not initialized properly.", @"Unable to enable security checks. PBKDF object is not initialized properly.")}];
            }
            success = NO;
        }
    }
    catch (std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = NSLocalizedString(@"Unknown error: impossible to get PBKDF exception description.", @"Unknown error: impossible to get PBKDF exception description.");
            }
            *error = [NSError errorWithDomain:kVSSPBKDFErrorDomain code:-1010 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        success = NO;
    }
    catch (...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSPBKDFErrorDomain code:-1011 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Unknown PBKDF error.", @"Unknown PBKDF error.") }];
        }
        success = NO;
    }
    return success;
}

- (BOOL)disableRecommendationsCheckWithError:(NSError * __nullable * __nullable)error {
    BOOL success = NO;
    try {
        if (self.pbkdf != NULL) {
            self.pbkdf->disableRecommendationsCheck();
            if (error) {
                *error = nil;
            }
            success = YES;
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSPBKDFErrorDomain code:-1003 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Unable to disable security checks. PBKDF object is not initialized properly.", @"Unable to disable security checks. PBKDF object is not initialized properly.")  }];
            }
            success = NO;
        }
    }
    catch (std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = NSLocalizedString(@"Unknown error: impossible to get PBKDF exception description.", @"Unknown error: impossible to get PBKDF exception description.");
            }
            *error = [NSError errorWithDomain:kVSSPBKDFErrorDomain code:-1010 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        success = NO;
    }
    catch (...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSPBKDFErrorDomain code:-1011 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Unknown PBKDF error.", @"Unknown PBKDF error.") }];
        }
        success = NO;
    }
    return success;
}

- (NSData *)keyFromPassword:(NSString *)password size:(size_t)size error:(NSError **)error {
    if (password.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSPBKDFErrorDomain code:-1000 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to derive the key: password is missing.", @"Impossible to derive the key: password is missing.") }];
        }
        return nil;
    }
    
    NSData *keyData = nil;
    try {
        if (self.pbkdf != NULL) {
            std::string sPwd = std::string([password UTF8String]);
            VirgilByteArray vbaPwd = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(sPwd.data(), sPwd.size());
            VirgilByteArray vbaKey = self.pbkdf->derive(vbaPwd, size);
            
            keyData = [NSData dataWithBytes:vbaKey.data() length:vbaKey.size()];
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSPBKDFErrorDomain code:-1001 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Unable to derive the key. PBKDF object is not initialized properly.", @"Unable to derive the key. PBKDF object is not initialized properly.")  }];
            }
            keyData = nil;
        }
    }
    catch (std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = NSLocalizedString(@"Unknown error: impossible to get PBKDF exception description.", @"Unknown error: impossible to get PBKDF exception description.");
            }
            *error = [NSError errorWithDomain:kVSSPBKDFErrorDomain code:-1010 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        keyData = nil;
    }
    catch (...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSPBKDFErrorDomain code:-1011 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Unknown PBKDF error.", @"Unknown PBKDF error.") }];
        }
        keyData = nil;
    }
    return keyData;
}


+ (NSData*)randomBytesOfSize:(size_t)size {
    if (size == 0) {
        size = kVSSDefaultRandomBytesSize;
    }
    uint8_t randomDataBytes[size];
    if (SecRandomCopyBytes(kSecRandomDefault, sizeof(randomDataBytes), randomDataBytes) == 0) {
        return [NSData dataWithBytes:randomDataBytes length:sizeof(randomDataBytes)];
    }
    
    return [NSData data];
}

@end
