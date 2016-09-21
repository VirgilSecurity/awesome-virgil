//
//  IPMConstants.m
//  IPMExample-objc
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

#import "IPMConstants.h"

const double kTimerInterval = 3.0;

NSString * _Nonnull const kMessageId = @"id";
NSString * _Nonnull const kMessageCreatedAt = @"created_at";
NSString * _Nonnull const kMessageSender = @"sender_identifier";
NSString * _Nonnull const kMessageContent = @"message";
NSString * _Nonnull const kSenderIdentifier = @"identifier";
NSString * _Nonnull const kIdentityToken = @"identity_token";

NSString * _Nonnull const kBaseURL = @"http://198.211.127.242:4000";
NSString * _Nonnull const kIdentityTokenHeader = @"X-IDENTITY-TOKEN";
NSString * _Nonnull const kAppToken = @"eyJpZCI6IjEzNGI0NzQ5LTIxMzEtNDRmOC05ODg0LTE5Yzc5YTcyYWM1OCIsImFwcGxpY2F0aW9uX2NhcmRfaWQiOiIxOTA5OTg5MS1iY2VkLTQ3YzMtYjIxNy02ZGJmYTQ4NGUzZDEiLCJ0dGwiOi0xLCJjdGwiOi0xLCJwcm9sb25nIjowfQ==.MFgwDQYJYIZIAWUDBAICBQAERzBFAiB1tGDWiopggpa3r1cztyHlf4VmShagbXG9hjZu1sOcrAIhAMpLlYJaYnWcBMs1F+PzX5v4cDP/IzVBovLhB+cZFHbg";
NSString * _Nonnull const kAppPrivateKey = @"-----BEGIN ENCRYPTED PRIVATE KEY-----\nMIHyMF0GCSqGSIb3DQEFDTBQMC8GCSqGSIb3DQEFDDAiBBDx2S/zoVlCzbj8JY/m\n9WBqAgIYqTAKBggqhkiG9w0CCjAdBglghkgBZQMEASoEEBXuaAzF21IhvQDDrG8L\nTwMEgZB88TOaf8nMMOqDsJy5Zpgr1MG0gyx6wZrisms5tZE7iuqFLVxzoQFs/lpD\nRA+KBKJaPoc7kPe12/GYKP9Qf8sPeNVJTbYM3yvycSF3lBuBFmh56mdB0beJl7eS\nubQAaKm4kqE4uxvV6gDlAuHaX2pao0bAC84NClmgPdDdJB099B7mKa8oCwe7RI7M\normtPiE=\n-----END ENCRYPTED PRIVATE KEY-----\n";
NSString * _Nonnull const kAppPrivateKeyPassword = @"1231";

NSString * _Nonnull const kIPMExampleCardType = @"IPMExample";
NSString * _Nonnull const kPrivateKeyStorage = @"PrivateKeyStorage";
NSString * _Nonnull const kPrivateKeyValue = @"PrivateKeyValue";

NSString * _Nonnull const kAppChannelName = @"iOS-IPM-EXAMPLE-948359";