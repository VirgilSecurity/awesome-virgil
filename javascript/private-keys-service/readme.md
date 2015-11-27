# JavaScript Private Keys Service

- [Obtaining an Application Token](#obtaining-an-application-token)
- [Create a New Container Object](#create-a-new-container-object)
- [Get Container Object](#get-container-object)
- [Delete Container Object](#delete-container-object)
- [Update Container Object](#update-container-object)
- [Reset the Container Password](#reset-the-container-password)
- [Persist Container Object](#persist-container-object)
- [Create a Private Key inside the Container Object](#create-a-private-key-inside-the-container-object)
- [Get Private Key Object](#get-private-key-object)
- [Delete Private Key Object](#delete-private-key-object)

## Obtaining an Application Token

First you must create a free Virgil Security developer account by signing up [here](https://virgilsecurity.com/signup). Once you have your account you can [sign in](https://virgilsecurity.com/signin) and generate an app token for your application.

The app token provides authenticated secure access to Virgil’s Keys Service and is passed with each API call. The app token also allows the API to associate your app’s requests with your Virgil Security developer account.

Simply add your app token to the HTTP header for each request:

```
X-VIRGIL-APPLICATION-TOKEN: <YOUR_APPLICATION_TOKEN>
```

> Create an Application under [Virgil Security, Inc](https://virgilsecurity.com/dashboard).

> Obtain the Virgil Security Application Token, please follow the [Obtaining an Application Token](#obtaining-an-application-token) section above.

> Create Private and Public Keys on your local machine.

> Create and confirm your account in the Public Keys service.

> Load a Public Key to the Public Key service.

> Use the same email that you used for the Public Key service.

## Create a New Container Object

```javascript
var VirgilSDK = window.VirgilSDK;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = 'd8e387bd-b8d9-593f-518f-47ef44eab151';
var PRIVATE_KEY_BASE64 = '<PRIVATE_KEY_IN_BASE64>';
var KEY_PASSWORD = 'password';
var CONTAINER_TYPE = VirgilSDK.PrivateKeysContainerTypeEnum.Easy;
var CONTAINER_PASSWORD = 'password';

var container = new VirgilSDK.PrivateKeysContainer(CONTAINER_TYPE, CONTAINER_PASSWORD);
// application token must be passed into the service's constructor
var privateKeysService = new VirgilSDK.PrivateKeysService(APP_TOKEN);

// KEY_PASSWORD an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
privateKeysService.addContainer(container, PUBLIC_KEY_ID, PRIVATE_KEY_BASE64, KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Get Container Object

```javascript
var VirgilSDK = window.VirgilSDK;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = 'd8e387bd-b8d9-593f-518f-47ef44eab151';
var USER_DATA_TYPE = VirgilSDK.UserDataTypeEnum.Email;
var USER_DATA_CLASS = VirgilSDK.UserDataClassEnum.UserId;
var USER_DATA_VALUE = 'example@domain.com';
var CONTAINER_PASSWORD = 'password';

// application token must be passed into the service's constructor
var privateKeysService = new VirgilSDK.PrivateKeysService(APP_TOKEN);
var virgilUserData = new VirgilSDK.UserData(USER_DATA_TYPE, USER_DATA_CLASS, USER_DATA_VALUE);
privateKeysService.setAuthCredentials(virgilUserData, CONTAINER_PASSWORD);

privateKeysService.getContainer(PUBLIC_KEY_ID).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Delete Container Object

```javascript
var VirgilSDK = window.VirgilSDK;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '9fdca3db-f412-9ce4-4dce-cd7c8ebe8cbb';
var PRIVATE_KEY_BASE64 = '<PRIVATE_KEY_IN_BASE64>';
var KEY_PASSWORD = 'password';
var USER_DATA_TYPE = VirgilSDK.UserDataTypeEnum.Email;
var USER_DATA_CLASS = VirgilSDK.UserDataClassEnum.UserId;
var USER_DATA_VALUE = 'example@domain.com';
var CONTAINER_PASSWORD = 'password';

// application token must be passed into the service's constructor
var privateKeysService = new VirgilSDK.PrivateKeysService(APP_TOKEN);
var virgilUserData = new VirgilSDK.UserData(USER_DATA_TYPE, USER_DATA_CLASS, USER_DATA_VALUE);
privateKeysService.setAuthCredentials(virgilUserData, CONTAINER_PASSWORD);

// KEY_PASSWORD an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
privateKeysService.deleteContainer(PUBLIC_KEY_ID, PRIVATE_KEY_BASE64, KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Update Container Object

> By invoking this method you can change the Container Type or|and Container Password

```javascript
var VirgilSDK = window.VirgilSDK;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '9fdca3db-f412-9ce4-4dce-cd7c8ebe8cbb';
var PRIVATE_KEY_BASE64 = '<PRIVATE_KEY_IN_BASE64>';
var KEY_PASSWORD = 'password';
var USER_DATA_TYPE = VirgilSDK.UserDataTypeEnum.Email;
var USER_DATA_CLASS = VirgilSDK.UserDataClassEnum.UserId;
var USER_DATA_VALUE = 'example@domain.com';
var CONTAINER_PASSWORD = 'password';
var EXISTING_CONTAINER_JSON_FROM_SERVER = {
  container_type: 'easy',
  password: 'password'
};
var CONTAINER_TYPE_NEW = VirgilSDK.PrivateKeysContainerTypeEnum.Normal;

// initialize container instance based on the JSON representation from server
var container = new VirgilSDK.PrivateKeysContainer.fromJS(EXISTING_CONTAINER_JSON_FROM_SERVER);
// update container type
container.Type = CONTAINER_TYPE_NEW;

// application token must be passed into the service's constructor
var privateKeysService = new VirgilSDK.PrivateKeysService(APP_TOKEN);
var virgilUserData = new VirgilSDK.UserData(USER_DATA_TYPE, USER_DATA_CLASS, USER_DATA_VALUE);
privateKeysService.setAuthCredentials(virgilUserData, CONTAINER_PASSWORD);

// KEY_PASSWORD an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
privateKeysService.updateContainer(container, PUBLIC_KEY_ID, PRIVATE_KEY_BASE64, KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Reset the Container Password

> A user can reset their Private Key object password if the Container Type equals 'easy'. 
> If the Container Type equals 'normal', the Private Key object will be stored in its original form.

```javascript
var VirgilSDK = window.VirgilSDK;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var USER_DATA_TYPE = VirgilSDK.UserDataTypeEnum.Email;
var USER_DATA_CLASS = VirgilSDK.UserDataClassEnum.UserId;
var USER_DATA_VALUE = 'example@domain.com';
var CONTAINER_PASSWORD_NEW = 'password_new';

// application token must be passed into the service's constructor
var privateKeysService = new VirgilSDK.PrivateKeysService(APP_TOKEN);
var virgilUserData = new VirgilSDK.UserData(USER_DATA_TYPE, USER_DATA_CLASS, USER_DATA_VALUE);

privateKeysService.resetContainerPassword(virgilUserData, CONTAINER_PASSWORD_NEW).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Persist Container Object

> The token generated during the container reset invocation only lives for 60 minutes.

```javascript
var VirgilSDK = window.VirgilSDK;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PERSIST_CONFIRMATION_TOKEN = 'I9Y6Y0';

// application token must be passed into the service's constructor
var privateKeysService = new VirgilSDK.PrivateKeysService(APP_TOKEN);

privateKeysService.persistContainerChanges(PERSIST_CONFIRMATION_TOKEN).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Create a Private Key inside the Container Object

> Load an existing Private Key into the Private Keys service and associate it with the existing Container object.

```javascript
var VirgilSDK = window.VirgilSDK;
var virgilCrypto = new VirgilSDK.Crypto();

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '9fdca3db-f412-9ce4-4dce-cd7c8ebe8cbb';
var PRIVATE_KEY_BASE64 = '<PRIVATE_KEY_IN_BASE64>';
var KEY_PASSWORD = 'password';
var USER_DATA_TYPE = VirgilSDK.UserDataTypeEnum.Email;
var USER_DATA_CLASS = VirgilSDK.UserDataClassEnum.UserId;
var USER_DATA_VALUE = 'example@domain.com';
var CONTAINER_PASSWORD = 'password';
var EXISTING_CONTAINER_JSON_FROM_SERVER = {
  container_type: 'easy',
  password: 'password'
};

// initialize container instance based on the JSON representation from server
var container = new VirgilSDK.PrivateKeysContainer.fromJS(EXISTING_CONTAINER_JSON_FROM_SERVER);
// application token must be passed into the service's constructor
var privateKeysService = new VirgilSDK.PrivateKeysService(APP_TOKEN);
var virgilUserData = new VirgilSDK.UserData(USER_DATA_TYPE, USER_DATA_CLASS, USER_DATA_VALUE);
privateKeysService.setAuthCredentials(virgilUserData, CONTAINER_PASSWORD);

// Set the cipher strategy for the private keys service.
// This strategy function will be used for getting the encrypted or not encrypted version of key.
// In this function you are able to describe specific serializer algorithm for private key,
// which will be applied before pushing to server.
// Always will be called with the private key as the first argument
// and all other given arguments will be passed into `strategy` function as additional arguments
privateKeysService.setKeyCipherStrategy(function(pKey, contType, keysPassword, contPassword) {
  var base64PrivateKey = pKey.Key;
  // return the not encrypted version by default
  var resultKey = base64PrivateKey;
  // the shorthand for container types enum
  var contTypes = VirgilSDK.PrivateKeysContainerTypeEnum;

  // if the container has the `Easy` type, then we have to use the container password here,
  // because the privateKeys will be encrypted using that password
  if (contTypes.Easy === contType) {
    resultKey = virgilCrypto.encryptWithPassword(base64PrivateKey, contPassword);
  }
  // for the `Normal` container type, the private keys will be encrypted using the special password,
  // which was provided by owner of the private key
  else if (contTypes.Normal === contType) {
    resultKey = virgilCrypto.encryptWithPassword(base64PrivateKey, keysPassword);
  }

  return resultKey;
}, container.Type, privateKeysService.authPassword, CONTAINER_PASSWORD);

// KEY_PASSWORD an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
privateKeysService.addKey(PUBLIC_KEY_ID, PRIVATE_KEY_BASE64, KEY_PASSWORD).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);

```

## Get Private Key Object

```javascript
var VirgilSDK = window.VirgilSDK;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';
var USER_DATA_TYPE = VirgilSDK.UserDataTypeEnum.Email;
var USER_DATA_CLASS = VirgilSDK.UserDataClassEnum.UserId;
var USER_DATA_VALUE = 'example@domain.com';
var CONTAINER_PASSWORD = 'password';

// application token must be passed into the service's constructor
var privateKeysService = new VirgilSDK.PrivateKeysService(APP_TOKEN);
var virgilUserData = new VirgilSDK.UserData(USER_DATA_TYPE, USER_DATA_CLASS, USER_DATA_VALUE);
privateKeysService.setAuthCredentials(virgilUserData, CONTAINER_PASSWORD);

privateKeysService.getKey(PUBLIC_KEY_ID).then(
  function(resData) {
    console.log(resData);
  },
  function(error) {
    console.error(error);
  }
);
```

## Delete Private Key Object

> Delete a Private Key object. A Private Key object will be disconnected from the Container Object and then deleted from the Private Key service.

```javascript
var VirgilSDK = window.VirgilSDK;

var APP_TOKEN = '77ce6c9c9e2254dbf4c71513ac74dced';
var PUBLIC_KEY_ID = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';
var PRIVATE_KEY_BASE64 = '<PRIVATE_KEY_IN_BASE64>';
var KEY_PASSWORD = 'password';
var USER_DATA_TYPE = VirgilSDK.UserDataTypeEnum.Email;
var USER_DATA_CLASS = VirgilSDK.UserDataClassEnum.UserId;
var USER_DATA_VALUE = 'example@domain.com';
var CONTAINER_PASSWORD = 'password';

// application token must be passed into the service's constructor
var privateKeysService = new VirgilSDK.PrivateKeysService(APP_TOKEN);
var virgilUserData = new VirgilSDK.UserData(USER_DATA_TYPE, USER_DATA_CLASS, USER_DATA_VALUE);
privateKeysService.setAuthCredentials(virgilUserData, CONTAINER_PASSWORD);

// KEY_PASSWORD an optional argument,
// it's needed only if your keys was generated using the appropriate passwords
privateKeysService.delKey(PUBLIC_KEY_ID, PRIVATE_KEY_BASE64, KEY_PASSWORD).then(
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
<div class="title">Quick Navigation</div>

<div class="menu-items-wrapper" data-ui="menu-items-wrapper"></div>
</div>
</div>
</div>
</div>
</section>
</div>
