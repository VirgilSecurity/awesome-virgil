
# C++ Keys Service

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

``` {.cpp}
#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>
#include <virgil/crypto/VirgilCryptoException.h>

#include <virgil/sdk/keys/client/Credentials.h>
#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>
#include <virgil/sdk/keys/model/UserData.h>

using virgil::crypto::VirgilByteArray;
using virgil::crypto::VirgilCryptoException;

using virgil::sdk::keys::client::Credentials;
using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;
using virgil::sdk::keys::model::UserData;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string USER_EMAIL = "test.virgilsecurity@mailinator.com";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main() {
    try {
        std::cout << "Prepare input file: public.key..." << std::endl;
        std::ifstream inFile("public.key", std::ios::in | std::ios::binary);
        if (!inFile.good()) {
            throw std::runtime_error("can not read file: public.key");
        }

        std::cout << "Prepare output file: virgil_public.key..." << std::endl;
        std::ofstream outFile("virgil_public.key", std::ios::out | std::ios::binary);
        if (!outFile.good()) {
            throw std::runtime_error("can not write file: virgil_public.key");
        }

        std::cout << "Read public key..." << std::endl;
        VirgilByteArray publicKey;
        std::copy(std::istreambuf_iterator<char>(inFile), std::istreambuf_iterator<char>(),
                std::back_inserter(publicKey));

        std::cout << "Read private key..." << std::endl;
        std::ifstream keyFile("private.key", std::ios::in | std::ios::binary);
        if (!keyFile.good()) {
            throw std::runtime_error("can not read private key: private.key");
        }
        VirgilByteArray privateKey;
        std::copy(std::istreambuf_iterator<char>(keyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(privateKey));

        Credentials credentials(privateKey);

        std::cout << "Create user (" << USER_EMAIL << ") account on the Virgil PKI service..." << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);
        UserData userData = UserData::email(USER_EMAIL);
        PublicKey virgilPublicKey = keysClient.publicKey().add(publicKey, {userData}, credentials, uuid());

        std::cout << "Store virgil public key to the output file..." << std::endl;
        std::string publicKeyData = Marshaller<PublicKey>::toJson(virgilPublicKey);
        std::copy(publicKeyData.begin(), publicKeyData.end(), std::ostreambuf_iterator<char>(outFile));

        std::cout << "Added user data id: " << virgilPublicKey.userData().front().userDataId() << std::endl;
        std::cout << "Confirmation code can be found in the email." << std::endl;
        std::cout << "Now launch next command 'user_data_confirm <user_data_id> <confirmation_code>'" << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }
    return 0;
}

std::string uuid () {
    auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);

    uint32_t time_low = ((generator() << 16) & 0xffff0000) | (generator() & 0xffff);
    uint16_t time_mid = generator() & 0xffff;
    uint16_t time_high_and_version = (generator() & 0x0fff) | 0x4000;
    uint16_t clock_seq = (generator() & 0x3fff) | 0x8000;
    uint8_t node [6];
    for (size_t i = 0; i < 6; ++i) {
        node[i] = generator() & 0xff;
    }

    char buffer[37] = {0x0};
    sprintf(buffer, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        time_low, time_mid, time_high_and_version, clock_seq >> 8, clock_seq & 0xff,
        node[0], node[1], node[2], node[3], node[4], node[5]);

    return std::string(buffer);
}
```


## Get a User's Public Key from Virgil's Keys Service

``` {.cpp}
#include <iostream>
#include <stdexcept>
#include <string>

#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";

int main(int argc, char **argv) {
    if (argc < 2) {
        std::cerr << std::string("USAGE: ") + argv[0] + " <public-key-id> " << std::endl;
        return 0;
    }
    try {
        const std::string kPublicKeyId = argv[1];

        std::cout << "Get user ("<< kPublicKeyId << ") information from the Virgil PKI service..." << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);
        PublicKey publicKey = keysClient.publicKey().get(kPublicKeyId);

        std::cout << "Store virgil public key without User Data to the stdout..." << std::endl;
        std::string publicKeyData = Marshaller<PublicKey>::toJson(publicKey);
        std::cout << publicKeyData << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }
    return 0;
}
```


