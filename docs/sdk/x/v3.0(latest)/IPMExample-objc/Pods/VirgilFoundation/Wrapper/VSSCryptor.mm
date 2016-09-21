//
//  VSSCryptor.mm
//  VirgilFoundation
//
//  Created by Pavel Gorb on 2/3/15.
//  Copyright (c) 2015 VirgilSecurity, Inc. All rights reserved.
//

#import "VSSCryptor.h"
#import "VSSBaseCryptor_Private.h"
#import <VirgilCrypto/virgil/crypto/VirgilCipher.h>

using virgil::crypto::VirgilByteArray;
using virgil::crypto::VirgilCipher;

NSString *const kVSSCryptorErrorDomain = @"VSSCryptorErrorDomain";

@interface VSSCryptor ()

- (VirgilCipher *)cryptor;

@end

@implementation VSSCryptor

#pragma mark - Lifecycle

- (void)initializeCryptor {
    if (self.llCryptor != NULL) {
        // llCryptor has been initialized already.
        return;
    }
    
    try {
        self.llCryptor = new VirgilCipher();
    }
    catch(...) {
        self.llCryptor = NULL;
    }
}

- (void)dealloc {
    if (self.llCryptor != NULL) {
        delete (VirgilCipher *)self.llCryptor;
        self.llCryptor = NULL;
    }
}

- (VirgilCipher *)cryptor {
    if (self.llCryptor == NULL) {
        return NULL;
    }
    
    return static_cast<VirgilCipher *>(self.llCryptor);
}

#pragma mark - Public class logic

- (NSData *)encryptData:(NSData *)plainData embedContentInfo:(NSNumber *) embedContentInfo {
    return [self encryptData:plainData embedContentInfo:[embedContentInfo boolValue] error:nil];
}

- (NSData *)encryptData:(NSData *)plainData embedContentInfo:(BOOL)embedContentInfo error:(NSError **)error {
    if (plainData.length == 0) {
        // Can't encrypt.
        if (error) {
            *error = [NSError errorWithDomain:kVSSCryptorErrorDomain code:-1000 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to encrypt: Required parameter is missing.", @"Encrypt data error.") }];
        }
        return nil;
    }
    
    NSData *encData = nil;
    try {
        if ([self cryptor] != NULL) {
            // Convert NSData to VirgilByteArray
            const unsigned char *dataToEncrypt = static_cast<const unsigned char *>([plainData bytes]);
            VirgilByteArray plainDataArray = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(dataToEncrypt, [plainData length]);
            
            // Encrypt data.
            VirgilByteArray encryptedData = [self cryptor]->encrypt(plainDataArray, (bool)embedContentInfo);
            encData = [NSData dataWithBytes:encryptedData.data() length:encryptedData.size()];
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSCryptorErrorDomain code:-1001 userInfo:@{ NSLocalizedDescriptionKey: @"Unable to encrypt. Cryptor is not initialized properly." }];
            }
            encData = nil;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown exception during encryption.";
            }
            *error = [NSError errorWithDomain:kVSSCryptorErrorDomain code:-1002 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        encData = nil;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSCryptorErrorDomain code:-1003 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown exception during encryption." }];
        }
        encData = nil;
    }
    
    return encData;
}

- (NSData *)decryptData:(NSData *)encryptedData recipientId:(NSString *)recipientId privateKey:(NSData *)privateKey keyPassword:(NSString *)keyPassword {
    return [self decryptData:encryptedData recipientId:recipientId privateKey:privateKey keyPassword:keyPassword error:nil];
}

