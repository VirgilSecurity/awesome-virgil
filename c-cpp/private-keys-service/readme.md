# С++ Private Keys Service

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


``` {.cpp}
#include <chrono>
#include <cstddef>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

#include <virgil/sdk/privatekeys/client/Credentials.h>
#include <virgil/sdk/privatekeys/client/PrivateKeysClient.h>
#include <virgil/sdk/privatekeys/model/ContainerType.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

using virgil::sdk::privatekeys::client::Credentials;
using virgil::sdk::privatekeys::client::PrivateKeysClient;
using virgil::sdk::privatekeys::model::ContainerType;

const std::string VIRGIL_PK_URL_BASE = "https://keys-private.virgilsecurity.com";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const ContainerType CONTAINER_TYPE = ContainerType::Normal;
const std::string CONTAINER_PASSWORD = "123456789";

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

        VirgilByteArray privateKey((std::istreambuf_iterator<char>(keyFile)),
                std::istreambuf_iterator<char>());

        Credentials credentials(publicKey.publicKeyId(), privateKey);

        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        PrivateKeysClient privateKeysClient(VIRGIL_APP_TOKEN, VIRGIL_PK_URL_BASE);

        std::cout << "Call the Private Key service to create a Container instance." << std::endl;
        privateKeysClient.container().create(credentials, CONTAINER_TYPE, CONTAINER_PASSWORD, uuid());
        std::cout << "Container instance successfully created in the Private Keys service." << std::endl;
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


## Get Container Object


``` {.cpp}
#include <fstream>
#include <iostream>
#include <iterator>
#include <stdexcept>
#include <string>

#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

#include <virgil/sdk/privatekeys/client/PrivateKeysClient.h>
#include <virgil/sdk/privatekeys/model/ContainerType.h>
#include <virgil/sdk/privatekeys/model/UserData.h>

using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

using virgil::sdk::privatekeys::client::PrivateKeysClient;
using virgil::sdk::privatekeys::model::ContainerType;
using virgil::sdk::privatekeys::model::UserData;

const std::string VIRGIL_PK_URL_BASE = "https://keys-private.virgilsecurity.com";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string USER_EMAIL = "test.virgilsecurity@mailinator.com";
const std::string CONTAINER_PASSWORD = "123456789";

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

        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        PrivateKeysClient privateKeysClient(VIRGIL_APP_TOKEN, VIRGIL_PK_URL_BASE);

        std::cout << "Authenticate session." << std::endl;
        UserData userData = UserData::email(USER_EMAIL);
        privateKeysClient.authenticate(userData, CONTAINER_PASSWORD);

        std::cout << "Call Private Key service to get Container Details instance." << std::endl;
        ContainerType containerType = privateKeysClient.container().getDetails(publicKey.publicKeyId());
        std::cout << "Container instance successfully fetched from Private Keys service." << std::endl;
        std::cout << "container_type: " << virgil::sdk::privatekeys::model::toString(containerType) << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }

    return 0;
}

```


## Delete Container Object


``` {.cpp}
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

#include <virgil/sdk/privatekeys/client/Credentials.h>
#include <virgil/sdk/privatekeys/client/PrivateKeysClient.h>
#include <virgil/sdk/privatekeys/model/UserData.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

using virgil::sdk::privatekeys::client::Credentials;
using virgil::sdk::privatekeys::client::PrivateKeysClient;
using virgil::sdk::privatekeys::model::UserData;

const std::string VIRGIL_PK_URL_BASE = "https://keys-private.virgilsecurity.com";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string USER_EMAIL = "test.virgilsecurity@mailinator.com";
const std::string CONTAINER_PASSWORD = "123456789";

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

        VirgilByteArray privateKey((std::istreambuf_iterator<char>(keyFile)),
                std::istreambuf_iterator<char>());

        Credentials credentials(publicKey.publicKeyId(), privateKey);

        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        PrivateKeysClient privateKeysClient(VIRGIL_APP_TOKEN, VIRGIL_PK_URL_BASE);

        std::cout << "Authenticate session..." << std::endl;
        UserData userData = UserData::email(USER_EMAIL);
        privateKeysClient.authenticate(userData, CONTAINER_PASSWORD);

        std::cout << "Call Private Key service to delete Container instance." << std::endl;
        privateKeysClient.container().del(credentials, uuid());
        std::cout << "Container instance successfully deleted from Private Keys service." << std::endl;
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


## Update Container Object

> By invoking this method you can change the Container Type or|and Container Password


