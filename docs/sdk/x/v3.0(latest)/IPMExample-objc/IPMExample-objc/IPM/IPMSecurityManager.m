//
//  IPMSecurityManager.m
//  IPMExample-objc
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

#import "IPMSecurityManager.h"
#import "IPMConstants.h"

@import VirgilFoundation;

NS_ASSUME_NONNULL_BEGIN

@interface IPMSecurityManager ()

@property (nonatomic, strong, readwrite) NSString *identity;
@property (nonatomic, strong, readwrite) VSSPrivateKey *privateKey;

@property (nonatomic, strong) NSMutableDictionary *cardCache;
@property (nonatomic, strong) VSSClient *client;

@property (atomic, assign) BOOL clientSetUp;
@property (atomic, strong) NSObject *mutex;

@end

NS_ASSUME_NONNULL_END

@implementation IPMSecurityManager

@synthesize cardCache = _cardCache;
@synthesize client = _client;
@synthesize clientSetUp = _clientSetUp;
@synthesize mutex = _mutex;

@synthesize identity = _identity;
@synthesize privateKey = _privateKey;

- (instancetype)initWithIdentity:(NSString *)identity {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _identity = identity;
    _privateKey = [[VSSPrivateKey alloc] initWithKey:[NSData data] password:@""];
    _cardCache = [NSMutableDictionary dictionary];

    _client = [[VSSClient alloc] initWithApplicationToken:kAppToken];
    _clientSetUp = NO;
    _mutex = [[NSObject alloc] init];
    return self;
}

- (instancetype)init {
    return [self initWithIdentity:@""];
}

- (void)cacheCardForIdentities:(NSArray *)identities {
    if (identities.count == 0) {
        NSLog(@"No identities to cache.");
        return;
    }
    
    XAsyncTask *cards = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
        NSInteger __block itemsCount = [identities count];
        for(NSString *identity in identities) {
            VSSCard * __block candidate = nil;
            @synchronized (self.mutex) {
                candidate = [self.cardCache[identity] as:[VSSCard class]];
            }
            if (candidate != nil) {
                --itemsCount;
                if (itemsCount == 0) {
                    [task fireSignal];
                    return;
                }
                continue;
            }
            
            [self.client searchCardWithIdentityValue:identity type:kIPMExampleCardType unauthorized:NO completionHandler:^(NSArray<VSSCard *> * _Nullable cards, NSError * _Nullable error) {
                if (error != nil) {
                    NSLog(@"Error searching cards: %@", [error localizedDescription]);
                }
                else {
                    if (cards.count > 0) {
                        @synchronized (self.mutex) {
                            self.cardCache[identity] = cards[0];
                        }
                    }
                }
                
                --itemsCount;
                if (itemsCount == 0) {
                    [task fireSignal];
                    return;
                }
            }];
        }
    }];
    [cards awaitSignal];
}

- (BOOL)checkSignature:(NSData *)signature data:(NSData *)data identity:(NSString *)identity {
    [self cacheCardForIdentities:@[identity]];
    
    XAsyncTask *verify = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
        VSSCard *sender = nil;
        @synchronized (self.mutex) {
            sender = [self.cardCache[identity] as:[VSSCard class]];
        }
        if (sender == nil) {
            return;
        }
        
        VSSSigner *verifier = [[VSSSigner alloc] init];
        NSError *checkError = nil;
        BOOL ok = [verifier verifySignature:signature data:data publicKey:sender.publicKey.key error:&checkError];
        if (checkError != nil) {
            NSLog(@"Error checking signature: %@", [checkError localizedDescription]);
        }
        task.result = [NSNumber numberWithBool:ok];
    }];
    [verify await];
    return [[verify.result as:[NSNumber class]] boolValue];
}

- (NSData * _Nullable)encryptData:(NSData *)data identities:(NSArray *)identities {
    [self cacheCardForIdentities:identities];
    
    XAsyncTask *encryptData = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
        VSSCryptor *cryptor = [[VSSCryptor alloc] init];
        for (NSString *identity in identities) {
            VSSCard *recipient = nil;
            @synchronized (self.mutex) {
                recipient = [self.cardCache[identity] as:[VSSCard class]];
            }
            if (recipient != nil) {
                NSError *recError = nil;
                [cryptor addKeyRecipient:recipient.Id publicKey:recipient.publicKey.key error:&recError];
                if (recError != nil) {
                    NSLog(@"Error adding key recipient: %@", [recError localizedDescription]);
                }
            }
        }
        task.result = [cryptor encryptData:data embedContentInfo:YES error:nil];
    }];
    [encryptData await];
    return [[encryptData result] as:[NSData class]];
}

