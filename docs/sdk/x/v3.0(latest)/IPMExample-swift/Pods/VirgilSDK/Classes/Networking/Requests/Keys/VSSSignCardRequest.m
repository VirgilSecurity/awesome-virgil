//
//  VSSSignCardRequest.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 2/3/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSSignCardRequest.h"
#import "VSSSign.h"
#import "NSObject+VSSUtils.h"

@interface VSSSignCardRequest ()

@property (nonatomic, strong, readwrite) VSSSign * __nullable Sign;
@property (nonatomic, strong) GUID * __nonnull signerId;

@end

@implementation VSSSignCardRequest

@synthesize Sign = _Sign;
@synthesize signerId = _signerId;

- (instancetype)initWithContext:(VSSRequestContext *)context signerCardId:(GUID *)signerId signedCardId:(GUID *) signedId digest:(NSData *)digest {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }
    
    _signerId = signerId;
    NSMutableDictionary *body = [[NSMutableDictionary alloc] init];
    if (signedId.length > 0) {
        body[kVSSModelSignedVirgilCardId] = signedId;
    }
    if (digest.length > 0) {
        NSString *base64 = [digest base64EncodedStringWithOptions:0];
        if (base64.length > 0) {
            body[kVSSModelSignedDigest] = base64;
        }
    }
    [self setRequestBodyWithObject:body];
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context {
    return [self initWithContext:context signerCardId:@"" signedCardId:@"" digest:[[NSData alloc] init]];
}

#pragma mark - Overrides

- (NSString *)methodPath {
    return [NSString stringWithFormat:@"virgil-card/%@/actions/sign", self.signerId];
}

- (NSError *)handleResponse:(NSObject *)candidate {
    NSError *error = [super handleResponse:candidate];
    if (error != nil) {
        return error;
    }
    
    self.Sign = [VSSSign deserializeFrom:[candidate as:[NSDictionary class]]];
    return nil;
}

@end