``` {.cpp}
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

#include <virgil/sdk/privatekeys/client/Credentials.h>
#include <virgil/sdk/privatekeys/client/PrivateKeysClient.h>
#include <virgil/sdk/privatekeys/model/ContainerType.h>
#include <virgil/sdk/privatekeys/model/UserData.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

using virgil::sdk::privatekeys::client::Credentials;
using virgil::sdk::privatekeys::client::PrivateKeysClient;
using virgil::sdk::privatekeys::model::ContainerType;
using virgil::sdk::privatekeys::model::UserData;

const std::string VIRGIL_PK_URL_BASE = "https://keys-private.virgilsecurity.com";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string USER_EMAIL = "test.virgilsecurity@mailinator.com";
const std::string CONTAINER_PASSWORD = "987654321";

const ContainerType CONTAINER_NEW_TYPE = ContainerType::Normal;
const std::string CONTAINER_NEW_PASSWORD = "123456789";

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

        VirgilByteArray privateKey((std::istreambuf_iterator<char>(keyFile)),
                std::istreambuf_iterator<char>());

        Credentials credentials(publicKey.publicKeyId(), privateKey);

        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        PrivateKeysClient privateKeysClient(VIRGIL_APP_TOKEN, VIRGIL_PK_URL_BASE);

        std::cout << "Authenticate session..." << std::endl;
        UserData userData = UserData::email(USER_EMAIL);
        privateKeysClient.authenticate(userData, CONTAINER_PASSWORD);

        std::cout << "Call the Private Key service to update Container instance." << std::endl;
        privateKeysClient.container().update(credentials, CONTAINER_NEW_TYPE, CONTAINER_NEW_PASSWORD, uuid());
        std::cout << "Container instance successfully update in the Private Keys service." << std::endl;
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


## Reset the Container Password

> A user can reset their Private Key object password if the Container Type equals 'easy'. 
> If the Container Type equals 'normal', the Private Key object will be stored in its original form.


``` {.cpp}
#include <iostream>
#include <stdexcept>
#include <string>

#include <virgil/sdk/privatekeys/client/PrivateKeysClient.h>
#include <virgil/sdk/privatekeys/model/UserData.h>

using virgil::sdk::privatekeys::client::PrivateKeysClient;
using virgil::sdk::privatekeys::model::UserData;

const std::string VIRGIL_PK_URL_BASE = "https://keys-private.virgilsecurity.com";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string USER_EMAIL = "test.virgilsecurity@mailinator.com";

int main(int argc, char **argv) {
    if (argc < 2) {
        std::cerr << std::string("USAGE: ") + argv[0] + " <new_container_password>" << std::endl;
        return 0;
    }

    try {
        const std::string kNewContainerPassword = argv[1];

        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        PrivateKeysClient privateKeysClient(VIRGIL_APP_TOKEN, VIRGIL_PK_URL_BASE);

        std::cout << "Call the Private Key service to reset a Container password." << std::endl;
        privateKeysClient.container().resetPassword(UserData::email(USER_EMAIL), kNewContainerPassword);
        std::cout << "Container password successfully reset." << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }

    return 0;
}

```


## Persist Container Object

> The token generated during the container reset invocation only lives for 60 minutes.

``` {.cpp}
#include <chrono>
#include <iostream>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/sdk/privatekeys/client/PrivateKeysClient.h>

using virgil::sdk::privatekeys::client::PrivateKeysClient;

const std::string VIRGIL_PK_URL_BASE = "https://keys-private.virgilsecurity.com";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main(int argc, char **argv) {
    if (argc < 2) {
        std::cerr << std::string("USAGE: ") + argv[0] + " <confirmation_code>" << std::endl;
        return 0;
    }

    try {
        const std::string kConfirmationToken = argv[1];
        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        PrivateKeysClient privateKeysClient(VIRGIL_APP_TOKEN, VIRGIL_PK_URL_BASE);

        std::cout << "Call the Private Key service to persist the container." << std::endl;
        privateKeysClient.container().confirm(kConfirmationToken, uuid());
        std::cout << "Container successfully persisted." << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }

    return 0;
}

