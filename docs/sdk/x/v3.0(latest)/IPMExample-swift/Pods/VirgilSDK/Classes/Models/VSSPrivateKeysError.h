//
//  VSSPrivateKeysError.h
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/16/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSError.h"

extern const NSInteger kVSSPrivateKeysInternalError;

extern const NSInteger kVSSPrivateKeysControllerNotFoundError;
extern const NSInteger kVSSPrivateKeysActionNotFoundError;

extern const NSInteger kVSSPrivateKeysInvalidEncodingError;
extern const NSInteger kVSSPrivateKeysJSONError;
extern const NSInteger kVSSPrivateKeysResponsePasswordInvalidError;

extern const NSInteger kVSSPrivateKeysPrivateKeyMissingError;
extern const NSInteger kVSSPrivateKeysPrivateKeyBase64Error;

extern const NSInteger kVSSPrivateKeysCardIdMissingError;
extern const NSInteger kVSSPrivateKeysCardIdFormatError;
extern const NSInteger kVSSPrivateKeysCardIdNotFoundError;
extern const NSInteger kVSSPrivateKeysCardIdExistsError;
extern const NSInteger kVSSPrivateKeysCardIdNotFoundKeysServiceError;
extern const NSInteger kVSSPrivateKeysCardIdNotFoundIdentityError;

extern const NSInteger kVSSPrivateKeysSignUUIDNotFoundError;
extern const NSInteger kVSSPrivateKeysSignUUIDFormatError;
extern const NSInteger kVSSPrivateKeysSignUUIDExistsError;
extern const NSInteger kVSSPrivateKeysSignInvalidError;

extern const NSInteger kVSSPrivateKeysIdentityNotFoundError;
extern const NSInteger kVSSPrivateKeysIdentityTypeNotFoundError;
extern const NSInteger kVSSPrivateKeysIdentityValueNotFoundError;
extern const NSInteger kVSSPrivateKeysIdentityTokenNotFoundError;

extern const NSInteger kVSSPrivateKeysIdentityValidationRAError;
extern const NSInteger kVSSPrivateKeysAccessTokenValidationStatsError;

/**
 * Concrete subclass representing the errors returning by the Virgil Private Keys Service.
 */
@interface VSSPrivateKeysError : VSSError

@end
