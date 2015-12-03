
# C++ Crypto Library

- [Generate Keys](#generate-keys)
- [Encrypt and Decrypt data using keys](#encrypt-and-decrypt-using-keys)
- [Encrypt and Decrypt data using password](#encrypt-and-decrypt-using-password)
- [Encrypt data for multiple recipients](#encrypt-using-multiple-recipients)
- [Sign and Verify data](#sign-and-verify-data)

## Generate Keys \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/keygen.cxx)\]

```cpp
// Specify password in the constructor to store private key encrypted.
// VirgilByteArray pwd = virgil::crypto::str2bytes("strong private key password");
// VirgilKeyPair newKeyPair(pwd);

VirgilKeyPair newKeyPair;
VirgilByteArray publicKey = newKeyPair.publicKey();
VirgilByteArray privateKey = newKeyPair.privateKey();
```

## Encrypt and Decrypt data using keys

### Encrypt data \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/encrypt_with_key.cxx)\]

```cpp
VirgilStreamCipher cipher;
cipher.addKeyRecipient(publicKeyId, publicKey.key());
cipher.encrypt(dataSource, dataSink, true);
```

### Decrypt data \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/decrypt_with_key.cxx)\]

```cpp
VirgilStreamCipher cipher;
// using private key with password
// cipher.decryptWithKey(dataSource, dataSink, publicKeyId, privateKey, privateKeyPwd);
cipher.decryptWithKey(dataSource, dataSink, publicKeyId, privateKey);
```

## Encrypt and Decrypt data using password

### Encrypt data \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/encrypt_with_pass.cxx)\]

```cpp
VirgilStreamCipher cipher;
VirgilByteArray recipientPwd = virgil::crypto::str2bytes("strong password");
cipher.addPasswordRecipient(recipientPwd);
cipher.encrypt(dataSource, dataSink, true);
```

### Decrypt data \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/decrypt_with_pass.cxx)\]

```cpp
VirgilStreamCipher cipher;
VirgilByteArray recipientPwd = virgil::crypto::str2bytes("strong password");
cipher.decryptWithPassword(dataSource, dataSink, recipientPwd);
```


## Encrypt data for multiple recipients

### Encrypt data \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/encrypt_with_multiple_recipients.cxx)\]

```cpp
VirgilStreamCipher cipher;
cipher.addKeyRecipient(alicePublicKeyId, alicePublicKey.key());
cipher.addKeyRecipient(bobPublicKeyId, bobPublicKey.key());
VirgilByteArray recipientPwd = virgil::crypto::str2bytes("strong password");
cipher.addPasswordRecipient(recipientPwd);
cipher.encrypt(dataSource, dataSink, true);
```

## Sign and Verify data

### Sign data \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/sign.cxx)\]

```cpp
VirgilStreamSigner signer;
// if Signer has a private key with password
// std::string privateKeyPwd = "strong private key password";
// VirgilByteArray sign = signer.sign(dataSource, privateKey, privateKeyPwd);
VirgilByteArray sign = signer.sign(dataSource, privateKey);
```

### Verify data \[[src](https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/release/examples/src/verify.cxx)\]

```cpp
VirgilStreamSigner signer;
bool verified = signer.verify(dataSource, sign, publicKey.key());
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
