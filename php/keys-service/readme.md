
# Virgil Security Keys SDK

- [Introduction](#introduction)
- [Build prerequisite](#build-prerequisite)
- [Build](#user-content-build)
- [Installation](#installation)
- [General statements](#general-statements)
- [Examples](#examples)
- [Generate keys](#generate-keys)
- [Register a New User](#register-a-new-user)
- [Get a User's Public Key](#get-a-users-public-key)
- [Search Public Key](#search-public-key)
- [Search Public Key Signed](#search-public-key-signed)
- [Update Public Key](#update-public-key)
- [Delete Public Key](#delete-public-key)
- [Reset Public Key](#reset-a-public-key)
- [Confirm Public Key](#confirm-public-key)
- [Create User Data](#create-user-data)
- [Delete User Data](#delete-user-data)
- [Confirm User Data](#confirm-user-data)
- [Resend Confirmation for User Data](#resend-a-users-confirmation-code)

## Introduction

This branch focuses on Virgil's PHP library implementation and covers the following topics:

  * build prerequisite;
  * build;
  * usage examples.

Virgil Security's Crypto Stack Library can be found [here](https://github.com/VirgilSecurity/virgil).

## Build prerequisite

1. [CMake](http://www.cmake.org/).
1. [Git](http://git-scm.com/).
1. [Python](http://python.org/).
1. [Python YAML](http://pyyaml.org/).
1. C/C++ compiler:
    [gcc](https://gcc.gnu.org/),
    [clang](http://clang.llvm.org/),
    [MinGW](http://www.mingw.org/),
    [Microsoft Visual Studio](http://www.visualstudio.com/), or other.
1. [libcurl](http://curl.haxx.se/libcurl/).

## Build

1. Open your terminal.
2. Clone the Virgil Security project. ``` git clone https://github.com/VirgilSecurity/virgil.git ```
4. Navigate to the project's folder.
5. ``` cd virgil_lib ```
6. Create a folder for the build. ``` mkdir build ```
7. Navigate to the "build" folder. ``` cd build ```
8. Configure cmake. Note, replace "../install" path, if you want to install the library in a different location.
 ``` cmake -DPLATFORM_NAME=PHP -DCMAKE_INSTALL_PREFIX=../install .. ```
10. Build the library. ``` make ```
11. Install the library. ``` make install ```
12. Add to your php.ini ```extension=path/to/your/virgil_php.so```, replace ``"path/to/your/virgil_php.so"`` with the path where your virgil_php.so extension is located.

## Installation

```bash
php composer.phar install
```

### General statements

1. Examples MUST be run from their directory.
2. Before running examples you have to install dependencies (run command ```composer install```)
3. All results are stored in the "data" directory.
4. Before using these examples, you must generate Public and Private Keys using the first Generate Keys example below.
5. Go to [Virgil Security, Inc](https://virgilsecurity.com) sign in and generate a new Application Token. Please replace the example value of the `VIRGIL_APPLICATION_TOKEN` variable with your real Application token.
6. Replace the example value of `VIRGIL_USER_DATA_VALUE` with your real email address. It needs to confirm some data and invocation of some endpoints inside the Public Key service.
7. Replace example value of `VIRGIL_PRIVATE_KEY_PASSWORD` to the value that you have used when generate Private Key. If you didn't specify it while you generated the Private Key, then just remove it from the method invocations.

## Examples

This section describes common case library usage scenarios.

  * CRUD operations for Virgil's Public Keys;
  * CRUD operations for Virgil's Public Key User Data;
  * Virgil's Public Keys search functionality;
  * Virgil's Public Keys Reset and Persist functionality.

### Generate Keys

> **Note:**

> Run the script to generate Virgil Private and Public Keys. If you prefer, you can specify a password for the Private Key. 
If you chose to specify a password for the Private Key then you have to use it everywhere for the `VIRGIL_PRIVATE_KEY_PASSWORD` variable and replace this with your password. If you didn't specify the Private Key, then please skip using the `VIRGIL_PRIVATE_KEY_PASSWORD` variable in each eaxmple and remove it from the each action invocation.

```php
<?php

require_once './vendor/autoload.php';

use Virgil\Crypto\VirgilKeyPair;

$key = new VirgilKeyPair('password');

echo 'Generate Keys with the password: "password".' . PHP_EOL;
file_put_contents(
    'data' . DIRECTORY_SEPARATOR . 'public.key',
    $key->publicKey()
);

file_put_contents(
    'data' . DIRECTORY_SEPARATOR . 'private.key',
    $key->privateKey()
);
echo 'Private and Public Keys were successfully generated.' . PHP_EOL;
```

### Register a New User

> A Virgil Account will be created when the first Public Key is uploaded. An application can only get information about Public Keys created for the current application. When the application uploads a new Public Key and there is an Account created for another application with the same UDID, the Public Key will be implicitly attached it to the existing Account instance.

```php
<?php

use Virgil\SDK\Keys\Models\UserData,
    Virgil\SDK\Keys\Models\UserDataCollection,
    Virgil\SDK\Keys\Client as KeysClient;

require_once '../vendor/autoload.php';

const VIRGIL_APPLICATION_TOKEN      = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_DATA_CLASS        = 'user_id';
const VIRGIL_USER_DATA_TYPE         = 'email';
const VIRGIL_USER_DATA_VALUE        = 'example.email@gmail.com';
const VIRGIL_PRIVATE_KEY_PASSWORD   = 'password';

try {

    // Create Keys Service HTTP Client
    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $userData = new VirgilUserData();
    $userData->class = VIRGIL_USER_DATA_CLASS;
    $userData->type  = VIRGIL_USER_DATA_TYPE;
    $userData->value = VIRGIL_USER_DATA_VALUE;

    $userDataCollection = new VirgilUserDataCollection();
    $userDataCollection->add(
        $userData
    );

    echo 'Reading Public Key.' . PHP_EOL;
    $publicKey = file_get_contents(
        '../data/public.key'
    );
    echo 'Public Key data successfully read.' . PHP_EOL;


    echo 'Reading Private Key.' . PHP_EOL;
    $privateKey = file_get_contents(
        '../data/private.key'
    );
    echo 'Private Key data successfully read.' . PHP_EOL;

    // Do service call
    echo 'Call Keys Service to create a Public Key instance.' . PHP_EOL;
    $publicKey = $keysClient->getPublicKeysClient()->createKey(
        $publicKey,
        $userDataCollection,
        $privateKey,
        VIRGIL_PRIVATE_KEY_PASSWORD
    );
    echo 'A Public Key instance was successfully created in Virgil's Public Keys Service.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Get a User's Public Key

> Get a Public Key’s data.

```php
<?php

require_once '../vendor/autoload.php';

use Virgil\SDK\Keys\Client as KeysClient;

const VIRGIL_APPLICATION_TOKEN = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_PUBLIC_KEY_ID     = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';

try {

    // Create Keys Service HTTP Client
    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    // Do service call
    echo 'Call Keys Service to get a Public Key.' . PHP_EOL;
    $publicKey = $keysClient->getPublicKeysClient()->getKey(
        VIRGIL_PUBLIC_KEY_ID
    );
    echo 'Public Key instance successfully returned Public Keys instance.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Search Public Key

> Search for Public Keys by UDID values.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\Keys\Client as KeysClient;

const VIRGIL_APPLICATION_TOKEN  = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_DATA_VALUE    = 'example.mail@gmail.com';

try {

    // Create Keys Service HTTP Client
    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    // Do service call
    echo 'Call Keys Service to search a Public Key instance.' . PHP_EOL;
    $result = $keysClient->getPublicKeysClient()->grabKey(
        VIRGIL_USER_DATA_VALUE
    );
    echo 'Public Key instance successfully searched in Keys Service.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Search Public Key Signed

> Search Public Keys by UDID values.

> **Note:**

> If a signed version of the action is used, the Public Key will be returned with all of the user_data items for this Public Key.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\Common\Utils\GUID,
    Virgil\SDK\Keys\Client as KeysClient;


const VIRGIL_APPLICATION_TOKEN  = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_DATA_VALUE    = 'example.mail@gmail.com';
const VIRGIL_PUBLIC_KEY_ID      = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';

try {

    // Create Keys Service HTTP Client
    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $keysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => VIRGIL_PUBLIC_KEY_ID
    ));

    echo 'Read Private Key.' . PHP_EOL;
    $privateKey = file_get_contents(
        '../data' . DIRECTORY_SEPARATOR . 'private.key'
    );
    echo 'Private Key is:' . PHP_EOL;
    echo $privateKey . PHP_EOL;
    $privateKeyPassword = 'password';

    // Do service call
    echo 'Call Keys service to search Public Key instance.' . PHP_EOL;
    $result = $keysClient->getPublicKeysClient()->grabKey(
        VIRGIL_USER_DATA_VALUE,
        $privateKey,
        $privateKeyPassword
    );
    echo 'Public Key instance successfully searched in Keys service.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Update Public Key

> Update a Public Key’s data.

> **Note:**

> User still controls the Public/Private Keys pair and provides requested signature for authentication purposes. That’s why user authorisation is required via X-VIRGIL-REQUEST-SIGN HTTP header. Public Key modification takes place immediately after action invocation.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\Keys\Client as KeysClient;


const VIRGIL_APPLICATION_TOKEN      = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_PUBLIC_KEY_ID          = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';
const VIRGIL_PRIVATE_KEY_PASSWORD   = 'password';

try {

    // Create Keys Service HTTP Client
    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $keysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => VIRGIL_PUBLIC_KEY_ID
    ));

    echo 'Reading Old Private Key.' . PHP_EOL;
    $oldPrivateKey = file_get_contents(
        '../data/private.key'
    );
    echo 'Old Private Key data successfully read.' . PHP_EOL;

    echo 'Reading New Public Key.' . PHP_EOL;
    $newPublicKey = file_get_contents(
        '../data/new_public.key'
    );
    echo 'New Public Key data successfully read.' . PHP_EOL;

    echo 'Reading New Private Key.' . PHP_EOL;
    $newPrivateKey = file_get_contents(
        '../data/new_private.key'
    );
    echo 'New Private Key data successfully read.' . PHP_EOL;

    // Do service call
    echo 'Call Keys Service to update the Public Key instance.' . PHP_EOL;
    $publicKey = $keysClient->getPublicKeysClient()->updateKey(
        VIRGIL_PUBLIC_KEY_ID,
        $oldPrivateKey,
        $newPublicKey,
        $newPrivateKey,
        VIRGIL_PRIVATE_KEY_PASSWORD
    );
    echo 'Public Key instance successfully updated in Public Keys service.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Delete Public Key

> The purpose is to remove a Public Key’s data.

> **Note:**

> If a signed version of the action is used, the Public Key will be removed immediately without any confirmation.

> If an unsigned version of the action is used, confirmation is required. The action will return an action_token response object and will send confirmation tokens to all of the Public Key’s confirmed UDIDs. The list of masked UDID’s will be returned in user_ids response object property. To commit a Public Key remove call persistKey() action with action_token value and the list of confirmation codes.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\Keys\Client as KeysClient;

const VIRGIL_APPLICATION_TOKEN      = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_PUBLIC_KEY_ID          = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';
const VIRGIL_PRIVATE_KEY_PASSWORD   = 'password';

try {

    // Create Keys Service HTTP Client
    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $keysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => VIRGIL_PUBLIC_KEY_ID
    ));

    echo 'Reading Public Key.' . PHP_EOL;
    $publicKey = file_get_contents(
        '../data/public.key'
    );
    echo 'Public Key data successfully read.' . PHP_EOL;


    echo 'Reading Private Key.' . PHP_EOL;
    $privateKey = file_get_contents(
        '../data/private.key'
    );
    echo 'Private Key data successfully read.' . PHP_EOL;

    // Do service call
    echo 'Call Keys Service to delete a Public Key instance.' . PHP_EOL;
    $result = $keysClient->getPublicKeysClient()->deleteKey(
        $publicKey,
        $privateKey,
        VIRGIL_PRIVATE_KEY_PASSWORD
    );
    echo 'Public Key instance successfully deleted from Public Keys service.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Reset a Public Key

> Reset a User’s Public Keys data if the User lost his/her Private Key.

> **Note:**

> After action invocation the user will receive the confirmation tokens on all his confirmed UDIDs. The Public Key data won’t be updated until the call persistKey() action is invoked with the token value from this step and confirmation codes sent to UDIDs. The list of UDIDs used as confirmation tokens recipients will be listed as user_ids response parameters.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\Keys\Client as KeysClient;


const VIRGIL_APPLICATION_TOKEN      = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_PUBLIC_KEY_ID          = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';
const VIRGIL_PRIVATE_KEY_PASSWORD   = 'password';

try {

    // Create Keys Service HTTP Client
    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    echo 'Reading Public Key.' . PHP_EOL;
    $publicKey = file_get_contents(
        '../data/public.key'
    );
    echo 'Public Key data successfully read.' . PHP_EOL;


    echo 'Reading Private Key.' . PHP_EOL;
    $privateKey = file_get_contents(
        '../data/private.key'
    );
    echo 'Private Key data successfully read.' . PHP_EOL;

    // Do service call
    echo 'Call Keys Service to reset Public Key instance.' . PHP_EOL;
    $result = $keysClient->getPublicKeysClient()->resetKey(
        VIRGIL_PUBLIC_KEY_ID,
        $publicKey,
        $privateKey,
        VIRGIL_PRIVATE_KEY_PASSWORD
    );
    echo 'Public Key instance successfully reset.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Confirm Public Key

> Confirm a Public Key’s data.

> **Note:**

> Confirm a Public Key’s data if the X-VIRGILREQUEST-SIGN HTTP header was omitted on deleteKey() action or resetKey action was invoked.

> In this case, the User must collect all the confirmation codes sent to all confirmed UDIDs and specify them in the request body in confirmation_codes parameter as well as action_token parameter received on previous action.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\Keys\Client as KeysClient;


const VIRGIL_APPLICATION_TOKEN = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_PUBLIC_KEY_ID     = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';
const VIRGIL_ACTION_TOKEN      = '31b4be12-9021-76bc-246d-5ecbd7a22350';


try {

    // Create Keys Service HTTP Client
    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    // Do service call
    echo 'Call Keys service to persist Public Key instance.' . PHP_EOL;
    $publicKey = $keysClient->getPublicKeysClient()->persistKey(
        VIRGIL_PUBLIC_KEY_ID,
        VIRGIL_ACTION_TOKEN,
        array(
            'Y4A6D9'
        )
    );
    echo 'Public Key instance successfully persisted.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Create User Data

> Append UDIDs and UDINFOs to Public Keys for the current application.

> **Note:**

> The user data instance will be created for the Public Key instance specified in X-VIRGIL-REQUEST-SIGN-PK-ID HTTP header.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\Keys\Models\UserData,
    Virgil\SDK\Keys\Client as KeysClient;


const VIRGIL_APPLICATION_TOKEN      = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_DATA_CLASS        = 'user_id';
const VIRGIL_USER_DATA_TYPE         = 'email';
const VIRGIL_USER_DATA_VALUE        = 'example.email2@gmail.com';
const VIRGIL_PRIVATE_KEY_PASSWORD   = 'password';
const VIRGIL_PUBLIC_KEY_ID          = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';

try {

    // Create Keys Service HTTP Client
    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $keysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => VIRGIL_PUBLIC_KEY_ID
    ));

    $userData = new VirgilUserData();
    $userData->class = VIRGIL_USER_DATA_CLASS;
    $userData->type  = VIRGIL_USER_DATA_TYPE;
    $userData->value = VIRGIL_USER_DATA_VALUE;

    echo 'Reading Public Key.' . PHP_EOL;
    $publicKey = file_get_contents(
        '../data/public.key'
    );
    echo 'Public Key data successfully read.' . PHP_EOL;


    echo 'Reading Private Key.' . PHP_EOL;
    $privateKey = file_get_contents(
        '../data/private.key'
    );
    echo 'Private Key data successfully read.' . PHP_EOL;

    // Do service call
    echo 'Call Keys service to create User Data instance.' . PHP_EOL;
    $userData = $keysClient->getUserDataClient()->createUserData(
        $userData,
        $privateKey,
        VIRGIL_PRIVATE_KEY_PASSWORD
    );
    echo 'User Data instance successfully created in Public Keys service.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Delete User Data

> Remove user data item from the Public Key.

```php
<?php

require_once '../vendor/autoload.php';

use Virgil\SDK\Keys\Client as KeysClient;

const VIRGIL_APPLICATION_TOKEN    = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_UUID                 =  'aa2141ee-8a50-a7c4-3e4c-513b67918053';
const VIRGIL_PRIVATE_KEY_PASSWORD = 'password';
const VIRGIL_PUBLIC_KEY_ID        = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';

try {

    // Create Keys Service HTTP Client
    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $keysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => VIRGIL_PUBLIC_KEY_ID
    ));

    echo 'Reading Public Key.' . PHP_EOL;
    $publicKey = file_get_contents(
        '../data/public.key'
    );
    echo 'Public Key data successfully read.' . PHP_EOL;


    echo 'Reading Private Key.' . PHP_EOL;
    $privateKey = file_get_contents(
        '../data/private.key'
    );
    echo 'Private Key data successfully read.' . PHP_EOL;

    // Do service call
    echo 'Call Keys service to delete User Data instance.' . PHP_EOL;
    $keysClient->getUserDataClient()->deleteUserData(
        VIRGIL_UUID,
        $privateKey,
        VIRGIL_PRIVATE_KEY_PASSWORD
    );
    echo 'User Data instance successfully deleted from Public Keys service.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Confirm User Data

> Confirm User Data item.

```php
<?php

require_once '../vendor/autoload.php';

use Virgil\SDK\Common\Utils\GUID,
    Virgil\SDK\Keys\Client as KeysClient;


const VIRGIL_APPLICATION_TOKEN  = '17da4b6d03fad06954b5dccd82439b10';

const VIRGIL_UUID = 'aa2141ee-8a50-a7c4-3e4c-513b67918053';
const VIRGIL_CONFIRMATION_CODE = 'J9Y0D5';


try {

    // Create Keys Service HTTP Client
    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    // Do service call
    echo 'Call Keys service to confirm User Data.' . PHP_EOL;
    $keysClient->getUserDataClient()->persistUserData(
        VIRGIL_UUID,
        VIRGIL_CONFIRMATION_CODE
    );
    echo 'User Data successfully confirmed.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Resend a User's Confirmation Code

> Resend a User's confirmation code.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\Keys\Client as KeysClient;


const VIRGIL_APPLICATION_TOKEN      = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_PRIVATE_KEY_PASSWORD   = 'password';
CONST VIRGIL_UUID                   = 'cac16f55-74cf-de0d-1581-d4499f5aa392';
const VIRGIL_PUBLIC_KEY_ID          = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';

try {

    // Create Keys Service HTTP Client
    $keysClient = new KeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $keysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => VIRGIL_PUBLIC_KEY_ID
    ));

    echo 'Reading Public Key.' . PHP_EOL;
    $publicKey = file_get_contents(
        '../data/public.key'
    );
    echo 'Public Key data successfully read.' . PHP_EOL;

    echo 'Reading Private Key.' . PHP_EOL;
    $privateKey = file_get_contents(
        '../data/private.key'
    );
    echo 'Private Key data successfully read.' . PHP_EOL;

    // Do service call
    echo 'Call Keys service to resend confirmation.' . PHP_EOL;
    $keysClient->getUserDataClient()->resendConfirmation(
        VIRGIL_UUID,
        $privateKey,
        VIRGIL_PRIVATE_KEY_PASSWORD
    );
    echo 'Confirmation successfully sent.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
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
