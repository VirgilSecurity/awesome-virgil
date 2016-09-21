//
//  VSSKeysError.h
//  VirgilKeysSDK
//
//  Created by Pavel Gorb on 9/12/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSError.h"

/// HTTP 500. Server error status is returned on internal application errors
extern const NSInteger kVSSKeysInternalError;

/// HTTP 401. Auth error status is returned on authorization errors
extern const NSInteger kVSSKeysIdHeaderDuplicationError;
extern const NSInteger kVSSKeysIdHeaderInvalidError;
extern const NSInteger kVSSKeysSignHeaderNotFoundError;
extern const NSInteger kVSSKeysCardIdHeaderInvalidError;
extern const NSInteger kVSSKeysSignHeaderInvalidError;
extern const NSInteger kVSSKeysPublicKeyValueNotFoundError;
extern const NSInteger kVSSKeysPublicKeyValueEncodingError;
extern const NSInteger kVSSKeysPublicKeyIdsMatchError;
extern const NSInteger kVSSKeysPublicKeyIdInvalidError;
extern const NSInteger kVSSKeysCardIdsMatchError;
extern const NSInteger kVSSKeysApplicationTokenInvalidError;
extern const NSInteger kVSSKeysStatisticsError;

/// HTTP 400. Request error status is returned on request data validation errors
extern const NSInteger kVSSKeysJSONError;
extern const NSInteger kVSSKeysPublicKeyIdError;
extern const NSInteger kVSSKeysPublicKeyLengthError;
extern const NSInteger kVSSKeysPublicKeyEncodingError;
extern const NSInteger kVSSKeysIdentityTypeError;
extern const NSInteger kVSSKeysIdentityEmailError;
extern const NSInteger kVSSKeysIdentityUnconfirmedApplicationError;
extern const NSInteger kVSSKeysIdentityApplicationValueError;
extern const NSInteger kVSSKeysCardNotFoundError;
extern const NSInteger kVSSKeysCardSignsListInvalidError;
extern const NSInteger kVSSKeysCardSignedDigestInvalidError;
extern const NSInteger kVSSKeysCardDataFormatInvalidError;
extern const NSInteger kVSSKeysCardDataArrayFormatInvalidError;
extern const NSInteger kVSSKeysCardDataLengthInvalidError;
extern const NSInteger kVSSKeysSignNotFoundError;
extern const NSInteger kVSSKeysSignedDigestInvalidError;
extern const NSInteger kVSSKeysSignedDigestEncodingError;
extern const NSInteger kVSSKeysSignDuplicationError;
extern const NSInteger kVSSKeysSearchValueInvalidError;
extern const NSInteger kVSSKeysApplicationSearchValueInvalidError;
extern const NSInteger kVSSKeysCardSignsFormatError;
extern const NSInteger kVSSKeysIdentityTokenInvalidError;
extern const NSInteger kVSSKeysCardRevocationMatchError;
extern const NSInteger kVSSKeysIdentityServiceError;
extern const NSInteger kVSSKeysIdentitiesInvalidError;
extern const NSInteger kVSSKeysIdentityInvalidError;

/**
 * Concrete subclass representing the errors returning by the Virgil Keys Service.
 */
@interface VSSKeysError : VSSError

@end
