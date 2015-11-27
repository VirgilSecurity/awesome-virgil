# Virgil Security Public Keys SDK

SDK for working with Virgil Security public keys service API.

You can use both promise or callback style for async function calls callbacks.

Promises provided by [bluebird](http://github.com).

- [Installation](#installation)
- [Usage](#usage)
    - [Create public key](#create-public-key)
    - [Confirm user data](#confirm-user-data)
    - [Get public key by id](#get-public-key-by-id)
    - [Update public key](#update-public-key)
    - [Resend user data confirmation](#resend-user-data-confirmation)
    - [Search for public key by identity](#search-for-public-key-by-identity)
    - [Update public key](#update-public-key)
    - [Delete public key](#delete-public-key)
    - [Reset public key](#reset-public-key)
    - [Confirm public key reset](#confirm-public-key-reset)
    - [Create user data](#create-user-data)
    - [Delete user data](#delete-user-data)
- [License](#license)
- [Contacts](#contacts)

## Installation

```
npm install virgil-public-keys
```

## Usage

To instantiate API client you should pass Virgil application token to constructor

```javascript
var VirgilPublicKeys = require('virgil-public-keys');
var keys = new VirgilPublicKeys('f5d3eddc719c3b6124ad00f0d8c17622');
```

## Create public key

Add your public key to Virgil Public Keys registry and retrieve `public_key_id`

```javascript
var Virgil = require('virgil-crypto');
var VirgilPublicKeys = require('virgil-public-keys');

// Generate new keypair
var keyPair = new Virgil.KeyPair();

// Init public keys API client
var keys = new VirgilPublicKeys('f5d3eddc719c3b6124ad00f0d8c17622');

// Private key is required in params to sign request body
// Private key isn't transferred with request
keys.createPublicKey({
	public_key: keyPair.publicKey,
	private_key: keyPair.privateKey,
	user_data: [{
		'class': VirgilPublicKeys.USER_DATA_CLASSES.USER_ID,
		'type': VirgilPublicKeys.USER_DATA_TYPES.EMAIL,
		'value': 'another-email@company.com'
	}]
}).then(console.log);
```

response:

```json
{
    "id": {
        "account_id": "0f4f3d4c-95ab-5e98-0ac2-e52fbb6380d4",
        "public_key_id": "920d7160-520c-e889-0462-42b1956712dc"
    },
    "public_key": "-----BEGIN PUBLIC KEY-----\nMIGbMBQGByqGSM49AgEGCSskAwMCCAEBDQOBggAEnVyVFlV80gypLISupiuzjX8R\n9JUgAxHlFPq5LV9IiqMaUoNBiqGw04QZlH4yKvRiVIgblslMLphuww7PyGj+/UK3\nlXUL3q/JW878j8kzwVTBj0TL8p8zJoP08bdN0hMrTAfFo7OV9ciG1UFnOKTIiEDF\nNDU3wa4cXVD98LZnv1k=\n-----END PUBLIC KEY-----\n",
    "user_data": [
        {
            "id": {
                "account_id": "0f4f3d4c-95ab-5e98-0ac2-e52fbb6380d4",
                "public_key_id": "920d7160-520c-e889-0462-42b1956712dc",
                "user_data_id": "353f3957-7386-b7f1-72df-15130823b8e6"
            },
            "class": "user_id",
            "type": "email",
            "value": "another-email@company.com",
            "is_confirmed": false
        }
    ]
}
```

After creating public key you must confirm it using specified user data identity.
E.g. when user data type is email apply confirmation code from email `confirmIdentity` method.

## Confirm user data

After recieving confirmation code you must confirm your identity to make your public key visible.

```javascript
// Use user_data_id returned after creating public key call

keys.confirmUserData({
	user_data_id: '353f3957-7386-b7f1-72df-15130823b8e6',
	confirmation_code: 'C7S7E6'
});
```

If operation completed successfully returns empty response otherwise appropriate exception will be thrown.

## Resend user data confirmation

```javascript
keys.resendUserDataConfirmation({
	private_key: privateKey,
	public_key_id: publicKeyId,
	user_data_id: userDataId
});
```

If operation completed successfully returns empty response otherwise appropriate exception will be thrown.

## Get public key by id

```javascript
keys.getPublicKey({
	public_key_id: '353f3957-7386-b7f1-72df-15130823b8e6'
});
```

response:

```json
{
    "id": {
        "account_id": "e9a2d80b-85e5-4931-6c87-74b117becd51",
        "public_key_id": "f9bd3cfa-22a9-9644-843b-b40b28e4f73c"
    },
    "public_key": "-----BEGIN PUBLIC KEY-----\nMIGbMBQGByqGSM49AgEGCSskAwMCCAEBDQOBggAEnVyVFlV80gypLISupiuzjX8R\n9JUgAxHlFPq5LV9IiqMaUoNBiqGw04QZlH4yKvRiVIgblslMLphuww7PyGj+/UK3\nlXUL3q/JW878j8kzwVTBj0TL8p8zJoP08bdN0hMrTAfFo7OV9ciG1UFnOKTIiEDF\nNDU3wa4cXVD98LZnv1k=\n-----END PUBLIC KEY-----\n"
}
```

## Search for public key by identity

```javascript
keys.findPublicKey({
	value: 'your-email@gmail.com'
});
```

response:

```json
{
    "id": {
        "account_id": "8422fc89-09b9-bed0-9964-56f2bdc4015d",
        "public_key_id": "acd1f831-3344-5a83-27b1-65c178581196"
    },
    "public_key": "-----BEGIN PUBLIC KEY-----\nMIGbMBQGByqGSM49AgEGCSskAwMCCAEBDQOBggAEnVyVFlV80gypLISupiuzjX8R\n9JUgAxHlFPq5LV9IiqMaUoNBiqGw04QZlH4yKvRiVIgblslMLphuww7PyGj+/UK3\nlXUL3q/JW878j8kzwVTBj0TL8p8zJoP08bdN0hMrTAfFo7OV9ciG1UFnOKTIiEDF\nNDU3wa4cXVD98LZnv1k=\n-----END PUBLIC KEY-----\n"
}

```

You can get extra public key informations such as user data if you passs private key to `findPublicKey` (to generate sign):

```javascript
keys.findPublicKey({
	value: 'your-email@gmail.com',
	private_key: yourPrivateKeyString
});
```

## Update public key

```javascript
keys.updatePublicKey({
	public_key_id: publicKeyId,
	private_key: currentPrivateKey,
	new_public_key: newPublicKey,
	new_private_key: newPrivateKey
});
```

response:

```json
{
	"id": {
		"account_id": "b78ad411-f0ec-f10f-5a9c-88df6db4f425",
		"public_key_id": "d0758dd4-8e52-d129-cf67-81339b9f4ad4"
	},
	"public_key": "-----BEGIN PUBLIC KEY-----\nMIGbMBQGByqGSM49AgEGCSskAwMCCAEBDQOBggAEXnrOy5tEJJl6RObtErp/fsC7\nmP7ZE4BJ+extnfWJ6Evuyn6LwEKwb3ZJSSdBx7e2aj0KqahhiEfq7jNRqQqTK6cO\nyipk7Qhkuxx0truXwc7Ezgk/lwBW3qKmHp6zIfyGUX5eIuAm5Wn7wlyJB3h1Owx2\n2BaN4N6xgp03hVqIryQ=\n-----END PUBLIC KEY-----\n"
}
```

## Delete public key

```javascript
keys.deletePublicKey({
	private_key: privateKey,
	public_key_id: publicKeyId
});
```

If operation completed successfully returns empty response otherwise appropriate exception will be thrown.

## Reset public key

This method purpose is to reset user’s public key’s data if user lost his
Private Key.

You should generate new keypair and pass it to reset

```javascript
keys.resetPublicKey({
	public_key_id: c.publicKeyId,
	public_key: newPublicKey,
	private_key: newPrivateKey
});
```

response:

```json
{
	"action_token": "250ae665-3596-6fb3-c9d0-f7a3f32e9795",
	"user_ids": [ "your....7@example.com", "second...@gmail.com" ]
}
```

After successful response you should confirm reset via `confirmPublicKeyReset` using `action_token` and confirmation codes from all of your identities.

## Confirm public key reset

You should gather confirmation codes from all of yours associated identities to confirm reset

```javascript
keys.confirmPublicKeyReset({
	public_key_id: publicKeyId,
	action_token: '9d4507c7-bf18-3ff1-db2a-afed2f94ea0e',
	confirmation_codes: ['X8J1P4']
});
```

response:

```json
{
	"id": {
		"account_id": "b78ad411-f0ec-f10f-5a9c-88df6db4f425",
		"public_key_id": "bf0d0dd3-a896-d20c-238a-2444a861f9cb"
	},
	"public_key": "-----BEGIN PUBLIC KEY-----\nMIGbMBQGByqGSM49AgEGCSskAwMCCAEBDQOBggAEVBanTXPCBNykzk5CsL7WQP8W\nlszq0dJAm9K9B5fmnfB7oQr9n1pBAmgpMWtKnWkjJIY6m1SaVDe68HAToXOA0BgD\nyI4wSaUtD6v9Qph7GbH+5vANgDzx0lhqdZNcdety0jIRyZyI2ob2iKMAOfnjoNEu\nT7wmsKpFkMgij29EVic=\n-----END PUBLIC KEY-----\n"
}
```

## Create user data

```javascript
keys.createUserData({
	private_key: privateKey,
	public_key_id: publicKeyId,
	'class': VirgilPublicKeys.USER_DATA_CLASSES.USER_ID,
	'type': VirgilPublicKeys.USER_DATA_TYPES.EMAIL,
	'value': 'your-new-email@gmail.com'
})
```

response:

```json
{
	"id": {
		"account_id": "b78ad411-f0ec-f10f-5a9c-88df6db4f425",
		"public_key_id": "d0758dd4-8e52-d129-cf67-81339b9f4ad4",
		"user_data_id": "1323b69b-dc32-0ce4-4508-9248bc913015"
	},
	"class": "user_id",
	"type": "email",
	"value": "your-new-email@gmail.com",
	"is_confirmed": false
}
```

## Delete user data

```javascript
keys.deleteUserData({
	private_key: privateKey,
	public_key_id: publicKeyId,
	user_data_id: userDataId
});
```

If operation completed successfully returns empty response otherwise appropriate exception will be thrown.
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
</div>