##  Search Public Key Data within Virgil's Keys Service

``` {.cpp}

#include <chrono>
#include <fstream>
#include <iostream> 
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string USER_EMAIL = "test.virgilsecurity@mailinator.com";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main() {
    try {
        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);

        std::cout << "Call Keys service to search Public Key instance." << std::endl;
        PublicKey publicKey = keysClient.publicKey().grab(USER_EMAIL, uuid());

        std::string publicKeyData = Marshaller<PublicKey>::toJson(publicKey);
        std::cout << publicKeyData << std::endl;

        std::ofstream outFile("virgil_public.key", std::ios::out | std::ios::binary);
        if (!outFile.good()) {
            throw std::runtime_error("can not write file: virgil_public.key");
        }
        std::cout << "Store virgil public key without User Data to the output file..." << std::endl;
        std::copy(publicKeyData.begin(), publicKeyData.end(), std::ostreambuf_iterator<char>(outFile));

        std::cout << "Public Key instance successfully searched in Keys Service." << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }

    return 0;
}

std::string uuid () {
    auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);

    uint32_t time_low = ((generator() << 16) & 0xffff0000) | (generator() & 0xffff);
    uint16_t time_mid = generator() & 0xffff;
    uint16_t time_high_and_version = (generator() & 0x0fff) | 0x4000;
    uint16_t clock_seq = (generator() & 0x3fff) | 0x8000;
    uint8_t node [6];
    for (size_t i = 0; i < 6; ++i) {
        node[i] = generator() & 0xff;
    }

    char buffer[37] = {0x0};
    sprintf(buffer, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        time_low, time_mid, time_high_and_version, clock_seq >> 8, clock_seq & 0xff,
        node[0], node[1], node[2], node[3], node[4], node[5]);

    return std::string(buffer);
}
```


## Search Public Key Signed Data from the Keys Service

``` {.cpp}
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/client/Credentials.h>
#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::client::Credentials;
using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string PUBLIC_KEY_ID = "d6dc4428-4e3d-c672-2b9e-6f0919a11a3d";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main() {
    try {
        std::cout << "Read private key..." << std::endl;
        std::ifstream keyFile("private.key", std::ios::in | std::ios::binary);
        if (!keyFile.good()) {
            throw std::runtime_error("can not read private key: private.key");
        }
        VirgilByteArray privateKey;
        std::copy(std::istreambuf_iterator<char>(keyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(privateKey));

        Credentials credentials(PUBLIC_KEY_ID, privateKey);

        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);

        std::cout << "Call Keys service to search Public Key instance." << std::endl;
        PublicKey publicKey = keysClient.publicKey().grab(credentials, uuid());

        std::cout << "Prepare output file: virgil_public.key..." << std::endl;
        std::string publicKeyData = Marshaller<PublicKey>::toJson(publicKey, true);
        std::cout << publicKeyData << std::endl;

        std::ofstream outFile("virgil_public.key", std::ios::out | std::ios::binary);
        if (!outFile.good()) {
            throw std::runtime_error("can not write file: virgil_public.key");
        }
        std::cout << "Store virgil public key with User Data to the output file..." << std::endl;
        std::copy(publicKeyData.begin(), publicKeyData.end(), std::ostreambuf_iterator<char>(outFile));

        std::cout << "Public Key instance successfully searched in Keys Service." << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }

    return 0;
}

std::string uuid () {
    auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);

    uint32_t time_low = ((generator() << 16) & 0xffff0000) | (generator() & 0xffff);
    uint16_t time_mid = generator() & 0xffff;
    uint16_t time_high_and_version = (generator() & 0x0fff) | 0x4000;
    uint16_t clock_seq = (generator() & 0x3fff) | 0x8000;
    uint8_t node [6];
    for (size_t i = 0; i < 6; ++i) {
        node[i] = generator() & 0xff;
    }

    char buffer[37] = {0x0};
    sprintf(buffer, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        time_low, time_mid, time_high_and_version, clock_seq >> 8, clock_seq & 0xff,
        node[0], node[1], node[2], node[3], node[4], node[5]);

    return std::string(buffer);
}

```



