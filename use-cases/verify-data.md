# Verify data

Recipient needs to make sure that received data has been sent from a secure source and hasn’t been changed during transport.

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

#### Sender signs the data with his private key in Virgil crypto library.

```
byte[] sign;
using (var signer = new VirgilSigner())
{
    sign = signer.Sign(dataToSign, privateKey);
}
```

#### Sender transfers the data, his digital signature and UDID to a recipient.

#### Recipient (or any person) verifies data integrity using the digital signature and sender’s public key in Virgil crypto library.

```
bool isValid;
using (var signer = new VirgilSigner())
{
    isValid = signer.Verify(dataToSign, sign, publicKey);
}
```
