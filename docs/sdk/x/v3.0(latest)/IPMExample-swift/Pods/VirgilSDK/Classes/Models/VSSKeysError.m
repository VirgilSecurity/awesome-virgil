//
//  VSSKeysError.m
//  VirgilKeysSDK
//
//  Created by Pavel Gorb on 9/12/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSKeysError.h"

/// HTTP 500. Server error status is returned on internal application errors
const NSInteger kVSSKeysInternalError                               = 10000;

/// HTTP 401. Auth error status is returned on authorization errors
const NSInteger kVSSKeysIdHeaderDuplicationError                    = 20100;
const NSInteger kVSSKeysIdHeaderInvalidError                        = 20101;
const NSInteger kVSSKeysSignHeaderNotFoundError                     = 20200;
const NSInteger kVSSKeysCardIdHeaderInvalidError                    = 20201;
const NSInteger kVSSKeysSignHeaderInvalidError                      = 20202;
const NSInteger kVSSKeysPublicKeyValueNotFoundError                 = 20203;
const NSInteger kVSSKeysPublicKeyValueEncodingError                 = 20204;
const NSInteger kVSSKeysPublicKeyIdsMatchError                      = 20205;
const NSInteger kVSSKeysPublicKeyIdInvalidError                     = 20206;
const NSInteger kVSSKeysCardIdsMatchError                           = 20208;
const NSInteger kVSSKeysApplicationTokenInvalidError                = 20300;
const NSInteger kVSSKeysStatisticsError                             = 20301;

/// HTTP 400. Request error status is returned on request data validation errors
const NSInteger kVSSKeysJSONError                                   = 30000;
const NSInteger kVSSKeysPublicKeyIdError                            = 30100;
const NSInteger kVSSKeysPublicKeyLengthError                        = 30101;
const NSInteger kVSSKeysPublicKeyEncodingError                      = 30102;
const NSInteger kVSSKeysIdentityTypeError                           = 30201;
const NSInteger kVSSKeysIdentityEmailError                          = 30202;
const NSInteger kVSSKeysIdentityUnconfirmedApplicationError         = 30203;
const NSInteger kVSSKeysIdentityApplicationValueError               = 30204;
const NSInteger kVSSKeysCardNotFoundError                           = 30300;
const NSInteger kVSSKeysCardSignsListInvalidError                   = 30301;
const NSInteger kVSSKeysCardSignedDigestInvalidError                = 30302;
const NSInteger kVSSKeysCardDataFormatInvalidError                  = 30303;
const NSInteger kVSSKeysCardDataArrayFormatInvalidError             = 30304;
const NSInteger kVSSKeysCardDataLengthInvalidError                  = 30305;
const NSInteger kVSSKeysSignNotFoundError                           = 30400;
const NSInteger kVSSKeysSignedDigestInvalidError                    = 30402;
const NSInteger kVSSKeysSignedDigestEncodingError                   = 30403;
const NSInteger kVSSKeysSignDuplicationError                        = 30404;
const NSInteger kVSSKeysSearchValueInvalidError                     = 31000;
const NSInteger kVSSKeysApplicationSearchValueInvalidError          = 31010;
const NSInteger kVSSKeysCardSignsFormatError                        = 31020;
const NSInteger kVSSKeysIdentityTokenInvalidError                   = 31030;
const NSInteger kVSSKeysCardRevocationMatchError                    = 31040;
const NSInteger kVSSKeysIdentityServiceError                        = 31050;
const NSInteger kVSSKeysIdentitiesInvalidError                      = 31060;
const NSInteger kVSSKeysIdentityInvalidError                        = 31070;

@implementation VSSKeysError