## Update Public Key Data

> Public Key modification takes place immediately after action invocation.


``` {.cpp}
#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/client/Credentials.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>
#include <virgil/sdk/keys/model/UserData.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::client::Credentials;
using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;
using virgil::sdk::keys::model::UserData;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string USER_EMAIL = "test.virgilsecurity@mailinator.com";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main() {
    try {
        std::cout << "Read new public key..." << std::endl;
        std::ifstream newPublicKeyFile("new_public.key", std::ios::in | std::ios::binary);
        if (!newPublicKeyFile.good()) {
            throw std::runtime_error("can not read public key: new_public.key");
        }
        VirgilByteArray newPublicKey;
        std::copy(std::istreambuf_iterator<char>(newPublicKeyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(newPublicKey));


        std::cout << "Read new private key..." << std::endl;
        std::ifstream newPrivateKeyFile("new_private.key", std::ios::in | std::ios::binary);
        if (!newPrivateKeyFile.good()) {
            throw std::runtime_error("can not read private key: new_private.key");
        }
        VirgilByteArray newPrivateKey;
        std::copy(std::istreambuf_iterator<char>(newPrivateKeyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(newPrivateKey));

        Credentials newKeyCredentials(newPrivateKey);


        std::cout << "Read old virgil public key..." << std::endl;
        std::ifstream oldPublicKeyFile("virgil_public.key", std::ios::in | std::ios::binary);
        if (!oldPublicKeyFile.good()) {
            throw std::runtime_error("can not read virgil public key: virgil_public.key");
        }
        std::string oldPublicKeyData((std::istreambuf_iterator<char>(oldPublicKeyFile)),
                std::istreambuf_iterator<char>());

        PublicKey oldPublicKey = Marshaller<PublicKey>::fromJson(oldPublicKeyData);

        std::cout << "Read old private key..." << std::endl;
        std::ifstream oldPrivateKeyFile("private.key", std::ios::in | std::ios::binary);
        if (!oldPrivateKeyFile.good()) {
            throw std::runtime_error("can not read private key: private.key");
        }
        VirgilByteArray oldPrivateKey;
        std::copy(std::istreambuf_iterator<char>(oldPrivateKeyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(oldPrivateKey));

        Credentials oldKeyCredentials(oldPublicKey.publicKeyId(), oldPrivateKey);

        std::cout << "Create Keys Service HTTP Client" << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);

        std::cout << "Call Keys Service to update the Public Key instance." << std::endl;
        keysClient.publicKey().update(newPublicKey, newKeyCredentials, oldKeyCredentials, uuid());
        std::cout << "Public Key instance successfully updated in Public Keys service." << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }

    return 0;
}

std::string uuid () {
    auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);

    uint32_t time_low = ((generator() << 16) & 0xffff0000) | (generator() & 0xffff);
    uint16_t time_mid = generator() & 0xffff;
    uint16_t time_high_and_version = (generator() & 0x0fff) | 0x4000;
    uint16_t clock_seq = (generator() & 0x3fff) | 0x8000;
    uint8_t node [6];
    for (size_t i = 0; i < 6; ++i) {
        node[i] = generator() & 0xff;
    }

    char buffer[37] = {0x0};
    sprintf(buffer, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        time_low, time_mid, time_high_and_version, clock_seq >> 8, clock_seq & 0xff,
        node[0], node[1], node[2], node[3], node[4], node[5]);

    return std::string(buffer);
}
```

