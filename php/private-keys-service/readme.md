
# Virgil Security Private Keys SDK

- [Introduction](#introduction)
- [Build prerequisite](#build-prerequisite)
- [Build](#build)
- [Installation](#installation)
- [General statements](#general-statements)
- [Examples](#examples)
- [Create Container](#create-a-container)
- [Get Container](#get-container)
- [Delete Container](#delete-container)
- [Update Container](#update-container)
- [Reset Container](#reset-container)
- [Persist Container](#persist-container)
- [Create a Private Key](#create-private-key)
- [Get Private Key](#get-private-key)
- [Delete Private Key](#delete-private-key)

## Introduction

This branch focuses on the PHP library implementation and covers the following:

  * build prerequisite;
  * build;
  * usage exmaples.

Virgil Security's Crypto Library can be found [here](https://github.com/VirgilSecurity/virgil).

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

1. Open terminal.
2. Clone the project. ``` git clone https://github.com/VirgilSecurity/virgil.git ```
4. Navigate to the project's folder.
5. ``` cd virgil_lib ```
6. Create a folder for the build. ``` mkdir build ```
7. Navigate to the "build" folder. ``` cd build ```
8. Configure cmake. Note, replace "../install" path, if you want to install the library in different location.
 ``` cmake -DPLATFORM_NAME=PHP -DCMAKE_INSTALL_PREFIX=../install .. ```
10. Build the library. ``` make ```
11. Install the library. ``` make install ```
12. Add to your php.ini ``` extension=path/to/your/virgil_php.so```, replace ``"path/to/your/virgil_php.so"`` with the path where the virgil_php.so extension is located.

## Installation

```bash
php composer.phar install
```

### General statements

1. You are ready to work with the PHP Library if you:
  1. Created an Application under [Virgil Security, Inc](https://virgilsecurity.com/dashboard).
  2. Created Private and Public Keys on your local machine.
  3. Created and confirmed your account in the Public Keys service.
  4. Loaded a Public Key to the Public Key service.
  5. Used the same email that you used for the Public Key service.
2. Examples MUST be run from their directory.
3. Before running examples you have to install dependencies (run command ```composer install``` or ```php composer.phar install``)
4. Replace the example value of `VIRGIL_APPLICATION_TOKEN` variable with your real Application token.
5. Replace the example value of `VIRGIL_USER_NAME` with your real email. It needs to confirm data and invoke some endpoints within the Private Key Service. The email you use must be registered and confirmed under the Public Key Service.
6. Replace the example value of `VIRGIL_PUBLIC_KEY_ID` with the real Public Key ID value. You can take this value from the Public Keys service when registering a new Public Key.
7. Replace the example value of `VIRGIL_PRIVATE_KEY_PASSWORD` with the value that you used when you generated the Private Key. If you didn't specify it when you generated the Private Key, then just remove it from the method invocations.

## Examples

Common case library usage scenarios;

  * CRUD operations for the Container object;
  * CRUD operations for Private Key object;
  * Private Key's Reset and Persist functionality.

### Create a Container.

> Create a new container object to store future Private Key's instances.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\PrivateKeys\Client as PrivateKeysClient;


const VIRGIL_APPLICATION_TOKEN  = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_NAME          = 'example.mail@gmail.com';
const VIRGIL_PUBLIC_KEY_ID      = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';

const VIRGIL_CONTAINER_TYPE     = 'normal';
const VIRGIL_CONTAINER_PASSWORD = 'password';

const VIRGIL_PRIVATE_KEY_PASSWORD   = 'password';

try {

    // Create Keys Service HTTP Client
    $privateKeysClient = new PrivateKeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $privateKeysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => VIRGIL_PUBLIC_KEY_ID
    ));

    echo 'Reading Private Key.' . PHP_EOL;
    $privateKey = file_get_contents(
        '../data/private.key'
    );
    echo 'Private Key data successfully read.' . PHP_EOL;

    // Do a service call
    echo 'Call the Private Key service to create a Container instance.' . PHP_EOL;
    $privateKeysClient->getContainerClient()->createContainer(
        VIRGIL_CONTAINER_TYPE,
        VIRGIL_CONTAINER_PASSWORD,
        $privateKey,
        VIRGIL_PRIVATE_KEY_PASSWORD
    );
    echo 'Container instance successfully created in the Private Keys service' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Get Container.

> Get Container Object Data.

```php
<?php

require_once '../vendor/autoload.php';

use Virgil\SDK\PrivateKeys\Client as PrivateKeysClient;


const VIRGIL_APPLICATION_TOKEN  = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_NAME          = 'example.mail@gmail.com';
const VIRGIL_CONTAINER_PASSWORD = 'password';
const VIRGIL_PUBLIC_KEY_ID      = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';

try {

    // Create Keys Service HTTP Client
    $privateKeysClient = new PrivateKeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $privateKeysClient->setAuthCredentials(
        VIRGIL_USER_NAME,
        VIRGIL_CONTAINER_PASSWORD
    );

    // Do service call
    echo 'Call Private Key service to get Container instance.' . PHP_EOL;
    $container = $privateKeysClient->getContainerClient()->getContainer(
        VIRGIL_PUBLIC_KEY_ID
    );
    echo 'Container instance successfully fetched from Private Keys service.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Delete Container.

> Delete existing container object from the Private Key service.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\PrivateKeys\Client as PrivateKeysClient;


const VIRGIL_APPLICATION_TOKEN    = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_NAME            = 'example.mail@gmail.com';
const VIRGIL_CONTAINER_PASSWORD   = 'password';
const VIRGIL_PUBLIC_KEY_ID        = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';
const VIRGIL_PRIVATE_KEY_PASSWORD = 'password';

try {

    // Create Keys Service HTTP Client
    $privateKeysClient = new PrivateKeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $privateKeysClient->setAuthCredentials(
        VIRGIL_USER_NAME,
        VIRGIL_CONTAINER_PASSWORD
    );

    $privateKeysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => VIRGIL_PUBLIC_KEY_ID
    ));

    echo 'Reading Private Key.' . PHP_EOL;
    $privateKey = file_get_contents(
        '../data/private.key'
    );
    echo 'Private Key data successfully read.' . PHP_EOL;

    // Do service call
    echo 'Call Private Key service to delete Container instance.' . PHP_EOL;
    $privateKeysClient->getContainerClient()->deleteContainer(
        $privateKey,
        VIRGIL_PRIVATE_KEY_PASSWORD
    );
    echo 'Container instance successfully deleted from Private Keys service' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Update Container.

> Update an existing Container object.

> **Note:**

> By invoking this method you can change the Container Type or|and Container Password

```php
<?php

require_once '../vendor/autoload.php';

use Virgil\SDK\PrivateKeys\Client as PrivateKeysClient;

const VIRGIL_APPLICATION_TOKEN      = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_NAME              = 'example.mail@gmail.com';
const VIRGIL_CONTAINER_PASSWORD     = 'password';
const VIRGIL_PUBLIC_KEY_ID          = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';

const VIRGIL_PRIVATE_KEY_PASSWORD   = 'password';

const VIRGIL_CONTAINER_TYPE         = 'normal';
const VIRGIL_NEW_CONTAINER_PASSWORD = 'password';

try {

    // Create Keys Service HTTP Client
    $privateKeysClient = new PrivateKeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $privateKeysClient->setAuthCredentials(
        VIRGIL_USER_NAME,
        VIRGIL_CONTAINER_PASSWORD
    );

    $privateKeysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => VIRGIL_PUBLIC_KEY_ID
    ));

    echo 'Reading Private Key.' . PHP_EOL;
    $privateKey = file_get_contents(
        '../data/private.key'
    );
    echo 'Private Key data successfully read.' . PHP_EOL;

    // Do service call
    echo 'Call the Private Key service to update Container instance.' . PHP_EOL;
    $privateKeysClient->getContainerClient()->updateContainer(
        VIRGIL_CONTAINER_TYPE,
        VIRGIL_NEW_CONTAINER_PASSWORD,
        $privateKey,
        VIRGIL_PRIVATE_KEY_PASSWORD
    );
    echo 'Container instance successfully update in the Private Keys service' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Reset Container.

> Reset a user's forgotten Private Key password.

> **Note:**

> A user can reset their Private Key object password if the Container Type equals 'easy'. If the Container Type equals 'normal', the Private Key object will be stored in its original form.

```php
<?php

require_once '../vendor/autoload.php';

use Virgil\SDK\PrivateKeys\Client as PrivateKeysClient,
    Virgil\SDK\PrivateKeys\Models\UserData;


const VIRGIL_APPLICATION_TOKEN      = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_NAME              = 'example.mail@gmail.com';
const VIRGIL_CONTAINER_PASSWORD     = 'password';

const VIRGIL_USER_DATA_CLASS        = 'user_id';
const VIRGIL_USER_DATA_TYPE         = 'email';
const VIRGIL_USER_DATA_VALUE        = 'example.mail@gmail.com';

const VIRGIL_NEW_CONTAINER_PASSWORD = 'password';

try {

    // Create Keys Service HTTP Client
    $privateKeysClient = new PrivateKeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $privateKeysClient->setAuthCredentials(
        VIRGIL_USER_NAME,
        VIRGIL_CONTAINER_PASSWORD
    );

    $userData = new VirgilUserData();
    $userData->class = VIRGIL_USER_DATA_CLASS;
    $userData->type  = VIRGIL_USER_DATA_TYPE;
    $userData->value = VIRGIL_USER_DATA_VALUE;

    // Do service call
    echo 'Call the Private Key service to reset a Container password.' . PHP_EOL;
    $privateKeysClient->getContainerClient()->resetPassword(
        $userData,
        VIRGIL_NEW_CONTAINER_PASSWORD
    );
    echo 'Container password successfully reset.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Persist Container.

> Confirm the password reset action.

> **Note:**

> The token generated during the container reset invocation only lives for 60 minutes.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\PrivateKeys\Client as PrivateKeysClient;

const VIRGIL_APPLICATION_TOKEN  = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_NAME          = 'example.mail@gmail.com';
const VIRGIL_CONTAINER_PASSWORD = 'password';

const VIRGIL_CONFIRMATION_TOKEN = 'I9Y6Y0';

try {

    // Create Keys Service HTTP Client
    $privateKeysClient = new PrivateKeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $privateKeysClient->setAuthCredentials(
        VIRGIL_USER_NAME,
        VIRGIL_CONTAINER_PASSWORD
    );

    // Do service call
    echo 'Call the Private Key service to persist the container.' . PHP_EOL;
    $privateKeysClient->getContainerClient()->persistContainer(
        VIRGIL_CONFIRMATION_TOKEN
    );    echo 'Container successfully persisted.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Create Private Key.

> Load an existing Private Key into the Private Keys service and associate it with the existing Container object.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\PrivateKeys\Client as PrivateKeysClient;


const VIRGIL_APPLICATION_TOKEN    = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_NAME            = 'example.mail@gmail.com';
const VIRGIL_CONTAINER_PASSWORD   = 'password';
const VIRGIL_PUBLIC_KEY_ID        = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';
const VIRGIL_PRIVATE_KEY_PASSWORD = 'password';

try {

    // Create Keys Service HTTP Client
    $privateKeysClient = new PrivateKeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $privateKeysClient->setAuthCredentials(
        VIRGIL_USER_NAME,
        VIRGIL_CONTAINER_PASSWORD
    );

    $privateKeysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => VIRGIL_PUBLIC_KEY_ID
    ));

    echo 'Reading Private Key.' . PHP_EOL;
    $privateKey = file_get_contents(
        '../data/private.key'
    );
    echo 'Private Key data successfully read.' . PHP_EOL;

    // Do service call
    echo 'Call the Private Key service to create a Private Key instance.' . PHP_EOL;
    $privateKeysClient->getPrivateKeysClient()->createPrivateKey(
        VIRGIL_PUBLIC_KEY_ID,
        $privateKey,
        VIRGIL_PRIVATE_KEY_PASSWORD
    );
    echo 'Private Key instance successfully created in the Private Keys service.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Get Private Key.

> Get a Private Key object.

```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\PrivateKeys\Client as PrivateKeysClient;


const VIRGIL_APPLICATION_TOKEN  = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_NAME          = 'example.mail@gmail.com';
const VIRGIL_CONTAINER_PASSWORD = 'password';
const VIRGIL_PUBLIC_KEY_ID      = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';

try {

    // Create Keys Service HTTP Client
    $privateKeysClient = new PrivateKeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $privateKeysClient->setAuthCredentials(
        VIRGIL_USER_NAME,
        VIRGIL_CONTAINER_PASSWORD
    );

    // Do service call
    echo 'Call the Private Key service to get a Private Key instance.' . PHP_EOL;
    $privateKey = $privateKeysClient->getPrivateKeysClient()->getPrivateKey(
        VIRGIL_PUBLIC_KEY_ID
    );
    echo 'Private Key instance successfully fetched from the Private Keys service' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
```

### Delete Private Key.

> Delete a Private Key object. A Private Key object will be disconnected from the Container Object and then deleted from the Private Key service.


```php
<?php
require_once '../vendor/autoload.php';

use Virgil\SDK\PrivateKeys\Client as PrivateKeysClient;


const VIRGIL_APPLICATION_TOKEN    = '17da4b6d03fad06954b5dccd82439b10';
const VIRGIL_USER_NAME            = 'example.mail@gmail.com';
const VIRGIL_CONTAINER_PASSWORD   = 'password';
const VIRGIL_PUBLIC_KEY_ID        = '5d3a8909-5fe5-2abb-232c-3cf9c277b111';
const VIRGIL_PRIVATE_KEY_PASSWORD = 'password';

try {

    // Create Keys Service HTTP Client
    $privateKeysClient = new PrivateKeysClient(
        VIRGIL_APPLICATION_TOKEN
    );

    $privateKeysClient->setAuthCredentials(
        VIRGIL_USER_NAME,
        VIRGIL_CONTAINER_PASSWORD
    );

    $privateKeysClient->setHeaders(array(
        'X-VIRGIL-REQUEST-SIGN-PK-ID' => VIRGIL_PUBLIC_KEY_ID
    ));

    echo 'Reading Private Key.' . PHP_EOL;
    $privateKey = file_get_contents(
        '../data/private.key'
    );
    echo 'Private Key data successfully read.' . PHP_EOL;

    // Do service call
    echo 'Call Private Key service to delete Private Key instance.' . PHP_EOL;
    $privateKeysClient->getPrivateKeysClient()->deletePrivateKey(
        $privateKey,
        VIRGIL_PRIVATE_KEY_PASSWORD
    );
    echo 'The Private Key instance was successfully deleted from the Private Keys service.' . PHP_EOL;

} catch (Exception $e) {

    echo 'Error:' . $e->getMessage();
}
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
