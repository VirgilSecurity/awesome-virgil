//
//  VKKeysClient.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/11/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSSBaseClient.h"
#import "VSSModelCommons.h"

@class VSSPublicKey;
@class VSSPublicKeyExtended;
@class VSSPrivateKey;
@class VSSCard;
@class VSSSign;
@class VSSIdentityInfo;

/**
 * The Virgil Service Client handles all the interactions with the Virgil Services.
 */
@interface VSSClient : VSSBaseClient

#pragma mark - Public keys related functionality

///------------------------------------------
/// @name Public keys related functionality
///------------------------------------------

/**
 * Gets public key instance from the Virgil Keys Service. This method sends unauthenticated request,
 * so the returned public key will contain only id, actual public key data and creation date. There will not be an array 
 * of cards for the key returned. Use authenticated request instead.
 *
 * @param keyId GUID containing the public key id of the key which should be get.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)getPublicKeyWithId:(GUID * __nonnull)keyId completionHandler:(void(^ __nullable)(VSSPublicKey * __nullable key, NSError * __nullable error))completionHandler;

/**
 * Gets public key instance from the Virgil Keys Service. This method sends authenticated request,
 * so the returned public key will contain an array of cards for the public key as well as all other key's data. 
 *
 * @param keyId GUID containing the public key id of the key which should be get.
 * @param card VSSCard which should be used for authenticated request.
 * @param privateKey VSSPrivateKey which will be used to compose the signature for authentication.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)getPublicKeyWithId:(GUID * __nonnull)keyId card:(VSSCard * __nonnull)card privateKey:(VSSPrivateKey * __nonnull)privateKey completionHandler:(void(^ __nullable)(VSSPublicKeyExtended * __nullable key, NSError * __nullable error))completionHandler;

/**
 * Deletes public key instance from the Virgil Keys Service. This method sends authenticated request.
 *
 * @param keyId GUID containing the public key id of the key which should be get.
 * @param identityInfoList NSArray of VSSIdentityInfo objects.
 * @param card VSSCard which should be used for authenticated request.
 * @param privateKey VSSPrivateKey which will be used to compose the signature for authentication.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)deletePublicKeyWithId:(GUID * __nonnull)keyId identityInfoList:(NSArray <VSSIdentityInfo *>* __nonnull)identityInfoList card:(VSSCard * __nonnull)card privateKey:(VSSPrivateKey * __nonnull)privateKey completionHandler:(void(^ __nullable)(NSError * __nullable error))completionHandler;

#pragma mark - Virgil Cards related functionality

///------------------------------------------
/// @name Virgil Cards related functionality
///------------------------------------------

/**
 * Creates Virgil Card instance on the Virgil Keys Service and associates it with the public key with given ID.
 *
 * @param keyId GUID public key identifier to associate this card with.
 * @param identityInfo VSSIdentityInfo containing the identity information.
 * @param data NSDictionary<String, String> object containing the custom key-value pairs associated with this card. May be nil.
 * @param privateKey VSSPrivateKey container with private key data and password if any.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)createCardWithPublicKeyId:(GUID * __nonnull)keyId identityInfo:(VSSIdentityInfo * __nonnull)identityInfo data:(NSDictionary * __nullable)data privateKey:(VSSPrivateKey * __nonnull)privateKey completionHandler:(void(^ __nullable)(VSSCard * __nullable card, NSError * __nullable error))completionHandler;

/**
 * Creates Virgil Card instance on the Virgil Keys Service with given public key data.
 *
 * @param key Public key data to associate this card with.
 * @param identityInfo VSSIdentityInfo containing the identity information.
 * @param data NSDictionary<String, String> object containing the custom key-value pairs associated with this card. May be nil.
 * @param privateKey VSSPrivateKey container with private key data and password if any.
 * @param completionHandler Callback handler which will be called after request completed.
 *
 */
- (void)createCardWithPublicKey:(NSData * __nonnull)key identityInfo:(VSSIdentityInfo * __nonnull)identityInfo data:(NSDictionary * __nullable)data privateKey:(VSSPrivateKey * __nonnull)privateKey completionHandler:(void(^ __nullable)(VSSCard * __nullable card, NSError * __nullable error))completionHandler;

/**
 * Gets Virgil Card with given id from the Virgil Keys Service.
 *
 * @param cardId GUID identifier of the card.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)getCardWithCardId:(GUID * __nonnull)cardId completionHandler:(void(^ __nullable)(VSSCard * __nullable card, NSError * __nullable error))completionHandler;

/**
 * Performs search of the private cards only with given parameters on the Virgil Keys Service.
 * The cards array in callback of this method will NOT return global cards, even if type is set to VSSIdentityTypeApplication or VSSIdentityTypeEmail
 *
 * @param value NSString Identity value for the card to search.
 * @param type NSString type of identity. May be nil.
 * @param unauthorized BOOL In case of NO - unauthorized cards will not be returned in the array of cards in callback.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)searchCardWithIdentityValue:(NSString * __nonnull)value type:(NSString * __nullable)type unauthorized:(BOOL)unauthorized completionHandler:(void(^ __nullable)(NSArray <VSSCard *>* __nullable cards, NSError * __nullable error))completionHandler;

/**
 * Performs search of the global cards only with type VSSIdentityTypeApplication with given parameters on the Virgil Keys Service.
 * The cards array in callback of this method will not return private cards even if type is the same.
 *
 * @param value NSString value of the app identity associated with required global Virgil Card.
 * @param completionHandler Callback handler which will be called after request completed.
 *
 */