## Delete Public Key Data

> If a signed version of the action is used, the Public Key will be removed immediately without any confirmation.
  
> If an unsigned version of the action is used, confirmation is required. 
> The action will return an action_token response object and will send confirmation tokens to all of the Public Key’s confirmed UDIDs. 
> The list of masked UDID’s will be returned in user_ids response object property. 
> To commit a Public Key remove call persistKey() action with action_token value and the list of confirmation codes.

### A signed version
``` {.cpp}
#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/client/Credentials.h>
#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::model::PublicKey;
using virgil::sdk::keys::client::Credentials;
using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::io::Marshaller;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main() {
    try {
        std::cout << "Read virgil public key..." << std::endl;
        std::ifstream publicKeyFile("virgil_public.key", std::ios::in | std::ios::binary);
        if (!publicKeyFile.good()) {
            throw std::runtime_error("can not read virgil public key: virgil_public.key");
        }
        std::string publicKeyData;
        std::copy(std::istreambuf_iterator<char>(publicKeyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(publicKeyData));

        PublicKey publicKey = Marshaller<PublicKey>::fromJson(publicKeyData);

        std::cout << "Read private key..." << std::endl;
        std::ifstream keyFile("private.key", std::ios::in | std::ios::binary);
        if (!keyFile.good()) {
            throw std::runtime_error("can not read private key: private.key");
        }
        VirgilByteArray privateKey;
        std::copy(std::istreambuf_iterator<char>(keyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(privateKey));

        Credentials credentials(publicKey.publicKeyId(), privateKey);

        std::cout << "Remove public key with id (" << publicKey.publicKeyId() << ")." << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);
        keysClient.publicKey().del(credentials, uuid());
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }
    return 0;
}

std::string uuid () {
    auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);

    uint32_t time_low = ((generator() << 16) & 0xffff0000) | (generator() & 0xffff);
    uint16_t time_mid = generator() & 0xffff;
    uint16_t time_high_and_version = (generator() & 0x0fff) | 0x4000;
    uint16_t clock_seq = (generator() & 0x3fff) | 0x8000;
    uint8_t node [6];
    for (size_t i = 0; i < 6; ++i) {
        node[i] = generator() & 0xff;
    }

    char buffer[37] = {0x0};
    sprintf(buffer, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        time_low, time_mid, time_high_and_version, clock_seq >> 8, clock_seq & 0xff,
        node[0], node[1], node[2], node[3], node[4], node[5]);

    return std::string(buffer);
}

```

###  A unsigned version
``` {.cpp}
#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main() {
    try {
        std::cout << "Read virgil public key..." << std::endl;
        std::ifstream publicKeyFile("virgil_public.key", std::ios::in | std::ios::binary);
        if (!publicKeyFile.good()) {
            throw std::runtime_error("can not read virgil public key: virgil_public.key");
        }
        std::string publicKeyData;
        std::copy(std::istreambuf_iterator<char>(publicKeyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(publicKeyData));

        PublicKey publicKey = Marshaller<PublicKey>::fromJson(publicKeyData);

        std::cout << "Remove public key with id (" << publicKey.publicKeyId() << ")." << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);
        std::string confirmInfo = keysClient.publicKey().del(publicKey.publicKeyId(), uuid());
        std::cout << confirmInfo << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }
    return 0;
}

std::string uuid () {
    auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);

    uint32_t time_low = ((generator() << 16) & 0xffff0000) | (generator() & 0xffff);
    uint16_t time_mid = generator() & 0xffff;
    uint16_t time_high_and_version = (generator() & 0x0fff) | 0x4000;
    uint16_t clock_seq = (generator() & 0x3fff) | 0x8000;
    uint8_t node [6];
    for (size_t i = 0; i < 6; ++i) {
        node[i] = generator() & 0xff;
    }

    char buffer[37] = {0x0};
    sprintf(buffer, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        time_low, time_mid, time_high_and_version, clock_seq >> 8, clock_seq & 0xff,
        node[0], node[1], node[2], node[3], node[4], node[5]);

    return std::string(buffer);
}
```

