//
//  VSSModelCommons.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/11/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString GUID;

extern NSString * __nonnull const kVSSModelId;
extern NSString * __nonnull const kVSSModelCreatedAt;

extern NSString * __nonnull const kVSSModelType;
extern NSString * __nonnull const kVSSModelValue;
extern NSString * __nonnull const kVSSModelAuthorizedBy;

extern NSString * __nonnull const kVSSModelIdentity;
extern NSString * __nonnull const kVSSModelHash;
extern NSString * __nonnull const kVSSModelData;

extern NSString * __nonnull const kVSSModelPublicKey;
extern NSString * __nonnull const kVSSModelCards;

extern NSString * __nonnull const kVSSModelPassword;
extern NSString * __nonnull const kVSSModelPrivateKey;

extern NSString * __nonnull const kVSSModelIdentities;
extern NSString * __nonnull const kVSSModelValidationToken;
extern NSString * __nonnull const kVSSModelVirgilCardId;
extern NSString * __nonnull const kVSSModelPublicKeyId;
extern NSString * __nonnull const kVSSModelSigns;
extern NSString * __nonnull const kVSSModelSignerVirgilCardId;
extern NSString * __nonnull const kVSSModelSignedVirgilCardId;
extern NSString * __nonnull const kVSSModelSignedDigest;
extern NSString * __nonnull const kVSSModelRelations;
extern NSString * __nonnull const kVSSModelIncludeUnconfirmed;
extern NSString * __nonnull const kVSSModelResponsePassword;

extern NSString * __nonnull const kVSSModelActionId;
extern NSString * __nonnull const kVSSModelConfirmationCode;
extern NSString * __nonnull const kVSSModelToken;
extern NSString * __nonnull const kVSSModelTTL;
extern NSString * __nonnull const kVSSModelCTL;
extern NSString * __nonnull const kVSSModelExtraFields;

extern NSString * __nonnull const kVSSModelError;
extern NSString * __nonnull const kVSSModelCode;

extern NSString * __nonnull const kVSSIdentityTypeEmail;
extern NSString * __nonnull const kVSSIdentityTypeApplication;

extern NSString * __nonnull const kVSSStringValueTrue;
extern NSString * __nonnull const kVSSStringValueFalse;

extern NSString * __nonnull const kVSSErrorDomain;
extern NSString * __nonnull const kVSSUnknownError;

extern NSInteger const kVSSNoErrorValue;