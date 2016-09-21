//
//  VSSKeysClient.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/11/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSClient.h"

#import "VSSPublicKey.h"
#import "VSSPublicKeyExtended.h"
#import "VSSPrivateKey.h"
#import "VSSCard.h"
#import "VSSIdentityInfo.h"
#import "VSSSign.h"

#import "VSSRequest.h"
#import "VSSServiceConfig.h"
#import "VSSRequestContextExtended.h"
#import "NSObject+VSSUtils.h"

#import "VSSGetPublicKeyRequest.h"
#import "VSSDeletePublicKeyRequest.h"
#import "VSSCreateCardRequest.h"
#import "VSSGetCardRequest.h"
#import "VSSSignCardRequest.h"
#import "VSSUnsignCardRequest.h"
#import "VSSSearchCardRequest.h"
#import "VSSSearchAppCardRequest.h"
#import "VSSSearchEmailCardRequest.h"
#import "VSSDeleteCardRequest.h"

#import "VSSVerifyIdentityRequest.h"
#import "VSSConfirmIdentityRequest.h"

#import "VSSStorePrivateKeyRequest.h"
#import "VSSGrabPrivateKeyRequest.h"
#import "VSSDeletePrivateKeyRequest.h"

@interface VSSClient ()

@property (nonatomic, strong) NSMutableDictionary * __nonnull serviceCards;

- (void)lazySetupServiceWithId:(NSString * __nonnull)serviceId completionHandler:(void (^ __nonnull)(NSError * __nullable error))completionHandler;
- (VSSCard * __nullable)cachedCardForServiceId:(NSString * __nonnull)serviceId;

@end

@implementation VSSClient

@synthesize serviceCards = _serviceCards;

#pragma mark - Overrides

- (void)setupClientWithCompletionHandler:(void (^)(NSError *error))completionHandler {
    /// Re-create serviceCards map
    self.serviceCards = [[NSMutableDictionary alloc] init];
    NSInteger __block requestCount = 0;
    /// For all serviceID from configuration we need to get a card.
    for (NSString *serviceID in [self.serviceConfig serviceIDList]) {
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            --requestCount;
            
            if (request.error != nil) {
                if (completionHandler != nil) {
                    completionHandler(request.error);
                }
                return;
            }

            VSSSearchAppCardRequest *r = [request as:[VSSSearchAppCardRequest class]];
            if (r.cards.count > 0) {
                /// Here should be only one item. So we are interested in first.
                VSSCard *serviceCard = [r.cards[0] as:[VSSCard class]];
                @synchronized(self) {
                    self.serviceCards[serviceID] = serviceCard;
                }
            }
            if (requestCount == 0) {
                if (completionHandler != nil) {
                    completionHandler(nil);
                }
            }
        };
        
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDKeys]];
        VSSSearchAppCardRequest *cardSearchRequest = [[VSSSearchAppCardRequest alloc] initWithContext:context value:[self.serviceConfig serviceCardValueForServiceID:serviceID]];
        cardSearchRequest.completionHandler = handler;
        ++requestCount;
        [self send:cardSearchRequest];
    }
}

- (void)send:(VSSRequest *)request {
    /// Before sending any request set proper token value into correspondent header field:
    if (self.token.length > 0) {
        [request setRequestHeaders:@{ kVSSAccessTokenHeader: self.token }];
    }
    
    [super send:request];
}

#pragma mark - Private class logic

- (void)lazySetupServiceWithId:(NSString *)serviceId completionHandler:(void (^)(NSError *error))completionHandler {
    if (self.serviceCards == nil) {
        self.serviceCards = [[NSMutableDictionary alloc] init];
    }
    
    VSSCard *serviceCard = [self cachedCardForServiceId:serviceId];
    
    if (serviceCard != nil) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil);
            });
        }
        return;
    }
    
    VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
        if (request.error != nil) {
            if (completionHandler != nil) {
                completionHandler(request.error);
            }
            return;
        }
        
        VSSSearchAppCardRequest *r = [request as:[VSSSearchAppCardRequest class]];
        if (r.cards.count > 0) {
            /// Here should be only one item. So we are interested in first.
            VSSCard *serviceCard = [r.cards[0] as:[VSSCard class]];
            @synchronized(self) {
                self.serviceCards[serviceId] = serviceCard;
            }
        }
        
        if (completionHandler != nil) {
            completionHandler(nil);
        }
    };
    
    VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDKeys]];
    VSSSearchAppCardRequest *cardSearchRequest = [[VSSSearchAppCardRequest alloc] initWithContext:context value:[self.serviceConfig serviceCardValueForServiceID:serviceId]];
    cardSearchRequest.completionHandler = handler;
    [self send:cardSearchRequest];
}