- (NSData *)decryptData:(NSData *)encryptedData recipientId:(NSString *)recipientId privateKey:(NSData *)privateKey keyPassword:(NSString *)keyPassword error:(NSError **)error {
    if (encryptedData.length == 0 || recipientId.length == 0 || privateKey.length == 0) {
        // Can't decrypt
        if (error) {
            *error = [NSError errorWithDomain:kVSSCryptorErrorDomain code:-1004 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to decrypt with key: At least one of the required parameters is missing.", @"Decrypt data error.") }];
        }
        return nil;
    }
    
    NSData *decData = nil;
    try {
        if ([self cryptor] != NULL) {
            const unsigned char *dataToDecrypt = static_cast<const unsigned char *>([encryptedData bytes]);
            VirgilByteArray encryptedDataArray = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(dataToDecrypt, [encryptedData length]);
            
            std::string recId = std::string([recipientId UTF8String]);
            VirgilByteArray recIdArray = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(recId.data(), recId.size());
            
            const unsigned char *pKeyData = static_cast<const unsigned char *>([privateKey bytes]);
            VirgilByteArray pKey = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pKeyData, [privateKey length]);
            
            VirgilByteArray decrypted;
            if (keyPassword.length > 0) {
                std::string pKeyPassS = std::string([keyPassword UTF8String]);
                VirgilByteArray pKeyPass = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pKeyPassS.data(), pKeyPassS.size());
                decrypted = [self cryptor]->decryptWithKey(encryptedDataArray, recIdArray, pKey, pKeyPass);
            }
            else {
                decrypted = [self cryptor]->decryptWithKey(encryptedDataArray, recIdArray, pKey);
            }
            decData = [NSData dataWithBytes:decrypted.data() length:decrypted.size()];
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSCryptorErrorDomain code:-1005 userInfo:@{ NSLocalizedDescriptionKey: @"Unable to decrypt with key. Cryptor is not initialized properly." }];
            }
            decData = nil;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown exception during decryption with key.";
            }
            *error = [NSError errorWithDomain:kVSSCryptorErrorDomain code:-1006 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        decData = nil;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSCryptorErrorDomain code:-1007 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown exception during decryption with key." }];
        }
        decData = nil;
    }
    return decData;
}

- (NSData *)decryptData:(NSData *)encryptedData password:(NSString *)password {
    return [self decryptData:encryptedData password:password error:nil];
}

- (NSData *)decryptData:(NSData *)encryptedData password:(NSString *)password error:(NSError **)error {
    if (encryptedData.length == 0 || password.length == 0) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSCryptorErrorDomain code:-1008 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to decrypt with password: At least one of the required parameters is missing.", @"Decrypt data error.") }];
        }
        return nil;
    }
    
    NSData *decData = nil;
    try {
        if ([self cryptor] != NULL) {
            const unsigned char *dataToDecrypt = (const unsigned char *)[encryptedData bytes];
            VirgilByteArray data = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(dataToDecrypt, [encryptedData length]);
            
            std::string pass = std::string([password UTF8String]);
            VirgilByteArray pwd = VIRGIL_BYTE_ARRAY_FROM_PTR_AND_LEN(pass.data(), pass.size());
            
            VirgilByteArray plain = [self cryptor]->decryptWithPassword(data, pwd);
            decData = [NSData dataWithBytes:plain.data() length:plain.size()];
            if (error) {
                *error = nil;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:kVSSCryptorErrorDomain code:-1009 userInfo:@{ NSLocalizedDescriptionKey: @"Unable to decrypt with password. Cryptor is not initialized properly." }];
            }
            decData = nil;
        }
    }
    catch(std::exception &ex) {
        if (error) {
            NSString *description = [[NSString alloc] initWithCString:ex.what() encoding:NSUTF8StringEncoding];
            if (description.length == 0) {
                description = @"Unknown exception during decryption with password.";
            }
            *error = [NSError errorWithDomain:kVSSCryptorErrorDomain code:-1010 userInfo:@{ NSLocalizedDescriptionKey: description }];
        }
        decData = nil;
    }
    catch(...) {
        if (error) {
            *error = [NSError errorWithDomain:kVSSCryptorErrorDomain code:-1011 userInfo:@{ NSLocalizedDescriptionKey: @"Unknown exception during decryption with password." }];
        }
        decData = nil;
    }
    
    return decData;
}

@end