## Reset a Public Key

> After action invocation the user will receive the confirmation tokens on all his confirmed UDIDs. 
> The Public Key data won’t be updated until the call persistKey() action is invoked with the token value from this step and confirmation codes sent to UDIDs. 
> The list of UDIDs used as confirmation tokens recipients will be listed as user_ids response parameters.

``` {.cpp}
#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/client/Credentials.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>
#include <virgil/sdk/keys/model/UserData.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::client::Credentials;
using virgil::sdk::keys::model::PublicKey;
using virgil::sdk::keys::model::UserData;
using virgil::sdk::keys::io::Marshaller;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string USER_EMAIL = "test.virgilsecurity@mailinator.com";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main() {
    try {
        std::cout << "Read old virgil public key..." << std::endl;
        std::ifstream oldPublicKeyFile("virgil_public.key", std::ios::in | std::ios::binary);
        if (!oldPublicKeyFile.good()) {
            throw std::runtime_error("can not read virgil public key: virgil_public.key");
        }
        std::string oldPublicKeyData((std::istreambuf_iterator<char>(oldPublicKeyFile)),
                std::istreambuf_iterator<char>());

        PublicKey oldPublicKey = Marshaller<PublicKey>::fromJson(oldPublicKeyData);

        std::cout << "Read new virgil public key..." << std::endl;
        std::ifstream newPublicKeyFile("new_public.key", std::ios::in | std::ios::binary);
        if (!newPublicKeyFile.good()) {
            throw std::runtime_error("can not read virgil public key: new_public.key");
        }
        VirgilByteArray newPublicKey;
        std::copy(std::istreambuf_iterator<char>(newPublicKeyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(newPublicKey));

        std::cout << "Read new private key..." << std::endl;
        std::ifstream newPrivateKeyFile("new_private.key", std::ios::in | std::ios::binary);
        if (!newPrivateKeyFile.good()) {
            throw std::runtime_error("can not read private key: new_private.key");
        }
        VirgilByteArray newPrivateKey;
        std::copy(std::istreambuf_iterator<char>(newPrivateKeyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(newPrivateKey));

        Credentials newKeyCredentials(newPrivateKey);

        std::cout << "Create Keys Service HTTP Client" << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);

        std::cout << "Call Keys Service to reset Public Key instance." << std::endl;
        std::string confirmInfo = keysClient.publicKey().reset(oldPublicKey.publicKeyId(),
                newPublicKey, newKeyCredentials, uuid());
        std::cout << confirmInfo << std::endl;
        std::cout << "Public Key instance successfully reset." << std::endl;

    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }

    return 0;
}

std::string uuid () {
    auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);

    uint32_t time_low = ((generator() << 16) & 0xffff0000) | (generator() & 0xffff);
    uint16_t time_mid = generator() & 0xffff;
    uint16_t time_high_and_version = (generator() & 0x0fff) | 0x4000;
    uint16_t clock_seq = (generator() & 0x3fff) | 0x8000;
    uint8_t node [6];
    for (size_t i = 0; i < 6; ++i) {
        node[i] = generator() & 0xff;
    }

    char buffer[37] = {0x0};
    sprintf(buffer, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        time_low, time_mid, time_high_and_version, clock_seq >> 8, clock_seq & 0xff,
        node[0], node[1], node[2], node[3], node[4], node[5]);

    return std::string(buffer);
}
```


## Confirm a Public Key

> Confirms the reset or delete a Public Key operation from the Virgil Public Keys service.

> The confirmation code will be sent to the email/phone etc. Usually the client application should provide opportunities for input appropriate confirmation code.