- (VSSCard * __nullable)cachedCardForServiceId:(NSString * __nonnull)serviceId {
    VSSCard *serviceCard = nil;
    @synchronized(self) {
        serviceCard = [self.serviceCards[serviceId] as:[VSSCard class]];
    }
    return serviceCard;
}

#pragma mark - Public keys related functionality

- (void)getPublicKeyWithId:(GUID *)keyId completionHandler:(void(^)(VSSPublicKey * __nullable key, NSError * __nullable error))completionHandler {
    if (keyId.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, [NSError errorWithDomain:kVSSRequestErrorDomain code:-200 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to get public key: public key id is not set.", @"GetPublicKeyError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDKeys completionHandler:^(NSError *error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, error);
            }
            return;
        }

        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (request.error != nil) {
                if (completionHandler != nil) {
                    completionHandler(nil, request.error);
                }
                return;
            }
            
            if (completionHandler != nil) {
                VSSGetPublicKeyRequest *r = [request as:[VSSGetPublicKeyRequest class]];
                completionHandler(r.publicKey, nil);
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDKeys] serviceCard:sCard requestEncrypt:@NO responseVerify:@YES privateKey:nil cardId:nil password:nil];
        VSSGetPublicKeyRequest *request = [[VSSGetPublicKeyRequest alloc] initWithContext:context publicKeyId:keyId];
        request.completionHandler = handler;
        [self send:request];
    }];
}

- (void)getPublicKeyWithId:(GUID *)keyId card:(VSSCard *)card privateKey:(VSSPrivateKey *)privateKey completionHandler:(void(^)(VSSPublicKeyExtended *key, NSError *error))completionHandler {
    if (keyId.length == 0 || card.Id.length == 0 || privateKey.key.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, [NSError errorWithDomain:kVSSRequestErrorDomain code:-201 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to get public key: public key id or/and virgil card id or/and private key is/are not set.", @"GetPublicKeySignedError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDKeys completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (request.error != nil) {
                if (completionHandler != nil) {
                    completionHandler(nil, request.error);
                }
                return;
            }
            
            if (completionHandler != nil) {
                VSSGetPublicKeyRequest *r = [request as:[VSSGetPublicKeyRequest class]];
                completionHandler(r.publicKey, nil);
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDKeys] serviceCard:sCard requestEncrypt:@NO responseVerify:@YES privateKey:privateKey cardId:card.Id password:nil];
        VSSGetPublicKeyRequest *request = [[VSSGetPublicKeyRequest alloc] initWithContext:context publicKeyId:keyId];
        request.completionHandler = handler;
        [self send:request];
    }];
}

- (void)deletePublicKeyWithId:(GUID * __nonnull)keyId identityInfoList:(NSArray <VSSIdentityInfo *>* __nonnull)identityInfoList card:(VSSCard * __nonnull)card privateKey:(VSSPrivateKey * __nonnull)privateKey completionHandler:(void(^ __nullable)(NSError * __nullable error))completionHandler {
    
    if (keyId.length == 0 || identityInfoList.count == 0 || card.Id.length == 0 || privateKey.key.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler([NSError errorWithDomain:kVSSRequestErrorDomain code:-202 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to delete public key: public key id or/and identites list or/and virgil card id or/and private key is/are not set.", @"DeletePublicKeySignedError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDKeys completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (completionHandler != nil) {
                completionHandler(request.error);
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDKeys] serviceCard:sCard requestEncrypt:@NO responseVerify:@YES privateKey:privateKey cardId:card.Id password:nil];
        VSSDeletePublicKeyRequest *request = [[VSSDeletePublicKeyRequest alloc] initWithContext:context publicKeyId:keyId identityInfoList:identityInfoList];
        request.completionHandler = handler;
        [self send:request];
    }];
}

#pragma mark - Virgil Cards related functionality

