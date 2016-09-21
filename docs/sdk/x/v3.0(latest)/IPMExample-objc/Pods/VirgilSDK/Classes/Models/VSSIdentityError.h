//
//  VSSIdentityError.h
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/16/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSError.h"

extern const NSInteger kVSSIdentityInternalError;

extern const NSInteger kVSSIdentityJSONError;
extern const NSInteger kVSSIdentityTypeError;
extern const NSInteger kVSSIdentityTTLError;
extern const NSInteger kVSSIdentityCTLError;
extern const NSInteger kVSSIdentityTokenNotFoundError;
extern const NSInteger kVSSIdentityTokenNotMatchParamsError;
extern const NSInteger kVSSIdentityTokenExpiredError;
extern const NSInteger kVSSIdentityTokenNotDecryptableError;
extern const NSInteger kVSSIdentityTokenNotValidError;
extern const NSInteger kVSSIdentityNotConfirmedError;
extern const NSInteger kVSSIdentityHashNotValidError;
extern const NSInteger kVSSIdentityEmailValueNotValidError;
extern const NSInteger kVSSIdentityConfirmationCodeNotValidError;
extern const NSInteger kVSSIdentityAppValueNotValidError;
extern const NSInteger kVSSIdentityAppSignedMessageNotValidError;
extern const NSInteger kVSSIdentityEntityNotFoundError;
extern const NSInteger kVSSIdentityConfirmationPeriodExpiredError;

/**
 * Concrete subclass representing the errors returning by the Virgil Identity Service.
 */
@interface VSSIdentityError : VSSError

@end
