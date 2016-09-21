//
//  VSSChunkCryptor.m
//  VirgilCypto
//
//  Created by Pavel Gorb on 3/1/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSChunkCryptor.h"
#import "VSSBaseCryptor_Private.h"
#import <VirgilCrypto/virgil/crypto/VirgilChunkCipher.h>

using virgil::crypto::VirgilByteArray;
using virgil::crypto::VirgilChunkCipher;

NSString *const kVSSChunkCryptorErrorDomain = @"VSSChunkCryptorErrorDomain";

@implementation VSSChunkCryptor

- (void)initializeCryptor {
    if (self.llCryptor != NULL) {
        // llCryptor has been initialized already.
        return;
    }
    
    try {
        self.llCryptor = new VirgilChunkCipher();
    }
    catch(...) {
        self.llCryptor = NULL;
    }
}

- (void)dealloc {
    if (self.llCryptor != NULL) {
        delete (VirgilChunkCipher *)self.llCryptor;
        self.llCryptor = NULL;
    }
}

- (VirgilChunkCipher *)cryptor {
    if (self.llCryptor == NULL) {
        return NULL;
    }
    
    return static_cast<VirgilChunkCipher *>(self.llCryptor);
}

- (size_t)startEncryptionWithPreferredChunkSize:(size_t)chunkSize error:(NSError * __nullable * __nullable)error {
    size_t actualSize = 0;
    try {
        if ([self cryptor] != NULL) {
            if (chunkSize > 0) {
                actualSize = [self cryptor]->startEncryption(chunkSize);
            }
            else {
                actualSize = [self cryptor]->startEncryption();
            }
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1000 userInfo:@{ NSLocalizedDescriptionKey: @"Unable to start chunk encryption. Cryptor is not initialized properly." }];
            }
            actualSize = 0;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown exception during chunk encryption.";
            }
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1001 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        actualSize = 0;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1002 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown exception during chunk encryption." }];
        }
        actualSize = 0;
    }
    
    return actualSize;
}

- (size_t)startDecryptionWithRecipientId:(NSString * __nonnull)recipientId privateKey:(NSData * __nonnull)privateKey keyPassword:(NSString * __nullable)keyPassword error:(NSError * __nullable * __nullable)error {
    if (recipientId.length == 0 || privateKey.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1003 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to start chunk decryption with key: At least one of the required parameters is missing.", @"Chunk decryption error.") }];
        }
        return 0;
    }
    
    size_t actualSize = 0;
    try {
        if ([self cryptor] != NULL) {
            std::string recId = std::string([recipientId UTF8String]);
            const unsigned char *pKey = static_cast<const unsigned char *>([privateKey bytes]);
            if (keyPassword.length == 0) {
                actualSize = [self cryptor]->startDecryptionWithKey(VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(recId.data(), recId.size()), VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pKey, [privateKey length]));
            }
            else {
                std::string keyPass = std::string([keyPassword UTF8String]);
                actualSize = [self cryptor]->startDecryptionWithKey(VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(recId.data(), recId.size()), VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pKey, [privateKey length]), VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(keyPass.data(), keyPass.size()));
            }
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1004 userInfo:@{ NSLocalizedDescriptionKey: @"Unable to start chunk decryption. Cryptor is not initialized properly." }];
            }
            actualSize = 0;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown exception during chunk decryption.";
            }
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1005 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        actualSize = 0;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1006 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown exception during chunk decryption." }];
        }
        actualSize = 0;
    }
    
    return actualSize;
}

- (size_t)startDecryptionWithPassword:(NSString * __nonnull)password error:(NSError * __nullable * __nullable)error {
    if (password.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1007 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to start chunk decryption with password: Required parameter is missing.", @"Chunk decryption error.") }];
        }
        return 0;
    }
    
    size_t actualSize = 0;
    try {
        if ([self cryptor] != NULL) {
            std::string pass = std::string([password UTF8String]);
            actualSize = [self cryptor]->startDecryptionWithPassword(VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pass.data(), pass.size()));
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1008 userInfo:@{ NSLocalizedDescriptionKey: @"Unable to start chunk decryption. Cryptor is not initialized properly." }];
            }
            actualSize = 0;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown exception during chunk decryption.";
            }
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1009 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        actualSize = 0;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1010 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown exception during chunk decryption." }];
        }
        actualSize = 0;
    }
    
    return actualSize;
}

- (NSData * __nullable)processDataChunk:(NSData * __nonnull)chunk error:(NSError * __nullable * __nullable)error {
    if (chunk.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1011 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to process data chunk: Required parameter is missing.", @"Chunk processing error.") }];
        }
        return nil;
    }
    
    NSData *processed = nil;
    try {
        if ([self cryptor] != NULL) {
            const unsigned char *bytes = static_cast<const unsigned char *>([chunk bytes]);
            VirgilByteArray proc = [self cryptor]->process(VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(bytes, [chunk length]));
            processed = [NSData dataWithBytes:proc.data() length:proc.size()];
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1012 userInfo:@{ NSLocalizedDescriptionKey: @"Unable to process data chunk. Cryptor is not initialized properly." }];
            }
            processed = nil;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown exception during chunk processing.";
            }
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1013 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        processed = nil;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1014 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown exception during chunk processing." }];
        }
        processed = nil;
    }
    
    return processed;
}

- (BOOL)finishWithError:(NSError * __nullable * __nullable)error {
    BOOL success = NO;
    try {
        if ([self cryptor] != NULL) {
            [self cryptor]->finish();
            success = YES;
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1015 userInfo:@{ NSLocalizedDescriptionKey: @"Unable to finish data chunk processing. Cryptor is not initialized properly." }];
            }
            success = NO;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown exception during finishing chunk processing.";
            }
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1016 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        success = NO;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSChunkCryptorErrorDomain code:-1017 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown exception during finishing chunk processing." }];
        }
        success = NO;
    }
    
    return success;
}

@end