- (void)createCardWithPublicKeyId:(GUID *)keyId identityInfo:(VSSIdentityInfo *)identityInfo data:(NSDictionary * )data privateKey:(VSSPrivateKey *)privateKey completionHandler:(void(^)(VSSCard *card, NSError *error))completionHandler {
    if (keyId.length == 0 || identityInfo == nil || identityInfo.value.length == 0 || privateKey.key.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, [NSError errorWithDomain:kVSSRequestErrorDomain code:-210 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to create card: public key id or/and identity or/and private key is/are not set.", @"CreateCardByKeyIDSignedError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDKeys completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (request.error != nil) {
                if (completionHandler != nil) {
                    completionHandler(nil, request.error);
                }
                return;
            }
            
            if (completionHandler != nil) {
                VSSCreateCardRequest *r = [request as:[VSSCreateCardRequest class]];
                completionHandler(r.card, nil);
                
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDKeys] serviceCard:sCard requestEncrypt:@NO responseVerify:@YES privateKey:privateKey cardId:nil password:nil];
        VSSCreateCardRequest *request = [[VSSCreateCardRequest alloc] initWithContext:context publicKeyId:keyId identityInfo:identityInfo data:data];
        request.completionHandler = handler;
        [self send:request];
    }];
}

- (void)createCardWithPublicKey:(NSData *)key identityInfo:(VSSIdentityInfo *)identityInfo data:(NSDictionary *)data privateKey:(VSSPrivateKey *)privateKey completionHandler:(void(^)(VSSCard *card, NSError *error))completionHandler {
    if (key.length == 0 || identityInfo == nil || identityInfo.value.length == 0 || privateKey.key.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, [NSError errorWithDomain:kVSSRequestErrorDomain code:-211 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to create card: public key or/and identity or/and private key is/are not set.", @"CreateCardByKeyDataSignedError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDKeys completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (request.error != nil) {
                if (completionHandler != nil) {
                    completionHandler(nil, request.error);
                }
                return;
            }
            
            if (completionHandler != nil) {
                VSSCreateCardRequest *r = [request as:[VSSCreateCardRequest class]];
                completionHandler(r.card, nil);
                
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDKeys] serviceCard:sCard requestEncrypt:@NO responseVerify:@YES privateKey:privateKey cardId:nil password:nil];
        VSSCreateCardRequest *request = [[VSSCreateCardRequest alloc] initWithContext:context publicKey:key identityInfo:identityInfo data:data];
        request.completionHandler = handler;
        [self send:request];
    }];
}

- (void)getCardWithCardId:(GUID *)cardId completionHandler:(void(^)(VSSCard *card, NSError *error))completionHandler {
    if (cardId.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, [NSError errorWithDomain:kVSSRequestErrorDomain code:-212 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to get a card: card id is not set.", @"GetCardUnsignedError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDKeys completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (request.error != nil) {
                if (completionHandler != nil) {
                    completionHandler(nil, request.error);
                }
                return;
            }
            
            if (completionHandler != nil) {
                VSSGetCardRequest *r = [request as:[VSSGetCardRequest class]];
                completionHandler(r.card, nil);
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDKeys] serviceCard:sCard requestEncrypt:@NO responseVerify:@YES privateKey:nil cardId:nil password:nil];
        VSSGetCardRequest *request = [[VSSGetCardRequest alloc] initWithContext:context cardId:cardId];
        request.completionHandler = handler;
        [self send:request];
    }];
    
}

- (void)searchCardWithIdentityValue:(NSString *)value type:(NSString *)type unauthorized:(BOOL)unauthorized completionHandler:(void(^)(NSArray <VSSCard *>*cards, NSError *error))completionHandler; {
    if (value.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, [NSError errorWithDomain:kVSSRequestErrorDomain code:-215 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to search for a card: identity value is not set.", @"SearchCardError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDKeys completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (request.error != nil) {
                if (completionHandler != nil) {
                    completionHandler(nil, request.error);
                }
                return;
            }
            
            if (completionHandler != nil) {
                VSSSearchCardRequest *r = [request as:[VSSSearchCardRequest class]];
                completionHandler(r.cards, nil);
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDKeys] serviceCard:sCard requestEncrypt:@NO responseVerify:@YES privateKey:nil cardId:nil password:nil];
        VSSSearchCardRequest *request = [[VSSSearchCardRequest alloc] initWithContext:context value:value type:type unauthorized:unauthorized];
        request.completionHandler = handler;
        [self send:request];
    }];
}

