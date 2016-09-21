//
//  VSSIdentityError.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 2/16/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSIdentityError.h"

const NSInteger kVSSIdentityInternalError                   = 10000;

const NSInteger kVSSIdentityJSONError                       = 40000;
const NSInteger kVSSIdentityTypeError                       = 40100;
const NSInteger kVSSIdentityTTLError                        = 40110;
const NSInteger kVSSIdentityCTLError                        = 40120;
const NSInteger kVSSIdentityTokenNotFoundError              = 40130;
const NSInteger kVSSIdentityTokenNotMatchParamsError        = 40140;
const NSInteger kVSSIdentityTokenExpiredError               = 40150;
const NSInteger kVSSIdentityTokenNotDecryptableError        = 40160;
const NSInteger kVSSIdentityTokenNotValidError              = 40170;
const NSInteger kVSSIdentityNotConfirmedError               = 40180;
const NSInteger kVSSIdentityHashNotValidError               = 40190;
const NSInteger kVSSIdentityEmailValueNotValidError         = 40200;
const NSInteger kVSSIdentityConfirmationCodeNotValidError   = 40210;
const NSInteger kVSSIdentityAppValueNotValidError           = 40300;
const NSInteger kVSSIdentityAppSignedMessageNotValidError   = 40310;
const NSInteger kVSSIdentityEntityNotFoundError             = 41000;
const NSInteger kVSSIdentityConfirmationPeriodExpiredError  = 41010;

@implementation VSSIdentityError

- (NSString *)message {
    NSString *message = nil;
    switch (self.code) {
        case kVSSIdentityInternalError:
            message = @"Internal application error.";
            break;
        case kVSSIdentityJSONError:
            message = @"JSON specified as a request body is invalid.";
            break;
        case kVSSIdentityTypeError:
            message = @"Identity type is invalid.";
            break;
        case kVSSIdentityTTLError:
            message = @"Identity's ttl is invalid.";
            break;
        case kVSSIdentityCTLError:
            message = @"Identity's ctl is invalid.";
            break;
        case kVSSIdentityTokenNotFoundError:
            message = @"Identity's token parameter is missing.";
            break;
        case kVSSIdentityTokenNotMatchParamsError:
            message = @"Identity's token doesn't match parameters.";
            break;
        case kVSSIdentityTokenExpiredError:
            message = @"Identity's token has expired.";
            break;
        case kVSSIdentityTokenNotDecryptableError:
            message = @"Identity's token cannot be decrypted.";
            break;
        case kVSSIdentityTokenNotValidError:
            message = @"Identity's token parameter is invalid.";
            break;
        case kVSSIdentityNotConfirmedError:
            message = @"Identity is not unconfirmed.";
            break;
        case kVSSIdentityHashNotValidError:
            message = @"Hash to be signed parameter is invalid.";
            break;
        case kVSSIdentityEmailValueNotValidError:
            message = @"Email identity value validation failed.";
            break;
        case kVSSIdentityConfirmationCodeNotValidError:
            message = @"Identity's confirmation code is invalid.";
            break;
        case kVSSIdentityAppValueNotValidError:
            message = @"Application value is invalid.";
            break;
        case kVSSIdentityAppSignedMessageNotValidError:
            message = @"Application's signed message is invalid.";
            break;
        case kVSSIdentityEntityNotFoundError:
            message = @"Identity entity was not found.";
            break;
        case kVSSIdentityConfirmationPeriodExpiredError:
            message = @"Identity's confirmation period has expired.";
            break;
            
        default:
            break;
    }
    
    return message;
}

@end