### Confirm  the delete a Public Key operation ( unsigned version )
``` {.cpp}
#include <fstream>
#include <iostream>
#include <iterator>
#include <stdexcept>
#include <string>

#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";

int main(int argc, char **argv) {
    if (argc < 3) {
        std::cerr << std::string("USAGE: ") + argv[0] + " <action_token> <confirmation_codes>" << std::endl;
        return 0;
    }
    try {
        const std::string actionToken = argv[1];
        const std::string confirmationCodes = argv[2];

        std::cout << "Read virgil public key..." << std::endl;
        std::ifstream publicKeyFile("virgil_public.key", std::ios::in | std::ios::binary);
        if (!publicKeyFile.good()) {
            throw std::runtime_error("can not read virgil public key: virgil_public.key");
        }
        std::string publicKeyData((std::istreambuf_iterator<char>(publicKeyFile)),
                std::istreambuf_iterator<char>());

        PublicKey publicKey = Marshaller<PublicKey>::fromJson(publicKeyData);

        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);

        std::cout << "Call Keys service to confirm delete Public Key instance." << std::endl;
        keysClient.publicKey().confirmDel(publicKey.publicKeyId(), actionToken, {confirmationCodes});
        std::cout << "Call Keys service to confirm delete Public Key instance." << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }

    return 0;
}

```

### Confirm  the reset a Public Key operation
``` {.cpp}
#include <fstream>
#include <iostream>
#include <iterator>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/client/Credentials.h>
#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::client::Credentials;
using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";

int main(int argc, char **argv) {
    if (argc < 3) {
        std::cerr << std::string("USAGE: ") + argv[0] + " <action_token> <confirmation_codes>" << std::endl;
        return 0;
    }
    try {
        const std::string actionToken = argv[1];
        const std::string confirmationCodes = argv[2];

        std::cout << "Read old virgil public key..." << std::endl;
        std::ifstream oldPublicKeyFile("virgil_public.key", std::ios::in | std::ios::binary);
        if (!oldPublicKeyFile.good()) {
            throw std::runtime_error("can not read virgil public key: virgil_public.key");
        }
        std::string oldPublicKeyData((std::istreambuf_iterator<char>(oldPublicKeyFile)),
                std::istreambuf_iterator<char>());

        PublicKey oldPublicKey = Marshaller<PublicKey>::fromJson(oldPublicKeyData);

        std::cout << "Read new private key..." << std::endl;
        std::ifstream newPrivateKeyFile("private.key", std::ios::in | std::ios::binary);
        if (!newPrivateKeyFile.good()) {
            throw std::runtime_error("can not read private key: private.key");
        }
        VirgilByteArray newPrivateKey((std::istreambuf_iterator<char>(newPrivateKeyFile)),
                std::istreambuf_iterator<char>());

        Credentials newKeyCredentials(newPrivateKey);

        std::cout << "Create Keys Service HTTP Client" << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);

        std::cout << "Call Keys service to confirm reset Public Key instance." << std::endl;
        keysClient.publicKey().confirmReset(oldPublicKey.publicKeyId(), newKeyCredentials,
                actionToken, {confirmationCodes});
        std::cout << "Public Key instance successfully confirm reset." << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }

    return 0;
}
```

## Create Public Key User Data

> Append UDIDs and UDINFOs to Public Keys for the current application.

