
# С++ Private Keys Service SDK

- [Obtain Application Token](#obtain-application-token)
- [Create Container](#create-container)
- [Authenticate Session](#authenticate-session)
- [Get Container](#get-container)
- [Delete Container](#delete-container)
- [Update Container](#update-container)
- [Reset Container Password](#reset-container-password)
- [Persist Container](#persist-container)
- [Push Private Key to the Container](#push-private-key)
- [Get Private Key](#get-private-key)
- [Delete Private Key](#delete-private-key)


## Obtain Application Token

First you must create a free Virgil Security developer account by [sign up](https://virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://virgilsecurity.com/account/signin) and generate an app token for your application.

The app token provides authenticated secure access to Virgil’s Keys Service and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

Simply add your app token to the HTTP header for each request:

```
X-VIRGIL-APPLICATION-TOKEN: <YOUR_APPLICATION_TOKEN>
```

## Prerequisite

1. Obtain the Virgil Security Application Token, please follow the [Obtain Application Token](#obtain-application-token) section above.
1. Create an Application under [Virgil Security, Inc](https://virgilsecurity.com/dashboard).
1. Create Private and Public Keys on your local machine.
1. Create and confirm your account in the Public Keys service.
1. Load a Public Key to the Public Key service.
1. Use the same email that you used for the Public Key service.


## Create Container \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/container_create.cxx)\]

Create container for storing Private Keys on the Virgil Private Keys Service.
Container type:
* `easy` - instructs Private Keys Service to use container's password for Private Keys encryption, so it can be reset if user forget it.
* `normal` - instructs Private Keys Service not to use container's password for Private Keys encryption, so user is responsible for Private Key password, and it can not be reset within Virgil Private Keys Service.

```cpp
PrivateKeysClient privateKeysClient("{Application Token}");
CredentialsExt credentialsExt(publicKeyId, privateKey);
ContainerType CONTAINER_TYPE = ContainerType::Easy;
std::string CONTAINER_PASSWORD = "123456789";
privateKeysClient.container().create(credentialsExt, CONTAINER_TYPE, CONTAINER_PASSWORD);
```


## Authenticate Session \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/authenticate.cxx)\]

Service will create **Authentication token** that will be available during the 60 minutes after creation. During this time service will automatically prolong life time of the token in case if **Authentication token** widely used so don't need to prolong it manually. In case when **Authentication token** is used after 60 minutes of life time, service will throw the appropriate error.

> Note, before login make sure that you have already [created Container](#create-container) under Private Key service. Use for user_data.value parameter the same value as you have registered under Public Keys service. This account has to be confirmed under Public Key service.

**Authentication token** is used in the following endpoints:

1. [Get Container](#get-container)
1. [Delete Container](#delete-container)
1. [Update Container](#update-container)
1. [Push Private Key to the Container](#push-private-key)
1. [Get Private Key](#get-private-key)
1. [Delete Private Key](#delete-private-key)

```cpp
PrivateKeysClient privateKeysClient("{Application Token}");
UserData userData = UserData::email(USER_EMAIL);
std::string authenticationToken = privateKeysClient.auth().getAuthToken(userData, CONTAINER_PASSWORD);
```


## Get Container \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/container_info_get.cxx)\]

Return container type. It can be `easy` or `normal`.

```cpp
PrivateKeysClient privateKeysClient("{Application Token}");
UserData userData = UserData::email(USER_EMAIL);
privateKeysClient.authenticate(userData, CONTAINER_PASSWORD);

// if the token has been received
// std::string authenticationToken = "";
// privateKeysClient.authenticate(authenticationToken);

ContainerType containerType = privateKeysClient.container().getDetails(publicKeyId);
```


## Delete Container \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/container_delete.cxx)\]

Delete existing container from the Virgil Private Key service.

```cpp
PrivateKeysClient privateKeysClient("{Application Token}");
UserData userData = UserData::email(USER_EMAIL);
privateKeysClient.authenticate(userData, CONTAINER_PASSWORD);

// if the token has been received
// std::string authenticationToken = "";
// privateKeysClient.authenticate(authenticationToken);

CredentialsExt credentialsExt(publicKeyId, privateKey);
privateKeysClient.container().del(credentialsExt);
```


## Update Container \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/container_update.cxx)\]

By invoking this method you can change the Container Password

```cpp
PrivateKeysClient privateKeysClient("{Application Token}");
UserData userData = UserData::email(USER_EMAIL);
privateKeysClient.authenticate(userData, CONTAINER_PASSWORD);

// if the token has been received
// std::string authenticationToken = "";
// privateKeysClient.authenticate(authenticationToken);

CredentialsExt credentialsExt(publicKey.publicKeyId(), privateKey);
privateKeysClient.container().update(credentials, CONTAINER_NEW_PASSWORD);
```

## Reset Container Password \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/container_reset_password.cxx)\]

A user can reset their Private Key password if the Container Type equals `easy`.
If the Container Type equals `normal`, the Private Key will be stored in its original form.

```cpp
PrivateKeysClient privateKeysClient("{Application Token}");
UserData userData = UserData::email(USER_EMAIL);
privateKeysClient.container().resetPassword(userData, CONTAINER_NEW_PASSWORD);
```


## Persist Container \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/container_confirm.cxx)\]

Confirm password reset action and re-encrypt Private Key data with the new password if
container type is `easy`.

The token generated during the container reset invocation only lives for 60 minutes.

```cpp
PrivateKeysClient privateKeysClient("{Application Token}");
privateKeysClient.container().confirm(<confirmation_token>);
```


## Push Private Key to the Container \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/private_key_add.cxx)\]

Load an existing Private Key into the Private Keys service and associate it with the existing Container.

Prerequisite:

1. Create container, see [Create Container](#create-container).
1. Get authentication token, see [Authenticate Session](#authenticate-session).

```cpp
PrivateKeysClient privateKeysClient("{Application Token}");
UserData userData = UserData::email(USER_EMAIL);
privateKeysClient.authenticate(userData, CONTAINER_PASSWORD);

// if the token has been received
// std::string authenticationToken = "";
// privateKeysClient.authenticate(authenticationToken);

CredentialsExt credentials(publicKeyId, privateKey);
privateKeysClient.privateKey().add(credentials, CONTAINER_PASSWORD);
```


## Get Private Key \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/private_key_get.cxx)\]

Get user's Private Key from the Virgil Private Keys service.

```cpp
PrivateKeysClient privateKeysClient("{Application Token}");
UserData userData = UserData::email(USER_EMAIL);
privateKeysClient.authenticate(userData, CONTAINER_PASSWORD);

// if the token has been received
// std::string authenticationToken = "";
// privateKeysClient.authenticate(authenticationToken);

PrivateKey privateKey = privateKeysClient.privateKey().get(publicKeyId, CONTAINER_PASSWORD);
```


## Delete Private Key \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/private_key_delete.cxx)\]

Delete a Private Key. First it will be disconnected from the Container and then deleted from the Private Key Service.

```cpp
PrivateKeysClient privateKeysClient("{Application Token}");
UserData userData = UserData::email(USER_EMAIL);
privateKeysClient.authenticate(userData, CONTAINER_PASSWORD);

// if the token has been received
// std::string authenticationToken = "";
// privateKeysClient.authenticate(authenticationToken);

CredentialsExt credentialsExt(publicKey.publicKeyId(), privateKey);
privateKeysClient.container().del(credentialsExt);
```

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
