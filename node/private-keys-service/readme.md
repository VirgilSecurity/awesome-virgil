
# Virgil Security Private Keys SDK

SDK for working with Virgil Security private keys service API.

You can use both promise or callback style for async function calls callbacks.

Promises provided by [bluebird](https://github.com/petkaantonov/bluebird).

- [Installation](#installation)
- [Usage](#usage)
    - [Create container](#create-container)
    - [Get auth token](#get-auth-token)
    - [Update container](#update-container)
    - [Get container info](#get-container-info)
    - [Reset container password](#reset-container-password)
    - [Confirm container password reset](#confirm-container-password-reset)
    - [Delete container](#delete-container)
    - [Create private key](#create-private-key)
    - [Get private key](#get-private-key)
    - [Delete private key](#delete-private-key)

## Installation

```
npm install virgil-private-keys
```

#### Before you start

1. Make sure that you have registered and confirmed account under Public Key service.
2. Make sure that you have Public Private Key pair and you have already uploaded Public Key to the Public Key service.
3. Make sure that you have Private Key under your local machine.
4. Make sure that you have registered Application under Virgil Security, Inc.

## Usage

To instantiate API client you should pass Virgil application token to constructor

```javascript
var VirgilPrivateKeys = require('virgil-private-keys');
var keys = new VirgilPrivateKeys('f5d3eddc719c3b6124ad00f0d8c17622');
```

## Create container

Container is used to keep all of your private keys.

```javascript
var Virgil = require('virgil-crypto');
var VirgilPrivateKeys = require('virgil-private-keys');

var keys = new VirgilPrivateKeys('f5d3eddc719c3b6124ad00f0d8c17622');

keys.createContainer({
	container_type: VirgilPrivateKeys.CONTAINER_TYPES.EASY,
	password: 'your password',
	private_key: yourPrivateKeyString,
	public_key_id: yourVirgilPublicKeyId
});
```

response:

```json
{
    "container_type": "easy",
    "data": []
}
```

## Get auth token

Service will create **`Authentication token`** that will be available during the 60 minutes after creation. During this time service will automatically prolong life time of the token in case if **`Authentication token`** widely used so don't need to prolong it manually. In case when **`Authentication token`** is used after 60 minutes of life time, service will throw the appropriate error.

> **Note:**

> Before login make sure that you have already created [Container Object](#create-container) under Private Key service.

> Use for `user_data.value` parameter the same value as you have registered under Public Keys service. This account has to be confirmed under Public Key service.

```javascript
keys.getAuthToken({
	password: 'password',
	user_data: {
		'class': VirgilPrivateKeys.USER_DATA_CLASSES.USER_ID,
		'type': VirgilPrivateKeys.USER_DATA_TYPES.EMAIL,
		'value': 'your-email@example.com'
	}
});
```

response:

```json
{
    "auth_token": "ec7af0bbe2ebaeb22b1edffd9be890cf950b4f30842d09bc441a8dcacc4317e4"
}
```

## Update container

```javascript
keys.updateContainer({
	container_type: VirgilKeys.CONTAINER_TYPES.NORMAL,
	password: 'new password',
	private_key: privateKey,
	public_key_id: publicKeyId,
	auth_token: 'ec7af0bbe2ebaeb22b1edffd9be890cf950b4f30842d09bc441a8dcacc4317e4'
});
```

If operation completed successfully returns empty response otherwise appropriate exception will be thrown.

## Get container info

```javascript
keys.getContainerInfo({
	public_key_id: publicKeyId,
	auth_token: yourAuthToken
});
```

response:

```json
{
    "container_type": "normal"
}
```

## Reset container password

> **Note:**

> You will receive reset token in case of `container_type` equal 'easy'.

> `user_data.value` - use for this request parameter the same value as you have registered under Public Keys service. This account has to be confirmed under Public Key service.

```javascript
keys.resetContainerPassword({
	'user_data': {
		'class': VirgilPrivateKeys.USER_DATA_CLASSES.USER_ID,
		'type': VirgilPrivateKeys.USER_DATA_TYPES.EMAIL,
		'value': 'your-email@example.com'
	},
	'new_password': 'password'
});
```

If operation completed successfully returns empty response otherwise appropriate exception will be thrown.

## Confirm container password reset

```javascript
keys.confirmContainerPassword({
	token: 'B2I4Z4'
});
```

If operation completed successfully returns empty response otherwise appropriate exception will be thrown.

## Delete container

Delete container object by public key id.

```javascript
keys.deleteContainer({
	private_key: privateKey,
	public_key_id: publicKeyId,
	auth_token: authToken
});
```

If operation completed successfully returns empty response otherwise appropriate exception will be thrown.

## Create private key

```javascript
keys.createPrivateKey({
	private_key: privateKey,
	private_key_encrypt_password: 'password to encrypt private key on client-side',
	public_key_id: publicKeyId,
	auth_token: authToken
});
```

If operation completed successfully returns empty response otherwise appropriate exception will be thrown.

## Get private key

Use password you used for private key create operation.

```javascript
keys.getPrivateKey({
	public_key_id: publicKeyId,
	auth_token: authToken,
	private_key_decrypt_password: 'password'
});
```

response:

```json
{
    "public_key_id": "144aa369-4d2d-c808-04cf-fdaec9572557",
    "private_key": "-----BEGIN EC PRIVATE KEY-----\nMIHaAgEBBEBvdZWzkPnDatQ8xkxD5MdzMBJ4+fc7pfL5oWJ5jAWya+tiRzzsPC01\nbbSUe5L3wu868VTin4aVbN3OhKZ9lZK0oAsGCSskAwMCCAEBDaGBhQOBggAEF8JK\n+qop2/QTHZuE4oDgvkZScpGkF9nlpaGY7aDCAhwMoVJz0f+xbz6jfWbpqyCIyl4w\nmb8hm4UwnSCLvKKYjpq7ctM1/xBQWdZBFJGfwrdOAUVKyJ5kCQVwJJ2JbNYMEs8c\n8nE1PuqAyIW4d3FPOUEBwMcvQgYH2ykQppXowO8=\n-----END EC PRIVATE KEY-----\n"
}
```

## Delete private key

```javascript
keys.deletePrivateKey({
	private_key: privateKey,
	public_key_id: publicKeyId,
	auth_token: authToken
});
```

If operation completed successfully returns empty response otherwise appropriate exception will be thrown.
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