- (void)searchAppCardWithIdentityValue:(NSString *)value completionHandler:(void(^)(NSArray <VSSCard *>*cards, NSError *error))completionHandler {
    if (value.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, [NSError errorWithDomain:kVSSRequestErrorDomain code:-216 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to search for an application's card: identity value is not set.", @"SearchAppCardError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDKeys completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (request.error != nil) {
                if (completionHandler != nil) {
                    completionHandler(nil, request.error);
                }
                return;
            }
            
            if (completionHandler != nil) {
                VSSSearchAppCardRequest *r = [request as:[VSSSearchAppCardRequest class]];
                completionHandler(r.cards, nil);
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDKeys] serviceCard:sCard requestEncrypt:@NO responseVerify:@YES privateKey:nil cardId:nil password:nil];
        VSSSearchAppCardRequest *request = [[VSSSearchAppCardRequest alloc] initWithContext:context value:value];
        request.completionHandler = handler;
        [self send:request];
    }];
}

- (void)searchEmailCardWithIdentityValue:(NSString *)value completionHandler:(void(^)(NSArray <VSSCard *>*cards, NSError *error))completionHandler {
    if (value.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, [NSError errorWithDomain:kVSSRequestErrorDomain code:-233 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to search for an application's card: identity value is not set.", @"SearchEmailCardError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDKeys completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (request.error != nil) {
                if (completionHandler != nil) {
                    completionHandler(nil, request.error);
                }
                return;
            }
            
            if (completionHandler != nil) {
                VSSSearchEmailCardRequest *r = [request as:[VSSSearchEmailCardRequest class]];
                completionHandler(r.cards, nil);
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDKeys] serviceCard:sCard requestEncrypt:@NO responseVerify:@YES privateKey:nil cardId:nil password:nil];
        VSSSearchEmailCardRequest *request = [[VSSSearchEmailCardRequest alloc] initWithContext:context value:value];
        request.completionHandler = handler;
        [self send:request];
    }];
}

- (void)deleteCardWithCardId:(GUID *)cardId identityInfo:(VSSIdentityInfo *)identityInfo privateKey:(VSSPrivateKey *)privateKey completionHandler:(void(^)(NSError *error))completionHandler {
    if (cardId.length == 0 || identityInfo == nil || identityInfo.value.length == 0 || privateKey.key.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler([NSError errorWithDomain:kVSSRequestErrorDomain code:-217 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to delete a card: card id or/and idetity or/and private key is/are not set.", @"DeleteCardError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDKeys completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (completionHandler != nil) {
                completionHandler(request.error);
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDKeys] serviceCard:sCard requestEncrypt:@NO responseVerify:@YES privateKey:privateKey cardId:cardId password:nil];
        VSSDeleteCardRequest *request = [[VSSDeleteCardRequest alloc] initWithContext:context cardId:cardId identityInfo:identityInfo];
        request.completionHandler = handler;
        [self send:request];
    }];
}

#pragma mark - Identities related functionality

- (void)verifyEmailIdentityWithValue:(NSString *)value extraFields:(NSDictionary *)extraFields completionHandler:(void(^)(GUID *actionId, NSError *error))completionHandler; {
    if (value.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, [NSError errorWithDomain:kVSSRequestErrorDomain code:-220 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to initiate verification procedure: identity type or/and identity value is/are not set.", @"VerifyIdentityError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDIdentity completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (request.error != nil) {
                if (completionHandler != nil) {
                    completionHandler(nil, request.error);
                }
                return;
            }
            
            if (completionHandler != nil) {
                VSSVerifyIdentityRequest *r = [request as:[VSSVerifyIdentityRequest class]];
                completionHandler(r.actionId, nil);
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDIdentity];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDIdentity] serviceCard:sCard requestEncrypt:@NO responseVerify:@YES privateKey:nil cardId:nil password:nil];
        VSSVerifyIdentityRequest *request = [[VSSVerifyIdentityRequest alloc] initWithContext:context type:kVSSIdentityTypeEmail value:value extraFields:extraFields];
        request.completionHandler = handler;
        [self send:request];
    }];
}

- (void)confirmEmailIdentityWithActionId:(GUID *)actionId code:(NSString *)code tokenTtl:(NSUInteger)tokenTtl tokenCtl:(NSUInteger)tokenCtl completionHandler:(void(^)(VSSIdentityInfo *identityInfo, NSError *error))completionHandler; {
    if (actionId.length == 0 || code.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, [NSError errorWithDomain:kVSSRequestErrorDomain code:-221 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to confirm identity: action id or/and confirmation code is/are not set.", @"ConfirmIdentityError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDIdentity completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (request.error != nil) {
                if (completionHandler != nil) {
                    completionHandler(nil, request.error);
                }
                return;
            }
            
            if (completionHandler != nil) {
                VSSConfirmIdentityRequest *r = [request as:[VSSConfirmIdentityRequest class]];
                completionHandler(r.identityInfo, nil);
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDIdentity];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDIdentity] serviceCard:sCard requestEncrypt:@NO responseVerify:@YES privateKey:nil cardId:nil password:nil];
        VSSConfirmIdentityRequest *request = [[VSSConfirmIdentityRequest alloc] initWithContext:context actionId:actionId code:code ttl:tokenTtl ctl:tokenCtl];
        request.completionHandler = handler;
        [self send:request];
    }];
}