- (NSString *)message {
    NSString *message = nil;
    switch (self.code) {
        case kVSSKeysInternalError:
            message = @"Internal service error.";
            break;
        case kVSSKeysIdHeaderDuplicationError:
            message = @"The request ID header was used already.";
            break;
        case kVSSKeysIdHeaderInvalidError:
            message = @"The request ID header is invalid.";
            break;
        case kVSSKeysSignHeaderNotFoundError:
            message = @"The request sign header not found.";
            break;
        case kVSSKeysCardIdHeaderInvalidError:
            message = @"The Virgil Card ID header not specified or incorrect.";
            break;
        case kVSSKeysSignHeaderInvalidError:
            message = @" The request sign header is invalid.";
            break;
        case kVSSKeysPublicKeyValueNotFoundError:
            message = @"Public Key value is required in request body.";
            break;
        case kVSSKeysPublicKeyValueEncodingError:
            message = @"Public Key value in request body must be base64 encoded value.";
            break;
        case kVSSKeysPublicKeyIdsMatchError:
            message = @"Public Key IDs in URL part and public key for the Virgil Card retrieved from X-VIRGIL-REQUEST-SIGN-VIRGIL-CARD-ID header must match.";
            break;
        case kVSSKeysPublicKeyIdInvalidError:
            message = @"The public key id in the request body is invalid.";
            break;
        case kVSSKeysCardIdsMatchError:
            message = @"Virgil card ids in url and authentication header must match.";
            break;
        case kVSSKeysApplicationTokenInvalidError:
            message = @"The Virgil application token was not specified or invalid.";
            break;
        case kVSSKeysStatisticsError:
            message = @"The Virgil statistics application error.";
            break;
        case kVSSKeysJSONError:
            message = @"JSON specified as a request body is invalid.";
            break;
        case kVSSKeysPublicKeyIdError:
            message = @"Public Key ID is invalid.";
            break;
        case kVSSKeysPublicKeyLengthError:
            message = @"Public key length invalid.";
            break;
        case kVSSKeysPublicKeyEncodingError:
            message = @"Public key must be base64-encoded string.";
            break;
        case kVSSKeysIdentityTypeError:
            message = @"Identity type is invalid. Valid types are: 'email', 'application'.";
            break;
        case kVSSKeysIdentityEmailError:
            message = @"Email value specified for the email identity is invalid.";
            break;
        case kVSSKeysIdentityUnconfirmedApplicationError:
            message = @"Cannot create unconfirmed application identity.";
            break;
        case kVSSKeysIdentityApplicationValueError:
            message = @"Application value specified for the application identity is invalid.";
            break;
        case kVSSKeysCardNotFoundError:
            message = @"Signed Virgil Card not found by UUID provided.";
            break;
        case kVSSKeysCardSignsListInvalidError:
            message = @"Virgil Card's signs list contains an item with invalid signed_id value.";
            break;
        case kVSSKeysCardSignedDigestInvalidError:
            message = @"Virgil Card's one of sined digests is invalid.";
            break;
        case kVSSKeysCardDataFormatInvalidError:
            message = @"Virgil Card's data parameters must be strings.";
            break;
        case kVSSKeysCardDataArrayFormatInvalidError:
            message = @"Virgil Card's data parameters must be an array of strings.";
            break;
        case kVSSKeysCardDataLengthInvalidError:
            message = @"Virgil Card custom data entry value length validation failed.";
            break;
        case kVSSKeysSignNotFoundError:
            message = @"Sign object not found for id specified.";
            break;
        case kVSSKeysSignedDigestInvalidError:
            message = @"The signed digest value is invalid.";
            break;
        case kVSSKeysSignedDigestEncodingError:
            message = @"Sign Signed digest must be base64 encoded string.";
            break;
        case kVSSKeysSignDuplicationError:
            message = @"Cannot save the Sign because it exists already.";
            break;
        case kVSSKeysSearchValueInvalidError:
            message = @"Value search parameter is mandatory.";
            break;
        case kVSSKeysApplicationSearchValueInvalidError:
            message = @"Search value parameter is mandatory for the application search.";
            break;
        case kVSSKeysCardSignsFormatError:
            message = @"Virgil Card's signs parameter must be an array.";
            break;
        case kVSSKeysIdentityTokenInvalidError:
            message = @"Identity validation token is invalid.";
            break;
        case kVSSKeysCardRevocationMatchError:
            message = @"Virgil Card revokation parameters do not match Virgil Card's identity.";
            break;
        case kVSSKeysIdentityServiceError:
            message = @"Virgil Identity service error.";
            break;
        case kVSSKeysIdentitiesInvalidError:
            message = @"Identities parameter is invalid.";
            break;
        case kVSSKeysIdentityInvalidError:
            message = @"Identity validation failed.";
            break;
        default:
            break;
    }
    
    return message;
}

@end