- (void)searchAppCardWithIdentityValue:(NSString * __nonnull)value completionHandler:(void(^ __nullable)(NSArray <VSSCard *>* __nullable cards, NSError * __nullable error))completionHandler;

/**
 * Performs search of the global cards only with type VSSIdentityTypeEmail with given parameters on the Virgil Keys Service.
 * The cards array in callback of this method will not return private cards even if type is the same.
 *
 * @param value NSString value of the email identity associated with required global Virgil Card.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)searchEmailCardWithIdentityValue:(NSString * __nonnull)value completionHandler:(void(^ __nullable)(NSArray <VSSCard *>* __nullable cards, NSError * __nullable error))completionHandler;

/**
 * Deletes the Virgil Card with given cardId and identity from the Virgil Keys Service.
 *
 * @param cardId GUID identifier of the card which is needs to be deleted.
 * @param identityInfo VSSIdentityInfo containing the identity information. May be nil for unconfirmed Virgil Cards.
 * @param privateKey VSSPrivateKey container with private key data and password if any.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)deleteCardWithCardId:(GUID * __nonnull)cardId identityInfo:(VSSIdentityInfo * __nullable)identityInfo privateKey:(VSSPrivateKey * __nonnull)privateKey completionHandler:(void(^ __nullable)(NSError * __nullable error))completionHandler;

#pragma mark - Identities related functionality

///------------------------------------------
/// @name Identities related functionality
///------------------------------------------

/**
 * Initiates email identity global verification flow for given identity with extra information.
 *
 * @param value NSString value of the identity which have to be verified. The only supported type for now is VSSIdentityTypeEmail.
 * @param extraFields NSDictionary<NSString, NSString> containing required extra key-value pairs to be used in verification process.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)verifyEmailIdentityWithValue:(NSString * __nonnull)value extraFields:(NSDictionary * __nullable)extraFields completionHandler:(void(^ __nullable)(GUID * __nullable actionId, NSError * __nullable error))completionHandler;

/**
 * Completes email identity global verification flow by action id and using confirmation code.
 *
 * @param actionId GUID identifier of the verification identity flow returned in callback of -verifyIdentity...
 * @param code NSString Confirmation code received from the user.
 * @param tokenTtl NSUInteger with token's 'time to live' parameter for the limitations of the token's lifetime in seconds:
 * (maximum value is 60 * 60 * 24 * 365 = 1 year). Default value is 3600. In case of 0 - default value will be used by the SDK.
 * @param tokenCtl NSUInteger with token's 'count to live' parameter to restrict the number of token usages (maximum value is 100). 
 * Default value is 1. In case of 0 - default value will be used by the SDK.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)confirmEmailIdentityWithActionId:(GUID * __nonnull)actionId code:(NSString * __nonnull)code tokenTtl:(NSUInteger)tokenTtl tokenCtl:(NSUInteger)tokenCtl completionHandler:(void(^ __nullable)(VSSIdentityInfo * __nullable identityInfo, NSError * __nullable error))completionHandler;


#pragma mark - Private keys related functionality

///------------------------------------------
/// @name Private keys related functionality
///------------------------------------------

/**
 * Stores the private key instance on the Virgil Private Keys Service.
 *
 * @param privateKey VSSPrivateKey containing the private key data and password if any.
 * @param cardId GUID identifier of the correspondent Virgil Card stored on the Virgil Keys Service.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)storePrivateKey:(VSSPrivateKey * __nonnull)privateKey cardId:(GUID * __nonnull)cardId completionHandler:(void(^ __nullable)(NSError * __nullable error))completionHandler;

/**
 * Gets the private key instance from the Virgil Private Keys Service.
 *
 * @param cardId GUID identifier of the correspondent Virgil Card stored on the Virgil Keys Service.
 * @param identityInfo VSSIdentityInfo containing the identity information.
 * @param password NSString password which will be used by the Virgil Private Keys Service for response encryption. 
 * If password is nil then random password will be generated by the SDK for this single request.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)getPrivateKeyWithCardId:(GUID * __nonnull)cardId identityInfo:(VSSIdentityInfo * __nonnull)identityInfo password:(NSString * __nullable)password completionHandler:(void(^ __nullable)(NSData * __nullable keyData, GUID * __nullable cardId, NSError * __nullable error))completionHandler;

/**
 * @brief Deletes the private key instance from the Virgil Private Keys Service.
 *
 * @param privateKey VSSPrivateKey containing the private key data and password if any.
 * @param cardId GUID identifier of the correspondent Virgil Card stored on the Virgil Keys Service.
 * @param completionHandler Callback handler which will be called after request completed.
 */
- (void)deletePrivateKey:(VSSPrivateKey * __nonnull)privateKey cardId:(GUID * __nonnull)cardId completionHandler:(void(^ __nullable)(NSError * __nullable error))completionHandler;

@end