#pragma mark - Private keys related functionality

- (void)storePrivateKey:(VSSPrivateKey *)privateKey cardId:(GUID *)cardId completionHandler:(void(^)(NSError *error))completionHandler {
    if (privateKey.key.length == 0 || cardId.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler([NSError errorWithDomain:kVSSRequestErrorDomain code:-230 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to store private key: card id or/and private key is/are not set.", @"StorePrivateKeyError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDPrivateKeys completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (completionHandler != nil) {
                completionHandler(request.error);
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDPrivateKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDPrivateKeys] serviceCard:sCard requestEncrypt:@YES responseVerify:@NO privateKey:privateKey cardId:cardId password:nil];
        VSSStorePrivateKeyRequest *request = [[VSSStorePrivateKeyRequest alloc] initWithContext:context privateKey:privateKey.key cardId:cardId];
        request.completionHandler = handler;
        [self send:request];
    }];
}

- (void)getPrivateKeyWithCardId:(GUID *)cardId identityInfo:(VSSIdentityInfo *)identityInfo password:(NSString *)password completionHandler:(void(^)(NSData *keyData, GUID *cardId, NSError *error))completionHandler {
    if (identityInfo == nil || identityInfo.value.length == 0 || cardId.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, nil, [NSError errorWithDomain:kVSSRequestErrorDomain code:-231 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to grab private key: card id or/and identity is/are not set.", @"GrabPrivateKeyError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDPrivateKeys completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, nil, error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (request.error != nil) {
                if (completionHandler != nil) {
                    completionHandler(nil, nil, request.error);
                }
                return;
            }
            
            if (completionHandler != nil) {
                VSSGrabPrivateKeyRequest *r = [request as:[VSSGrabPrivateKeyRequest class]];
                completionHandler(r.privateKey, r.cardId, nil);
            }
            return;
        };
        
        NSString *responsePassword = password;
        if (responsePassword.length == 0) {
            responsePassword = [[[[[NSUUID UUID] UUIDString] lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""] substringToIndex:30];
        }
        else {
            if (responsePassword.length > 30) {
                responsePassword = [responsePassword substringToIndex:30];
            }
        }
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDPrivateKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDPrivateKeys] serviceCard:sCard requestEncrypt:@YES responseVerify:@NO privateKey:nil cardId:cardId password:responsePassword];
        VSSGrabPrivateKeyRequest *request = [[VSSGrabPrivateKeyRequest alloc] initWithContext:context identityInfo:identityInfo cardId:cardId];
        request.completionHandler = handler;
        [self send:request];
    }];
}

- (void)deletePrivateKey:(VSSPrivateKey *)privateKey cardId:(GUID *)cardId completionHandler:(void(^)(NSError *error))completionHandler {
    if (privateKey.key.length == 0 || cardId.length == 0) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler([NSError errorWithDomain:kVSSRequestErrorDomain code:-232 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Impossible to delete private key: card id or/and private key is/are not set.", @"DeletePrivateKeyError") }]);
            });
        }
        return;
    }
    
    [self lazySetupServiceWithId:kVSSServiceIDPrivateKeys completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            if (completionHandler != nil) {
                completionHandler(error);
            }
            return;
        }
        
        VSSRequestCompletionHandler handler = ^(VSSRequest *request) {
            if (completionHandler != nil) {
                completionHandler(request.error);
            }
            return;
        };
        
        VSSCard *sCard = [self cachedCardForServiceId:kVSSServiceIDPrivateKeys];
        VSSRequestContextExtended *context = [[VSSRequestContextExtended alloc] initWithServiceUrl:[self.serviceConfig serviceURLForServiceID:kVSSServiceIDPrivateKeys] serviceCard:sCard requestEncrypt:@YES responseVerify:@NO privateKey:privateKey cardId:cardId password:nil];
        VSSDeletePrivateKeyRequest *request = [[VSSDeletePrivateKeyRequest alloc] initWithContext:context cardId:cardId];
        request.completionHandler = handler;
        [self send:request];
    }];
}

@end
