//
//  VSSPrivateKeysError.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/16/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSPrivateKeysError.h"

const NSInteger kVSSPrivateKeysInternalError                    = 10000;

const NSInteger kVSSPrivateKeysControllerNotFoundError          = 10010;
const NSInteger kVSSPrivateKeysActionNotFoundError              = 10020;

const NSInteger kVSSPrivateKeysInvalidEncodingError             = 20000;
const NSInteger kVSSPrivateKeysJSONError                        = 20010;
const NSInteger kVSSPrivateKeysResponsePasswordInvalidError     = 20020;

const NSInteger kVSSPrivateKeysPrivateKeyMissingError           = 30010;
const NSInteger kVSSPrivateKeysPrivateKeyBase64Error            = 30020;

const NSInteger kVSSPrivateKeysCardIdMissingError               = 40000;
const NSInteger kVSSPrivateKeysCardIdFormatError                = 40010;
const NSInteger kVSSPrivateKeysCardIdNotFoundError              = 40020;
const NSInteger kVSSPrivateKeysCardIdExistsError                = 40030;
const NSInteger kVSSPrivateKeysCardIdNotFoundKeysServiceError   = 40040;
const NSInteger kVSSPrivateKeysCardIdNotFoundIdentityError      = 40050;

const NSInteger kVSSPrivateKeysSignUUIDNotFoundError            = 50000;
const NSInteger kVSSPrivateKeysSignUUIDFormatError              = 50010;
const NSInteger kVSSPrivateKeysSignUUIDExistsError              = 50020;
const NSInteger kVSSPrivateKeysSignInvalidError                 = 50030;

const NSInteger kVSSPrivateKeysIdentityNotFoundError            = 60000;
const NSInteger kVSSPrivateKeysIdentityTypeNotFoundError        = 60010;
const NSInteger kVSSPrivateKeysIdentityValueNotFoundError       = 60020;
const NSInteger kVSSPrivateKeysIdentityTokenNotFoundError       = 60030;

const NSInteger kVSSPrivateKeysIdentityValidationRAError        = 90000;
const NSInteger kVSSPrivateKeysAccessTokenValidationStatsError  = 90010;

@implementation VSSPrivateKeysError

- (NSString *)message {
    NSString *message = nil;
    switch (self.code) {
        case kVSSPrivateKeysInternalError:
            message = @"Internal application error.";
            break;
        case kVSSPrivateKeysControllerNotFoundError:
            message = @"Controller was not found.";
            break;
        case kVSSPrivateKeysActionNotFoundError:
            message = @"Action was not found.";
            break;
        case kVSSPrivateKeysInvalidEncodingError:
            message = @"Request wrongly encoded.";
            break;
        case kVSSPrivateKeysJSONError:
            message = @"Request JSON invalid.";
            break;
        case kVSSPrivateKeysResponsePasswordInvalidError:
            message = @"Request 'response_password' parameter invalid.";
            break;
        case kVSSPrivateKeysPrivateKeyMissingError:
            message = @"Private Key not specified.";
            break;
        case kVSSPrivateKeysPrivateKeyBase64Error:
            message = @"Private Key not base64 encoded.";
            break;
        case kVSSPrivateKeysCardIdMissingError:
            message = @"Virgil Card ID not specified.";
            break;
        case kVSSPrivateKeysCardIdFormatError:
            message = @"Virgil Card ID has incorrect format.";
            break;
        case kVSSPrivateKeysCardIdNotFoundError:
            message = @"Virgil Card ID not found.";
            break;
        case kVSSPrivateKeysCardIdExistsError:
            message = @"Virgil Card ID already exists.";
            break;
        case kVSSPrivateKeysCardIdNotFoundKeysServiceError:
            message = @"Virgil Card ID not found in Public Key service.";
            break;
        case kVSSPrivateKeysCardIdNotFoundIdentityError:
            message = @"Virgil Card ID not found for provided Identity.";
            break;
        case kVSSPrivateKeysSignUUIDNotFoundError:
            message = @"Request Sign UUID not specified.";
            break;
        case kVSSPrivateKeysSignUUIDFormatError:
            message = @"Request Sign UUID has wrong format.";
            break;
        case kVSSPrivateKeysSignUUIDExistsError:
            message = @"Request Sign UUID already exists.";
            break;
        case kVSSPrivateKeysSignInvalidError:
            message = @"Request Sign is incorrect.";
            break;
        case kVSSPrivateKeysIdentityNotFoundError:
            message = @"Identity not specified.";
            break;
        case kVSSPrivateKeysIdentityTypeNotFoundError:
            message = @"Identity Type not specified.";
            break;
        case kVSSPrivateKeysIdentityValueNotFoundError:
            message = @"Identity Value not specified.";
            break;
        case kVSSPrivateKeysIdentityTokenNotFoundError:
            message = @"Identity Token not specified.";
            break;
        case kVSSPrivateKeysIdentityValidationRAError:
            message = @"Identity validation under RA service failed.";
            break;
        case kVSSPrivateKeysAccessTokenValidationStatsError:
            message = @"Access Token validation under Stats service failed.";
            break;
        default:
            break;
    }
    
    return message;
}

@end