``` {.cpp}
#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <string>
#include <stdexcept>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/client/Credentials.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>
#include <virgil/sdk/keys/model/UserData.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::client::Credentials;
using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;
using virgil::sdk::keys::model::UserData;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string USER_EMAIL = "test.virgilsecurity@mailinator.com";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main() {
    try {
        std::cout << "Read virgil public key..." << std::endl;
        std::ifstream publicKeyFile("virgil_public.key", std::ios::in | std::ios::binary);
        if (!publicKeyFile.good()) {
            throw std::runtime_error("can not read virgil public key: virgil_public.key");
        }
        std::string publicKeyData((std::istreambuf_iterator<char>(publicKeyFile)),
                std::istreambuf_iterator<char>());

        PublicKey publicKey = Marshaller<PublicKey>::fromJson(publicKeyData);

        std::cout << "Read private key..." << std::endl;
        std::ifstream keyFile("private.key", std::ios::in | std::ios::binary);
        if (!keyFile.good()) {
            throw std::runtime_error("can not read private key: private.key");
        }
        VirgilByteArray privateKey;
        std::copy(std::istreambuf_iterator<char>(keyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(privateKey));

        Credentials credentials(publicKey.publicKeyId(), privateKey);

        std::cout << "Create user (" << USER_EMAIL << ") account on the Virgil PKI service..." << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);
        UserData userData = UserData::email(USER_EMAIL);

        std::cout << "Call Keys service to create User Data instance." << std::endl;
        UserData userDataResponse = keysClient.userData().add(userData, credentials, uuid());

        std::string data = Marshaller<UserData>::toJson(userDataResponse);
        std::cout << data << std::endl;
        std::cout << "User Data instance successfully created in Public Keys service." << std::endl;

    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }

    return 0;
}

std::string uuid () {
    auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);

    uint32_t time_low = ((generator() << 16) & 0xffff0000) | (generator() & 0xffff);
    uint16_t time_mid = generator() & 0xffff;
    uint16_t time_high_and_version = (generator() & 0x0fff) | 0x4000;
    uint16_t clock_seq = (generator() & 0x3fff) | 0x8000;
    uint8_t node [6];
    for (size_t i = 0; i < 6; ++i) {
        node[i] = generator() & 0xff;
    }

    char buffer[37] = {0x0};
    sprintf(buffer, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        time_low, time_mid, time_high_and_version, clock_seq >> 8, clock_seq & 0xff,
        node[0], node[1], node[2], node[3], node[4], node[5]);

    return std::string(buffer);
}
```

## Delete User Data from the Public Key


``` {.cpp}
#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/client/Credentials.h>
#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::client::Credentials;
using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main(int argc, char **argv) {
    if (argc < 2) {
        std::cerr << std::string("USAGE: ") + argv[0] + " <user_data_id>" << std::endl;
        return 0;
    }

    try {
        const std::string kUserDataId = argv[1];

        std::cout << "Read virgil public key..." << std::endl;
        std::ifstream publicKeyFile("virgil_public.key", std::ios::in | std::ios::binary);
        if (!publicKeyFile.good()) {
            throw std::runtime_error("can not read virgil public key: virgil_public.key");
        }
        std::string publicKeyData;
        std::copy(std::istreambuf_iterator<char>(publicKeyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(publicKeyData));

        PublicKey publicKey = Marshaller<PublicKey>::fromJson(publicKeyData);

        std::cout << "Read private key..." << std::endl;
        std::ifstream keyFile("private.key", std::ios::in | std::ios::binary);
        if (!keyFile.good()) {
            throw std::runtime_error("can not read private key: private.key");
        }
        VirgilByteArray privateKey;
        std::copy(std::istreambuf_iterator<char>(keyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(privateKey));

        Credentials credentials(publicKey.publicKeyId(), privateKey);

        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);

        std::cout << "Call Keys service to delete User Data instance." << std::endl;
        keysClient.userData().del(kUserDataId, credentials, uuid());
        std::cout << "User Data instance successfully deleted from Public Keys service." << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }

    return 0;
}

std::string uuid () {
    auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);

    uint32_t time_low = ((generator() << 16) & 0xffff0000) | (generator() & 0xffff);
    uint16_t time_mid = generator() & 0xffff;
    uint16_t time_high_and_version = (generator() & 0x0fff) | 0x4000;
    uint16_t clock_seq = (generator() & 0x3fff) | 0x8000;
    uint8_t node [6];
    for (size_t i = 0; i < 6; ++i) {
        node[i] = generator() & 0xff;
    }

    char buffer[37] = {0x0};
    sprintf(buffer, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        time_low, time_mid, time_high_and_version, clock_seq >> 8, clock_seq & 0xff,
        node[0], node[1], node[2], node[3], node[4], node[5]);

    return std::string(buffer);
}

```

