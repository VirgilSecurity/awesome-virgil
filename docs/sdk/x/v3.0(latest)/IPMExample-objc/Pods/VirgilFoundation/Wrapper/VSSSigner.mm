//
//  VSSSigner.mm
//  VirgilFoundation
//
//  Created by Pavel Gorb on 2/3/15.
//  Copyright (c) 2015 VirgilSecurity, Inc. All rights reserved.
//

/// In the MacOSX SDK there is a macro definition which covers signer->verify method.
/// So we need to disable it for this.
#ifdef verify
# undef verify
#endif

#import "VSSSigner.h"
#import <VirgilCrypto/virgil/crypto/VirgilByteArray.h>
#import <VirgilCrypto/virgil/crypto/VirgilSigner.h>
#import <VirgilCrypto/virgil/crypto/foundation/VirgilHash.h>

using virgil::crypto::VirgilByteArray;
using virgil::crypto::VirgilSigner;
using virgil::crypto::foundation::VirgilHash;

NSString *const kVSSSignerErrorDomain = @"VSSSignerErrorDomain";

@interface VSSSigner ()

@property (nonatomic, assign) VirgilSigner *signer;

@end

@implementation VSSSigner

@synthesize signer = _signer;

#pragma mark - Lifecycle

- (instancetype)init {
    return [self initWithHash:nil];
}

- (instancetype) initWithHash:(NSString *)hash {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    try {
        if ([hash isEqualToString:kHashNameMD5]) {
            _signer = new VirgilSigner(VirgilHash::md5());
        }
        else if ([hash isEqualToString:kHashNameSHA256]) {
            _signer = new VirgilSigner(VirgilHash::sha256());
        }
        else if ([hash isEqualToString:kHashNameSHA384]) {
            _signer = new VirgilSigner(VirgilHash::sha384());
        }
        else if ([hash isEqualToString:kHashNameSHA512]) {
            _signer = new VirgilSigner(VirgilHash::sha512());
        }
        else if (hash.length > 0)
        {
            std::string hashName = std::string([hash UTF8String]);
            VirgilByteArray hashNameArray = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(hashName.data(), hashName.size());
            _signer = new VirgilSigner(VirgilHash::withName(hashNameArray));
        }
        else {
            _signer = new VirgilSigner();
        }
    }
    catch(...) {
        _signer = NULL;
    }
    return self;
}

- (void)dealloc {
    if (_signer != NULL) {
        delete _signer;
        _signer = NULL;
    }
}

#pragma mark - Public class logic

- (NSData *)signData:(NSData *)data privateKey:(NSData *)privateKey keyPassword:(NSString *)keyPassword {
    return [self signData:data privateKey:privateKey keyPassword:keyPassword error:nil];
}

- (NSData *)signData:(NSData *)data privateKey:(NSData *)privateKey keyPassword:(NSString *)keyPassword error:(NSError **)error {
    if (data.length == 0 || privateKey.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSSignerErrorDomain code:-1000 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to compose the signature: no data or no private key given.", "Sign data error.") }];
        }
        return nil;
    }
    
    NSData *signData = nil;
    try {
        if (self.signer != NULL) {
            // Convert NSData to
            const unsigned char *dataToSign = static_cast<const unsigned char *>([data bytes]);
            VirgilByteArray plainData = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(dataToSign, [data length]);
            // Convert NSData to
            const unsigned char *pKeyData = static_cast<const unsigned char *>([privateKey bytes]);
            VirgilByteArray pKey = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pKeyData, [privateKey length]);
            
            VirgilByteArray sign;
            if (keyPassword.length > 0) {
                std::string pKeyPassS = std::string([keyPassword UTF8String]);
                VirgilByteArray pKeyPassword = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pKeyPassS.data(), pKeyPassS.size());
                sign = self.signer->sign(plainData, pKey, pKeyPassword);
            }
            else {
                sign = self.signer->sign(plainData, pKey);
            }
            signData = [NSData dataWithBytes:sign.data() length:sign.size()];
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSSignerErrorDomain code:-1013 userInfo:@{ NSLocalizedDescriptionKey: @"Unable to compose signature. Cryptor is not initialized properly." }];
            }
            signData = nil;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown error: impossible to get sign exception description.";
            }
            *error = [NSError errorWithDomain:kVSSSignerErrorDomain code:-1001 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        signData = nil;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSSignerErrorDomain code:-1002 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown error during composing of signature." }];
        }
        signData = nil;
    }
    
    return signData;
}

- (BOOL)verifySignature:(NSData *)signature data:(NSData *)data publicKey:(NSData *)publicKey {
    return [self verifySignature:signature data:data publicKey:publicKey error:nil];
}

- (BOOL)verifySignature:(NSData *)signature data:(NSData *)data publicKey:(NSData *)publicKey error:(NSError **)error {
    if (data.length == 0 || signature.length == 0 || publicKey.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSSignerErrorDomain code:-1010 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to verify signature: signature data or/and verification data or/and public key is/are not given.", @"Verify data error.") }];
        }
        return NO;
    }
    
    BOOL verified = NO;
    try {
        if (self.signer != NULL) {
            // Convert NSData data
            const unsigned char *signedDataPtr = static_cast<const unsigned char *>([data bytes]);
            VirgilByteArray signedData = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(signedDataPtr, [data length]);
            // Convert NSData sign
            const unsigned char *signDataPtr = static_cast<const unsigned char *>([signature bytes]);
            VirgilByteArray signData = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(signDataPtr, [signature length]);
            // Convert NSData Key
            const unsigned char *keyDataPtr = static_cast<const unsigned char *>([publicKey bytes]);
            VirgilByteArray pKey = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(keyDataPtr, [publicKey length]);
            
            bool result = self.signer->verify(signedData, signData, pKey);
            verified = (result) ? YES : NO;
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSSignerErrorDomain code:-1014 userInfo:@{ NSLocalizedDescriptionKey: @"Unable to verify signature. Cryptor is not initialized properly." }];
            }
            verified = NO;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown error: impossible to get verify exception description.";
            }
            *error = [NSError errorWithDomain:kVSSSignerErrorDomain code:-1011 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        verified = NO;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSSignerErrorDomain code:-1012 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown error during verification of signature." }];
        }
        verified = NO;
    }
    return verified;
}

@end
