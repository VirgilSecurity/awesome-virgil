
# Tutorial C#/.NET Keys SDK 

- [Introduction](#introduction)
- [Install](#install)
- [Obtaining an Application Token](#obtaining-an-application-token)
  - [Register Public Key](#register-public-key)
  - [Get a Public Key](#get-a-public-key)
  - [Search Public Key](#search-public-key)
  - [Update Public Key](#update-public-key)
  - [Reset Public Key](#reset-public-key)
  - [Delete Public Key](#delete-public-key)
  - [Insert User Data](#insert-user-data)
  - [Delete User Data](#delete-user-data)
  - [Resend Confirmation for User Data](#resend-confirmation-for-user-data)

##Introduction
This tutorial explains how to use Public Keys Service with SDK library in .NET applications. 

##Install
Use the NuGet Package Manager (Tools -> Library Package Manager -> Package Manager Console) to install the Virgil.SDK.Keys package, running the command:

```
PM> Install-Package Virgil.SDK.Keys
```

##Obtaining an Application Token

First you must create a free Virgil Security developer account by signing up [here](https://virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://virgilsecurity.com/account/signin) and generate an app token for your application.

The app token provides authenticated secure access to Virgil’s Keys Service and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

Simply add your app token to the client constuctor.

```
var keysService = new KeysClient("{ YOUR_APPLICATION_TOKEN }");
```

##Register Public Key
The example below shows how to register a new **Public Key** for specified application. **User Data** identity is required to create a **Public Key**. To complete registration this **User Data** must be confirmed with verification code.

```csharp
var userData = new UserData
{
    Class = UserDataClass.UserId,
    Type = UserDataType.EmailId,
    Value = EmailId
};

var keysService = new KeysClient(AppToken);
var result = await keysService.PublicKeys.Create(publicKey, privateKey, userData);

// check an email box for confirmation code.

var userDataId = result.UserData.First().UserDataId;

var confirmationCode = "K5J1E4"; // confirmation code you received on email.
await keysService.UserData.Confirm(userDataId, confirmationCode, result.PublicKeyId, privateKey);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/RegisterPublicKey.cs)

##Get a Public Key
The example below shows how to get a **Public Key** by identifier. A **Public Key** identifier is assigned on registration stage and then can be used to access it's access.

```csharp
var keysService = new KeysClient(Constants.AppToken); // use your application access token
var publicKey = await keysService.PublicKeys.GetById(Constants.PublicKeyId);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/GetPublicKey.cs)

You also can get a **Public Key** with all **User Data** items by providing **Private Key** signature.

```csharp
var publicKey = await keysService.PublicKeys.SearchExtended(Constants.PublicKeyId, Constants.PrivateKey);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/GetPublicKeySigned.cs)


##Search Public Key
The example below shows how to search a **Public Key** by **User Data** identity. 

```csharp
var keysService = new KeysClient(Constants.AppToken); // use your application access token
var publicKey = await keysService.PublicKeys.Search(EmailId);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/SearchPublicKey.cs)

##Update Public Key
The example below shows how to update a **Public Key** key. You can use this method in case if your Private Key has been stolen.

```csharp
await keysService.PublicKeys.Update(Constants.PublicKeyId, newPublicKey, 
    newPrivateKey, Constants.PrivateKey);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/UpdatePublicKey.cs)

##Reset Public Key
The example below shows how to reset a **Public Key** key. You can use this method in case if you lost your Private Key.

```csharp
var resetResult = await keysService.PublicKeys.Reset(Constants.PublicKeyId, newPublicKey, newPrivateKey);

// once you reset the Public Key you need to confirm this action with all User Data 
// identities registered for this key.

var resetConfirmation = new PublicKeyOperationComfirmation
{
    ActionToken = resetResult.ActionToken,
    ConfirmationCodes = new[] { "F0G4T3", "D9S6J1" }
};

await keysService.PublicKeys.ConfirmReset(Constants.PublicKeyId, newPrivateKey, resetConfirmation);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/ResetPublicKey.cs)

##Delete Public Key
The example below shows how to delete a **Public Key** without **Private Key**.

```csharp
var keysService = new KeysClient(Constants.AppToken); // use your application access token
var resetResult = await keysService.PublicKeys.Delete(Constants.PublicKeyId);

// once you deleted the Public Key you need to confirm this action with all User Data 
// identities registered for this key.

var resetConfirmation = new PublicKeyOperationComfirmation
{
    ActionToken = resetResult.ActionToken,
    ConfirmationCodes = new[] { "F0G4T3", "D9S6J1" }
};

await keysService.PublicKeys.ConfirmDelete(Constants.PublicKeyId, resetConfirmation);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/DeletePublicKey.cs)

You also can delete **Public Key** with **Private Key** without confirmation.

```csharp
await keysService.PublicKeys.Delete(Constants.PublicKeyId, Constants.PrivateKey);
```

See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/DeletePublicKeySigned.cs)

##Insert User Data
The example below shows how to add **User Data** Indentity for existing **Public Key**.
```csharp

var userData = new UserData
{
    Class = UserDataClass.UserId, 
    Type = UserDataType.EmailId,
    Value = "virgil-demo+1@freeletter.me"
};

var insertResult = await keysService.UserData.Insert(userData, Constants.PublicKeyId, Constants.PrivateKey);

// check an email box for confirmation code.

var userDataId = insertResult.UserDataId;

var code = "R6H1E4"; // confirmation code you received on email.
await keysService.UserData.Confirm(userDataId, code, Constants.PublicKeyId, Constants.PrivateKey);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/InsertUserDataIdentity.cs)

Use method below to insert **User Data** Information.
```csharp

var userData = new UserData
{
    Class = UserDataClass.UserInfo,
    Type = UserDataType.FirstNameInfo,
    Value = "Denis"
};

await keysService.UserData.Insert(userData, Constants.PublicKeyId, Constants.PrivateKey);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/InsertUserDataInformation.cs)

##Delete User Data
The example below shows how to delete **User Data** from existing **Public Key** by **User Data** ID.
```csharp
await keysService.UserData.Delete(userData.UserDataId, Constants.PublicKeyId, Constants.PrivateKey);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/DeleteUserData.cs)

##Resend Confirmation for User Data
The example below shows how to re-send confirmation code to **User Data** Indentity.
```csharp
await keysService.UserData.ResendConfirmation(userData.UserDataId, Constants.PublicKeyId, 
    Constants.PrivateKey);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/ResendUserDataConfirmation.cs)

</div>
</div>

<div class="col-md-12 col-md-offset-2 hidden-md hidden-xs hidden-sm">
<div class="docs-menu" data-ui="affix-docs">
<div class="title">Quick Navigation</div>

<div class="menu-items-wrapper" data-ui="menu-items-wrapper"></div>
</div>
</div>
</div>
</div>
</section>
