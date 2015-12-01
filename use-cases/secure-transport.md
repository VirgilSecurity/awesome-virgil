# Secure data at transport
Users need to exchange important data (text, audio, video, etc.) without any risks. 

#### Sender and recipient create Virgil accounts with a pair of asymmetric keys:

- public key on Virgil cloud in Keys service;

```
byte[] publicKey;
byte[] privateKey;

using (var keyPair new VirgilKeyPair())
{
    publicKey = keyPair.PublicKey();
    privateKey = keyPair.PrivateKey();
}
```

- private key on Virgil cloud in Private Keys service;

```
var password = Encoding.UTF8.GetBytes("my_password-:)")

using (var keyPair = new VirgilKeyPair(password))
{
    ...
}
```

- or private key locally.

#### Sender encrypts the data using Virgil crypto library and recipient’s public key.

```
byte[] cipherData;

using (var cipher = new VirgilCipher())
{
    cipher.AddPasswordRecipient(password);
    cipher.AddKeyRecipient(keyRecepinet.Id, keyRecepinet.PublicKey);

    cipherData = cipher.Encrypt(Encoding.UTF8.GetBytes(textToEncrypt), true);
}
```

#### Sender signs encrypted data with his private key using Virgil crypto library.

```
byte[] sign;
using (var signer = new VirgilSigner())
{
    sign = signer.Sign(dataToSign, privateKey);
}
```

#### Sender securely transfers encrypted data, his digital signature and UDID to recipient without any risk to be revealed. 
#### Recipient verifies that the signature of transferred data is valid using the signature and sender’s public key in Virgil crypto library.

```
bool isValid;
using (var signer = new VirgilSigner())
{
    isValid = signer.Verify(dataToSign, sign, publicKey);
}
```

#### Recipient decrypts the data with his private key using Virgil crypto library.

```
byte[] decryptedData;
using (var cipher = new VirgilCipher())
{
    decryptedData = cipher.DecryptWithKey(cipherData, keyRecepinet.Id, keyRecepinet.PrivateKey);
}

decryptedData = cipher.DecryptWithPassword(cipherData, password);
```

#### Decrypted data is provided to the recipient. 