- (NSData * _Nullable)decryptData:(NSData *)data {
    [self cacheCardForIdentities:@[self.identity]];
    
    XAsyncTask *decrypt = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
        VSSCard *recipient = nil;
        @synchronized (self.mutex) {
            recipient = self.cardCache[self.identity];
        }
        if (recipient == nil) {
            return;
        }
        
        VSSCryptor *decryptor = [[VSSCryptor alloc] init];
        NSError *decryptError = nil;
        NSData *decrypted = [decryptor decryptData:data recipientId:recipient.Id privateKey:self.privateKey.key keyPassword:self.privateKey.password error:&decryptError];
        if (decryptError != nil) {
            NSLog(@"Error decrypting data: %@", [decryptError localizedDescription]);
        }
        task.result = decrypted;
    }];
    [decrypt await];
    
    return [decrypt.result as:[NSData class]];
}

- (NSData * _Nullable)composeSignatureOnData:(NSData *)data {
    XAsyncTask *sign = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
        VSSSigner *signer = [[VSSSigner alloc] init];
        NSError *signError = nil;
        NSData *signature = [signer signData:data privateKey:self.privateKey.key keyPassword:self.privateKey.password error:&signError];
        if (signError != nil) {
            NSLog(@"Error composing the signature: %@", [signError localizedDescription]);
        }
        task.result = signature;
    }];
    [sign await];
    return [sign.result as:[NSData class]];
}

#pragma mark - Registration/authentication routines

- (NSError *)signin {
    XAsyncTask *signin = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
        [self cacheCardForIdentities:@[self.identity]];
        VSSCard *card = nil;
        @synchronized (self.mutex) {
            card = [self.cardCache[self.identity] as:[VSSCard class]];
        }
        if (card == nil) {
            task.result = [NSError errorWithDomain:@"ErrorDomain" code:-5555 userInfo:nil];
            return;
        }
        
        /// Card has been found. Search for the private key in the keychain
        VSSKeychainValue *pkey = [[VSSKeychainValue alloc] initWithId:kPrivateKeyStorage accessGroup:nil];
        self.privateKey = [[pkey objectForKey:card.identity.value] as:[VSSPrivateKey class]];
        if (self.privateKey == nil) {
            NSLog(@"There is no private key found in the keychain!");
            NSAssert(self.privateKey != nil, @"Private key should exist!");
            task.result = [NSError errorWithDomain:@"ErrorDomain" code:-6660 userInfo:nil];
            return;
        }
    }];
    [signin await];
    return signin.error;
}

- (NSError *)signup {
    XAsyncTask *signup = [XAsyncTask taskWithAction:^(XAsyncTask *__weak  _Nullable task) {
        VSSKeyPair *pair = [[VSSKeyPair alloc] initWithPassword:nil];
        self.privateKey = [[VSSPrivateKey alloc] initWithKey:pair.privateKey password:nil];
        VSSIdentityInfo *info = [[VSSIdentityInfo alloc] initWithType:kIPMExampleCardType value:self.identity];
        NSError *err = nil;
        VSSPrivateKey *appKey = [[VSSPrivateKey alloc] initWithKey:[kAppPrivateKey dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO] password:kAppPrivateKeyPassword];
        [VSSValidationTokenGenerator setValidationTokenForIdentityInfo:info privateKey:appKey error:&err];
        if (err != nil) {
            task.result = err;
            [task fireSignal];
            return;
        }
        
        [self.client createCardWithPublicKey:pair.publicKey identityInfo:info data:nil privateKey:self.privateKey completionHandler:^(VSSCard * _Nullable card, NSError * _Nullable error) {
            if (error != nil || card == nil) {
                task.result = error;
                [task fireSignal];
                return;
            }
            
            @synchronized (self.mutex) {
                self.cardCache[self.identity] = card;
            }
            
            VSSKeychainValue *pkey = [[VSSKeychainValue alloc] initWithId:kPrivateKeyStorage accessGroup:nil];
            [pkey setObject:self.privateKey forKey:self.identity];
            [task fireSignal];
        }];
        
    }];
    [signup awaitSignal];
    return signup.error;
}

@end
