<a name='contents'></a>
# Contents [#](#contents 'Go To Here')

- [CardModel](#T-Virgil-SDK-Models-CardModel 'Virgil.SDK.Models.CardModel')
  - [AuthorizedBy](#P-Virgil-SDK-Models-CardModel-AuthorizedBy 'Virgil.SDK.Models.CardModel.AuthorizedBy')
  - [CreatedAt](#P-Virgil-SDK-Models-CardModel-CreatedAt 'Virgil.SDK.Models.CardModel.CreatedAt')
  - [CustomData](#P-Virgil-SDK-Models-CardModel-CustomData 'Virgil.SDK.Models.CardModel.CustomData')
  - [Hash](#P-Virgil-SDK-Models-CardModel-Hash 'Virgil.SDK.Models.CardModel.Hash')
  - [Id](#P-Virgil-SDK-Models-CardModel-Id 'Virgil.SDK.Models.CardModel.Id')
  - [Identity](#P-Virgil-SDK-Models-CardModel-Identity 'Virgil.SDK.Models.CardModel.Identity')
  - [PublicKey](#P-Virgil-SDK-Models-CardModel-PublicKey 'Virgil.SDK.Models.CardModel.PublicKey')
- [CardsClient](#T-Virgil-SDK-Cards-CardsClient 'Virgil.SDK.Cards.CardsClient')
  - [#ctor(connection,cache)](#M-Virgil-SDK-Cards-CardsClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache- 'Virgil.SDK.Cards.CardsClient.#ctor(Virgil.SDK.Http.IConnection,Virgil.SDK.Common.IServiceKeyCache)')
  - [Create(identityInfo,publicKeyId,privateKey,privateKeyPassword,customData)](#M-Virgil-SDK-Cards-CardsClient-Create-Virgil-SDK-Identities-IdentityInfo,System-Guid,System-Byte[],System-String,System-Collections-Generic-IDictionary{System-String,System-String}- 'Virgil.SDK.Cards.CardsClient.Create(Virgil.SDK.Identities.IdentityInfo,System.Guid,System.Byte[],System.String,System.Collections.Generic.IDictionary{System.String,System.String})')
  - [Create(identityInfo,publicKey,privateKey,privateKeyPassword,customData)](#M-Virgil-SDK-Cards-CardsClient-Create-Virgil-SDK-Identities-IdentityInfo,System-Byte[],System-Byte[],System-String,System-Collections-Generic-IDictionary{System-String,System-String}- 'Virgil.SDK.Cards.CardsClient.Create(Virgil.SDK.Identities.IdentityInfo,System.Byte[],System.Byte[],System.String,System.Collections.Generic.IDictionary{System.String,System.String})')
  - [Get(cardId)](#M-Virgil-SDK-Cards-CardsClient-Get-System-Guid- 'Virgil.SDK.Cards.CardsClient.Get(System.Guid)')
  - [GetCardsRealtedToThePublicKey(publicKeyId,cardId,privateKey,privateKeyPassword)](#M-Virgil-SDK-Cards-CardsClient-GetCardsRealtedToThePublicKey-System-Guid,System-Guid,System-Byte[],System-String- 'Virgil.SDK.Cards.CardsClient.GetCardsRealtedToThePublicKey(System.Guid,System.Guid,System.Byte[],System.String)')
  - [Revoke(cardId,identityInfo,privateKey,privateKeyPassword)](#M-Virgil-SDK-Cards-CardsClient-Revoke-System-Guid,Virgil-SDK-Identities-IdentityInfo,System-Byte[],System-String- 'Virgil.SDK.Cards.CardsClient.Revoke(System.Guid,Virgil.SDK.Identities.IdentityInfo,System.Byte[],System.String)')
  - [Search(identityValue,identityType,includeUnauthorized)](#M-Virgil-SDK-Cards-CardsClient-Search-System-String,System-String,System-Nullable{System-Boolean}- 'Virgil.SDK.Cards.CardsClient.Search(System.String,System.String,System.Nullable{System.Boolean})')
  - [Search(identityValue,identityType)](#M-Virgil-SDK-Cards-CardsClient-Search-System-String,Virgil-SDK-Identities-IdentityType- 'Virgil.SDK.Cards.CardsClient.Search(System.String,Virgil.SDK.Identities.IdentityType)')
- [ConnectionBase](#T-Virgil-SDK-Http-ConnectionBase 'Virgil.SDK.Http.ConnectionBase')
  - [#ctor(accessToken,baseAddress)](#M-Virgil-SDK-Http-ConnectionBase-#ctor-System-String,System-Uri- 'Virgil.SDK.Http.ConnectionBase.#ctor(System.String,System.Uri)')
  - [AccessTokenHeaderName](#F-Virgil-SDK-Http-ConnectionBase-AccessTokenHeaderName 'Virgil.SDK.Http.ConnectionBase.AccessTokenHeaderName')
  - [Errors](#F-Virgil-SDK-Http-ConnectionBase-Errors 'Virgil.SDK.Http.ConnectionBase.Errors')
  - [AccessToken](#P-Virgil-SDK-Http-ConnectionBase-AccessToken 'Virgil.SDK.Http.ConnectionBase.AccessToken')
  - [BaseAddress](#P-Virgil-SDK-Http-ConnectionBase-BaseAddress 'Virgil.SDK.Http.ConnectionBase.BaseAddress')
  - [ExceptionHandler(message)](#M-Virgil-SDK-Http-ConnectionBase-ExceptionHandler-System-Net-Http-HttpResponseMessage- 'Virgil.SDK.Http.ConnectionBase.ExceptionHandler(System.Net.Http.HttpResponseMessage)')
  - [GetNativeRequest(request)](#M-Virgil-SDK-Http-ConnectionBase-GetNativeRequest-Virgil-SDK-Http-IRequest- 'Virgil.SDK.Http.ConnectionBase.GetNativeRequest(Virgil.SDK.Http.IRequest)')
  - [Send(request)](#M-Virgil-SDK-Http-ConnectionBase-Send-Virgil-SDK-Http-IRequest- 'Virgil.SDK.Http.ConnectionBase.Send(Virgil.SDK.Http.IRequest)')
  - [ThrowException\`\`1(message,exception)](#M-Virgil-SDK-Http-ConnectionBase-ThrowException``1-System-Net-Http-HttpResponseMessage,System-Func{System-Int32,System-String,``0}- 'Virgil.SDK.Http.ConnectionBase.ThrowException``1(System.Net.Http.HttpResponseMessage,System.Func{System.Int32,System.String,``0})')
  - [TryParseErrorCode(content)](#M-Virgil-SDK-Http-ConnectionBase-TryParseErrorCode-System-String- 'Virgil.SDK.Http.ConnectionBase.TryParseErrorCode(System.String)')
- [DynamicKeyCache](#T-Virgil-SDK-Common-DynamicKeyCache 'Virgil.SDK.Common.DynamicKeyCache')
  - [#ctor(connection)](#M-Virgil-SDK-Common-DynamicKeyCache-#ctor-Virgil-SDK-Http-IConnection- 'Virgil.SDK.Common.DynamicKeyCache.#ctor(Virgil.SDK.Http.IConnection)')
  - [GetServiceCard(servicePublicKeyId)](#M-Virgil-SDK-Common-DynamicKeyCache-GetServiceCard-System-String- 'Virgil.SDK.Common.DynamicKeyCache.GetServiceCard(System.String)')
- [EmailVerifier](#T-Virgil-SDK-Identities-EmailVerifier 'Virgil.SDK.Identities.EmailVerifier')
  - [#ctor()](#M-Virgil-SDK-Identities-EmailVerifier-#ctor-System-Guid,Virgil-SDK-Identities-IIdentityClient- 'Virgil.SDK.Identities.EmailVerifier.#ctor(System.Guid,Virgil.SDK.Identities.IIdentityClient)')
  - [ActionId](#P-Virgil-SDK-Identities-EmailVerifier-ActionId 'Virgil.SDK.Identities.EmailVerifier.ActionId')
  - [Confirm(code,timeToLive,countToLive)](#M-Virgil-SDK-Identities-EmailVerifier-Confirm-System-String,System-Int32,System-Int32- 'Virgil.SDK.Identities.EmailVerifier.Confirm(System.String,System.Int32,System.Int32)')
- [EndpointClient](#T-Virgil-SDK-Common-EndpointClient 'Virgil.SDK.Common.EndpointClient')
  - [#ctor(connection)](#M-Virgil-SDK-Common-EndpointClient-#ctor-Virgil-SDK-Http-IConnection- 'Virgil.SDK.Common.EndpointClient.#ctor(Virgil.SDK.Http.IConnection)')
  - [#ctor(connection,cache)](#M-Virgil-SDK-Common-EndpointClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache- 'Virgil.SDK.Common.EndpointClient.#ctor(Virgil.SDK.Http.IConnection,Virgil.SDK.Common.IServiceKeyCache)')
  - [Cache](#F-Virgil-SDK-Common-EndpointClient-Cache 'Virgil.SDK.Common.EndpointClient.Cache')
  - [Connection](#F-Virgil-SDK-Common-EndpointClient-Connection 'Virgil.SDK.Common.EndpointClient.Connection')
  - [EndpointApplicationId](#F-Virgil-SDK-Common-EndpointClient-EndpointApplicationId 'Virgil.SDK.Common.EndpointClient.EndpointApplicationId')
  - [Send()](#M-Virgil-SDK-Common-EndpointClient-Send-Virgil-SDK-Http-IRequest- 'Virgil.SDK.Common.EndpointClient.Send(Virgil.SDK.Http.IRequest)')
  - [Send\`\`1()](#M-Virgil-SDK-Common-EndpointClient-Send``1-Virgil-SDK-Http-IRequest- 'Virgil.SDK.Common.EndpointClient.Send``1(Virgil.SDK.Http.IRequest)')
- [Ensure](#T-Virgil-SDK-Helpers-Ensure 'Virgil.SDK.Helpers.Ensure')
  - [ArgumentNotNull(value,name)](#M-Virgil-SDK-Helpers-Ensure-ArgumentNotNull-System-Object,System-String- 'Virgil.SDK.Helpers.Ensure.ArgumentNotNull(System.Object,System.String)')
  - [ArgumentNotNullOrEmptyString(value,name)](#M-Virgil-SDK-Helpers-Ensure-ArgumentNotNullOrEmptyString-System-String,System-String- 'Virgil.SDK.Helpers.Ensure.ArgumentNotNullOrEmptyString(System.String,System.String)')
- [ICardsClient](#T-Virgil-SDK-Cards-ICardsClient 'Virgil.SDK.Cards.ICardsClient')
  - [Create(identityInfo,publicKeyId,privateKey,privateKeyPassword,customData)](#M-Virgil-SDK-Cards-ICardsClient-Create-Virgil-SDK-Identities-IdentityInfo,System-Guid,System-Byte[],System-String,System-Collections-Generic-IDictionary{System-String,System-String}- 'Virgil.SDK.Cards.ICardsClient.Create(Virgil.SDK.Identities.IdentityInfo,System.Guid,System.Byte[],System.String,System.Collections.Generic.IDictionary{System.String,System.String})')
  - [Create(identityInfo,publicKey,privateKey,privateKeyPassword,customData)](#M-Virgil-SDK-Cards-ICardsClient-Create-Virgil-SDK-Identities-IdentityInfo,System-Byte[],System-Byte[],System-String,System-Collections-Generic-IDictionary{System-String,System-String}- 'Virgil.SDK.Cards.ICardsClient.Create(Virgil.SDK.Identities.IdentityInfo,System.Byte[],System.Byte[],System.String,System.Collections.Generic.IDictionary{System.String,System.String})')
  - [Get(cardId)](#M-Virgil-SDK-Cards-ICardsClient-Get-System-Guid- 'Virgil.SDK.Cards.ICardsClient.Get(System.Guid)')
  - [GetCardsRealtedToThePublicKey(publicKeyId,cardId,privateKey,privateKeyPassword)](#M-Virgil-SDK-Cards-ICardsClient-GetCardsRealtedToThePublicKey-System-Guid,System-Guid,System-Byte[],System-String- 'Virgil.SDK.Cards.ICardsClient.GetCardsRealtedToThePublicKey(System.Guid,System.Guid,System.Byte[],System.String)')
  - [Revoke(cardId,identityInfo,privateKey,privateKeyPassword)](#M-Virgil-SDK-Cards-ICardsClient-Revoke-System-Guid,Virgil-SDK-Identities-IdentityInfo,System-Byte[],System-String- 'Virgil.SDK.Cards.ICardsClient.Revoke(System.Guid,Virgil.SDK.Identities.IdentityInfo,System.Byte[],System.String)')
  - [Search(identityValue,identityType,includeUnauthorized)](#M-Virgil-SDK-Cards-ICardsClient-Search-System-String,System-String,System-Nullable{System-Boolean}- 'Virgil.SDK.Cards.ICardsClient.Search(System.String,System.String,System.Nullable{System.Boolean})')
  - [Search(identityValue,identityType)](#M-Virgil-SDK-Cards-ICardsClient-Search-System-String,Virgil-SDK-Identities-IdentityType- 'Virgil.SDK.Cards.ICardsClient.Search(System.String,Virgil.SDK.Identities.IdentityType)')
- [IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection')
  - [BaseAddress](#P-Virgil-SDK-Http-IConnection-BaseAddress 'Virgil.SDK.Http.IConnection.BaseAddress')
  - [Send(request)](#M-Virgil-SDK-Http-IConnection-Send-Virgil-SDK-Http-IRequest- 'Virgil.SDK.Http.IConnection.Send(Virgil.SDK.Http.IRequest)')
- [IdentityClient](#T-Virgil-SDK-Identities-IdentityClient 'Virgil.SDK.Identities.IdentityClient')
  - [#ctor(connection,cache)](#M-Virgil-SDK-Identities-IdentityClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache- 'Virgil.SDK.Identities.IdentityClient.#ctor(Virgil.SDK.Http.IConnection,Virgil.SDK.Common.IServiceKeyCache)')
  - [Confirm(actionId,code,timeToLive,countToLive)](#M-Virgil-SDK-Identities-IdentityClient-Confirm-System-Guid,System-String,System-Int32,System-Int32- 'Virgil.SDK.Identities.IdentityClient.Confirm(System.Guid,System.String,System.Int32,System.Int32)')
  - [IsValid(identityValue,identityType,validationToken)](#M-Virgil-SDK-Identities-IdentityClient-IsValid-System-String,Virgil-SDK-Identities-VerifiableIdentityType,System-String- 'Virgil.SDK.Identities.IdentityClient.IsValid(System.String,Virgil.SDK.Identities.VerifiableIdentityType,System.String)')
  - [Verify(identityValue,identityType,extraFields)](#M-Virgil-SDK-Identities-IdentityClient-Verify-System-String,Virgil-SDK-Identities-VerifiableIdentityType,System-Collections-Generic-IDictionary{System-String,System-String}- 'Virgil.SDK.Identities.IdentityClient.Verify(System.String,Virgil.SDK.Identities.VerifiableIdentityType,System.Collections.Generic.IDictionary{System.String,System.String})')
  - [VerifyEmail(emailAddress,extraFields)](#M-Virgil-SDK-Identities-IdentityClient-VerifyEmail-System-String,System-Collections-Generic-IDictionary{System-String,System-String}- 'Virgil.SDK.Identities.IdentityClient.VerifyEmail(System.String,System.Collections.Generic.IDictionary{System.String,System.String})')
- [IdentityConfirmationResponse](#T-Virgil-SDK-Identities-IdentityConfirmationResponse 'Virgil.SDK.Identities.IdentityConfirmationResponse')
  - [Type](#P-Virgil-SDK-Identities-IdentityConfirmationResponse-Type 'Virgil.SDK.Identities.IdentityConfirmationResponse.Type')
  - [ValidationToken](#P-Virgil-SDK-Identities-IdentityConfirmationResponse-ValidationToken 'Virgil.SDK.Identities.IdentityConfirmationResponse.ValidationToken')
  - [Value](#P-Virgil-SDK-Identities-IdentityConfirmationResponse-Value 'Virgil.SDK.Identities.IdentityConfirmationResponse.Value')
- [IdentityConnection](#T-Virgil-SDK-Http-IdentityConnection 'Virgil.SDK.Http.IdentityConnection')
  - [#ctor(baseAddress)](#M-Virgil-SDK-Http-IdentityConnection-#ctor-System-Uri- 'Virgil.SDK.Http.IdentityConnection.#ctor(System.Uri)')
  - [ExceptionHandler(message)](#M-Virgil-SDK-Http-IdentityConnection-ExceptionHandler-System-Net-Http-HttpResponseMessage- 'Virgil.SDK.Http.IdentityConnection.ExceptionHandler(System.Net.Http.HttpResponseMessage)')
- [IdentityInfo](#T-Virgil-SDK-Identities-IdentityInfo 'Virgil.SDK.Identities.IdentityInfo')
  - [Type](#P-Virgil-SDK-Identities-IdentityInfo-Type 'Virgil.SDK.Identities.IdentityInfo.Type')
  - [ValidationToken](#P-Virgil-SDK-Identities-IdentityInfo-ValidationToken 'Virgil.SDK.Identities.IdentityInfo.ValidationToken')
  - [Value](#P-Virgil-SDK-Identities-IdentityInfo-Value 'Virgil.SDK.Identities.IdentityInfo.Value')
- [IdentityModel](#T-Virgil-SDK-Models-IdentityModel 'Virgil.SDK.Models.IdentityModel')
  - [CreatedAt](#P-Virgil-SDK-Models-IdentityModel-CreatedAt 'Virgil.SDK.Models.IdentityModel.CreatedAt')
  - [Id](#P-Virgil-SDK-Models-IdentityModel-Id 'Virgil.SDK.Models.IdentityModel.Id')
  - [Type](#P-Virgil-SDK-Models-IdentityModel-Type 'Virgil.SDK.Models.IdentityModel.Type')
  - [Value](#P-Virgil-SDK-Models-IdentityModel-Value 'Virgil.SDK.Models.IdentityModel.Value')
- [IdentityServiceException](#T-Virgil-SDK-Exceptions-IdentityServiceException 'Virgil.SDK.Exceptions.IdentityServiceException')
  - [#ctor(errorCode,errorMessage)](#M-Virgil-SDK-Exceptions-IdentityServiceException-#ctor-System-Int32,System-String- 'Virgil.SDK.Exceptions.IdentityServiceException.#ctor(System.Int32,System.String)')
- [IdentityType](#T-Virgil-SDK-Identities-IdentityType 'Virgil.SDK.Identities.IdentityType')
  - [Application](#F-Virgil-SDK-Identities-IdentityType-Application 'Virgil.SDK.Identities.IdentityType.Application')
  - [Email](#F-Virgil-SDK-Identities-IdentityType-Email 'Virgil.SDK.Identities.IdentityType.Email')
- [IdentityVerificationResponse](#T-Virgil-SDK-Identities-IdentityVerificationResponse 'Virgil.SDK.Identities.IdentityVerificationResponse')
  - [ActionId](#P-Virgil-SDK-Identities-IdentityVerificationResponse-ActionId 'Virgil.SDK.Identities.IdentityVerificationResponse.ActionId')
- [IEmailVerifier](#T-Virgil-SDK-Identities-IEmailVerifier 'Virgil.SDK.Identities.IEmailVerifier')
  - [ActionId](#P-Virgil-SDK-Identities-IEmailVerifier-ActionId 'Virgil.SDK.Identities.IEmailVerifier.ActionId')
  - [Confirm(code,timeToLive,countToLive)](#M-Virgil-SDK-Identities-IEmailVerifier-Confirm-System-String,System-Int32,System-Int32- 'Virgil.SDK.Identities.IEmailVerifier.Confirm(System.String,System.Int32,System.Int32)')
- [IIdentityClient](#T-Virgil-SDK-Identities-IIdentityClient 'Virgil.SDK.Identities.IIdentityClient')
  - [Confirm(actionId,code,timeToLive,countToLive)](#M-Virgil-SDK-Identities-IIdentityClient-Confirm-System-Guid,System-String,System-Int32,System-Int32- 'Virgil.SDK.Identities.IIdentityClient.Confirm(System.Guid,System.String,System.Int32,System.Int32)')
  - [IsValid(identityValue,identityType,validationToken)](#M-Virgil-SDK-Identities-IIdentityClient-IsValid-System-String,Virgil-SDK-Identities-VerifiableIdentityType,System-String- 'Virgil.SDK.Identities.IIdentityClient.IsValid(System.String,Virgil.SDK.Identities.VerifiableIdentityType,System.String)')
  - [Verify(identityValue,identityType,extraFields)](#M-Virgil-SDK-Identities-IIdentityClient-Verify-System-String,Virgil-SDK-Identities-VerifiableIdentityType,System-Collections-Generic-IDictionary{System-String,System-String}- 'Virgil.SDK.Identities.IIdentityClient.Verify(System.String,Virgil.SDK.Identities.VerifiableIdentityType,System.Collections.Generic.IDictionary{System.String,System.String})')
  - [VerifyEmail(emailAddress,extraFields)](#M-Virgil-SDK-Identities-IIdentityClient-VerifyEmail-System-String,System-Collections-Generic-IDictionary{System-String,System-String}- 'Virgil.SDK.Identities.IIdentityClient.VerifyEmail(System.String,System.Collections.Generic.IDictionary{System.String,System.String})')
- [IPrivateKeysClient](#T-Virgil-SDK-PrivateKeys-IPrivateKeysClient 'Virgil.SDK.PrivateKeys.IPrivateKeysClient')
  - [Destroy(cardId,privateKey,privateKeyPassword)](#M-Virgil-SDK-PrivateKeys-IPrivateKeysClient-Destroy-System-Guid,System-Byte[],System-String- 'Virgil.SDK.PrivateKeys.IPrivateKeysClient.Destroy(System.Guid,System.Byte[],System.String)')
  - [Get(cardId,identityInfo)](#M-Virgil-SDK-PrivateKeys-IPrivateKeysClient-Get-System-Guid,Virgil-SDK-Identities-IdentityInfo- 'Virgil.SDK.PrivateKeys.IPrivateKeysClient.Get(System.Guid,Virgil.SDK.Identities.IdentityInfo)')
  - [Get(cardId,identityInfo,responsePassword)](#M-Virgil-SDK-PrivateKeys-IPrivateKeysClient-Get-System-Guid,Virgil-SDK-Identities-IdentityInfo,System-String- 'Virgil.SDK.PrivateKeys.IPrivateKeysClient.Get(System.Guid,Virgil.SDK.Identities.IdentityInfo,System.String)')
  - [Stash(cardId,privateKey,privateKeyPassword)](#M-Virgil-SDK-PrivateKeys-IPrivateKeysClient-Stash-System-Guid,System-Byte[],System-String- 'Virgil.SDK.PrivateKeys.IPrivateKeysClient.Stash(System.Guid,System.Byte[],System.String)')
- [IPublicKeysClient](#T-Virgil-SDK-PublicKeys-IPublicKeysClient 'Virgil.SDK.PublicKeys.IPublicKeysClient')
  - [Get(publicKeyId)](#M-Virgil-SDK-PublicKeys-IPublicKeysClient-Get-System-Guid- 'Virgil.SDK.PublicKeys.IPublicKeysClient.Get(System.Guid)')
  - [Revoke(publicKeyId,identityInfos,cardId,privateKey,privateKeyPassword)](#M-Virgil-SDK-PublicKeys-IPublicKeysClient-Revoke-System-Guid,System-Collections-Generic-IEnumerable{Virgil-SDK-Identities-IdentityInfo},System-Guid,System-Byte[],System-String- 'Virgil.SDK.PublicKeys.IPublicKeysClient.Revoke(System.Guid,System.Collections.Generic.IEnumerable{Virgil.SDK.Identities.IdentityInfo},System.Guid,System.Byte[],System.String)')
- [IRequest](#T-Virgil-SDK-Http-IRequest 'Virgil.SDK.Http.IRequest')
  - [Body](#P-Virgil-SDK-Http-IRequest-Body 'Virgil.SDK.Http.IRequest.Body')
  - [Endpoint](#P-Virgil-SDK-Http-IRequest-Endpoint 'Virgil.SDK.Http.IRequest.Endpoint')
  - [Headers](#P-Virgil-SDK-Http-IRequest-Headers 'Virgil.SDK.Http.IRequest.Headers')
  - [Method](#P-Virgil-SDK-Http-IRequest-Method 'Virgil.SDK.Http.IRequest.Method')
- [IResponse](#T-Virgil-SDK-Http-IResponse 'Virgil.SDK.Http.IResponse')
  - [Body](#P-Virgil-SDK-Http-IResponse-Body 'Virgil.SDK.Http.IResponse.Body')
  - [Headers](#P-Virgil-SDK-Http-IResponse-Headers 'Virgil.SDK.Http.IResponse.Headers')
  - [StatusCode](#P-Virgil-SDK-Http-IResponse-StatusCode 'Virgil.SDK.Http.IResponse.StatusCode')
- [IServiceKeyCache](#T-Virgil-SDK-Common-IServiceKeyCache 'Virgil.SDK.Common.IServiceKeyCache')
  - [GetServiceCard(servicePublicKeyId)](#M-Virgil-SDK-Common-IServiceKeyCache-GetServiceCard-System-String- 'Virgil.SDK.Common.IServiceKeyCache.GetServiceCard(System.String)')
- [IVirgilService](#T-Virgil-SDK-Common-IVirgilService 'Virgil.SDK.Common.IVirgilService')
- [Localization](#T-Virgil-SDK-Localization 'Virgil.SDK.Localization')
  - [Culture](#P-Virgil-SDK-Localization-Culture 'Virgil.SDK.Localization.Culture')
  - [ExceptionDomainValueDomainIdentityIsInvalid](#P-Virgil-SDK-Localization-ExceptionDomainValueDomainIdentityIsInvalid 'Virgil.SDK.Localization.ExceptionDomainValueDomainIdentityIsInvalid')
  - [ExceptionIdentityVerificationIsNotSent](#P-Virgil-SDK-Localization-ExceptionIdentityVerificationIsNotSent 'Virgil.SDK.Localization.ExceptionIdentityVerificationIsNotSent')
  - [ExceptionPublicKeyNotFound](#P-Virgil-SDK-Localization-ExceptionPublicKeyNotFound 'Virgil.SDK.Localization.ExceptionPublicKeyNotFound')
  - [ExceptionStringCanNotBeEmpty](#P-Virgil-SDK-Localization-ExceptionStringCanNotBeEmpty 'Virgil.SDK.Localization.ExceptionStringCanNotBeEmpty')
  - [ExceptionStringLengthIsInvalid](#P-Virgil-SDK-Localization-ExceptionStringLengthIsInvalid 'Virgil.SDK.Localization.ExceptionStringLengthIsInvalid')
  - [ExceptionUserDataAlreadyExists](#P-Virgil-SDK-Localization-ExceptionUserDataAlreadyExists 'Virgil.SDK.Localization.ExceptionUserDataAlreadyExists')
  - [ExceptionUserDataClassSpecifiedIsInvalid](#P-Virgil-SDK-Localization-ExceptionUserDataClassSpecifiedIsInvalid 'Virgil.SDK.Localization.ExceptionUserDataClassSpecifiedIsInvalid')
  - [ExceptionUserDataConfirmationEntityNotFound](#P-Virgil-SDK-Localization-ExceptionUserDataConfirmationEntityNotFound 'Virgil.SDK.Localization.ExceptionUserDataConfirmationEntityNotFound')
  - [ExceptionUserDataConfirmationTokenInvalid](#P-Virgil-SDK-Localization-ExceptionUserDataConfirmationTokenInvalid 'Virgil.SDK.Localization.ExceptionUserDataConfirmationTokenInvalid')
  - [ExceptionUserDataIntegrityConstraintViolation](#P-Virgil-SDK-Localization-ExceptionUserDataIntegrityConstraintViolation 'Virgil.SDK.Localization.ExceptionUserDataIntegrityConstraintViolation')
  - [ExceptionUserDataIsNotConfirmedYet](#P-Virgil-SDK-Localization-ExceptionUserDataIsNotConfirmedYet 'Virgil.SDK.Localization.ExceptionUserDataIsNotConfirmedYet')
  - [ExceptionUserDataNotFound](#P-Virgil-SDK-Localization-ExceptionUserDataNotFound 'Virgil.SDK.Localization.ExceptionUserDataNotFound')
  - [ExceptionUserDataValueIsRequired](#P-Virgil-SDK-Localization-ExceptionUserDataValueIsRequired 'Virgil.SDK.Localization.ExceptionUserDataValueIsRequired')
  - [ExceptionUserDataWasAlreadyConfirmed](#P-Virgil-SDK-Localization-ExceptionUserDataWasAlreadyConfirmed 'Virgil.SDK.Localization.ExceptionUserDataWasAlreadyConfirmed')
  - [ExceptionUserIdHadBeenConfirmed](#P-Virgil-SDK-Localization-ExceptionUserIdHadBeenConfirmed 'Virgil.SDK.Localization.ExceptionUserIdHadBeenConfirmed')
  - [ExceptionUserInfoDataValidationFailed](#P-Virgil-SDK-Localization-ExceptionUserInfoDataValidationFailed 'Virgil.SDK.Localization.ExceptionUserInfoDataValidationFailed')
  - [ResourceManager](#P-Virgil-SDK-Localization-ResourceManager 'Virgil.SDK.Localization.ResourceManager')
- [Obfuscator](#T-Virgil-SDK-Utils-Obfuscator 'Virgil.SDK.Utils.Obfuscator')
  - [Process(value,algorithm,iterations,salt)](#M-Virgil-SDK-Utils-Obfuscator-Process-System-String,System-String,Virgil-Crypto-Foundation-VirgilPBKDF-Hash,System-UInt32- 'Virgil.SDK.Utils.Obfuscator.Process(System.String,System.String,Virgil.Crypto.Foundation.VirgilPBKDF.Hash,System.UInt32)')
- [PrivateKeyModel](#T-Virgil-SDK-Models-PrivateKeyModel 'Virgil.SDK.Models.PrivateKeyModel')
  - [CardId](#P-Virgil-SDK-Models-PrivateKeyModel-CardId 'Virgil.SDK.Models.PrivateKeyModel.CardId')
  - [PrivateKey](#P-Virgil-SDK-Models-PrivateKeyModel-PrivateKey 'Virgil.SDK.Models.PrivateKeyModel.PrivateKey')
- [PrivateKeysClient](#T-Virgil-SDK-PrivateKeys-PrivateKeysClient 'Virgil.SDK.PrivateKeys.PrivateKeysClient')
  - [#ctor(connection,cache)](#M-Virgil-SDK-PrivateKeys-PrivateKeysClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache- 'Virgil.SDK.PrivateKeys.PrivateKeysClient.#ctor(Virgil.SDK.Http.IConnection,Virgil.SDK.Common.IServiceKeyCache)')
- [PrivateKeysConnection](#T-Virgil-SDK-Http-PrivateKeysConnection 'Virgil.SDK.Http.PrivateKeysConnection')
  - [#ctor(accessToken,baseAddress)](#M-Virgil-SDK-Http-PrivateKeysConnection-#ctor-System-String,System-Uri- 'Virgil.SDK.Http.PrivateKeysConnection.#ctor(System.String,System.Uri)')
  - [ExceptionHandler(message)](#M-Virgil-SDK-Http-PrivateKeysConnection-ExceptionHandler-System-Net-Http-HttpResponseMessage- 'Virgil.SDK.Http.PrivateKeysConnection.ExceptionHandler(System.Net.Http.HttpResponseMessage)')
- [PublicKeyExtendedResponse](#T-Virgil-SDK-Models-PublicKeyExtendedResponse 'Virgil.SDK.Models.PublicKeyExtendedResponse')
  - [Cards](#P-Virgil-SDK-Models-PublicKeyExtendedResponse-Cards 'Virgil.SDK.Models.PublicKeyExtendedResponse.Cards')
  - [CreatedAt](#P-Virgil-SDK-Models-PublicKeyExtendedResponse-CreatedAt 'Virgil.SDK.Models.PublicKeyExtendedResponse.CreatedAt')
  - [Id](#P-Virgil-SDK-Models-PublicKeyExtendedResponse-Id 'Virgil.SDK.Models.PublicKeyExtendedResponse.Id')
  - [Value](#P-Virgil-SDK-Models-PublicKeyExtendedResponse-Value 'Virgil.SDK.Models.PublicKeyExtendedResponse.Value')
- [PublicKeyModel](#T-Virgil-SDK-Models-PublicKeyModel 'Virgil.SDK.Models.PublicKeyModel')
  - [CreatedAt](#P-Virgil-SDK-Models-PublicKeyModel-CreatedAt 'Virgil.SDK.Models.PublicKeyModel.CreatedAt')
  - [Id](#P-Virgil-SDK-Models-PublicKeyModel-Id 'Virgil.SDK.Models.PublicKeyModel.Id')
  - [Value](#P-Virgil-SDK-Models-PublicKeyModel-Value 'Virgil.SDK.Models.PublicKeyModel.Value')
- [PublicKeysClient](#T-Virgil-SDK-PublicKeys-PublicKeysClient 'Virgil.SDK.PublicKeys.PublicKeysClient')
  - [#ctor(connection,cache)](#M-Virgil-SDK-PublicKeys-PublicKeysClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache- 'Virgil.SDK.PublicKeys.PublicKeysClient.#ctor(Virgil.SDK.Http.IConnection,Virgil.SDK.Common.IServiceKeyCache)')
- [PublicServiceConnection](#T-Virgil-SDK-Http-PublicServiceConnection 'Virgil.SDK.Http.PublicServiceConnection')
  - [#ctor(accessToken,baseAddress)](#M-Virgil-SDK-Http-PublicServiceConnection-#ctor-System-String,System-Uri- 'Virgil.SDK.Http.PublicServiceConnection.#ctor(System.String,System.Uri)')
  - [ExceptionHandler(message)](#M-Virgil-SDK-Http-PublicServiceConnection-ExceptionHandler-System-Net-Http-HttpResponseMessage- 'Virgil.SDK.Http.PublicServiceConnection.ExceptionHandler(System.Net.Http.HttpResponseMessage)')
- [Request](#T-Virgil-SDK-Http-Request 'Virgil.SDK.Http.Request')
  - [#ctor()](#M-Virgil-SDK-Http-Request-#ctor 'Virgil.SDK.Http.Request.#ctor')
  - [Body](#P-Virgil-SDK-Http-Request-Body 'Virgil.SDK.Http.Request.Body')
  - [Endpoint](#P-Virgil-SDK-Http-Request-Endpoint 'Virgil.SDK.Http.Request.Endpoint')
  - [Headers](#P-Virgil-SDK-Http-Request-Headers 'Virgil.SDK.Http.Request.Headers')
  - [Method](#P-Virgil-SDK-Http-Request-Method 'Virgil.SDK.Http.Request.Method')
- [RequestExtensions](#T-Virgil-SDK-Http-RequestExtensions 'Virgil.SDK.Http.RequestExtensions')
  - [EncryptJsonBody(request,card)](#M-Virgil-SDK-Http-RequestExtensions-EncryptJsonBody-Virgil-SDK-Http-Request,Virgil-SDK-Models-CardModel- 'Virgil.SDK.Http.RequestExtensions.EncryptJsonBody(Virgil.SDK.Http.Request,Virgil.SDK.Models.CardModel)')
  - [SignRequest(request,cardId,privateKey,privateKeyPassword)](#M-Virgil-SDK-Http-RequestExtensions-SignRequest-Virgil-SDK-Http-Request,System-Guid,System-Byte[],System-String- 'Virgil.SDK.Http.RequestExtensions.SignRequest(Virgil.SDK.Http.Request,System.Guid,System.Byte[],System.String)')
  - [SignRequest(request,privateKey,privateKeyPassword)](#M-Virgil-SDK-Http-RequestExtensions-SignRequest-Virgil-SDK-Http-Request,System-Byte[],System-String- 'Virgil.SDK.Http.RequestExtensions.SignRequest(Virgil.SDK.Http.Request,System.Byte[],System.String)')
  - [WithBody(request,body)](#M-Virgil-SDK-Http-RequestExtensions-WithBody-Virgil-SDK-Http-Request,System-Object- 'Virgil.SDK.Http.RequestExtensions.WithBody(Virgil.SDK.Http.Request,System.Object)')
  - [WithEndpoint(request,endpoint)](#M-Virgil-SDK-Http-RequestExtensions-WithEndpoint-Virgil-SDK-Http-Request,System-String- 'Virgil.SDK.Http.RequestExtensions.WithEndpoint(Virgil.SDK.Http.Request,System.String)')
- [RequestMethod](#T-Virgil-SDK-Http-RequestMethod 'Virgil.SDK.Http.RequestMethod')
- [Response](#T-Virgil-SDK-Http-Response 'Virgil.SDK.Http.Response')
  - [Body](#P-Virgil-SDK-Http-Response-Body 'Virgil.SDK.Http.Response.Body')
  - [Headers](#P-Virgil-SDK-Http-Response-Headers 'Virgil.SDK.Http.Response.Headers')
  - [StatusCode](#P-Virgil-SDK-Http-Response-StatusCode 'Virgil.SDK.Http.Response.StatusCode')
- [ResponseVerifyClient](#T-Virgil-SDK-Common-ResponseVerifyClient 'Virgil.SDK.Common.ResponseVerifyClient')
  - [#ctor(connection)](#M-Virgil-SDK-Common-ResponseVerifyClient-#ctor-Virgil-SDK-Http-IConnection- 'Virgil.SDK.Common.ResponseVerifyClient.#ctor(Virgil.SDK.Http.IConnection)')
  - [#ctor(connection,cache)](#M-Virgil-SDK-Common-ResponseVerifyClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache- 'Virgil.SDK.Common.ResponseVerifyClient.#ctor(Virgil.SDK.Http.IConnection,Virgil.SDK.Common.IServiceKeyCache)')
  - [Send()](#M-Virgil-SDK-Common-ResponseVerifyClient-Send-Virgil-SDK-Http-IRequest- 'Virgil.SDK.Common.ResponseVerifyClient.Send(Virgil.SDK.Http.IRequest)')
  - [Send\`\`1(request)](#M-Virgil-SDK-Common-ResponseVerifyClient-Send``1-Virgil-SDK-Http-IRequest- 'Virgil.SDK.Common.ResponseVerifyClient.Send``1(Virgil.SDK.Http.IRequest)')
  - [VerifyResponse(nativeResponse,publicKey)](#M-Virgil-SDK-Common-ResponseVerifyClient-VerifyResponse-Virgil-SDK-Http-IResponse,System-Byte[]- 'Virgil.SDK.Common.ResponseVerifyClient.VerifyResponse(Virgil.SDK.Http.IResponse,System.Byte[])')
- [ServiceHub](#T-Virgil-SDK-ServiceHub 'Virgil.SDK.ServiceHub')
  - [#ctor()](#M-Virgil-SDK-ServiceHub-#ctor-Virgil-SDK-ServiceHubConfig- 'Virgil.SDK.ServiceHub.#ctor(Virgil.SDK.ServiceHubConfig)')
  - [Cards](#P-Virgil-SDK-ServiceHub-Cards 'Virgil.SDK.ServiceHub.Cards')
  - [Identity](#P-Virgil-SDK-ServiceHub-Identity 'Virgil.SDK.ServiceHub.Identity')
  - [PrivateKeys](#P-Virgil-SDK-ServiceHub-PrivateKeys 'Virgil.SDK.ServiceHub.PrivateKeys')
  - [PublicKeys](#P-Virgil-SDK-ServiceHub-PublicKeys 'Virgil.SDK.ServiceHub.PublicKeys')
  - [BuildCardsClient()](#M-Virgil-SDK-ServiceHub-BuildCardsClient 'Virgil.SDK.ServiceHub.BuildCardsClient')
  - [BuildIdentityClient()](#M-Virgil-SDK-ServiceHub-BuildIdentityClient 'Virgil.SDK.ServiceHub.BuildIdentityClient')
  - [BuildPrivateKeysClient()](#M-Virgil-SDK-ServiceHub-BuildPrivateKeysClient 'Virgil.SDK.ServiceHub.BuildPrivateKeysClient')
  - [BuildPublicKeysClient()](#M-Virgil-SDK-ServiceHub-BuildPublicKeysClient 'Virgil.SDK.ServiceHub.BuildPublicKeysClient')
  - [Create()](#M-Virgil-SDK-ServiceHub-Create-System-String- 'Virgil.SDK.ServiceHub.Create(System.String)')
  - [Create()](#M-Virgil-SDK-ServiceHub-Create-Virgil-SDK-ServiceHubConfig- 'Virgil.SDK.ServiceHub.Create(Virgil.SDK.ServiceHubConfig)')
  - [Initialize()](#M-Virgil-SDK-ServiceHub-Initialize 'Virgil.SDK.ServiceHub.Initialize')
- [ServiceHubConfig](#T-Virgil-SDK-ServiceHubConfig 'Virgil.SDK.ServiceHubConfig')
  - [#ctor()](#M-Virgil-SDK-ServiceHubConfig-#ctor-System-String- 'Virgil.SDK.ServiceHubConfig.#ctor(System.String)')
  - [UseAccessToken()](#M-Virgil-SDK-ServiceHubConfig-UseAccessToken-System-String- 'Virgil.SDK.ServiceHubConfig.UseAccessToken(System.String)')
  - [WithIdentityServiceAddress()](#M-Virgil-SDK-ServiceHubConfig-WithIdentityServiceAddress-System-String- 'Virgil.SDK.ServiceHubConfig.WithIdentityServiceAddress(System.String)')
  - [WithPrivateServicesAddress()](#M-Virgil-SDK-ServiceHubConfig-WithPrivateServicesAddress-System-String- 'Virgil.SDK.ServiceHubConfig.WithPrivateServicesAddress(System.String)')
  - [WithPublicServicesAddress()](#M-Virgil-SDK-ServiceHubConfig-WithPublicServicesAddress-System-String- 'Virgil.SDK.ServiceHubConfig.WithPublicServicesAddress(System.String)')
  - [WithStagingEnvironment()](#M-Virgil-SDK-ServiceHubConfig-WithStagingEnvironment 'Virgil.SDK.ServiceHubConfig.WithStagingEnvironment')
- [ServiceIdentities](#T-Virgil-SDK-Common-ServiceIdentities 'Virgil.SDK.Common.ServiceIdentities')
  - [IdentityService](#F-Virgil-SDK-Common-ServiceIdentities-IdentityService 'Virgil.SDK.Common.ServiceIdentities.IdentityService')
  - [PrivateService](#F-Virgil-SDK-Common-ServiceIdentities-PrivateService 'Virgil.SDK.Common.ServiceIdentities.PrivateService')
  - [PublicService](#F-Virgil-SDK-Common-ServiceIdentities-PublicService 'Virgil.SDK.Common.ServiceIdentities.PublicService')
- [ServiceSignVerificationException](#T-Virgil-SDK-Exceptions-ServiceSignVerificationException 'Virgil.SDK.Exceptions.ServiceSignVerificationException')
  - [#ctor(message)](#M-Virgil-SDK-Exceptions-ServiceSignVerificationException-#ctor-System-String- 'Virgil.SDK.Exceptions.ServiceSignVerificationException.#ctor(System.String)')
- [SignModel](#T-Virgil-SDK-Models-SignModel 'Virgil.SDK.Models.SignModel')
  - [CreatedAt](#P-Virgil-SDK-Models-SignModel-CreatedAt 'Virgil.SDK.Models.SignModel.CreatedAt')
  - [Id](#P-Virgil-SDK-Models-SignModel-Id 'Virgil.SDK.Models.SignModel.Id')
  - [SignedCardId](#P-Virgil-SDK-Models-SignModel-SignedCardId 'Virgil.SDK.Models.SignModel.SignedCardId')
  - [SignedDigest](#P-Virgil-SDK-Models-SignModel-SignedDigest 'Virgil.SDK.Models.SignModel.SignedDigest')
  - [SignerCardId](#P-Virgil-SDK-Models-SignModel-SignerCardId 'Virgil.SDK.Models.SignModel.SignerCardId')
- [ValidationTokenGenerator](#T-Virgil-SDK-Utils-ValidationTokenGenerator 'Virgil.SDK.Utils.ValidationTokenGenerator')
  - [Generate(identityValue,identityType,privateKey,privateKeyPassword)](#M-Virgil-SDK-Utils-ValidationTokenGenerator-Generate-System-String,System-String,System-Byte[],System-String- 'Virgil.SDK.Utils.ValidationTokenGenerator.Generate(System.String,System.String,System.Byte[],System.String)')
  - [Generate(identityValue,identityType,privateKey,privateKeyPassword)](#M-Virgil-SDK-Utils-ValidationTokenGenerator-Generate-System-Guid,System-String,System-String,System-Byte[],System-String- 'Virgil.SDK.Utils.ValidationTokenGenerator.Generate(System.Guid,System.String,System.String,System.Byte[],System.String)')
- [VerifiableIdentityType](#T-Virgil-SDK-Identities-VerifiableIdentityType 'Virgil.SDK.Identities.VerifiableIdentityType')
  - [Email](#F-Virgil-SDK-Identities-VerifiableIdentityType-Email 'Virgil.SDK.Identities.VerifiableIdentityType.Email')
- [VerificationRequestIsNotSentException](#T-Virgil-SDK-Exceptions-VerificationRequestIsNotSentException 'Virgil.SDK.Exceptions.VerificationRequestIsNotSentException')
  - [#ctor()](#M-Virgil-SDK-Exceptions-VerificationRequestIsNotSentException-#ctor 'Virgil.SDK.Exceptions.VerificationRequestIsNotSentException.#ctor')
- [VirgilException](#T-Virgil-SDK-Exceptions-VirgilException 'Virgil.SDK.Exceptions.VirgilException')
  - [#ctor(errorCode,errorMessage)](#M-Virgil-SDK-Exceptions-VirgilException-#ctor-System-Int32,System-String- 'Virgil.SDK.Exceptions.VirgilException.#ctor(System.Int32,System.String)')
  - [#ctor(message)](#M-Virgil-SDK-Exceptions-VirgilException-#ctor-System-String- 'Virgil.SDK.Exceptions.VirgilException.#ctor(System.String)')
  - [ErrorCode](#P-Virgil-SDK-Exceptions-VirgilException-ErrorCode 'Virgil.SDK.Exceptions.VirgilException.ErrorCode')
- [VirgilPrivateServicesException](#T-Virgil-SDK-Exceptions-VirgilPrivateServicesException 'Virgil.SDK.Exceptions.VirgilPrivateServicesException')
  - [#ctor(errorCode,errorMessage)](#M-Virgil-SDK-Exceptions-VirgilPrivateServicesException-#ctor-System-Int32,System-String- 'Virgil.SDK.Exceptions.VirgilPrivateServicesException.#ctor(System.Int32,System.String)')
- [VirgilPublicServicesException](#T-Virgil-SDK-Exceptions-VirgilPublicServicesException 'Virgil.SDK.Exceptions.VirgilPublicServicesException')
  - [#ctor(errorCode,errorMessage)](#M-Virgil-SDK-Exceptions-VirgilPublicServicesException-#ctor-System-Int32,System-String- 'Virgil.SDK.Exceptions.VirgilPublicServicesException.#ctor(System.Int32,System.String)')

<a name='assembly'></a>
# Virgil.SDK [#](#assembly 'Go To Here') [=](#contents 'Back To Contents')

<a name='T-Virgil-SDK-Models-CardModel'></a>
## CardModel [#](#T-Virgil-SDK-Models-CardModel 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Models

##### Summary

Represents full virgil card object returned from virgil cards service

<a name='P-Virgil-SDK-Models-CardModel-AuthorizedBy'></a>
### AuthorizedBy `property` [#](#P-Virgil-SDK-Models-CardModel-AuthorizedBy 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets a value indicating whether this instance is confirmed.

<a name='P-Virgil-SDK-Models-CardModel-CreatedAt'></a>
### CreatedAt `property` [#](#P-Virgil-SDK-Models-CardModel-CreatedAt 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the created at date.

<a name='P-Virgil-SDK-Models-CardModel-CustomData'></a>
### CustomData `property` [#](#P-Virgil-SDK-Models-CardModel-CustomData 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the custom data.

<a name='P-Virgil-SDK-Models-CardModel-Hash'></a>
### Hash `property` [#](#P-Virgil-SDK-Models-CardModel-Hash 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the hash.

<a name='P-Virgil-SDK-Models-CardModel-Id'></a>
### Id `property` [#](#P-Virgil-SDK-Models-CardModel-Id 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the identifier.

<a name='P-Virgil-SDK-Models-CardModel-Identity'></a>
### Identity `property` [#](#P-Virgil-SDK-Models-CardModel-Identity 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the identity.

<a name='P-Virgil-SDK-Models-CardModel-PublicKey'></a>
### PublicKey `property` [#](#P-Virgil-SDK-Models-CardModel-PublicKey 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the public key.

<a name='T-Virgil-SDK-Cards-CardsClient'></a>
## CardsClient [#](#T-Virgil-SDK-Cards-CardsClient 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Cards

##### Summary

Provides common methods to interact with Virgil Card resource endpoints.

##### See Also

- [Virgil.SDK.Common.EndpointClient](#T-Virgil-SDK-Common-EndpointClient 'Virgil.SDK.Common.EndpointClient')
- [Virgil.SDK.Cards.ICardsClient](#T-Virgil-SDK-Cards-ICardsClient 'Virgil.SDK.Cards.ICardsClient')

<a name='M-Virgil-SDK-Cards-CardsClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache-'></a>
### #ctor(connection,cache) `constructor` [#](#M-Virgil-SDK-Cards-CardsClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [CardsClient](#T-Virgil-SDK-Cards-CardsClient 'Virgil.SDK.Cards.CardsClient') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| connection | [Virgil.SDK.Http.IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection') | The connection. |
| cache | [Virgil.SDK.Common.IServiceKeyCache](#T-Virgil-SDK-Common-IServiceKeyCache 'Virgil.SDK.Common.IServiceKeyCache') | The services key cache. |

<a name='M-Virgil-SDK-Cards-CardsClient-Create-Virgil-SDK-Identities-IdentityInfo,System-Guid,System-Byte[],System-String,System-Collections-Generic-IDictionary{System-String,System-String}-'></a>
### Create(identityInfo,publicKeyId,privateKey,privateKeyPassword,customData) `method` [#](#M-Virgil-SDK-Cards-CardsClient-Create-Virgil-SDK-Identities-IdentityInfo,System-Guid,System-Byte[],System-String,System-Collections-Generic-IDictionary{System-String,System-String}- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Creates a new card with specified identity and existing public key.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityInfo | [Virgil.SDK.Identities.IdentityInfo](#T-Virgil-SDK-Identities-IdentityInfo 'Virgil.SDK.Identities.IdentityInfo') | The information about identity. |
| publicKeyId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The public key identifier in Virgil Services. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key. Private key is used to produce sign. It is not transfered over network |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. Pass this parameter if your private key is encrypted with password |
| customData | [System.Collections.Generic.IDictionary{System.String,System.String}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Collections.Generic.IDictionary 'System.Collections.Generic.IDictionary{System.String,System.String}') | The dictionary of key/value pairs with custom values that can be used by different applications |

<a name='M-Virgil-SDK-Cards-CardsClient-Create-Virgil-SDK-Identities-IdentityInfo,System-Byte[],System-Byte[],System-String,System-Collections-Generic-IDictionary{System-String,System-String}-'></a>
### Create(identityInfo,publicKey,privateKey,privateKeyPassword,customData) `method` [#](#M-Virgil-SDK-Cards-CardsClient-Create-Virgil-SDK-Identities-IdentityInfo,System-Byte[],System-Byte[],System-String,System-Collections-Generic-IDictionary{System-String,System-String}- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Creates a new card with specified identity and public key.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityInfo | [Virgil.SDK.Identities.IdentityInfo](#T-Virgil-SDK-Identities-IdentityInfo 'Virgil.SDK.Identities.IdentityInfo') | The information about identity. |
| publicKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The generated public key value. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key. Private key is used to produce sign. It is not transfered over network |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. Pass this parameter if your private key is encrypted with password |
| customData | [System.Collections.Generic.IDictionary{System.String,System.String}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Collections.Generic.IDictionary 'System.Collections.Generic.IDictionary{System.String,System.String}') | The dictionary of key/value pairs with custom values that can be used by different applications |

<a name='M-Virgil-SDK-Cards-CardsClient-Get-System-Guid-'></a>
### Get(cardId) `method` [#](#M-Virgil-SDK-Cards-CardsClient-Get-System-Guid- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the card by ID.

##### Returns

Virgil card model.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| cardId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The card ID. |

<a name='M-Virgil-SDK-Cards-CardsClient-GetCardsRealtedToThePublicKey-System-Guid,System-Guid,System-Byte[],System-String-'></a>
### GetCardsRealtedToThePublicKey(publicKeyId,cardId,privateKey,privateKeyPassword) `method` [#](#M-Virgil-SDK-Cards-CardsClient-GetCardsRealtedToThePublicKey-System-Guid,System-Guid,System-Byte[],System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the cards by specified public key.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| publicKeyId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The public key identifier. |
| cardId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The private/public keys associated card identifier. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key. Private key is used to produce sign. It is not transfered over network |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. |

<a name='M-Virgil-SDK-Cards-CardsClient-Revoke-System-Guid,Virgil-SDK-Identities-IdentityInfo,System-Byte[],System-String-'></a>
### Revoke(cardId,identityInfo,privateKey,privateKeyPassword) `method` [#](#M-Virgil-SDK-Cards-CardsClient-Revoke-System-Guid,Virgil-SDK-Identities-IdentityInfo,System-Byte[],System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Revokes the specified public key.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| cardId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The card ID. |
| identityInfo | [Virgil.SDK.Identities.IdentityInfo](#T-Virgil-SDK-Identities-IdentityInfo 'Virgil.SDK.Identities.IdentityInfo') | Validation token for card's identity. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key. Private key is used to produce sign. It is not transfered over network |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. |

<a name='M-Virgil-SDK-Cards-CardsClient-Search-System-String,System-String,System-Nullable{System-Boolean}-'></a>
### Search(identityValue,identityType,includeUnauthorized) `method` [#](#M-Virgil-SDK-Cards-CardsClient-Search-System-String,System-String,System-Nullable{System-Boolean}- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Searches the private cards by specified criteria.

##### Returns

The collection of Virgil Cards.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityValue | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The value of identifier. |
| identityType | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The type of identifier. |
| includeUnauthorized | [System.Nullable{System.Boolean}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Nullable 'System.Nullable{System.Boolean}') | Unconfirmed Virgil cards will be included in output. Optional |

<a name='M-Virgil-SDK-Cards-CardsClient-Search-System-String,Virgil-SDK-Identities-IdentityType-'></a>
### Search(identityValue,identityType) `method` [#](#M-Virgil-SDK-Cards-CardsClient-Search-System-String,Virgil-SDK-Identities-IdentityType- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Searches the global cards by specified criteria.

##### Returns

The collection of Virgil Cards.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityValue | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The value of identifier. |
| identityType | [Virgil.SDK.Identities.IdentityType](#T-Virgil-SDK-Identities-IdentityType 'Virgil.SDK.Identities.IdentityType') | The type of identifier. |

<a name='T-Virgil-SDK-Http-ConnectionBase'></a>
## ConnectionBase [#](#T-Virgil-SDK-Http-ConnectionBase 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Http

##### Summary



<a name='M-Virgil-SDK-Http-ConnectionBase-#ctor-System-String,System-Uri-'></a>
### #ctor(accessToken,baseAddress) `constructor` [#](#M-Virgil-SDK-Http-ConnectionBase-#ctor-System-String,System-Uri- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [ConnectionBase](#T-Virgil-SDK-Http-ConnectionBase 'Virgil.SDK.Http.ConnectionBase') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| accessToken | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The application token. |
| baseAddress | [System.Uri](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Uri 'System.Uri') | The base address. |

<a name='F-Virgil-SDK-Http-ConnectionBase-AccessTokenHeaderName'></a>
### AccessTokenHeaderName `constants` [#](#F-Virgil-SDK-Http-ConnectionBase-AccessTokenHeaderName 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

The access token header name

<a name='F-Virgil-SDK-Http-ConnectionBase-Errors'></a>
### Errors `constants` [#](#F-Virgil-SDK-Http-ConnectionBase-Errors 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

The error code to message mapping dictionary

<a name='P-Virgil-SDK-Http-ConnectionBase-AccessToken'></a>
### AccessToken `property` [#](#P-Virgil-SDK-Http-ConnectionBase-AccessToken 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Access Token

<a name='P-Virgil-SDK-Http-ConnectionBase-BaseAddress'></a>
### BaseAddress `property` [#](#P-Virgil-SDK-Http-ConnectionBase-BaseAddress 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Base address for the connection.

<a name='M-Virgil-SDK-Http-ConnectionBase-ExceptionHandler-System-Net-Http-HttpResponseMessage-'></a>
### ExceptionHandler(message) `method` [#](#M-Virgil-SDK-Http-ConnectionBase-ExceptionHandler-System-Net-Http-HttpResponseMessage- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Handles exception responses

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| message | [System.Net.Http.HttpResponseMessage](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Net.Http.HttpResponseMessage 'System.Net.Http.HttpResponseMessage') | The http response message. |

<a name='M-Virgil-SDK-Http-ConnectionBase-GetNativeRequest-Virgil-SDK-Http-IRequest-'></a>
### GetNativeRequest(request) `method` [#](#M-Virgil-SDK-Http-ConnectionBase-GetNativeRequest-Virgil-SDK-Http-IRequest- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Produces native HTTP request.

##### Returns

HttpRequestMessage

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| request | [Virgil.SDK.Http.IRequest](#T-Virgil-SDK-Http-IRequest 'Virgil.SDK.Http.IRequest') | The request. |

<a name='M-Virgil-SDK-Http-ConnectionBase-Send-Virgil-SDK-Http-IRequest-'></a>
### Send(request) `method` [#](#M-Virgil-SDK-Http-ConnectionBase-Send-Virgil-SDK-Http-IRequest- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Sends an HTTP request to the API.

##### Returns



##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| request | [Virgil.SDK.Http.IRequest](#T-Virgil-SDK-Http-IRequest 'Virgil.SDK.Http.IRequest') | The HTTP request details. |

<a name='M-Virgil-SDK-Http-ConnectionBase-ThrowException``1-System-Net-Http-HttpResponseMessage,System-Func{System-Int32,System-String,``0}-'></a>
### ThrowException\`\`1(message,exception) `method` [#](#M-Virgil-SDK-Http-ConnectionBase-ThrowException``1-System-Net-Http-HttpResponseMessage,System-Func{System-Int32,System-String,``0}- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Parses service http response and throws apropriate exception

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| message | [System.Net.Http.HttpResponseMessage](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Net.Http.HttpResponseMessage 'System.Net.Http.HttpResponseMessage') | Message received from service |
| exception | [System.Func{System.Int32,System.String,\`\`0}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Func 'System.Func{System.Int32,System.String,``0}') | Exception factory |

##### Generic Types

| Name | Description |
| ---- | ----------- |
| T | Virgil exception child class |

<a name='M-Virgil-SDK-Http-ConnectionBase-TryParseErrorCode-System-String-'></a>
### TryParseErrorCode(content) `method` [#](#M-Virgil-SDK-Http-ConnectionBase-TryParseErrorCode-System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Parses service response to retrieve error code

##### Returns

Parsed error code

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| content | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | Http body of service response |

<a name='T-Virgil-SDK-Common-DynamicKeyCache'></a>
## DynamicKeyCache [#](#T-Virgil-SDK-Common-DynamicKeyCache 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Common

##### Summary

Provides cached value of known public key for channel encryption and response verification

##### See Also

- [Virgil.SDK.Common.IServiceKeyCache](#T-Virgil-SDK-Common-IServiceKeyCache 'Virgil.SDK.Common.IServiceKeyCache')

<a name='M-Virgil-SDK-Common-DynamicKeyCache-#ctor-Virgil-SDK-Http-IConnection-'></a>
### #ctor(connection) `constructor` [#](#M-Virgil-SDK-Common-DynamicKeyCache-#ctor-Virgil-SDK-Http-IConnection- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [DynamicKeyCache](#T-Virgil-SDK-Common-DynamicKeyCache 'Virgil.SDK.Common.DynamicKeyCache') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| connection | [Virgil.SDK.Http.IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection') | The Virgil Public Services connection instance. |

<a name='M-Virgil-SDK-Common-DynamicKeyCache-GetServiceCard-System-String-'></a>
### GetServiceCard(servicePublicKeyId) `method` [#](#M-Virgil-SDK-Common-DynamicKeyCache-GetServiceCard-System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the service's public key by specified identifier.

##### Returns

An instance of [PublicKeyModel](#T-Virgil-SDK-Models-PublicKeyModel 'Virgil.SDK.Models.PublicKeyModel'), that represents Public Key.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| servicePublicKeyId | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The service's public key identifier. |

<a name='T-Virgil-SDK-Identities-EmailVerifier'></a>
## EmailVerifier [#](#T-Virgil-SDK-Identities-EmailVerifier 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Identities

##### Summary

Represents a class for email address verification.

<a name='M-Virgil-SDK-Identities-EmailVerifier-#ctor-System-Guid,Virgil-SDK-Identities-IIdentityClient-'></a>
### #ctor() `constructor` [#](#M-Virgil-SDK-Identities-EmailVerifier-#ctor-System-Guid,Virgil-SDK-Identities-IIdentityClient- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [EmailVerifier](#T-Virgil-SDK-Identities-EmailVerifier 'Virgil.SDK.Identities.EmailVerifier') class.

##### Parameters

This constructor has no parameters.

<a name='P-Virgil-SDK-Identities-EmailVerifier-ActionId'></a>
### ActionId `property` [#](#P-Virgil-SDK-Identities-EmailVerifier-ActionId 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the verification process ID.

<a name='M-Virgil-SDK-Identities-EmailVerifier-Confirm-System-String,System-Int32,System-Int32-'></a>
### Confirm(code,timeToLive,countToLive) `method` [#](#M-Virgil-SDK-Identities-EmailVerifier-Confirm-System-String,System-Int32,System-Int32- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Confirms the identity using confirmation code, that has been generated to confirm an identity.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| code | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The confirmation code that was recived on email box. |
| timeToLive | [System.Int32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Int32 'System.Int32') | The parameter is used to limit the lifetime of the token in seconds (maximum value is 60 * 60 * 24 * 365 = 1 year) |
| countToLive | [System.Int32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Int32 'System.Int32') | The parameter is used to restrict the number of token usages (maximum value is 100) |

<a name='T-Virgil-SDK-Common-EndpointClient'></a>
## EndpointClient [#](#T-Virgil-SDK-Common-EndpointClient 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Common

##### Summary

Provides a base implementation of HTTP client for the Virgil Security services.

<a name='M-Virgil-SDK-Common-EndpointClient-#ctor-Virgil-SDK-Http-IConnection-'></a>
### #ctor(connection) `constructor` [#](#M-Virgil-SDK-Common-EndpointClient-#ctor-Virgil-SDK-Http-IConnection- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [EndpointClient](#T-Virgil-SDK-Common-EndpointClient 'Virgil.SDK.Common.EndpointClient') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| connection | [Virgil.SDK.Http.IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection') | The connection. |

<a name='M-Virgil-SDK-Common-EndpointClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache-'></a>
### #ctor(connection,cache) `constructor` [#](#M-Virgil-SDK-Common-EndpointClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [EndpointClient](#T-Virgil-SDK-Common-EndpointClient 'Virgil.SDK.Common.EndpointClient') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| connection | [Virgil.SDK.Http.IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection') | The connection. |
| cache | [Virgil.SDK.Common.IServiceKeyCache](#T-Virgil-SDK-Common-IServiceKeyCache 'Virgil.SDK.Common.IServiceKeyCache') | The service key cache. |

<a name='F-Virgil-SDK-Common-EndpointClient-Cache'></a>
### Cache `constants` [#](#F-Virgil-SDK-Common-EndpointClient-Cache 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

The cache

<a name='F-Virgil-SDK-Common-EndpointClient-Connection'></a>
### Connection `constants` [#](#F-Virgil-SDK-Common-EndpointClient-Connection 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

The connection

<a name='F-Virgil-SDK-Common-EndpointClient-EndpointApplicationId'></a>
### EndpointApplicationId `constants` [#](#F-Virgil-SDK-Common-EndpointClient-EndpointApplicationId 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

The endpoint application identifier

<a name='M-Virgil-SDK-Common-EndpointClient-Send-Virgil-SDK-Http-IRequest-'></a>
### Send() `method` [#](#M-Virgil-SDK-Common-EndpointClient-Send-Virgil-SDK-Http-IRequest- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Performs an asynchronous HTTP request.

##### Parameters

This method has no parameters.

<a name='M-Virgil-SDK-Common-EndpointClient-Send``1-Virgil-SDK-Http-IRequest-'></a>
### Send\`\`1() `method` [#](#M-Virgil-SDK-Common-EndpointClient-Send``1-Virgil-SDK-Http-IRequest- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Performs an asynchronous HTTP POST request. Attempts to map the response body to an object of type `TResult`

##### Parameters

This method has no parameters.

<a name='T-Virgil-SDK-Helpers-Ensure'></a>
## Ensure [#](#T-Virgil-SDK-Helpers-Ensure 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Helpers

##### Summary

Ensure input parameters

<a name='M-Virgil-SDK-Helpers-Ensure-ArgumentNotNull-System-Object,System-String-'></a>
### ArgumentNotNull(value,name) `method` [#](#M-Virgil-SDK-Helpers-Ensure-ArgumentNotNull-System-Object,System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Checks an argument to ensure it isn't null.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | [System.Object](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Object 'System.Object') | The argument value to check |
| name | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The name of the argument |

<a name='M-Virgil-SDK-Helpers-Ensure-ArgumentNotNullOrEmptyString-System-String,System-String-'></a>
### ArgumentNotNullOrEmptyString(value,name) `method` [#](#M-Virgil-SDK-Helpers-Ensure-ArgumentNotNullOrEmptyString-System-String,System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Checks a string argument to ensure it isn't null or empty.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The argument value to check |
| name | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The name of the argument |

<a name='T-Virgil-SDK-Cards-ICardsClient'></a>
## ICardsClient [#](#T-Virgil-SDK-Cards-ICardsClient 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Cards

##### Summary

Provides common methods to interact with Public Keys resource endpoints.

<a name='M-Virgil-SDK-Cards-ICardsClient-Create-Virgil-SDK-Identities-IdentityInfo,System-Guid,System-Byte[],System-String,System-Collections-Generic-IDictionary{System-String,System-String}-'></a>
### Create(identityInfo,publicKeyId,privateKey,privateKeyPassword,customData) `method` [#](#M-Virgil-SDK-Cards-ICardsClient-Create-Virgil-SDK-Identities-IdentityInfo,System-Guid,System-Byte[],System-String,System-Collections-Generic-IDictionary{System-String,System-String}- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Creates a new card with specified identity and existing public key.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityInfo | [Virgil.SDK.Identities.IdentityInfo](#T-Virgil-SDK-Identities-IdentityInfo 'Virgil.SDK.Identities.IdentityInfo') | The information about identity. |
| publicKeyId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The public key identifier in Virgil Services. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key. Private key is used to produce sign. It is not transfered over network |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. Pass this parameter if your private key is encrypted with password |
| customData | [System.Collections.Generic.IDictionary{System.String,System.String}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Collections.Generic.IDictionary 'System.Collections.Generic.IDictionary{System.String,System.String}') | The dictionary of key/value pairs with custom values that can be used by different applications |

<a name='M-Virgil-SDK-Cards-ICardsClient-Create-Virgil-SDK-Identities-IdentityInfo,System-Byte[],System-Byte[],System-String,System-Collections-Generic-IDictionary{System-String,System-String}-'></a>
### Create(identityInfo,publicKey,privateKey,privateKeyPassword,customData) `method` [#](#M-Virgil-SDK-Cards-ICardsClient-Create-Virgil-SDK-Identities-IdentityInfo,System-Byte[],System-Byte[],System-String,System-Collections-Generic-IDictionary{System-String,System-String}- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Creates a new card with specified identity and public key.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityInfo | [Virgil.SDK.Identities.IdentityInfo](#T-Virgil-SDK-Identities-IdentityInfo 'Virgil.SDK.Identities.IdentityInfo') | The information about identity. |
| publicKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The generated public key value. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key. Private key is used to produce sign. It is not transfered over network |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. Pass this parameter if your private key is encrypted with password |
| customData | [System.Collections.Generic.IDictionary{System.String,System.String}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Collections.Generic.IDictionary 'System.Collections.Generic.IDictionary{System.String,System.String}') | The dictionary of key/value pairs with custom values that can be used by different applications |

<a name='M-Virgil-SDK-Cards-ICardsClient-Get-System-Guid-'></a>
### Get(cardId) `method` [#](#M-Virgil-SDK-Cards-ICardsClient-Get-System-Guid- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the card by ID.

##### Returns

Virgil card model.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| cardId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The card ID. |

<a name='M-Virgil-SDK-Cards-ICardsClient-GetCardsRealtedToThePublicKey-System-Guid,System-Guid,System-Byte[],System-String-'></a>
### GetCardsRealtedToThePublicKey(publicKeyId,cardId,privateKey,privateKeyPassword) `method` [#](#M-Virgil-SDK-Cards-ICardsClient-GetCardsRealtedToThePublicKey-System-Guid,System-Guid,System-Byte[],System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the cards by specified public key.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| publicKeyId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The public key identifier. |
| cardId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The private/public keys associated card identifier. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key. Private key is used to produce sign. It is not transfered over network |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. |

<a name='M-Virgil-SDK-Cards-ICardsClient-Revoke-System-Guid,Virgil-SDK-Identities-IdentityInfo,System-Byte[],System-String-'></a>
### Revoke(cardId,identityInfo,privateKey,privateKeyPassword) `method` [#](#M-Virgil-SDK-Cards-ICardsClient-Revoke-System-Guid,Virgil-SDK-Identities-IdentityInfo,System-Byte[],System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Revokes the specified public key.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| cardId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The card ID. |
| identityInfo | [Virgil.SDK.Identities.IdentityInfo](#T-Virgil-SDK-Identities-IdentityInfo 'Virgil.SDK.Identities.IdentityInfo') | Validation identityInfo for card's identity. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key. Private key is used to produce sign. It is not transfered over network |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. |

<a name='M-Virgil-SDK-Cards-ICardsClient-Search-System-String,System-String,System-Nullable{System-Boolean}-'></a>
### Search(identityValue,identityType,includeUnauthorized) `method` [#](#M-Virgil-SDK-Cards-ICardsClient-Search-System-String,System-String,System-Nullable{System-Boolean}- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Searches the private cards by specified criteria.

##### Returns

The collection of Virgil Cards.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityValue | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The value of identifier. Required. |
| identityType | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The value of identity type. Optional. |
| includeUnauthorized | [System.Nullable{System.Boolean}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Nullable 'System.Nullable{System.Boolean}') | The request parameter specifies whether an unconfirmed Virgil Cards should be included in the search result. |

<a name='M-Virgil-SDK-Cards-ICardsClient-Search-System-String,Virgil-SDK-Identities-IdentityType-'></a>
### Search(identityValue,identityType) `method` [#](#M-Virgil-SDK-Cards-ICardsClient-Search-System-String,Virgil-SDK-Identities-IdentityType- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Searches the global cards by specified criteria.

##### Returns

The collection of Virgil Cards.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityValue | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The value of identifier. Required. |
| identityType | [Virgil.SDK.Identities.IdentityType](#T-Virgil-SDK-Identities-IdentityType 'Virgil.SDK.Identities.IdentityType') | The type of identifier. Optional. |

<a name='T-Virgil-SDK-Http-IConnection'></a>
## IConnection [#](#T-Virgil-SDK-Http-IConnection 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Http

##### Summary

A connection for making HTTP requests against URI endpoints.

<a name='P-Virgil-SDK-Http-IConnection-BaseAddress'></a>
### BaseAddress `property` [#](#P-Virgil-SDK-Http-IConnection-BaseAddress 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Base address for the connection.

<a name='M-Virgil-SDK-Http-IConnection-Send-Virgil-SDK-Http-IRequest-'></a>
### Send(request) `method` [#](#M-Virgil-SDK-Http-IConnection-Send-Virgil-SDK-Http-IRequest- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Sends an HTTP request to the API.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| request | [Virgil.SDK.Http.IRequest](#T-Virgil-SDK-Http-IRequest 'Virgil.SDK.Http.IRequest') | The HTTP request details. |

<a name='T-Virgil-SDK-Identities-IdentityClient'></a>
## IdentityClient [#](#T-Virgil-SDK-Identities-IdentityClient 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Identities

##### Summary

Provides common methods for validating and authorization a different types of identities.

<a name='M-Virgil-SDK-Identities-IdentityClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache-'></a>
### #ctor(connection,cache) `constructor` [#](#M-Virgil-SDK-Identities-IdentityClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [IdentityClient](#T-Virgil-SDK-Identities-IdentityClient 'Virgil.SDK.Identities.IdentityClient') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| connection | [Virgil.SDK.Http.IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection') | The connection. |
| cache | [Virgil.SDK.Common.IServiceKeyCache](#T-Virgil-SDK-Common-IServiceKeyCache 'Virgil.SDK.Common.IServiceKeyCache') | The cache. |

<a name='M-Virgil-SDK-Identities-IdentityClient-Confirm-System-Guid,System-String,System-Int32,System-Int32-'></a>
### Confirm(actionId,code,timeToLive,countToLive) `method` [#](#M-Virgil-SDK-Identities-IdentityClient-Confirm-System-Guid,System-String,System-Int32,System-Int32- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Confirms the identity using confirmation code, that has been generated to confirm an identity.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| actionId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The action identifier that was obtained on verification step. |
| code | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The confirmation code that was recived on email box. |
| timeToLive | [System.Int32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Int32 'System.Int32') | The parameter is used to limit the lifetime of the token in seconds (maximum value is 60 * 60 * 24 * 365 = 1 year) |
| countToLive | [System.Int32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Int32 'System.Int32') | The parameter is used to restrict the number of token usages (maximum value is 100) |

<a name='M-Virgil-SDK-Identities-IdentityClient-IsValid-System-String,Virgil-SDK-Identities-VerifiableIdentityType,System-String-'></a>
### IsValid(identityValue,identityType,validationToken) `method` [#](#M-Virgil-SDK-Identities-IdentityClient-IsValid-System-String,Virgil-SDK-Identities-VerifiableIdentityType,System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Returns true if validation token is valid.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityValue | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The type of identity. |
| identityType | [Virgil.SDK.Identities.VerifiableIdentityType](#T-Virgil-SDK-Identities-VerifiableIdentityType 'Virgil.SDK.Identities.VerifiableIdentityType') | The identity value. |
| validationToken | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The validation token. |

<a name='M-Virgil-SDK-Identities-IdentityClient-Verify-System-String,Virgil-SDK-Identities-VerifiableIdentityType,System-Collections-Generic-IDictionary{System-String,System-String}-'></a>
### Verify(identityValue,identityType,extraFields) `method` [#](#M-Virgil-SDK-Identities-IdentityClient-Verify-System-String,Virgil-SDK-Identities-VerifiableIdentityType,System-Collections-Generic-IDictionary{System-String,System-String}- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Sends the request for identity verification, that's will be processed depending of specified type.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityValue | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | An unique string that represents identity. |
| identityType | [Virgil.SDK.Identities.VerifiableIdentityType](#T-Virgil-SDK-Identities-VerifiableIdentityType 'Virgil.SDK.Identities.VerifiableIdentityType') | The type of identity. |
| extraFields | [System.Collections.Generic.IDictionary{System.String,System.String}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Collections.Generic.IDictionary 'System.Collections.Generic.IDictionary{System.String,System.String}') |  |

##### Remarks

Use method [Confirm](#M-Virgil-SDK-Identities-IdentityClient-Confirm-System-Guid,System-String,System-Int32,System-Int32- 'Virgil.SDK.Identities.IdentityClient.Confirm(System.Guid,System.String,System.Int32,System.Int32)') to confirm and get the indentity token.

<a name='M-Virgil-SDK-Identities-IdentityClient-VerifyEmail-System-String,System-Collections-Generic-IDictionary{System-String,System-String}-'></a>
### VerifyEmail(emailAddress,extraFields) `method` [#](#M-Virgil-SDK-Identities-IdentityClient-VerifyEmail-System-String,System-Collections-Generic-IDictionary{System-String,System-String}- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initiates a process to verify a specified email address.

##### Returns

The verification identuty class

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| emailAddress | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The email address you are going to verify. |
| extraFields | [System.Collections.Generic.IDictionary{System.String,System.String}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Collections.Generic.IDictionary 'System.Collections.Generic.IDictionary{System.String,System.String}') | In some cases it could be necessary to pass some parameters and receive them back in an email. For this special case an optional `extraFields` dictionary can be used. All values passed in `extraFields` parameter will be passed back in an email in a hidden form with extra hidden fields. |

<a name='T-Virgil-SDK-Identities-IdentityConfirmationResponse'></a>
## IdentityConfirmationResponse [#](#T-Virgil-SDK-Identities-IdentityConfirmationResponse 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Identities

##### Summary

Represents an confirmed identity information.

<a name='P-Virgil-SDK-Identities-IdentityConfirmationResponse-Type'></a>
### Type `property` [#](#P-Virgil-SDK-Identities-IdentityConfirmationResponse-Type 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the type.

<a name='P-Virgil-SDK-Identities-IdentityConfirmationResponse-ValidationToken'></a>
### ValidationToken `property` [#](#P-Virgil-SDK-Identities-IdentityConfirmationResponse-ValidationToken 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the validation token.

<a name='P-Virgil-SDK-Identities-IdentityConfirmationResponse-Value'></a>
### Value `property` [#](#P-Virgil-SDK-Identities-IdentityConfirmationResponse-Value 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the value.

<a name='T-Virgil-SDK-Http-IdentityConnection'></a>
## IdentityConnection [#](#T-Virgil-SDK-Http-IdentityConnection 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Http

##### Summary

A connection for making HTTP requests against URI endpoints for identity api services.

##### See Also

- [Virgil.SDK.Http.ConnectionBase](#T-Virgil-SDK-Http-ConnectionBase 'Virgil.SDK.Http.ConnectionBase')
- [Virgil.SDK.Http.IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection')

<a name='M-Virgil-SDK-Http-IdentityConnection-#ctor-System-Uri-'></a>
### #ctor(baseAddress) `constructor` [#](#M-Virgil-SDK-Http-IdentityConnection-#ctor-System-Uri- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [IdentityConnection](#T-Virgil-SDK-Http-IdentityConnection 'Virgil.SDK.Http.IdentityConnection') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| baseAddress | [System.Uri](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Uri 'System.Uri') | The base address. |

<a name='M-Virgil-SDK-Http-IdentityConnection-ExceptionHandler-System-Net-Http-HttpResponseMessage-'></a>
### ExceptionHandler(message) `method` [#](#M-Virgil-SDK-Http-IdentityConnection-ExceptionHandler-System-Net-Http-HttpResponseMessage- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Handles exception responses

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| message | [System.Net.Http.HttpResponseMessage](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Net.Http.HttpResponseMessage 'System.Net.Http.HttpResponseMessage') | The http response message. |

<a name='T-Virgil-SDK-Identities-IdentityInfo'></a>
## IdentityInfo [#](#T-Virgil-SDK-Identities-IdentityInfo 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Identities

##### Summary

Represents an identity information.

<a name='P-Virgil-SDK-Identities-IdentityInfo-Type'></a>
### Type `property` [#](#P-Virgil-SDK-Identities-IdentityInfo-Type 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the type.

<a name='P-Virgil-SDK-Identities-IdentityInfo-ValidationToken'></a>
### ValidationToken `property` [#](#P-Virgil-SDK-Identities-IdentityInfo-ValidationToken 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the validation token.

<a name='P-Virgil-SDK-Identities-IdentityInfo-Value'></a>
### Value `property` [#](#P-Virgil-SDK-Identities-IdentityInfo-Value 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the value.

<a name='T-Virgil-SDK-Models-IdentityModel'></a>
## IdentityModel [#](#T-Virgil-SDK-Models-IdentityModel 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Models

##### Summary

Represents identity object returned from virgil services

<a name='P-Virgil-SDK-Models-IdentityModel-CreatedAt'></a>
### CreatedAt `property` [#](#P-Virgil-SDK-Models-IdentityModel-CreatedAt 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the created at date.

<a name='P-Virgil-SDK-Models-IdentityModel-Id'></a>
### Id `property` [#](#P-Virgil-SDK-Models-IdentityModel-Id 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the identifier.

<a name='P-Virgil-SDK-Models-IdentityModel-Type'></a>
### Type `property` [#](#P-Virgil-SDK-Models-IdentityModel-Type 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the type.

<a name='P-Virgil-SDK-Models-IdentityModel-Value'></a>
### Value `property` [#](#P-Virgil-SDK-Models-IdentityModel-Value 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the value.

<a name='T-Virgil-SDK-Exceptions-IdentityServiceException'></a>
## IdentityServiceException [#](#T-Virgil-SDK-Exceptions-IdentityServiceException 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Exceptions

##### Summary

Base exception for all Identity Service exceptions

##### See Also

- [Virgil.SDK.Exceptions.VirgilException](#T-Virgil-SDK-Exceptions-VirgilException 'Virgil.SDK.Exceptions.VirgilException')

<a name='M-Virgil-SDK-Exceptions-IdentityServiceException-#ctor-System-Int32,System-String-'></a>
### #ctor(errorCode,errorMessage) `constructor` [#](#M-Virgil-SDK-Exceptions-IdentityServiceException-#ctor-System-Int32,System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [IdentityServiceException](#T-Virgil-SDK-Exceptions-IdentityServiceException 'Virgil.SDK.Exceptions.IdentityServiceException') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| errorCode | [System.Int32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Int32 'System.Int32') | The error code. |
| errorMessage | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The error message. |

<a name='T-Virgil-SDK-Identities-IdentityType'></a>
## IdentityType [#](#T-Virgil-SDK-Identities-IdentityType 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Identities

##### Summary

Represents identity type

<a name='F-Virgil-SDK-Identities-IdentityType-Application'></a>
### Application `constants` [#](#F-Virgil-SDK-Identities-IdentityType-Application 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

The application identity type

<a name='F-Virgil-SDK-Identities-IdentityType-Email'></a>
### Email `constants` [#](#F-Virgil-SDK-Identities-IdentityType-Email 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

The email identity type

<a name='T-Virgil-SDK-Identities-IdentityVerificationResponse'></a>
## IdentityVerificationResponse [#](#T-Virgil-SDK-Identities-IdentityVerificationResponse 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Identities

##### Summary

Represents virgil verify response

<a name='P-Virgil-SDK-Identities-IdentityVerificationResponse-ActionId'></a>
### ActionId `property` [#](#P-Virgil-SDK-Identities-IdentityVerificationResponse-ActionId 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the action identifier.

<a name='T-Virgil-SDK-Identities-IEmailVerifier'></a>
## IEmailVerifier [#](#T-Virgil-SDK-Identities-IEmailVerifier 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Identities

##### Summary

Represents a class for identity confirmation.

<a name='P-Virgil-SDK-Identities-IEmailVerifier-ActionId'></a>
### ActionId `property` [#](#P-Virgil-SDK-Identities-IEmailVerifier-ActionId 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the ID of identity verification process.

<a name='M-Virgil-SDK-Identities-IEmailVerifier-Confirm-System-String,System-Int32,System-Int32-'></a>
### Confirm(code,timeToLive,countToLive) `method` [#](#M-Virgil-SDK-Identities-IEmailVerifier-Confirm-System-String,System-Int32,System-Int32- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Confirms the identity using confirmation code, that has been generated to confirm an identity.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| code | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The confirmation code that was recived on email box. |
| timeToLive | [System.Int32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Int32 'System.Int32') | The parameter is used to limit the lifetime of the token in seconds (maximum value is 60 * 60 * 24 * 365 = 1 year) |
| countToLive | [System.Int32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Int32 'System.Int32') | The parameter is used to restrict the number of token usages (maximum value is 100) |

<a name='T-Virgil-SDK-Identities-IIdentityClient'></a>
## IIdentityClient [#](#T-Virgil-SDK-Identities-IIdentityClient 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Identities

##### Summary

Interface that specifies communication with Virgil Security Identity service.

<a name='M-Virgil-SDK-Identities-IIdentityClient-Confirm-System-Guid,System-String,System-Int32,System-Int32-'></a>
### Confirm(actionId,code,timeToLive,countToLive) `method` [#](#M-Virgil-SDK-Identities-IIdentityClient-Confirm-System-Guid,System-String,System-Int32,System-Int32- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Confirms the identity using confirmation code, that has been generated to confirm an identity.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| actionId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The action identifier. |
| code | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The confirmation code. |
| timeToLive | [System.Int32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Int32 'System.Int32') | The time to live. |
| countToLive | [System.Int32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Int32 'System.Int32') | The count to live. |

<a name='M-Virgil-SDK-Identities-IIdentityClient-IsValid-System-String,Virgil-SDK-Identities-VerifiableIdentityType,System-String-'></a>
### IsValid(identityValue,identityType,validationToken) `method` [#](#M-Virgil-SDK-Identities-IIdentityClient-IsValid-System-String,Virgil-SDK-Identities-VerifiableIdentityType,System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Checks whether the validation token is valid for specified identity.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityValue | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The type of identity. |
| identityType | [Virgil.SDK.Identities.VerifiableIdentityType](#T-Virgil-SDK-Identities-VerifiableIdentityType 'Virgil.SDK.Identities.VerifiableIdentityType') | The identity value. |
| validationToken | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The string value that represents validation token for Virgil Identity Service. |

<a name='M-Virgil-SDK-Identities-IIdentityClient-Verify-System-String,Virgil-SDK-Identities-VerifiableIdentityType,System-Collections-Generic-IDictionary{System-String,System-String}-'></a>
### Verify(identityValue,identityType,extraFields) `method` [#](#M-Virgil-SDK-Identities-IIdentityClient-Verify-System-String,Virgil-SDK-Identities-VerifiableIdentityType,System-Collections-Generic-IDictionary{System-String,System-String}- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Sends the request for identity verification, that's will be processed depending of specified type.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityValue | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | An unique string that represents identity. |
| identityType | [Virgil.SDK.Identities.VerifiableIdentityType](#T-Virgil-SDK-Identities-VerifiableIdentityType 'Virgil.SDK.Identities.VerifiableIdentityType') | The identity type that going to be verified. |
| extraFields | [System.Collections.Generic.IDictionary{System.String,System.String}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Collections.Generic.IDictionary 'System.Collections.Generic.IDictionary{System.String,System.String}') |  |

##### Remarks

Use method [Confirm](#M-Virgil-SDK-Identities-IIdentityClient-Confirm-System-Guid,System-String,System-Int32,System-Int32- 'Virgil.SDK.Identities.IIdentityClient.Confirm(System.Guid,System.String,System.Int32,System.Int32)') to confirm and get the indentity token.

<a name='M-Virgil-SDK-Identities-IIdentityClient-VerifyEmail-System-String,System-Collections-Generic-IDictionary{System-String,System-String}-'></a>
### VerifyEmail(emailAddress,extraFields) `method` [#](#M-Virgil-SDK-Identities-IIdentityClient-VerifyEmail-System-String,System-Collections-Generic-IDictionary{System-String,System-String}- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initiates a process to verify a specified email address.

##### Returns

The verification identuty class

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| emailAddress | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The email address you are going to verify. |
| extraFields | [System.Collections.Generic.IDictionary{System.String,System.String}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Collections.Generic.IDictionary 'System.Collections.Generic.IDictionary{System.String,System.String}') | In some cases it could be necessary to pass some parameters and receive them back in an email. For this special case an optional `extraFields` dictionary can be used. All values passed in `extraFields` parameter will be passed back in an email in a hidden form with extra hidden fields. |

<a name='T-Virgil-SDK-PrivateKeys-IPrivateKeysClient'></a>
## IPrivateKeysClient [#](#T-Virgil-SDK-PrivateKeys-IPrivateKeysClient 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.PrivateKeys

##### Summary

Provides common methods to interact with Private Keys resource endpoints.

<a name='M-Virgil-SDK-PrivateKeys-IPrivateKeysClient-Destroy-System-Guid,System-Byte[],System-String-'></a>
### Destroy(cardId,privateKey,privateKeyPassword) `method` [#](#M-Virgil-SDK-PrivateKeys-IPrivateKeysClient-Destroy-System-Guid,System-Byte[],System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Deletes the private key from service by specified card ID.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| cardId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The public key identifier. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key value. Private key is used to produce sign. It is not transfered over network |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. |

<a name='M-Virgil-SDK-PrivateKeys-IPrivateKeysClient-Get-System-Guid,Virgil-SDK-Identities-IdentityInfo-'></a>
### Get(cardId,identityInfo) `method` [#](#M-Virgil-SDK-PrivateKeys-IPrivateKeysClient-Get-System-Guid,Virgil-SDK-Identities-IdentityInfo- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Downloads private part of key by its public id.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| cardId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The public key identifier. |
| identityInfo | [Virgil.SDK.Identities.IdentityInfo](#T-Virgil-SDK-Identities-IdentityInfo 'Virgil.SDK.Identities.IdentityInfo') |  |

##### Remarks

Random password will be generated to encrypt server response

<a name='M-Virgil-SDK-PrivateKeys-IPrivateKeysClient-Get-System-Guid,Virgil-SDK-Identities-IdentityInfo,System-String-'></a>
### Get(cardId,identityInfo,responsePassword) `method` [#](#M-Virgil-SDK-PrivateKeys-IPrivateKeysClient-Get-System-Guid,Virgil-SDK-Identities-IdentityInfo,System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Downloads private part of key by its public id.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| cardId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The public key identifier. |
| identityInfo | [Virgil.SDK.Identities.IdentityInfo](#T-Virgil-SDK-Identities-IdentityInfo 'Virgil.SDK.Identities.IdentityInfo') |  |
| responsePassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') |  |

<a name='M-Virgil-SDK-PrivateKeys-IPrivateKeysClient-Stash-System-Guid,System-Byte[],System-String-'></a>
### Stash(cardId,privateKey,privateKeyPassword) `method` [#](#M-Virgil-SDK-PrivateKeys-IPrivateKeysClient-Stash-System-Guid,System-Byte[],System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Uploads private key to private key store.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| cardId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The public key identifier. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key value. Private key is used to produce sign. It is not transfered over network |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. |

<a name='T-Virgil-SDK-PublicKeys-IPublicKeysClient'></a>
## IPublicKeysClient [#](#T-Virgil-SDK-PublicKeys-IPublicKeysClient 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.PublicKeys

##### Summary

Provides common methods to interact with Public Keys resource endpoints.

<a name='M-Virgil-SDK-PublicKeys-IPublicKeysClient-Get-System-Guid-'></a>
### Get(publicKeyId) `method` [#](#M-Virgil-SDK-PublicKeys-IPublicKeysClient-Get-System-Guid- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the specified public key by it identifier.

##### Returns

Public key dto

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| publicKeyId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The public key identifier. |

<a name='M-Virgil-SDK-PublicKeys-IPublicKeysClient-Revoke-System-Guid,System-Collections-Generic-IEnumerable{Virgil-SDK-Identities-IdentityInfo},System-Guid,System-Byte[],System-String-'></a>
### Revoke(publicKeyId,identityInfos,cardId,privateKey,privateKeyPassword) `method` [#](#M-Virgil-SDK-PublicKeys-IPublicKeysClient-Revoke-System-Guid,System-Collections-Generic-IEnumerable{Virgil-SDK-Identities-IdentityInfo},System-Guid,System-Byte[],System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Revoke a Public Key endpoint. To revoke the Public Key it's mandatory to pass validation tokens obtained on Virgil Identity service for all confirmed Virgil Cards for this Public Key .

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| publicKeyId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The public key ID to be revoked. |
| identityInfos | [System.Collections.Generic.IEnumerable{Virgil.SDK.Identities.IdentityInfo}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Collections.Generic.IEnumerable 'System.Collections.Generic.IEnumerable{Virgil.SDK.Identities.IdentityInfo}') | The list of confirmed identities with associated with this public key. |
| cardId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The private/public keys associated card identifier |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key. |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password |

<a name='T-Virgil-SDK-Http-IRequest'></a>
## IRequest [#](#T-Virgil-SDK-Http-IRequest 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Http

##### Summary

Represent a generic HTTP request

<a name='P-Virgil-SDK-Http-IRequest-Body'></a>
### Body `property` [#](#P-Virgil-SDK-Http-IRequest-Body 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the requests body.

<a name='P-Virgil-SDK-Http-IRequest-Endpoint'></a>
### Endpoint `property` [#](#P-Virgil-SDK-Http-IRequest-Endpoint 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the endpoint. Does not include server base address

<a name='P-Virgil-SDK-Http-IRequest-Headers'></a>
### Headers `property` [#](#P-Virgil-SDK-Http-IRequest-Headers 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the http headers.

<a name='P-Virgil-SDK-Http-IRequest-Method'></a>
### Method `property` [#](#P-Virgil-SDK-Http-IRequest-Method 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the request method.

<a name='T-Virgil-SDK-Http-IResponse'></a>
## IResponse [#](#T-Virgil-SDK-Http-IResponse 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Http

##### Summary

Represents a generic HTTP response

<a name='P-Virgil-SDK-Http-IResponse-Body'></a>
### Body `property` [#](#P-Virgil-SDK-Http-IResponse-Body 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Raw response body.

<a name='P-Virgil-SDK-Http-IResponse-Headers'></a>
### Headers `property` [#](#P-Virgil-SDK-Http-IResponse-Headers 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Information about the API.

<a name='P-Virgil-SDK-Http-IResponse-StatusCode'></a>
### StatusCode `property` [#](#P-Virgil-SDK-Http-IResponse-StatusCode 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

The response status code.

<a name='T-Virgil-SDK-Common-IServiceKeyCache'></a>
## IServiceKeyCache [#](#T-Virgil-SDK-Common-IServiceKeyCache 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Common

##### Summary

Provides cached value of known public key for channel encryption

<a name='M-Virgil-SDK-Common-IServiceKeyCache-GetServiceCard-System-String-'></a>
### GetServiceCard(servicePublicKeyId) `method` [#](#M-Virgil-SDK-Common-IServiceKeyCache-GetServiceCard-System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the service's public key by specified identifier.

##### Returns

An instance of [CardModel](#T-Virgil-SDK-Models-CardModel 'Virgil.SDK.Models.CardModel'), that represents service card.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| servicePublicKeyId | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The service's public key identifier. |

<a name='T-Virgil-SDK-Common-IVirgilService'></a>
## IVirgilService [#](#T-Virgil-SDK-Common-IVirgilService 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Common

##### Summary

Interface that specifies the Virgil Security service.

<a name='T-Virgil-SDK-Localization'></a>
## Localization [#](#T-Virgil-SDK-Localization 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK

##### Summary

A strongly-typed resource class, for looking up localized strings, etc.

<a name='P-Virgil-SDK-Localization-Culture'></a>
### Culture `property` [#](#P-Virgil-SDK-Localization-Culture 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Overrides the current thread's CurrentUICulture property for all resource lookups using this strongly typed resource class.

<a name='P-Virgil-SDK-Localization-ExceptionDomainValueDomainIdentityIsInvalid'></a>
### ExceptionDomainValueDomainIdentityIsInvalid `property` [#](#P-Virgil-SDK-Localization-ExceptionDomainValueDomainIdentityIsInvalid 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to Domain value specified for the domain identity is invalid.

<a name='P-Virgil-SDK-Localization-ExceptionIdentityVerificationIsNotSent'></a>
### ExceptionIdentityVerificationIsNotSent `property` [#](#P-Virgil-SDK-Localization-ExceptionIdentityVerificationIsNotSent 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to Identity verification request is not sent.

<a name='P-Virgil-SDK-Localization-ExceptionPublicKeyNotFound'></a>
### ExceptionPublicKeyNotFound `property` [#](#P-Virgil-SDK-Localization-ExceptionPublicKeyNotFound 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to Public Key is not found.

<a name='P-Virgil-SDK-Localization-ExceptionStringCanNotBeEmpty'></a>
### ExceptionStringCanNotBeEmpty `property` [#](#P-Virgil-SDK-Localization-ExceptionStringCanNotBeEmpty 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to String can not be empty.

<a name='P-Virgil-SDK-Localization-ExceptionStringLengthIsInvalid'></a>
### ExceptionStringLengthIsInvalid `property` [#](#P-Virgil-SDK-Localization-ExceptionStringLengthIsInvalid 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to String parameter should have length less than {0}.

<a name='P-Virgil-SDK-Localization-ExceptionUserDataAlreadyExists'></a>
### ExceptionUserDataAlreadyExists `property` [#](#P-Virgil-SDK-Localization-ExceptionUserDataAlreadyExists 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to User data with same fields is already exists..

<a name='P-Virgil-SDK-Localization-ExceptionUserDataClassSpecifiedIsInvalid'></a>
### ExceptionUserDataClassSpecifiedIsInvalid `property` [#](#P-Virgil-SDK-Localization-ExceptionUserDataClassSpecifiedIsInvalid 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to User Data class specified is invalid.

<a name='P-Virgil-SDK-Localization-ExceptionUserDataConfirmationEntityNotFound'></a>
### ExceptionUserDataConfirmationEntityNotFound `property` [#](#P-Virgil-SDK-Localization-ExceptionUserDataConfirmationEntityNotFound 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to User Data confirmation entity not found.

<a name='P-Virgil-SDK-Localization-ExceptionUserDataConfirmationTokenInvalid'></a>
### ExceptionUserDataConfirmationTokenInvalid `property` [#](#P-Virgil-SDK-Localization-ExceptionUserDataConfirmationTokenInvalid 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to User Data confirmation identityInfo invalid.

<a name='P-Virgil-SDK-Localization-ExceptionUserDataIntegrityConstraintViolation'></a>
### ExceptionUserDataIntegrityConstraintViolation `property` [#](#P-Virgil-SDK-Localization-ExceptionUserDataIntegrityConstraintViolation 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to User Data integrity constraint violation.

<a name='P-Virgil-SDK-Localization-ExceptionUserDataIsNotConfirmedYet'></a>
### ExceptionUserDataIsNotConfirmedYet `property` [#](#P-Virgil-SDK-Localization-ExceptionUserDataIsNotConfirmedYet 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to The user data is not confirmed yet.

<a name='P-Virgil-SDK-Localization-ExceptionUserDataNotFound'></a>
### ExceptionUserDataNotFound `property` [#](#P-Virgil-SDK-Localization-ExceptionUserDataNotFound 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to User data is not found.

<a name='P-Virgil-SDK-Localization-ExceptionUserDataValueIsRequired'></a>
### ExceptionUserDataValueIsRequired `property` [#](#P-Virgil-SDK-Localization-ExceptionUserDataValueIsRequired 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to The user data value is required.

<a name='P-Virgil-SDK-Localization-ExceptionUserDataWasAlreadyConfirmed'></a>
### ExceptionUserDataWasAlreadyConfirmed `property` [#](#P-Virgil-SDK-Localization-ExceptionUserDataWasAlreadyConfirmed 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to User Data was already confirmed and does not need further confirmation.

<a name='P-Virgil-SDK-Localization-ExceptionUserIdHadBeenConfirmed'></a>
### ExceptionUserIdHadBeenConfirmed `property` [#](#P-Virgil-SDK-Localization-ExceptionUserIdHadBeenConfirmed 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to This user id had been confirmed earlier.

<a name='P-Virgil-SDK-Localization-ExceptionUserInfoDataValidationFailed'></a>
### ExceptionUserInfoDataValidationFailed `property` [#](#P-Virgil-SDK-Localization-ExceptionUserInfoDataValidationFailed 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Looks up a localized string similar to User info data validation failed.

<a name='P-Virgil-SDK-Localization-ResourceManager'></a>
### ResourceManager `property` [#](#P-Virgil-SDK-Localization-ResourceManager 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Returns the cached ResourceManager instance used by this class.

<a name='T-Virgil-SDK-Utils-Obfuscator'></a>
## Obfuscator [#](#T-Virgil-SDK-Utils-Obfuscator 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Utils

##### Summary

Provides a helper methods to obfuscate the data.

<a name='M-Virgil-SDK-Utils-Obfuscator-Process-System-String,System-String,Virgil-Crypto-Foundation-VirgilPBKDF-Hash,System-UInt32-'></a>
### Process(value,algorithm,iterations,salt) `method` [#](#M-Virgil-SDK-Utils-Obfuscator-Process-System-String,System-String,Virgil-Crypto-Foundation-VirgilPBKDF-Hash,System-UInt32- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Derives the obfuscated data from incoming parameters using PBKDF function.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The string value to be hashed. |
| algorithm | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The hash algorithm [Hash](#T-Virgil-Crypto-Foundation-VirgilPBKDF-Hash 'Virgil.Crypto.Foundation.VirgilPBKDF.Hash') type. |
| iterations | [Virgil.Crypto.Foundation.VirgilPBKDF.Hash](#T-Virgil-Crypto-Foundation-VirgilPBKDF-Hash 'Virgil.Crypto.Foundation.VirgilPBKDF.Hash') | The count of iterations. |
| salt | [System.UInt32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.UInt32 'System.UInt32') | The hash salt. |

<a name='T-Virgil-SDK-Models-PrivateKeyModel'></a>
## PrivateKeyModel [#](#T-Virgil-SDK-Models-PrivateKeyModel 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Models

##### Summary

Represents private key service grab response

<a name='P-Virgil-SDK-Models-PrivateKeyModel-CardId'></a>
### CardId `property` [#](#P-Virgil-SDK-Models-PrivateKeyModel-CardId 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the virgil card identifier.

<a name='P-Virgil-SDK-Models-PrivateKeyModel-PrivateKey'></a>
### PrivateKey `property` [#](#P-Virgil-SDK-Models-PrivateKeyModel-PrivateKey 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the private key.

<a name='T-Virgil-SDK-PrivateKeys-PrivateKeysClient'></a>
## PrivateKeysClient [#](#T-Virgil-SDK-PrivateKeys-PrivateKeysClient 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.PrivateKeys

##### Summary

Provides common methods to interact with Private Keys resource endpoints.

##### See Also

- [Virgil.SDK.Common.EndpointClient](#T-Virgil-SDK-Common-EndpointClient 'Virgil.SDK.Common.EndpointClient')
- [Virgil.SDK.PrivateKeys.IPrivateKeysClient](#T-Virgil-SDK-PrivateKeys-IPrivateKeysClient 'Virgil.SDK.PrivateKeys.IPrivateKeysClient')

<a name='M-Virgil-SDK-PrivateKeys-PrivateKeysClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache-'></a>
### #ctor(connection,cache) `constructor` [#](#M-Virgil-SDK-PrivateKeys-PrivateKeysClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [PrivateKeysClient](#T-Virgil-SDK-PrivateKeys-PrivateKeysClient 'Virgil.SDK.PrivateKeys.PrivateKeysClient') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| connection | [Virgil.SDK.Http.IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection') | The connection. |
| cache | [Virgil.SDK.Common.IServiceKeyCache](#T-Virgil-SDK-Common-IServiceKeyCache 'Virgil.SDK.Common.IServiceKeyCache') | The known key provider. |

<a name='T-Virgil-SDK-Http-PrivateKeysConnection'></a>
## PrivateKeysConnection [#](#T-Virgil-SDK-Http-PrivateKeysConnection 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Http

##### Summary

A connection for making HTTP requests against URI endpoints for public keys service.

##### See Also

- [Virgil.SDK.Http.ConnectionBase](#T-Virgil-SDK-Http-ConnectionBase 'Virgil.SDK.Http.ConnectionBase')
- [Virgil.SDK.Http.IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection')

<a name='M-Virgil-SDK-Http-PrivateKeysConnection-#ctor-System-String,System-Uri-'></a>
### #ctor(accessToken,baseAddress) `constructor` [#](#M-Virgil-SDK-Http-PrivateKeysConnection-#ctor-System-String,System-Uri- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [PrivateKeysConnection](#T-Virgil-SDK-Http-PrivateKeysConnection 'Virgil.SDK.Http.PrivateKeysConnection') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| accessToken | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | Application token |
| baseAddress | [System.Uri](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Uri 'System.Uri') | The base address. |

<a name='M-Virgil-SDK-Http-PrivateKeysConnection-ExceptionHandler-System-Net-Http-HttpResponseMessage-'></a>
### ExceptionHandler(message) `method` [#](#M-Virgil-SDK-Http-PrivateKeysConnection-ExceptionHandler-System-Net-Http-HttpResponseMessage- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Handles private keys service exception responses

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| message | [System.Net.Http.HttpResponseMessage](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Net.Http.HttpResponseMessage 'System.Net.Http.HttpResponseMessage') | The http response message. |

<a name='T-Virgil-SDK-Models-PublicKeyExtendedResponse'></a>
## PublicKeyExtendedResponse [#](#T-Virgil-SDK-Models-PublicKeyExtendedResponse 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Models

##### Summary

Represents an information about public key's cards.

<a name='P-Virgil-SDK-Models-PublicKeyExtendedResponse-Cards'></a>
### Cards `property` [#](#P-Virgil-SDK-Models-PublicKeyExtendedResponse-Cards 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the virgil cards.

<a name='P-Virgil-SDK-Models-PublicKeyExtendedResponse-CreatedAt'></a>
### CreatedAt `property` [#](#P-Virgil-SDK-Models-PublicKeyExtendedResponse-CreatedAt 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the created at date.

<a name='P-Virgil-SDK-Models-PublicKeyExtendedResponse-Id'></a>
### Id `property` [#](#P-Virgil-SDK-Models-PublicKeyExtendedResponse-Id 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the identifier.

<a name='P-Virgil-SDK-Models-PublicKeyExtendedResponse-Value'></a>
### Value `property` [#](#P-Virgil-SDK-Models-PublicKeyExtendedResponse-Value 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the public key.

<a name='T-Virgil-SDK-Models-PublicKeyModel'></a>
## PublicKeyModel [#](#T-Virgil-SDK-Models-PublicKeyModel 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Models

##### Summary

Represent public key object returned from virgil public keys service

<a name='P-Virgil-SDK-Models-PublicKeyModel-CreatedAt'></a>
### CreatedAt `property` [#](#P-Virgil-SDK-Models-PublicKeyModel-CreatedAt 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the created at date.

<a name='P-Virgil-SDK-Models-PublicKeyModel-Id'></a>
### Id `property` [#](#P-Virgil-SDK-Models-PublicKeyModel-Id 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the identifier.

<a name='P-Virgil-SDK-Models-PublicKeyModel-Value'></a>
### Value `property` [#](#P-Virgil-SDK-Models-PublicKeyModel-Value 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the public key.

<a name='T-Virgil-SDK-PublicKeys-PublicKeysClient'></a>
## PublicKeysClient [#](#T-Virgil-SDK-PublicKeys-PublicKeysClient 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.PublicKeys

##### Summary

Provides common methods to interact with Public Keys resource endpoints.

<a name='M-Virgil-SDK-PublicKeys-PublicKeysClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache-'></a>
### #ctor(connection,cache) `constructor` [#](#M-Virgil-SDK-PublicKeys-PublicKeysClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [PublicKeysClient](#T-Virgil-SDK-PublicKeys-PublicKeysClient 'Virgil.SDK.PublicKeys.PublicKeysClient') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| connection | [Virgil.SDK.Http.IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection') | The connection. |
| cache | [Virgil.SDK.Common.IServiceKeyCache](#T-Virgil-SDK-Common-IServiceKeyCache 'Virgil.SDK.Common.IServiceKeyCache') | The service keys cache. |

<a name='T-Virgil-SDK-Http-PublicServiceConnection'></a>
## PublicServiceConnection [#](#T-Virgil-SDK-Http-PublicServiceConnection 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Http

##### Summary

A connection for making HTTP requests against URI endpoints for public api services.

##### See Also

- [Virgil.SDK.Http.ConnectionBase](#T-Virgil-SDK-Http-ConnectionBase 'Virgil.SDK.Http.ConnectionBase')
- [Virgil.SDK.Http.IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection')

<a name='M-Virgil-SDK-Http-PublicServiceConnection-#ctor-System-String,System-Uri-'></a>
### #ctor(accessToken,baseAddress) `constructor` [#](#M-Virgil-SDK-Http-PublicServiceConnection-#ctor-System-String,System-Uri- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [PublicServiceConnection](#T-Virgil-SDK-Http-PublicServiceConnection 'Virgil.SDK.Http.PublicServiceConnection') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| accessToken | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | Application token |
| baseAddress | [System.Uri](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Uri 'System.Uri') | The base address. |

<a name='M-Virgil-SDK-Http-PublicServiceConnection-ExceptionHandler-System-Net-Http-HttpResponseMessage-'></a>
### ExceptionHandler(message) `method` [#](#M-Virgil-SDK-Http-PublicServiceConnection-ExceptionHandler-System-Net-Http-HttpResponseMessage- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Handles public keys service exception responses

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| message | [System.Net.Http.HttpResponseMessage](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Net.Http.HttpResponseMessage 'System.Net.Http.HttpResponseMessage') | The http response message. |

<a name='T-Virgil-SDK-Http-Request'></a>
## Request [#](#T-Virgil-SDK-Http-Request 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Http

##### Summary

[IRequest](#T-Virgil-SDK-Http-IRequest 'Virgil.SDK.Http.IRequest') default implementation"/>

##### See Also

- [Virgil.SDK.Http.IRequest](#T-Virgil-SDK-Http-IRequest 'Virgil.SDK.Http.IRequest')

<a name='M-Virgil-SDK-Http-Request-#ctor'></a>
### #ctor() `constructor` [#](#M-Virgil-SDK-Http-Request-#ctor 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [Request](#T-Virgil-SDK-Http-Request 'Virgil.SDK.Http.Request') class.

##### Parameters

This constructor has no parameters.

<a name='P-Virgil-SDK-Http-Request-Body'></a>
### Body `property` [#](#P-Virgil-SDK-Http-Request-Body 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the requests body.

<a name='P-Virgil-SDK-Http-Request-Endpoint'></a>
### Endpoint `property` [#](#P-Virgil-SDK-Http-Request-Endpoint 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the endpoint. Does not include server base address

<a name='P-Virgil-SDK-Http-Request-Headers'></a>
### Headers `property` [#](#P-Virgil-SDK-Http-Request-Headers 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the http headers.

<a name='P-Virgil-SDK-Http-Request-Method'></a>
### Method `property` [#](#P-Virgil-SDK-Http-Request-Method 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the request method.

<a name='T-Virgil-SDK-Http-RequestExtensions'></a>
## RequestExtensions [#](#T-Virgil-SDK-Http-RequestExtensions 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Http

##### Summary

Extensions to help construct http requests

<a name='M-Virgil-SDK-Http-RequestExtensions-EncryptJsonBody-Virgil-SDK-Http-Request,Virgil-SDK-Models-CardModel-'></a>
### EncryptJsonBody(request,card) `method` [#](#M-Virgil-SDK-Http-RequestExtensions-EncryptJsonBody-Virgil-SDK-Http-Request,Virgil-SDK-Models-CardModel- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Encrypts the json body.

##### Returns

[Request](#T-Virgil-SDK-Http-Request 'Virgil.SDK.Http.Request')

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| request | [Virgil.SDK.Http.Request](#T-Virgil-SDK-Http-Request 'Virgil.SDK.Http.Request') | The request. |
| card | [Virgil.SDK.Models.CardModel](#T-Virgil-SDK-Models-CardModel 'Virgil.SDK.Models.CardModel') | The Virgil Card dto. |

<a name='M-Virgil-SDK-Http-RequestExtensions-SignRequest-Virgil-SDK-Http-Request,System-Guid,System-Byte[],System-String-'></a>
### SignRequest(request,cardId,privateKey,privateKeyPassword) `method` [#](#M-Virgil-SDK-Http-RequestExtensions-SignRequest-Virgil-SDK-Http-Request,System-Guid,System-Byte[],System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Signs the request.

##### Returns

[Request](#T-Virgil-SDK-Http-Request 'Virgil.SDK.Http.Request')

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| request | [Virgil.SDK.Http.Request](#T-Virgil-SDK-Http-Request 'Virgil.SDK.Http.Request') | The request. |
| cardId | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The card identifier. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key. |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. |

<a name='M-Virgil-SDK-Http-RequestExtensions-SignRequest-Virgil-SDK-Http-Request,System-Byte[],System-String-'></a>
### SignRequest(request,privateKey,privateKeyPassword) `method` [#](#M-Virgil-SDK-Http-RequestExtensions-SignRequest-Virgil-SDK-Http-Request,System-Byte[],System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Signs the request.

##### Returns

[Request](#T-Virgil-SDK-Http-Request 'Virgil.SDK.Http.Request')

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| request | [Virgil.SDK.Http.Request](#T-Virgil-SDK-Http-Request 'Virgil.SDK.Http.Request') | The request. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key. |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. |

<a name='M-Virgil-SDK-Http-RequestExtensions-WithBody-Virgil-SDK-Http-Request,System-Object-'></a>
### WithBody(request,body) `method` [#](#M-Virgil-SDK-Http-RequestExtensions-WithBody-Virgil-SDK-Http-Request,System-Object- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Withes the body.

##### Returns

[Request](#T-Virgil-SDK-Http-Request 'Virgil.SDK.Http.Request')

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| request | [Virgil.SDK.Http.Request](#T-Virgil-SDK-Http-Request 'Virgil.SDK.Http.Request') | The request. |
| body | [System.Object](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Object 'System.Object') | The body. |

<a name='M-Virgil-SDK-Http-RequestExtensions-WithEndpoint-Virgil-SDK-Http-Request,System-String-'></a>
### WithEndpoint(request,endpoint) `method` [#](#M-Virgil-SDK-Http-RequestExtensions-WithEndpoint-Virgil-SDK-Http-Request,System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Sets the request enpoint

##### Returns

[Request](#T-Virgil-SDK-Http-Request 'Virgil.SDK.Http.Request')

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| request | [Virgil.SDK.Http.Request](#T-Virgil-SDK-Http-Request 'Virgil.SDK.Http.Request') | The request. |
| endpoint | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The endpoint. |

<a name='T-Virgil-SDK-Http-RequestMethod'></a>
## RequestMethod [#](#T-Virgil-SDK-Http-RequestMethod 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Http

##### Summary

Represents HTTP request methods

<a name='T-Virgil-SDK-Http-Response'></a>
## Response [#](#T-Virgil-SDK-Http-Response 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Http

##### Summary

[IResponse](#T-Virgil-SDK-Http-IResponse 'Virgil.SDK.Http.IResponse') default implementation

<a name='P-Virgil-SDK-Http-Response-Body'></a>
### Body `property` [#](#P-Virgil-SDK-Http-Response-Body 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Raw response body.

<a name='P-Virgil-SDK-Http-Response-Headers'></a>
### Headers `property` [#](#P-Virgil-SDK-Http-Response-Headers 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Information about the API.

<a name='P-Virgil-SDK-Http-Response-StatusCode'></a>
### StatusCode `property` [#](#P-Virgil-SDK-Http-Response-StatusCode 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

The response status code.

<a name='T-Virgil-SDK-Common-ResponseVerifyClient'></a>
## ResponseVerifyClient [#](#T-Virgil-SDK-Common-ResponseVerifyClient 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Common

##### Summary

Provides a base implementation of HTTP client for the Virgil Security services which provide response signature.

<a name='M-Virgil-SDK-Common-ResponseVerifyClient-#ctor-Virgil-SDK-Http-IConnection-'></a>
### #ctor(connection) `constructor` [#](#M-Virgil-SDK-Common-ResponseVerifyClient-#ctor-Virgil-SDK-Http-IConnection- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [ResponseVerifyClient](#T-Virgil-SDK-Common-ResponseVerifyClient 'Virgil.SDK.Common.ResponseVerifyClient') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| connection | [Virgil.SDK.Http.IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection') | The connection. |

<a name='M-Virgil-SDK-Common-ResponseVerifyClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache-'></a>
### #ctor(connection,cache) `constructor` [#](#M-Virgil-SDK-Common-ResponseVerifyClient-#ctor-Virgil-SDK-Http-IConnection,Virgil-SDK-Common-IServiceKeyCache- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [ResponseVerifyClient](#T-Virgil-SDK-Common-ResponseVerifyClient 'Virgil.SDK.Common.ResponseVerifyClient') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| connection | [Virgil.SDK.Http.IConnection](#T-Virgil-SDK-Http-IConnection 'Virgil.SDK.Http.IConnection') | The connection. |
| cache | [Virgil.SDK.Common.IServiceKeyCache](#T-Virgil-SDK-Common-IServiceKeyCache 'Virgil.SDK.Common.IServiceKeyCache') | The service key cache. |

<a name='M-Virgil-SDK-Common-ResponseVerifyClient-Send-Virgil-SDK-Http-IRequest-'></a>
### Send() `method` [#](#M-Virgil-SDK-Common-ResponseVerifyClient-Send-Virgil-SDK-Http-IRequest- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Performs an asynchronous HTTP request.

##### Parameters

This method has no parameters.

<a name='M-Virgil-SDK-Common-ResponseVerifyClient-Send``1-Virgil-SDK-Http-IRequest-'></a>
### Send\`\`1(request) `method` [#](#M-Virgil-SDK-Common-ResponseVerifyClient-Send``1-Virgil-SDK-Http-IRequest- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Performs an asynchronous HTTP POST request. Attempts to map the response body to an object of type `TResult`

##### Returns



##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| request | [Virgil.SDK.Http.IRequest](#T-Virgil-SDK-Http-IRequest 'Virgil.SDK.Http.IRequest') |  |

##### Generic Types

| Name | Description |
| ---- | ----------- |
| TResult |  |

<a name='M-Virgil-SDK-Common-ResponseVerifyClient-VerifyResponse-Virgil-SDK-Http-IResponse,System-Byte[]-'></a>
### VerifyResponse(nativeResponse,publicKey) `method` [#](#M-Virgil-SDK-Common-ResponseVerifyClient-VerifyResponse-Virgil-SDK-Http-IResponse,System-Byte[]- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Verifies the HTTP response with specified public key.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| nativeResponse | [Virgil.SDK.Http.IResponse](#T-Virgil-SDK-Http-IResponse 'Virgil.SDK.Http.IResponse') | An instance of HTTP response. |
| publicKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | A public key to be used for verification. |

<a name='T-Virgil-SDK-ServiceHub'></a>
## ServiceHub [#](#T-Virgil-SDK-ServiceHub 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK

##### Summary

Represents all exposed virgil services

<a name='M-Virgil-SDK-ServiceHub-#ctor-Virgil-SDK-ServiceHubConfig-'></a>
### #ctor() `constructor` [#](#M-Virgil-SDK-ServiceHub-#ctor-Virgil-SDK-ServiceHubConfig- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [ServiceHub](#T-Virgil-SDK-ServiceHub 'Virgil.SDK.ServiceHub') class.

##### Parameters

This constructor has no parameters.

<a name='P-Virgil-SDK-ServiceHub-Cards'></a>
### Cards `property` [#](#P-Virgil-SDK-ServiceHub-Cards 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets a client that handle requests for `Card` resources.

<a name='P-Virgil-SDK-ServiceHub-Identity'></a>
### Identity `property` [#](#P-Virgil-SDK-ServiceHub-Identity 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets a client that handle requests Identity service resources.

<a name='P-Virgil-SDK-ServiceHub-PrivateKeys'></a>
### PrivateKeys `property` [#](#P-Virgil-SDK-ServiceHub-PrivateKeys 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets a client that handle requests for `PrivateKey` resources.

<a name='P-Virgil-SDK-ServiceHub-PublicKeys'></a>
### PublicKeys `property` [#](#P-Virgil-SDK-ServiceHub-PublicKeys 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets a client that handle requests for `PublicKey` resources.

<a name='M-Virgil-SDK-ServiceHub-BuildCardsClient'></a>
### BuildCardsClient() `method` [#](#M-Virgil-SDK-ServiceHub-BuildCardsClient 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Builds a Cards client instance.

##### Parameters

This method has no parameters.

<a name='M-Virgil-SDK-ServiceHub-BuildIdentityClient'></a>
### BuildIdentityClient() `method` [#](#M-Virgil-SDK-ServiceHub-BuildIdentityClient 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Builds a Identity Service client instance.

##### Parameters

This method has no parameters.

<a name='M-Virgil-SDK-ServiceHub-BuildPrivateKeysClient'></a>
### BuildPrivateKeysClient() `method` [#](#M-Virgil-SDK-ServiceHub-BuildPrivateKeysClient 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Builds a Private Key client instance.

##### Parameters

This method has no parameters.

<a name='M-Virgil-SDK-ServiceHub-BuildPublicKeysClient'></a>
### BuildPublicKeysClient() `method` [#](#M-Virgil-SDK-ServiceHub-BuildPublicKeysClient 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Builds a Public Key client instance.

##### Parameters

This method has no parameters.

<a name='M-Virgil-SDK-ServiceHub-Create-System-String-'></a>
### Create() `method` [#](#M-Virgil-SDK-ServiceHub-Create-System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Creates new [ServiceHub](#T-Virgil-SDK-ServiceHub 'Virgil.SDK.ServiceHub') instances with default configuration for specified access token.

##### Parameters

This method has no parameters.

<a name='M-Virgil-SDK-ServiceHub-Create-Virgil-SDK-ServiceHubConfig-'></a>
### Create() `method` [#](#M-Virgil-SDK-ServiceHub-Create-Virgil-SDK-ServiceHubConfig- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Creates new [ServiceHub](#T-Virgil-SDK-ServiceHub 'Virgil.SDK.ServiceHub') instances with default configuration for specified configuration.

##### Parameters

This method has no parameters.

<a name='M-Virgil-SDK-ServiceHub-Initialize'></a>
### Initialize() `method` [#](#M-Virgil-SDK-ServiceHub-Initialize 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes an implementation of the ServiceHub class.

##### Parameters

This method has no parameters.

<a name='T-Virgil-SDK-ServiceHubConfig'></a>
## ServiceHubConfig [#](#T-Virgil-SDK-ServiceHubConfig 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK

##### Summary

Represents a configuration file that is applicable to a particular [ServiceHub](#T-Virgil-SDK-ServiceHub 'Virgil.SDK.ServiceHub'). This class cannot be inherited.

<a name='M-Virgil-SDK-ServiceHubConfig-#ctor-System-String-'></a>
### #ctor() `constructor` [#](#M-Virgil-SDK-ServiceHubConfig-#ctor-System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [ServiceHubConfig](#T-Virgil-SDK-ServiceHubConfig 'Virgil.SDK.ServiceHubConfig') class.

##### Parameters

This constructor has no parameters.

<a name='M-Virgil-SDK-ServiceHubConfig-UseAccessToken-System-String-'></a>
### UseAccessToken() `method` [#](#M-Virgil-SDK-ServiceHubConfig-UseAccessToken-System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Sets the application token to access to the Virgil Security services. This token has to be generated with application private key on Virgil Security portal or manually with SDK Utils.

##### Parameters

This method has no parameters.

<a name='M-Virgil-SDK-ServiceHubConfig-WithIdentityServiceAddress-System-String-'></a>
### WithIdentityServiceAddress() `method` [#](#M-Virgil-SDK-ServiceHubConfig-WithIdentityServiceAddress-System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Overrides default Virgil Identity service address.

##### Parameters

This method has no parameters.

<a name='M-Virgil-SDK-ServiceHubConfig-WithPrivateServicesAddress-System-String-'></a>
### WithPrivateServicesAddress() `method` [#](#M-Virgil-SDK-ServiceHubConfig-WithPrivateServicesAddress-System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Overrides default Virgil Private Keys service address.

##### Parameters

This method has no parameters.

<a name='M-Virgil-SDK-ServiceHubConfig-WithPublicServicesAddress-System-String-'></a>
### WithPublicServicesAddress() `method` [#](#M-Virgil-SDK-ServiceHubConfig-WithPublicServicesAddress-System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Overrides default Virgil Public Keys service address.

##### Parameters

This method has no parameters.

<a name='M-Virgil-SDK-ServiceHubConfig-WithStagingEnvironment'></a>
### WithStagingEnvironment() `method` [#](#M-Virgil-SDK-ServiceHubConfig-WithStagingEnvironment 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes Virgil Securtity services with staging urls.

##### Parameters

This method has no parameters.

<a name='T-Virgil-SDK-Common-ServiceIdentities'></a>
## ServiceIdentities [#](#T-Virgil-SDK-Common-ServiceIdentities 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Common

##### Summary

Holds known Virgil application ids

<a name='F-Virgil-SDK-Common-ServiceIdentities-IdentityService'></a>
### IdentityService `constants` [#](#F-Virgil-SDK-Common-ServiceIdentities-IdentityService 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Identity service app id

<a name='F-Virgil-SDK-Common-ServiceIdentities-PrivateService'></a>
### PrivateService `constants` [#](#F-Virgil-SDK-Common-ServiceIdentities-PrivateService 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Private key service app id

<a name='F-Virgil-SDK-Common-ServiceIdentities-PublicService'></a>
### PublicService `constants` [#](#F-Virgil-SDK-Common-ServiceIdentities-PublicService 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Public service app id

<a name='T-Virgil-SDK-Exceptions-ServiceSignVerificationException'></a>
## ServiceSignVerificationException [#](#T-Virgil-SDK-Exceptions-ServiceSignVerificationException 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Exceptions

##### Summary

Occurs when service response sign is invalid

##### See Also

- [Virgil.SDK.Exceptions.VirgilException](#T-Virgil-SDK-Exceptions-VirgilException 'Virgil.SDK.Exceptions.VirgilException')

<a name='M-Virgil-SDK-Exceptions-ServiceSignVerificationException-#ctor-System-String-'></a>
### #ctor(message) `constructor` [#](#M-Virgil-SDK-Exceptions-ServiceSignVerificationException-#ctor-System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [ServiceSignVerificationException](#T-Virgil-SDK-Exceptions-ServiceSignVerificationException 'Virgil.SDK.Exceptions.ServiceSignVerificationException') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| message | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The message that describes the error. |

<a name='T-Virgil-SDK-Models-SignModel'></a>
## SignModel [#](#T-Virgil-SDK-Models-SignModel 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Models

##### Summary

Represents trust card response

<a name='P-Virgil-SDK-Models-SignModel-CreatedAt'></a>
### CreatedAt `property` [#](#P-Virgil-SDK-Models-SignModel-CreatedAt 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the created at date.

<a name='P-Virgil-SDK-Models-SignModel-Id'></a>
### Id `property` [#](#P-Virgil-SDK-Models-SignModel-Id 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the identifier.

<a name='P-Virgil-SDK-Models-SignModel-SignedCardId'></a>
### SignedCardId `property` [#](#P-Virgil-SDK-Models-SignModel-SignedCardId 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the signed virgil card identifier.

<a name='P-Virgil-SDK-Models-SignModel-SignedDigest'></a>
### SignedDigest `property` [#](#P-Virgil-SDK-Models-SignModel-SignedDigest 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the signed digest.

<a name='P-Virgil-SDK-Models-SignModel-SignerCardId'></a>
### SignerCardId `property` [#](#P-Virgil-SDK-Models-SignModel-SignerCardId 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets or sets the signer virgil card identifier.

<a name='T-Virgil-SDK-Utils-ValidationTokenGenerator'></a>
## ValidationTokenGenerator [#](#T-Virgil-SDK-Utils-ValidationTokenGenerator 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Utils

##### Summary

Provides a helper methods to generate validation token based on application's private key.

<a name='M-Virgil-SDK-Utils-ValidationTokenGenerator-Generate-System-String,System-String,System-Byte[],System-String-'></a>
### Generate(identityValue,identityType,privateKey,privateKeyPassword) `method` [#](#M-Virgil-SDK-Utils-ValidationTokenGenerator-Generate-System-String,System-String,System-Byte[],System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Generates the validation token based on application's private key.

##### Returns



##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityValue | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The identity value. |
| identityType | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The type of the identity. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The application's private key. |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. |

<a name='M-Virgil-SDK-Utils-ValidationTokenGenerator-Generate-System-Guid,System-String,System-String,System-Byte[],System-String-'></a>
### Generate(identityValue,identityType,privateKey,privateKeyPassword) `method` [#](#M-Virgil-SDK-Utils-ValidationTokenGenerator-Generate-System-Guid,System-String,System-String,System-Byte[],System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Generates the validation token based on application's private key.

##### Returns



##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| identityValue | [System.Guid](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Guid 'System.Guid') | The identity value. |
| identityType | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The type of the identity. |
| privateKey | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The application's private key. |
| privateKeyPassword | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The private key password. |

<a name='T-Virgil-SDK-Identities-VerifiableIdentityType'></a>
## VerifiableIdentityType [#](#T-Virgil-SDK-Identities-VerifiableIdentityType 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Identities

##### Summary

Represents a supported identity type that Virgil Service are able to verify.

<a name='F-Virgil-SDK-Identities-VerifiableIdentityType-Email'></a>
### Email `constants` [#](#F-Virgil-SDK-Identities-VerifiableIdentityType-Email 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

The email identity type

<a name='T-Virgil-SDK-Exceptions-VerificationRequestIsNotSentException'></a>
## VerificationRequestIsNotSentException [#](#T-Virgil-SDK-Exceptions-VerificationRequestIsNotSentException 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Exceptions

##### Summary



<a name='M-Virgil-SDK-Exceptions-VerificationRequestIsNotSentException-#ctor'></a>
### #ctor() `constructor` [#](#M-Virgil-SDK-Exceptions-VerificationRequestIsNotSentException-#ctor 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [VerificationRequestIsNotSentException](#T-Virgil-SDK-Exceptions-VerificationRequestIsNotSentException 'Virgil.SDK.Exceptions.VerificationRequestIsNotSentException') class.

##### Parameters

This constructor has no parameters.

<a name='T-Virgil-SDK-Exceptions-VirgilException'></a>
## VirgilException [#](#T-Virgil-SDK-Exceptions-VirgilException 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Exceptions

##### Summary

Base exception class for all Virgil Services operations

##### See Also

- [System.Exception](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Exception 'System.Exception')

<a name='M-Virgil-SDK-Exceptions-VirgilException-#ctor-System-Int32,System-String-'></a>
### #ctor(errorCode,errorMessage) `constructor` [#](#M-Virgil-SDK-Exceptions-VirgilException-#ctor-System-Int32,System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [VirgilException](#T-Virgil-SDK-Exceptions-VirgilException 'Virgil.SDK.Exceptions.VirgilException') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| errorCode | [System.Int32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Int32 'System.Int32') | The error code. |
| errorMessage | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The error message. |

<a name='M-Virgil-SDK-Exceptions-VirgilException-#ctor-System-String-'></a>
### #ctor(message) `constructor` [#](#M-Virgil-SDK-Exceptions-VirgilException-#ctor-System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [VirgilException](#T-Virgil-SDK-Exceptions-VirgilException 'Virgil.SDK.Exceptions.VirgilException') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| message | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The message that describes the error. |

<a name='P-Virgil-SDK-Exceptions-VirgilException-ErrorCode'></a>
### ErrorCode `property` [#](#P-Virgil-SDK-Exceptions-VirgilException-ErrorCode 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Gets the error code.

<a name='T-Virgil-SDK-Exceptions-VirgilPrivateServicesException'></a>
## VirgilPrivateServicesException [#](#T-Virgil-SDK-Exceptions-VirgilPrivateServicesException 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Exceptions

##### Summary

Private service exception

##### See Also

- [Virgil.SDK.Exceptions.VirgilException](#T-Virgil-SDK-Exceptions-VirgilException 'Virgil.SDK.Exceptions.VirgilException')

<a name='M-Virgil-SDK-Exceptions-VirgilPrivateServicesException-#ctor-System-Int32,System-String-'></a>
### #ctor(errorCode,errorMessage) `constructor` [#](#M-Virgil-SDK-Exceptions-VirgilPrivateServicesException-#ctor-System-Int32,System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [VirgilPrivateServicesException](#T-Virgil-SDK-Exceptions-VirgilPrivateServicesException 'Virgil.SDK.Exceptions.VirgilPrivateServicesException') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| errorCode | [System.Int32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Int32 'System.Int32') | The error code. |
| errorMessage | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The error message. |

<a name='T-Virgil-SDK-Exceptions-VirgilPublicServicesException'></a>
## VirgilPublicServicesException [#](#T-Virgil-SDK-Exceptions-VirgilPublicServicesException 'Go To Here') [=](#contents 'Back To Contents')

##### Namespace

Virgil.SDK.Exceptions

##### Summary

Public service exception

##### See Also

- [Virgil.SDK.Exceptions.VirgilException](#T-Virgil-SDK-Exceptions-VirgilException 'Virgil.SDK.Exceptions.VirgilException')

<a name='M-Virgil-SDK-Exceptions-VirgilPublicServicesException-#ctor-System-Int32,System-String-'></a>
### #ctor(errorCode,errorMessage) `constructor` [#](#M-Virgil-SDK-Exceptions-VirgilPublicServicesException-#ctor-System-Int32,System-String- 'Go To Here') [=](#contents 'Back To Contents')

##### Summary

Initializes a new instance of the [VirgilPublicServicesException](#T-Virgil-SDK-Exceptions-VirgilPublicServicesException 'Virgil.SDK.Exceptions.VirgilPublicServicesException') class.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| errorCode | [System.Int32](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Int32 'System.Int32') | The error code. |
| errorMessage | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The error message. |
