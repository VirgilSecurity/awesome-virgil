//
//  VSSStreamSigner.m
//  VirgilCypto
//
//  Created by Pavel Gorb on 3/2/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

/// In the MacOSX SDK there is a macro definition which covers signer->verify method.
/// So we need to disable it for this.
#ifdef verify
# undef verify
#endif

#import "VSSStreamSigner.h"
#import <VirgilCrypto/virgil/crypto/VirgilByteArray.h>
#import <VirgilCrypto/virgil/crypto/VirgilStreamSigner.h>
#import <VirgilCrypto/virgil/crypto/foundation/VirgilHash.h>
#import <VirgilCrypto/virgil/crypto/VirgilDataSource.h>

NSString *const kVSSStreamSignerErrorDomain = @"VSSStreamSignerErrorDomain";

using virgil::crypto::VirgilByteArray;
using virgil::crypto::VirgilStreamSigner;
using virgil::crypto::foundation::VirgilHash;
using virgil::crypto::VirgilDataSource;

#pragma mark - @interface VirgilStreamSignerDataSource

class VirgilStreamSignerDataSource: public VirgilDataSource {
private:
    NSInputStream *istream;
public:
    bool hasData();
    VirgilByteArray read();
    
    VirgilStreamSignerDataSource(NSInputStream *is);
    ~VirgilStreamSignerDataSource();
};

#pragma mark - @implementation VirgilStreamSignerDataSource

VirgilStreamSignerDataSource::VirgilStreamSignerDataSource(NSInputStream *is) {
    /// Assign pointer.
    this->istream = is;
    if ([this->istream streamStatus] == NSStreamStatusNotOpen) {
        [this->istream open];
    }
}

VirgilStreamSignerDataSource::~VirgilStreamSignerDataSource() {
    /// Drop pointer.
    [this->istream close];
    this->istream = NULL;
}

bool VirgilStreamSignerDataSource::hasData() {
    if (this->istream != NULL) {
        NSStreamStatus st = [this->istream streamStatus];
        if (st == NSStreamStatusNotOpen || st == NSStreamStatusError || st == NSStreamStatusClosed) {
            return false;
        }
        
        if ([this->istream hasBytesAvailable]) {
            return true;
        }
    }
    
    return false;
}

VirgilByteArray VirgilStreamSignerDataSource::read() {
    std::vector<unsigned char> buffer;
    unsigned long desiredSize = 1024;
    long actualSize = 0;
    
    buffer.resize(desiredSize);
    if (this->istream != NULL) {
        actualSize = [this->istream read:buffer.data() maxLength:desiredSize];
        if (actualSize < 0) {
            actualSize = 0;
        }
    }
    buffer.resize(actualSize);
    buffer.shrink_to_fit();
    
    return static_cast<VirgilByteArray>(buffer);
}

#pragma mark -

@interface VSSStreamSigner ()

@property (nonatomic, assign) VirgilStreamSigner *signer;

@end

@implementation VSSStreamSigner

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
            _signer = new VirgilStreamSigner(VirgilHash::md5());
        }
        else if ([hash isEqualToString:kHashNameSHA256]) {
            _signer = new VirgilStreamSigner(VirgilHash::sha256());
        }
        else if ([hash isEqualToString:kHashNameSHA384]) {
            _signer = new VirgilStreamSigner(VirgilHash::sha384());
        }
        else if ([hash isEqualToString:kHashNameSHA512]) {
            _signer = new VirgilStreamSigner(VirgilHash::sha512());
        }
        else if (hash.length > 0)
        {
            std::string hashName = std::string([hash UTF8String]);
            VirgilByteArray hashNameArray = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(hashName.data(), hashName.size());
            _signer = new VirgilStreamSigner(VirgilHash::withName(hashNameArray));
        }
        else {
            _signer = new VirgilStreamSigner();
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

- (NSData *)signStreamData:(NSInputStream *)source privateKey:(NSData *)privateKey keyPassword:(NSString *)keyPassword error:(NSError **)error {
    if (source == nil || privateKey.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSStreamSignerErrorDomain code:-1000 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to compose the signature: no data source or no private key given.", "Compose signature error.") }];
        }
        return nil;
    }
    
    NSData *signData = nil;
    try {
        if (self.signer != NULL) {
            VirgilStreamSignerDataSource src = VirgilStreamSignerDataSource(source);
            // Convert NSData to Virgil Byte Array
            const unsigned char *pKey = static_cast<const unsigned char *>([privateKey bytes]);
            VirgilByteArray signature;
            if (keyPassword.length > 0) {
                std::string keyPass = std::string([keyPassword UTF8String]);
                signature = self.signer->sign(src, VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pKey, [privateKey length]), VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(keyPass.data(), keyPass.size()));
            }
            else {
                signature = self.signer->sign(src, VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pKey, [privateKey length]));
            }
            signData = [NSData dataWithBytes:signature.data() length:signature.size()];
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSStreamSignerErrorDomain code:-1001 userInfo:@{ NSLocalizedDescriptionKey: @"Unable to compose signature. Cryptor is not initialized properly." }];
            }
            signData = nil;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown error: impossible to get signature exception description.";
            }
            *error = [NSError errorWithDomain:kVSSStreamSignerErrorDomain code:-1002 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        signData = nil;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSStreamSignerErrorDomain code:-1003 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown error during composing of signature from stream." }];
        }
        signData = nil;
    }
    
    return signData;
}

- (BOOL)verifySignature:(NSData *)signature fromStream:(NSInputStream *)source publicKey:(NSData *)publicKey error:(NSError **)error {
    if (source == nil || signature.length == 0 || publicKey.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSStreamSignerErrorDomain code:-1004 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to verify signature: source stream or/and verification data or/and public key is/are not given.", @"Verification signature error.") }];
        }
        return NO;
    }
    
    BOOL verified = NO;
    try {
        if (self.signer != NULL) {
            VirgilStreamSignerDataSource src = VirgilStreamSignerDataSource(source);
            const unsigned char *signBytes = static_cast<const unsigned char *>([signature bytes]);
            const unsigned char *pKey = static_cast<const unsigned char *>([publicKey bytes]);
            
            bool result = self.signer->verify(src, VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(signBytes, [signature length]), VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pKey, [publicKey length]));
            verified = (result) ? YES : NO;
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSStreamSignerErrorDomain code:-1005 userInfo:@{ NSLocalizedDescriptionKey: @"Unable to compose signature. Cryptor is not initialized properly." }];
            }
            verified = NO;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown error: impossible to get verification exception description.";
            }
            *error = [NSError errorWithDomain:kVSSStreamSignerErrorDomain code:-1006 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        verified = NO;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSStreamSignerErrorDomain code:-1007 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown error during verification of signature." }];
        }
        verified = NO;
    }
    return verified;
}

@end
