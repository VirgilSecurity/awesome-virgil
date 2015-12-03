
# C++ Keys Service SDK

- [Obtain Application Token](#obtain-application-token)
- [Register New User](#register-new-user)
- [Get User's Public Key](#get-user-public-key)
- [Search Public Key](#search-public-key)
- [Search Public Key With Data](#search-public-key-with-data)
- [Update Public Key Data](#update-public-key-data)
- [Delete Public Key Data](#delete-public-key-data)
- [Reset Public Key](#reset-public-key)
- [Confirm Delete Public Key operation](#confirm-public-key-delete)
- [Confirm Reset Public Key operation](#confirm-public-key-reset)
- [Create Public Key User Data](#create-public-key-user-data)
- [Delete User Data from the Public Key](#delete-user-data)
- [Confirm User Data](#confirm-user-data)
- [Resend User's Confirmation Code](#resend-confirmation-code)


## Obtain Application Token

First you must create a free Virgil Security developer account by [sign up](https://virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://virgilsecurity.com/account/signin) and generate an app token for your application.

The app token provides authenticated secure access to Virgil’s Keys Service and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

Simply add your app token to the HTTP header for each request:

```
X-VIRGIL-APPLICATION-TOKEN: <YOUR_APPLICATION_TOKEN>
```

## Register a New User \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/public_key_add.cxx)\]

A Virgil Account will be created when the first Public Key is uploaded. An application can only get information about Public Keys created for the current application. When the application uploads a new Public Key and there is an Account created for another application with the same UDID, the Public Key will be implicitly attached it to the existing Account instance.

Once you've created a public key you may push it to Virgil’s Keys Service. This will allow other users to send you encrypted data using your public key.

```cpp
UserData userData = UserData::email("mail@server.com");
Credentials credentials(privateKey);
KeysClient keysClient("{Application Token}");
PublicKey virgilPublicKey = keysClient.publicKey().add(publicKey, {userData}, credentials);
```

If registration successfull confirmation code will be sent to the user email. To confirm, you can use - [Confirm User Data.](#confirm-user-data)


## Get User's Public Key \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/public_key_get.cxx)\]

```cpp
KeysClient keysClient("{Application Token}");
PublicKey publicKey = keysClient.publicKey().get(publicKeyId);
```


## Search Public Key \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/public_key_grab.cxx)\]

```cpp
KeysClient keysClient("{Application Token}");
PublicKey publicKey = keysClient.publicKey().grab("mail@server.com");
```


## Search Public Key With Data \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/public_key_grab_signed.cxx)\]

If a signed version of the action is used, the Public Key will be returned with all of the `user_data` items for this Public Key.

```cpp
CredentialsExt credentialsExt(publicKeyId, privateKey);
KeysClient keysClient("{Application Token}");
PublicKey publicKey = keysClient.publicKey().grab(credentialsExt);
```


## Update Public Key Data \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/public_key_update.cxx)\]

Public Key modification takes place immediately after action invocation.

```cpp
Credentials newKeyCredentials(newPrivateKey);
CredentialsExt oldKeyCredentialsExt(oldPublicKey.publicKeyId(), oldPrivateKey);

KeysClient keysClient("{Application Token}");
keysClient.publicKey().update(newPublicKey, newKeyCredentials, oldKeyCredentialsExt);
```

## Delete Public Key Data

If a signed version of the action is used, the Public Key will be removed immediately without any confirmation.
If an unsigned version of the action is used, confirmation is required.
The action will return an `action_token` response object and will send confirmation tokens to all of the Public Key’s confirmed UDIDs.
The list of masked UDID’s will be returned in user_ids response object property.
To commit a Public Key remove call [Confirm Delete Public Key operation](#confirm-public-key-delete) action with `action_token` value and the list of confirmation codes.

### Unsigned version \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/public_key_delete.cxx)\]
```cpp
KeysClient keysClient("{Application Token}");
std::string confirmInfo = keysClient.publicKey().del(publicKey.publicKeyId());
```

### Signed version \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/public_key_delete_signed.cxx)\]
```cpp
CredentialsExt credentialsExt(publicKey.publicKeyId(), privateKey);
KeysClient keysClient("{Application Token}");
keysClient.publicKey().del(credentialsExt);
```

## Reset Public Key \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/public_key_reset.cxx)\]

After action invocation the user will receive the confirmation tokens on all his confirmed UDIDs.
The Public Key data won’t be updated until the call [Confirm Reset Public Key operation](#confirm-public-key-reset) is invoked with the token value from this step and confirmation codes sent to UDIDs. The list of UDIDs used as confirmation tokens will be listed as `user_ids` parameter of the response.

```cpp
Credentials newKeyCredentials(newPrivateKey);
KeysClient keysClient("{Application Token}");
std::string confirmInfo = keysClient.publicKey().reset(oldPublicKey.publicKeyId(),
        newPublicKey, newKeyCredentials);
```

## Confirm Delete Public Key operation \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/public_key_confirm_delete.cxx)\]

Send confirmation code to the Virgil Keys service to finish Public Key delete operation.

```cpp
KeysClient keysClient("{Application Token}");
keysClient.publicKey().confirmDel(publicKey.publicKeyId(),
        <action_token>, {<confirmation_codes>});
```

## Confirm Reset Public Key operation \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/public_key_confirm_reset.cxx)\]

Send confirmation code to the Virgil Keys service to finish Public Key reset operation.

```cpp
KeysClient keysClient("{Application Token}");
Credentials credentials(privateKey);
keysClient.publicKey().confirmReset(oldPublicKey.publicKeyId(), credentials,
        <action_token>, {<confirmation_codes>});
```

## Create Public Key User Data \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/user_data_add.cxx)\]

Add user data, i.e. email. If registration successfull confirmation code will be sent to the user.
To confirm user data use [Confirm User Data](#confirm-user-data).

```cpp
KeysClient keysClient("{Application Token}");
UserData userData = UserData::email("newmail@server.com");
CredentialsExt credentialsExt(publicKey.publicKeyId(), privateKey);
UserData userDataResponse = keysClient.userData().add(userData, credentialsExt);
```


## Delete User Data from the Public Key \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/user_data_del.cxx)\]

Remove user data item from the associated Public Key.

```cpp
KeysClient keysClient("{Application Token}");
CredentialsExt credentialsExt(publicKey.publicKeyId(), privateKey);
keysClient.userData().del(<user_data_id>, credentialsExt);
```


## Confirm User Data \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/user_data_confirm.cxx)\]

Send confirmation code to the Virgil Keys service. Confirmation code provided for user after:

  * [Create Public Key User Data](#create-public-key-user-data)
  * [Register a New User](#register-new-user)

```cpp
KeysClient keysClient("{Application Token}");
keysClient.userData().confirm(<user_data_id>, <confirmation_code>);
```


## Resend User's Confirmation Code \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/user_data_resend_confirmation.cxx)\]
Resend confirmation code to the user for given user's identifier.

```cpp
KeysClient keysClient("{Application Token}");
CredentialsExt credentialsExt(publicKey.publicKeyId(), privateKey);
keysClient.userData().resendConfirmation(<user_data_id>, credentialsExt);
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
