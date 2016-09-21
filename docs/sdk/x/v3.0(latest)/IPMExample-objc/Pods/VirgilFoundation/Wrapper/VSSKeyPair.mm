//
//  VSSKeyPair.mm
//  VirgilFoundation
//
//  Created by Pavel Gorb on 2/3/15.
//  Copyright (c) 2015 VirgilSecurity, Inc. All rights reserved.
//

#import "VSSKeyPair.h"
#import <VirgilCrypto/virgil/crypto/VirgilByteArray.h>
#import <VirgilCrypto/virgil/crypto/VirgilKeyPair.h>

using virgil::crypto::VirgilByteArray;
using Type = virgil::crypto::VirgilKeyPair::Type;
using namespace virgil::crypto;

NSString *const kVSSKeyPairErrorDomain = @"VSSKeyPairErrorDomain";

@interface VSSKeyPair ()

@property (nonatomic, assign) VirgilKeyPair *keyPair;

- (instancetype __nonnull)initWithKeyPairType:(Type)keyPairType password:(NSString * __nullable)password NS_DESIGNATED_INITIALIZER;

@end

@implementation VSSKeyPair

@synthesize keyPair = _keyPair;

#pragma mark - Lifecycle

- (instancetype)initWithKeyPairType:(Type)keyPairType password:(NSString *)password {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    try {
        if (password.length == 0) {
            _keyPair = new VirgilKeyPair(VirgilKeyPair::generate());
        }
        else {
            std::string pwd = std::string([password UTF8String]);
            _keyPair = new VirgilKeyPair(VirgilKeyPair::generate(keyPairType, VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pwd.data(), pwd.size())));
        }
    }
    catch(...) {
        _keyPair = NULL;
    }
    
    return self;
}

- (instancetype)init {
    return [self initWithKeyPairType:Type::Type_Default password:nil];
}

- (instancetype)initWithPassword:(NSString *)password {
    return [self initWithKeyPairType:Type::Type_Default password:password];
}

- (void)dealloc {
    if (_keyPair != NULL) {
        delete _keyPair;
        _keyPair = NULL;
    }
}

+ (VSSKeyPair *)ecNist192WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_SECP192R1 password:password];
}

+ (VSSKeyPair *)ecNist224WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_SECP224R1 password:password];
}

+ (VSSKeyPair *)ecNist256WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_SECP256R1 password:password];
}

+ (VSSKeyPair *)ecNist384WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_SECP384R1 password:password];
}

+ (VSSKeyPair *)ecNist521WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_SECP521R1 password:password];
}

+ (VSSKeyPair *)ecBrainpool256WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_BP256R1 password:password];
}

+ (VSSKeyPair *)ecBrainpool384WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_BP384R1 password:password];
}

+ (VSSKeyPair *)ecBrainpool512WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_BP512R1 password:password];
}

+ (VSSKeyPair *)ecKoblitz192WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_SECP192K1 password:password];
}

+ (VSSKeyPair *)ecKoblitz224WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_SECP224K1 password:password];
}

+ (VSSKeyPair *)ecKoblitz256WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_SECP256K1 password:password];
}

+ (VSSKeyPair *)rsa256WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_RSA_256 password:password];
}

+ (VSSKeyPair *)rsa512WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_RSA_512 password:password];
}

+ (VSSKeyPair *)rsa1024WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_RSA_1024 password:password];
}

+ (VSSKeyPair *)rsa2048WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_RSA_2048 password:password];
}

+ (VSSKeyPair *)rsa4096WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_RSA_4096 password:password];
}

+ (VSSKeyPair *)m255WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_M255 password:password];
}

+ (VSSKeyPair *)curve25519WithPassword:(NSString *)password {
    return (VSSKeyPair *)[[self alloc] initWithKeyPairType:Type::Type_EC_Curve25519 password:password];
}

#pragma mark - Public class logic

- (NSData *)publicKey {
    if( self.keyPair == NULL ) {
        return [NSData data];
    }
    NSData *publicKey = nil;
    try {
        VirgilByteArray pkey = self.keyPair->publicKey();
        publicKey = [NSData dataWithBytes:pkey.data() length:pkey.size()];
    }
    catch(...) {
        publicKey = [NSData data];
    }
    return publicKey;
}

