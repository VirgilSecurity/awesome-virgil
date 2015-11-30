
# Tutorial C#/.NET Private Keys SDK 

- [Introduction](#introduction)
- [Install](#install)
- [Obtaining an Application Token](#obtaining-an-application-token)
  - [Container Initialization](#container-initialization)
  - [Get Container Type](#get-container-type)
  - [Delete Container](#delete-container)
  - [Reset Container's Password](#reset-container-password)
  - [Get Private Key](#get-private-key)
  - [Add Private Key to Container](#add-private-key-to-container)
  - [Delete Private Key from Container](#delete-private-key-from-container)

##Introduction
This tutorial explains how to use Private Keys Service with SDK library in .NET applications. 

##Install
Use the NuGet Package Manager (Tools -> Library Package Manager -> Package Manager Console) to install the Virgil.SDK.PrivateKeys package, running the command:

```
PM> Install-Package Virgil.SDK.PrivateKeys
```

##Obtaining an Application Token

First you must create a free Virgil Security developer account by signing up [here](https://virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://virgilsecurity.com/account/signin) and generate an app token for your application.

The app token provides authenticated secure access to Virgil’s Keys Service and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

Simply add your app token to SDK client constructor.

```
var keyringClient = new KeyringClient("{ YOUR_APPLICATION_TOKEN }");
```

##Container Initialization
Initializes an easy private keys container, all private keys encrypted with account password, and server can decrypt them in case you forget container password.

```csharp
await keyringClient.Container.Initialize(ContainerType.Easy, Constants.PublicKeyId, 
  Constants.PrivateKey, password);
```

Initializes a normal private keys container, all private keys encrypted on the client side and server can't decrypt them.

```csharp
await keyringClient.Container.Initialize(ContainerType.Normal, Constants.PublicKeyId, 
  Constants.PrivateKey, password);
```

See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/InitializeContainerForPrivateKeys.cs)

##Get Container Type
The example below shows how to get the Container Type.

```csharp
var containerType = await keyringClient.Container.GetContainerType({ PUBLIC_KEY_ID });
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/GetContainerType.cs)

##Delete Container
The example below shows how to delete Container with all Private Keys. 

```csharp
await keyringClient.Container.Remove({ PUBLIC_KEY_ID }, privateKey);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/DeleteContainerWithPrivateKeys.cs)

##Reset Container Password
The example below shows how to reset a password for Easy container.

```csharp
await keyringClient.Container.ResetPassword(userId, newPassword);

var confirmationCode = "G7L1T4"; // confirmation code you received on email.
await keyringClient.Container.Confirm(confirmationCode);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/ResetContainerPassword.cs)

##Get Private Key
The example below shows how to get private key form Private Keys service.

```csharp
var privateKey = await keyringClient.PrivateKeys.Get(publicKey.PublicKeyId);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/GetPrivateKey.cs)

##Add Private Key to Container
The example below shows how to add a **Private Key** to existing Container.

```csharp
await keyringClient.PrivateKeys.Add(createdPublicKey.PublicKeyId, privateKey);
```
See full example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/SDK/AddPrivateKeyToExistingContainer.cs)

##Delete Private Key from Container
The example below shows how to delete **Private Key** from existing **Container**.
```csharp
await keyringClient.PrivateKeys.Remove(publicKey.PublicKeyId, privateKey.Key);
```

See full example [here...](https://github.com/VirgilSecurity/virgil-sdk-net/blob/master/Examples/SDK/DeletePrivateKey.cs)
</div>
</div>

<div class="col-md-12 col-md-offset-2 hidden-md hidden-xs hidden-sm">
<div class="docs-menu" data-ui="affix-docs">

<div class="menu-items-wrapper" data-ui="menu-items-wrapper"></div>
</div>
</div>
</div>
</div>
</section>
