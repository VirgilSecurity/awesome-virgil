# C++ Crypto Library

- [Generate Keys](#generate-keys)
- [Encrypt and Decrypt data using Key](#encrypt-and-decrypt-data-using-key)
- [Sign and Verify data using Key](#sign-and-verify-data-using-key)
  
## Generate Keys

``` {.cpp}
#include <algorithm>
#include <fstream>
#include <iostream>
#include <iterator>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>
#include <virgil/crypto/VirgilKeyPair.h>

using virgil::crypto::VirgilByteArray;
using virgil::crypto::VirgilKeyPair;

int main() {
    try {
        std::cout << "Generate keys" << std::endl;
        VirgilKeyPair newKeyPair; // Specify password in the constructor to make private key encrypted.

        std::cout << "Store public key: new_public.key ..." << std::endl;
        std::ofstream publicKeyStream("new_public.key", std::ios::out | std::ios::binary);
        if (!publicKeyStream.good()) {
            throw std::runtime_error("can not write file: new_public.key");
        }
        VirgilByteArray publicKey = newKeyPair.publicKey();
        std::copy(publicKey.begin(), publicKey.end(), std::ostreambuf_iterator<char>(publicKeyStream));

        std::cout << "Store private key: new_private.key ..." << std::endl;
        std::ofstream privateKeyStream("new_private.key", std::ios::out | std::ios::binary);
        if (!privateKeyStream.good()) {
            throw std::runtime_error("can not write file: new_private.key");
        }
        VirgilByteArray privateKey = newKeyPair.privateKey();
        std::copy(privateKey.begin(), privateKey.end(), std::ostreambuf_iterator<char>(privateKeyStream));
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }
    return 0;
}
```


## Encrypt and Decrypt data using Key

> Initial data must be passed in [Base64](https://en.wikipedia.org/wiki/Base64) format.

> Encrypted data also will be returned in [Base64](https://en.wikipedia.org/wiki/Base64) format.

### Encrypt data using Key
``` {.cpp}
#include <algorithm>
#include <fstream>
#include <iostream>
#include <iterator>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>
#include <virgil/crypto/VirgilStreamCipher.h>
#include <virgil/crypto/stream/VirgilStreamDataSource.h>
#include <virgil/crypto/stream/VirgilStreamDataSink.h>

#include <virgil/sdk/keys/model/PublicKey.h>
#include <virgil/sdk/keys/io/Marshaller.h>

using virgil::crypto::VirgilByteArray;
using virgil::crypto::VirgilStreamCipher;
using virgil::crypto::stream::VirgilStreamDataSource;
using virgil::crypto::stream::VirgilStreamDataSink;

using virgil::sdk::keys::model::PublicKey;
using virgil::sdk::keys::io::Marshaller;

int main() {
    try {
        std::cout << "Prepare input file: test.txt.enc..." << std::endl;
        std::ifstream inFile("test.txt.enc", std::ios::in | std::ios::binary);
        if (!inFile.good()) {
            throw std::runtime_error("can not read file: test.txt.enc");
        }

        std::cout << "Prepare output file: decrypted_test.txt..." << std::endl;
        std::ofstream outFile("decrypted_test.txt", std::ios::out | std::ios::binary);
        if (!outFile.good()) {
            throw std::runtime_error("can not write file: decrypted_test.txt");
        }

        std::cout << "Initialize cipher..." << std::endl;
        VirgilStreamCipher cipher;

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

        std::cout << "Decrypt..." << std::endl;
        VirgilStreamDataSource dataSource(inFile);
        VirgilStreamDataSink dataSink(outFile);
        cipher.decryptWithKey(dataSource, dataSink, virgil::crypto::str2bytes(publicKey.publicKeyId()), privateKey);
        std::cout << "Decrypted data is successfully stored in the output file..." << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }
    return 0;
}
```

### Decrypt data using Key
``` {.cpp}
#include <algorithm>
#include <fstream>
#include <iostream>
#include <iterator>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>
#include <virgil/crypto/VirgilStreamCipher.h>
#include <virgil/crypto/stream/VirgilStreamDataSource.h>
#include <virgil/crypto/stream/VirgilStreamDataSink.h>

#include <virgil/sdk/keys/model/PublicKey.h>
#include <virgil/sdk/keys/io/Marshaller.h>

using virgil::crypto::VirgilByteArray;
using virgil::crypto::VirgilStreamCipher;
using virgil::crypto::stream::VirgilStreamDataSource;
using virgil::crypto::stream::VirgilStreamDataSink;

using virgil::sdk::keys::model::PublicKey;
using virgil::sdk::keys::io::Marshaller;

int main() {
    try {
        std::cout << "Prepare input file: test.txt.enc..." << std::endl;
        std::ifstream inFile("test.txt.enc", std::ios::in | std::ios::binary);
        if (!inFile.good()) {
            throw std::runtime_error("can not read file: test.txt.enc");
        }

        std::cout << "Prepare output file: decrypted_test.txt..." << std::endl;
        std::ofstream outFile("decrypted_test.txt", std::ios::out | std::ios::binary);
        if (!outFile.good()) {
            throw std::runtime_error("can not write file: decrypted_test.txt");
        }

        std::cout << "Initialize cipher..." << std::endl;
        VirgilStreamCipher cipher;

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

        std::cout << "Decrypt..." << std::endl;
        VirgilStreamDataSource dataSource(inFile);
        VirgilStreamDataSink dataSink(outFile);
        cipher.decryptWithKey(dataSource, dataSink, virgil::crypto::str2bytes(publicKey.publicKeyId()), privateKey);
        std::cout << "Decrypted data is successfully stored in the output file..." << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }
    return 0;
}
```



## Sign and Verify data using Key

> Initial data must be passed in [Base64](https://en.wikipedia.org/wiki/Base64) format.

> Encrypted data also will be returned in [Base64](https://en.wikipedia.org/wiki/Base64) format.

### Sign data using Key

``` {.cpp}
#include <algorithm>
#include <fstream>
#include <iostream>
#include <iterator>
#include <stdexcept>
#include <string>

#include <virgil/crypto/VirgilByteArray.h>
#include <virgil/crypto/VirgilStreamSigner.h>
#include <virgil/crypto/stream/VirgilStreamDataSource.h>

using virgil::crypto::VirgilByteArray;
using virgil::crypto::VirgilStreamSigner;
using virgil::crypto::stream::VirgilStreamDataSource;

int main() {
    try {
        std::cout << "Prepare input file: test.txt..." << std::endl;
        std::ifstream inFile("test.txt", std::ios::in | std::ios::binary);
        if (!inFile.good()) {
            throw std::runtime_error("can not read file: test.txt");
        }

        std::cout << "Prepare output file: test.txt.sign..." << std::endl;
        std::ofstream outFile("test.txt.sign", std::ios::out | std::ios::binary);
        if (!outFile.good()) {
            throw std::runtime_error("can not write file: test.txt.sign");
        }

        std::cout << "Read private key..." << std::endl;
        std::ifstream keyFile("private.key", std::ios::in | std::ios::binary);
        if (!keyFile.good()) {
            throw std::runtime_error("can not read private key: private.key");
        }
        VirgilByteArray privateKey;
        std::copy(std::istreambuf_iterator<char>(keyFile), std::istreambuf_iterator<char>(),
                std::back_inserter(privateKey));

        std::cout << "Initialize signer..." << std::endl;
        VirgilStreamSigner signer;

        std::cout << "Sign data..." << std::endl;
        VirgilStreamDataSource dataSource(inFile);
        VirgilByteArray sign = signer.sign(dataSource, privateKey);

        std::cout << "Save sign..." << std::endl;
        std::copy(sign.begin(), sign.end(), std::ostreambuf_iterator<char>(outFile));

        std::cout << "Sign is successfully stored in the output file." << std::endl;
    } catch (std::exception& exception) {
        std::cerr << "Error: " << exception.what() << std::endl;
    }
    return 0;
}
```

### Verify data using Key
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
#include <virgil/crypto/VirgilStreamSigner.h>
#include <virgil/crypto/stream/VirgilStreamDataSource.h>

#include <virgil/sdk/keys/client/KeysClient.h>
#include <virgil/sdk/keys/model/PublicKey.h>

using virgil::crypto::VirgilByteArray;
using virgil::crypto::VirgilStreamSigner;
using virgil::crypto::stream::VirgilStreamDataSource;

using virgil::sdk::keys::client::KeysClient;
using virgil::sdk::keys::model::PublicKey;

const std::string VIRGIL_PKI_URL_BASE = "https://keys.virgilsecurity.com/";
const std::string VIRGIL_APP_TOKEN = "45fd8a505f50243fa8400594ba0b2b29";
const std::string SIGNER_EMAIL = "test.virgilsecurity@mailinator.com";

/**
 * @brief Generate new UUID
 */
std::string uuid();

int main() {
    try {
        std::cout << "Prepare input file: test.txt..." << std::endl;
        std::ifstream inFile("test.txt", std::ios::in | std::ios::binary);
        if (!inFile.good()) {
            throw std::runtime_error("can not read file: test.txt");
        }

        std::cout << "Read virgil sign..." << std::endl;
        std::ifstream signFile("test.txt.sign", std::ios::in | std::ios::binary);
        if (!signFile.good()) {
            throw std::runtime_error("can not read sign: test.txt.sign");
        }
        VirgilByteArray sign;
        std::copy(std::istreambuf_iterator<char>(signFile), std::istreambuf_iterator<char>(),
                std::back_inserter(sign));

        std::cout << "Get signer ("<< SIGNER_EMAIL << ") public key from the Virgil PKI service..." << std::endl;
        KeysClient keysClient(VIRGIL_APP_TOKEN, VIRGIL_PKI_URL_BASE);
        PublicKey publicKey = keysClient.publicKey().grab(SIGNER_EMAIL, uuid());

        std::cout << "Initialize verifier..." << std::endl;
        VirgilStreamSigner signer;

        std::cout << "Verify data..." << std::endl;
        VirgilStreamDataSource dataSource(inFile);
        bool verified = signer.verify(dataSource, sign, publicKey.key());

        std::cout << "Data is " << (verified ? "" : "not ") << "verified!" << std::endl;
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