std::string uuid() {
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

## Create a Private Key inside the Container Object

> Load an existing Private Key into the Private Keys service and associate it with the existing Container object.

``` {.cpp}
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

#include <virgil/sdk/privatekeys/client/Credentials.h>
#include <virgil/sdk/privatekeys/client/PrivateKeysClient.h>
#include <virgil/sdk/privatekeys/model/UserData.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

using virgil::sdk::privatekeys::client::Credentials;
using virgil::sdk::privatekeys::client::PrivateKeysClient;
using virgil::sdk::privatekeys::model::UserData;

const std::string VIRGIL_PK_URL_BASE = "https://keys-private.virgilsecurity.com";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string USER_EMAIL = "test.virgilsecurity@mailinator.com";
const std::string CONTAINER_PASSWORD = "123456789";

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

        VirgilByteArray privateKey((std::istreambuf_iterator<char>(keyFile)),
                std::istreambuf_iterator<char>());

        Credentials credentials(publicKey.publicKeyId(), privateKey);

        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        PrivateKeysClient privateKeysClient(VIRGIL_APP_TOKEN, VIRGIL_PK_URL_BASE);

        std::cout << "Authenticate session..." << std::endl;
        UserData userData = UserData::email(USER_EMAIL);
        privateKeysClient.authenticate(userData, CONTAINER_PASSWORD);

        std::cout << "Call the Private Key service to add a Private Key instance." << std::endl;
        privateKeysClient.privateKey().add(credentials, uuid());
        std::cout << "Private Key instance successfully added in the Private Keys service." << std::endl;
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


## Get Private Key Object


``` {.cpp}
#include <algorithm>
#include <fstream>
#include <iostream>
#include <iterator>
#include <stdexcept>
#include <string>

#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

#include <virgil/sdk/privatekeys/client/PrivateKeysClient.h>
#include <virgil/sdk/privatekeys/model/PrivateKey.h>
#include <virgil/sdk/privatekeys/model/UserData.h>

using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

using virgil::sdk::privatekeys::model::PrivateKey;
using virgil::sdk::privatekeys::client::PrivateKeysClient;
using virgil::sdk::privatekeys::model::UserData;

const std::string VIRGIL_PK_URL_BASE = "https://keys-private.virgilsecurity.com";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string USER_EMAIL = "test.virgilsecurity@mailinator.com";
const std::string CONTAINER_PASSWORD = "123456789";

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

        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        PrivateKeysClient privateKeysClient(VIRGIL_APP_TOKEN, VIRGIL_PK_URL_BASE);

        std::cout << "Authenticate session..." << std::endl;
        UserData userData = UserData::email(USER_EMAIL);
        privateKeysClient.authenticate(userData, CONTAINER_PASSWORD);

        std::cout << "Call the Private Key service to get a Private Key instance." << std::endl;
        PrivateKey privateKey = privateKeysClient.privateKey().get(publicKey.publicKeyId());

        std::cout << "Private Key instance successfully fetched from the Private Keys service." << std::endl;
        std::cout << "Public key id: " << privateKey.publicKeyId() << std::endl;
        std::cout << "Private key: " << std::endl;
        std::vector<unsigned char> key = privateKey.key();
        std::copy(key.begin(), key.end(), std::ostreambuf_iterator<char>(std::cout));
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }

    return 0;
}

```


## Delete Private Key Object

> Delete a Private Key object. A Private Key object will be disconnected from the Container Object and then deleted from the Private Key service.

``` {.cpp}
#include <chrono>
#include <fstream>
#include <iostream>
#include <iterator>
#include <random>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>

#include <virgil/sdk/keys/io/Marshaller.h>
#include <virgil/sdk/keys/model/PublicKey.h>

#include <virgil/sdk/privatekeys/client/Credentials.h>
#include <virgil/sdk/privatekeys/client/PrivateKeysClient.h>
#include <virgil/sdk/privatekeys/model/UserData.h>

using virgil::crypto::VirgilByteArray;

using virgil::sdk::keys::io::Marshaller;
using virgil::sdk::keys::model::PublicKey;

using virgil::sdk::privatekeys::client::Credentials;
using virgil::sdk::privatekeys::client::PrivateKeysClient;
using virgil::sdk::privatekeys::model::ContainerType;
using virgil::sdk::privatekeys::model::UserData;

const std::string VIRGIL_PK_URL_BASE = "https://keys-private.virgilsecurity.com";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string USER_EMAIL = "test.virgilsecurity@mailinator.com";
const std::string CONTAINER_PASSWORD = "123456789";

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

        VirgilByteArray privateKey((std::istreambuf_iterator<char>(keyFile)),
                std::istreambuf_iterator<char>());

        Credentials credentials(publicKey.publicKeyId(), privateKey);

        std::cout << "Create Private Keys Service HTTP Client." << std::endl;
        PrivateKeysClient privateKeysClient(VIRGIL_APP_TOKEN, VIRGIL_PK_URL_BASE);

        std::cout << "Authenticate session..." << std::endl;
        UserData userData = UserData::email(USER_EMAIL);
        privateKeysClient.authenticate(userData, CONTAINER_PASSWORD);

        std::cout << "Call Private Key service to delete Private Key instance." << std::endl;
        privateKeysClient.privateKey().del(credentials, uuid());
        std::cout << "The Private Key instance was successfully deleted from the Private Keys service." << std::endl;
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
<div class="title">Quick Navigation</div>

<div class="menu-items-wrapper" data-ui="menu-items-wrapper"></div>
</div>
</div>
</div>
</div>
</section>
</div>
