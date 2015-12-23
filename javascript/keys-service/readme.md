
# JavaScript Keys Service

- [Obtaining an Application Token](#obtaining-an-application-token)
- [Register a New User on Virgil's Public Keys Service](#register-a-new-user-on-virgils-public-keys-service)
- [Get a User's Public Key from Virgil's Keys Service](#get-a-users-public-key-from-virgils-keys-service)
- [Search Public Key Data within Virgil's Keys Service](#search-public-key-data-within-virgils-keys-service)
- [Search Public Key Signed Data from the Keys Service](#search-public-key-signed-data-from-the-keys-service)
- [Update Public Key Data](#update-public-key-data)
- [Delete Public Key Data](#delete-public-key-data)
- [Reset a Public Key](#reset-a-public-key)
- [Confirm a Public Key](#confirm-a-public-key)
- [Create Public Key User Data](#create-public-key-user-data)
- [Delete User Data from the Public Key](#delete-user-data-from-the-public-key)
- [Confirm User Data](#confirm-user-data)
- [Resend a User's Confirmation Code](#resend-a-users-confirmation-code)

## Obtaining an Application Token

First you must create a free Virgil Security developer account by signing up [here](https://virgilsecurity.com/signup). Once you have your account you can [sign in](https://virgilsecurity.com/signin) and generate an app token for your application.

The app token provides authenticated secure access to Virgil’s Keys Service and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

Simply add your app token to the HTTP header for each request:

```
X-VIRGIL-APPLICATION-TOKEN: <YOUR_APPLICATION_TOKEN>
```

> Before using the services you have to obtain the Virgil Security Application Token, please follow the [Obtaining an Application Token](#obtaining-an-application-token) section above.

## Register a New User on Virgil's Public Keys Service

> A Virgil Account will be created when the first Public Key is uploaded. An application can only get information about Public Keys created for the current application. When the application uploads a new Public Key and there is an Account created for another application with the same UDID, the Public Key will be implicitly attached it to the existing Account instance.

```javascript
var Virgil = window.Virgil;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var USER_DATA_ITEMS = [
  {
    'class': 'user_id',
    type: 'email',
    value: 'example@domain.com'
  }
];
var KEY_PASSWORD = 'password';

var virgilCrypto = Virgil.Crypto;
// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);
var keys = virgilCrypto.generateKeys(KEY_PASSWORD);
var virgilPublicKey = new Virgil.PublicKey(keys.publicKey, USER_DATA_ITEMS);
var virgilPrivateKey = new Virgil.PrivateKey(keys.privateKey);

publicKeysService.addKey(virgilPublicKey, virgilPrivateKey.KeyBase64, KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Get a User's Public Key from Virgil's Keys Service

```javascript
var Virgil = window.Virgil;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';

// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);

publicKeysService.getKey(PUBLIC_KEY_ID).then(
  function(resData) {
    console.log(new Virgil.PublicKey.fromJS(resData));
  },
  function(error) {
    console.error(error);
  }
);
```

## Search Public Key Data within Virgil's Keys Service

```javascript
var Virgil = window.Virgil;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var USER_DATA_VALUE = 'example@domain.com';

// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);

publicKeysService.searchKey(USER_DATA_VALUE).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Search Public Key Signed Data from the Keys Service

> If a signed version of the action is used, the Public Key will be returned with all of the user_data items for this Public Key. Where:

> unsigned version: ```.searchKey(<USER_DATA_VALUE>)```

> signed version: ```.searchKey(<USER_DATA_VALUE>, <VIRGIL_PUBLIC_KEY>, <VIRGIL_PRIVATE_KEY>, <VIRGIL_PRIVATE_KEY_PASSWORD>)```

```javascript
var Virgil = window.Virgil;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var USER_DATA_VALUE = 'example@domain.com';
var PUBLIC_KEY_ID = '00ab82f3-56e5-0fd6-c608-f4da9ebc791c';
var PRIVATE_KEY = '<PRIVATE_KEY_CONTENT>';
var KEY_PASSWORD = 'password';

var virgilPrivateKey = new Virgil.PrivateKey(PRIVATE_KEY);
// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);

// KEY_PASSWORD an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
publicKeysService.searchKey(USER_DATA_VALUE, PUBLIC_KEY_ID, virgilPrivateKey.KeyBase64, KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Update Public Key Data

> Public Key modification takes place immediately after action invocation.

```javascript
var Virgil = window.Virgil;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '47a44580-f501-ea17-3581-7524d46e1af5';
var CURRENT_PRIVATE_KEY = '<PRIVATE_KEY_CONTENT>';
var KEY_PASSWORD_CURRENT = 'password';
var KEY_PASSWORD_NEW = 'password_new';

var virgilCrypto = Virgil.Crypto;
var keysNew = virgilCrypto.generateKeys(KEY_PASSWORD_NEW);
var virgilPrivateKeyCurrent = new Virgil.PrivateKey(CURRENT_PRIVATE_KEY);
var virgilPrivateKeyNew = new Virgil.PrivateKey(keysNew.privateKey);
// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);

// KEY_PASSWORD_CURRENT, KEY_PASSWORD_NEW an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
publicKeysService.updateKey(
  PUBLIC_KEY_ID, virgilPrivateKeyCurrent.KeyBase64,
  btoa(keysNew.publicKey), virgilPrivateKeyNew.KeyBase64,
  KEY_PASSWORD_CURRENT, KEY_PASSWORD_NEW
).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);

```

## Delete Public Key Data

> If a signed version of the action is used, the Public Key will be removed immediately without any confirmation.
  
> If an unsigned version of the action is used, confirmation is required. 
> The action will return an action_token response object and will send confirmation tokens to all of the Public Key’s confirmed UDIDs. 
> The list of masked UDID’s will be returned in user_ids response object property. 
> To commit a Public Key remove call persistKey() action with action_token value and the list of confirmation codes.

```javascript
var Virgil = window.Virgil;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '423ee230-3b5d-ffb3-b661-349923d8a509';
var PRIVATE_KEY = '<PRIVATE_KEY_CONTENT>';
var KEY_PASSWORD = 'password';

var virgilCrypto = Virgil.Crypto;
var virgilPrivateKey = new Virgil.PrivateKey(PRIVATE_KEY);
// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);

// KEY_PASSWORD an optional argument,
// it's needed only if your key was generated using the appropriate password
publicKeysService.deleteKey(PUBLIC_KEY_ID, virgilPrivateKey.KeyBase64, KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Reset a Public Key

> After action invocation the user will receive the confirmation tokens on all his confirmed UDIDs. 
> The Public Key data won’t be updated until the call persistKey() action is invoked with the token value from this step and confirmation codes sent to UDIDs. 
> The list of UDIDs used as confirmation tokens recipients will be listed as user_ids response parameters.

```javascript
var Virgil = window.Virgil;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '2f1eb567-a137-fc88-8268-d9ad208f8227';
var KEY_PASSWORD_NEW = 'password';

var virgilCrypto = Virgil.Crypto;
var keysNew = virgilCrypto.generateKeys(KEY_PASSWORD_NEW);
// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);

// KEY_PASSWORD_CURRENT an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
publicKeysService.resetKey(
  PUBLIC_KEY_ID,
  btoa(keysNew.publicKey),
  btoa(keysNew.privateKey),
  KEY_PASSWORD_NEW
).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Confirm a Public Key

> Confirm a Public Key’s data if the X-VIRGILREQUEST-SIGN HTTP header was omitted on ```deleteKey()``` action or ```resetKey()``` action was invoked.

> The confirmation code will be sent to the email/phone etc. Usually the client application should provide opportunities for input appropriate confirmation code.

```javascript
var Virgil = window.Virgil;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '9fdca3db-f412-9ce4-4dce-cd7c8ebe8cbb';
var ACTION_TOKEN = '31b4be12-9021-76bc-246d-5ecbd7a22350';
var CONFIRMATION_CODES = ['Y4A6D9'];

// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);

publicKeysService.persistKey(PUBLIC_KEY_ID, ACTION_TOKEN, CONFIRMATION_CODES).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Create Public Key User Data

> Append UDIDs and UDINFOs to Public Keys for the current application.

```javascript
var Virgil = window.Virgil;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '17177252-58c0-1cd1-afae-1a435275f85c';
var USER_DATA_TYPE = Virgil.UserDataTypeEnum.Email;
var USER_DATA_CLASS = Virgil.UserDataClassEnum.UserId;
var USER_DATA_VALUE = 'example@domain.com';
var PRIVATE_KEY = '<PRIVATE_KEY_CONTENT>';
var KEY_PASSWORD = 'password';

// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);
var userData = new Virgil.UserData(USER_DATA_TYPE, USER_DATA_CLASS, USER_DATA_VALUE);
var virgilPrivateKey = new Virgil.PrivateKey(PRIVATE_KEY);

// KEY_PASSWORD an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
publicKeysService.addUserData(userData, PUBLIC_KEY_ID, virgilPrivateKey.KeyBase64, KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Delete User Data from the Public Key

```javascript
var Virgil = window.Virgil;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '9fdca3db-f412-9ce4-4dce-cd7c8ebe8cbb';
var USER_DATA_ID = '3f8cb770-1869-b3d7-ff8f-a4a9266828e5';
var PRIVATE_KEY = '<PRIVATE_KEY_CONTENT>';
var KEY_PASSWORD = 'password';

// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);
var virgilPrivateKey = new Virgil.PrivateKey(PRIVATE_KEY);

// KEY_PASSWORD an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
publicKeysService.deleteUserData(USER_DATA_ID, PUBLIC_KEY_ID, virgilPrivateKey, KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Confirm User Data

```javascript
var Virgil = window.Virgil;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var USER_DATA_ID = '3f8cb770-1869-b3d7-ff8f-a4a9266828e5';
var CONFIRMATION_CODE = 'Y4A6D9';

// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);

publicKeysService.persistUserData(USER_DATA_ID, CONFIRMATION_CODE).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Resend a User's Confirmation Code

```javascript
var Virgil = window.Virgil;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '9fdca3db-f412-9ce4-4dce-cd7c8ebe8cbb';
var USER_DATA_ID = '3f8cb770-1869-b3d7-ff8f-a4a9266828e5';
var PRIVATE_KEY = '<PRIVATE_KEY_CONTENT>';
var KEY_PASSWORD = 'password';

// application token must be passed into the service's constructor
var publicKeysService = new Virgil.PublicKeysService(APP_TOKEN);
var virgilPrivateKey = new Virgil.PrivateKey(PRIVATE_KEY);

// KEY_PASSWORD an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
publicKeysService.resendUserDataConfirmationCode(USER_DATA_ID, PUBLIC_KEY_ID, virgilPrivateKey.KeyBase64, KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```
</div>
</div>

<div class="col-md-12 col-md-offset-2 hidden-md hidden-xs hidden-sm">
<div class="docs-menu" data-ui="affix-docs">

<div class="menu-items-wrapper" data-ui="menu-items-wrapper"> </div>
</div>
</div>
</div>
</div>
</section>
