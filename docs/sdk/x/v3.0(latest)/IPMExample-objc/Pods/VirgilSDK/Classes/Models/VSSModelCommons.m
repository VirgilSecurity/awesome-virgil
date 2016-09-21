//
//  VSSModelCommons.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/11/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSModelCommons.h"

NSString *const kVSSModelId = @"id";
NSString *const kVSSModelCreatedAt = @"created_at";

NSString *const kVSSModelType = @"type";
NSString *const kVSSModelValue = @"value";
NSString *const kVSSModelAuthorizedBy = @"authorized_by";

NSString *const kVSSModelIdentity = @"identity";
NSString *const kVSSModelHash = @"hash";
NSString *const kVSSModelData = @"data";

NSString *const kVSSModelPublicKey = @"public_key";
NSString *const kVSSModelCards = @"virgil_cards";

NSString *const kVSSModelPassword = @"password";
NSString *const kVSSModelPrivateKey = @"private_key";

NSString *const kVSSModelIdentities = @"identities";
NSString *const kVSSModelValidationToken = @"validation_token";
NSString *const kVSSModelVirgilCardId = @"virgil_card_id";
NSString *const kVSSModelPublicKeyId = @"public_key_id";
NSString *const kVSSModelSigns = @"signs";
NSString *const kVSSModelSignerVirgilCardId = @"signer_virgil_card_id";
NSString *const kVSSModelSignedVirgilCardId = @"signed_virgil_card_id";
NSString *const kVSSModelSignedDigest = @"signed_digest";
NSString *const kVSSModelRelations = @"relations";
NSString *const kVSSModelIncludeUnconfirmed = @"include_unconfirmed";
NSString *const kVSSModelResponsePassword = @"response_password";

NSString *const kVSSModelActionId = @"action_id";
NSString *const kVSSModelConfirmationCode = @"confirmation_code";
NSString *const kVSSModelToken = @"token";
NSString *const kVSSModelTTL = @"time_to_live";
NSString *const kVSSModelCTL = @"count_to_live";
NSString *const kVSSModelExtraFields = @"extra_fields";

NSString *const kVSSModelError = @"error";
NSString *const kVSSModelCode = @"code";

NSString *const kVSSIdentityTypeEmail = @"email";
NSString *const kVSSIdentityTypeApplication = @"application";

NSString *const kVSSStringValueTrue = @"true";
NSString *const kVSSStringValueFalse = @"false";

NSString *const kVSSErrorDomain = @"VirgilSecurityServicesErrorDomain";
NSString *const kVSSUnknownError = @"Virgil Security service unknown error.";

NSInteger const kVSSNoErrorValue = 0;