- (NSData *)privateKey {
    if( self.keyPair == NULL ) {
        return [NSData data];
    }
    
    NSData *privateKey = nil;
    try {
        VirgilByteArray pkey = self.keyPair->privateKey();
        privateKey = [NSData dataWithBytes:pkey.data() length:pkey.size()];
    }
    catch(...) {
        privateKey = [NSData data];
    }
    return privateKey;
}

+ (BOOL)isEncryptedPrivateKey:(NSData *)keyData {
    if (keyData.length == 0) {
        return NO;
    }
    
    bool isEncrypted = false;
    try {
        const unsigned char *data = static_cast<const unsigned char *>([keyData bytes]);
        isEncrypted = VirgilKeyPair::isPrivateKeyEncrypted(VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(data, [keyData length]));
    }
    catch(...) {
        isEncrypted = false;
    }
    
    if (isEncrypted) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isPrivateKey:(NSData *)keyData matchesPassword:(NSString *)password {
    if (keyData.length == 0 || password.length == 0) {
        return NO;
    }
    
    bool isMatches = false;
    try {
        const unsigned char *data = static_cast<const unsigned char *>([keyData bytes]);
        std::string pwd = std::string([password UTF8String]);
        isMatches = VirgilKeyPair::checkPrivateKeyPassword(VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(data, [keyData length]), VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pwd.data(), pwd.size()));
    }
    catch(...) {
        isMatches = false;
    }
    
    if (isMatches) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isPublicKey:(NSData *)publicKeyData matchesPrivateKey:(NSData *)privateKeyData withPassword:(NSString *)password {
    if (publicKeyData.length == 0 || privateKeyData.length == 0) {
        return NO;
    }
    
    bool isMatches = false;
    try {
        const unsigned char *pubKeyData = static_cast<const unsigned char *>([publicKeyData bytes]);
        const unsigned char *privKeyData = static_cast<const unsigned char *>([privateKeyData bytes]);
        if (password.length == 0) {
            isMatches = VirgilKeyPair::isKeyPairMatch(VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pubKeyData, [publicKeyData length]), VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(privKeyData, [privateKeyData length]));
        }
        else {
            std::string pwd = std::string([password UTF8String]);
            isMatches = VirgilKeyPair::isKeyPairMatch(VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pubKeyData, [publicKeyData length]), VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(privKeyData, [privateKeyData length]), VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pwd.data(), pwd.size()));
        }
    }
    catch(...) {
        isMatches = false;
    }
    
    if (isMatches) {
        return YES;
    }
    
    return NO;
}

+ (NSData * __nullable)resetPassword:(NSString *)password toPassword:(NSString *)newPassword forPrivateKey:(NSData *)keyData error:(NSError **)error {
    if (password.length == 0 || newPassword.length == 0 || keyData.length == 0) {
        // Can't reset password.
        if (error) {
            *error = [NSError errorWithDomain:kVSSKeyPairErrorDomain code:-1000 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to reset password: Required parameter is missing.", @"Reset password error.") }];
        }
        return nil;
    }
    
    NSData *pkeyData = nil;
    try {
        std::string sPwd = std::string([password UTF8String]);
        VirgilByteArray vbaPwd = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(sPwd.data(), sPwd.size());
        
        std::string sNewPwd = std::string([newPassword UTF8String]);
        VirgilByteArray vbaNewPwd = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(sNewPwd.data(), sNewPwd.size());
        
        const unsigned char *pKeyData = static_cast<const unsigned char *>([keyData bytes]);
        VirgilByteArray pKey = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pKeyData, [keyData length]);
        
        VirgilByteArray pNewKey = VirgilKeyPair::resetPrivateKeyPassword(pKey, vbaPwd, vbaNewPwd);
        pkeyData = [NSData dataWithBytes:pNewKey.data() length:pNewKey.size()];
        if (error) {
            *error = nil;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown exception during password reset.";
            }
            *error = [NSError errorWithDomain:kVSSKeyPairErrorDomain code:-1001 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        pkeyData = nil;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSKeyPairErrorDomain code:-1002 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown exception during password reset." }];
        }
        pkeyData = nil;
    }
    
    return pkeyData;
}

@end