## Confirm User Data

``` {.cpp}
#include <chrono>
#include <iostream>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/model/PublicKey.h>

using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::model::PublicKey;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main(int argc, char **argv) {
    if (argc < 3) {
        std::cerr << std::string("USAGE: ") + argv[0] + " <user_data_id> <confirmation_code>" << std::endl;
        return 0;
    }
    try {
        const std::string kUserDataId = argv[1];
        const std::string kConfirmationCode = argv[2];

        std::cout << "Confirm user data with id ("<<kUserDataId <<
                ") and code (" << kConfirmationCode << ")." << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);
        keysClient.userData().confirm(kUserDataId, kConfirmationCode, uuid());
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }
    return 0;
}

std::string uuid () {
    auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);

    uint32_t time_low = ((generator() << 16) & 0xffff0000) | (generator() & 0xffff);
    uint16_t time_mid = generator() & 0xffff;
    uint16_t time_high_and_version = (generator() & 0x0fff) | 0x4000;
    uint16_t clock_seq = (generator() & 0x3fff) | 0x8000;
    uint8_t node [6];
    for (size_t i = 0; i < 6; ++i) {
        node[i] = generator() & 0xff;
    }

    char buffer[37] = {0x0};
    sprintf(buffer, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        time_low, time_mid, time_high_and_version, clock_seq >> 8, clock_seq & 0xff,
        node[0], node[1], node[2], node[3], node[4], node[5]);

    return std::string(buffer);
}

```


## Resend a User's Confirmation Code

``` {.cpp}
#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/client/Credentials.h>
#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::client::Credentials;
using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main(int argc, char **argv) {
    if (argc < 2) {
        std::cerr << std::string("USAGE: ") + argv[0] + " <user_data_id>" << std::endl;
        return 0;
    }
    try {
        const std::string kUserDataId = argv[1];

        std::cout << "Read virgil public key..." << std::endl;
        std::ifstream publicKeyFile("virgil_public.key", std::ios::in | std::ios::binary);
        if (!publicKeyFile.good()) {
            throw std::runtime_error("can not read virgil public key: virgil_public.key");
        }
        std::string publicKeyData;
        std::copy(std::istreambuf_iterator<char>(publicKeyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(publicKeyData));

        PublicKey publicKey = Marshaller<PublicKey>::fromJson(publicKeyData);

        std::cout << "Read private key..." << std::endl;
        std::ifstream keyFile("private.key", std::ios::in | std::ios::binary);
        if (!keyFile.good()) {
            throw std::runtime_error("can not read private key: private.key");
        }
        VirgilByteArray privateKey;
        std::copy(std::istreambuf_iterator<char>(keyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(privateKey));

        Credentials credentials(publicKey.publicKeyId(), privateKey);

        std::cout << "Resend confirmation code for user data with id (" << kUserDataId << ")." << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);
        keysClient.userData().resendConfirmation(kUserDataId, credentials, uuid());
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }
    return 0;
}

std::string uuid () {
    auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator(seed);

    uint32_t time_low = ((generator() << 16) & 0xffff0000) | (generator() & 0xffff);
    uint16_t time_mid = generator() & 0xffff;
    uint16_t time_high_and_version = (generator() & 0x0fff) | 0x4000;
    uint16_t clock_seq = (generator() & 0x3fff) | 0x8000;
    uint8_t node [6];
    for (size_t i = 0; i < 6; ++i) {
        node[i] = generator() & 0xff;
    }

    char buffer[37] = {0x0};
    sprintf(buffer, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        time_low, time_mid, time_high_and_version, clock_seq >> 8, clock_seq & 0xff,
        node[0], node[1], node[2], node[3], node[4], node[5]);

    return std::string(buffer);
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
