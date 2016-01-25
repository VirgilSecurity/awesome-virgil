
# Tutorial C#/.NET Crypto Library


- [Install](#install)
- [Generate Keys](#generate-keys)
- [Encrypt Data](#encrypt-data)
- [Sign Data](#sign-data)
- [Verify Data](#verify-data)
- [Decrypt Data](#decrypt-data)
- [See Also](#see-also)

##Install
Use NuGet Package Manager (Tools -> Library Package Manager -> Package Manager Console) to install Virgil.SDK.Keys package, running the command:

```
PM> Install-Package Virgil.Crypto
```

## Generate Keys

The following code example creates a new public/private key pair.

```csharp
var keyPair = VirgilKeyPair.Generate();
```
In the example below you can see a simply generated public/private keypair without a password.

```
-----BEGIN PUBLIC KEY-----
MIGbMBQGByqGSM49AgEGCSskAwMCCAEBDQOBggAEWIH2SohavmLdRwEJ/VWbFcWr
rU+g7Z/BkI+E1L5JF7Jlvi1T1ed5P0/JCs+K0ZBM/0hip5ThhUBKK2IMbeFjS3Oz
zEsWKgDn8j3WqTb8uaKIFWWG2jEEnU/8S81Bgpw6CyxbCTWoB+0+eDYO1pZesaIS
Tv6dTclx3GljHpFRdZQ=
-----END PUBLIC KEY-----

-----BEGIN EC PRIVATE KEY-----
MIHaAgEBBEAaKrInIcjTeBI6B0mX+W4gMpu84iJtlPxksCQ1Dv+8iM/lEwx3nWWf
ol6OvLkmG/qP9RqyXkTSCW+QONiN9JCEoAsGCSskAwMCCAEBDaGBhQOBggAEWIH2
SohavmLdRwEJ/VWbFcWrrU+g7Z/BkI+E1L5JF7Jlvi1T1ed5P0/JCs+K0ZBM/0hi
p5ThhUBKK2IMbeFjS3OzzEsWKgDn8j3WqTb8uaKIFWWG2jEEnU/8S81Bgpw6Cyxb
CTWoB+0+eDYO1pZesaISTv6dTclx3GljHpFRdZQ=
-----END EC PRIVATE KEY-----
```
You can also generate a key pair with an encrypted private key just using one of the overloaded constructors.

```csharp
var password = "TafaSuf4";
var keyPair = VirgilKeyPair.Generate(Encoding.UTF8.GetBytes(password));
```

Here is what an encrypted private key looks like:

```
-----BEGIN ENCRYPTED PRIVATE KEY-----
MIIBKTA0BgoqhkiG9w0BDAEDMCYEIJjDIF2KRj7u86Up1ZB4yHHKhqMg5C/OW2+F
mG5gpI+3AgIgAASB8F39JXRBTK5hyqEHCLcCTbtLKijdNH3t+gtCrLyMlfSfK49N
UTREjF/CcojkyDVs9M0y5K2rTKP0S/LwUWeNoO0zCT6L/zp/qIVy9wCSAr+Ptenz
MR6TLtglpGqpG4bhjqLNR2I96IufFmK+ZrJvJeZkRiMXQSWbPavepnYRUAbXHXGB
a8HWkrjKPHW6KQxKkotGRLcThbi9cDtH+Cc7FvwT80O7qMyIFQvk8OUJdY3sXWH4
5tol7pMolbalqtaUc6dGOsw6a4UAIDaZhT6Pt+v65LQqA34PhgiCxQvJt2UOiPdi
SFMQ8705Y2W1uTexqw==
-----END ENCRYPTED PRIVATE KEY-----
```

Generate keys with specific type

```csharp
var keyPair = VirgilKeyPair.Generate(VirgilKeyPair.Type.EC_SECP256K1);
```

In the table below you can see all types.

| Key Type          | Description                    |
|-------------------|--------------------------------|
| Type_Default      | recommended most safe type     |
| Type_RSA_256      | RSA 1024 bit (not recommended) |
| Type_RSA_512      | RSA 1024 bit (not recommended) |
| Type_RSA_1024     | RSA 1024 bit (not recommended) |
| Type_RSA_2048     | RSA 2048 bit (not recommended) |
| Type_RSA_3072     | RSA 3072 bit                   |
| Type_RSA_4096     | RSA 4096 bit                   |
| Type_RSA_8192     | RSA 8192 bit                   |
| Type_EC_SECP192R1 | 192-bits NIST curve            |
| Type_EC_SECP224R1 | 224-bits NIST curve            |
| Type_EC_SECP256R1 | 256-bits NIST curve            |
| Type_EC_SECP384R1 | 384-bits NIST curve            |
| Type_EC_SECP521R1 | 521-bits NIST curve            |
| Type_EC_BP256R1   | 256-bits Brainpool curve       |
| Type_EC_BP384R1   | 384-bits Brainpool curve       |
| Type_EC_BP512R1   | 512-bits Brainpool curve       |
| Type_EC_M221      | (not implemented yet)          |
| Type_EC_M255      | Curve25519                     |
| Type_EC_M383      | (not implemented yet)          |
| Type_EC_M511      | (not implemented yet)          |
| Type_EC_SECP192K1 | 192-bits "Koblitz" curve       |
| Type_EC_SECP224K1 | 224-bits "Koblitz" curve       |
| Type_EC_SECP256K1 | 256-bits "Koblitz" curve       |

See a working example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/Crypto/GenerateKeyPair.cs)

## Encrypt Data

The procedure for encrypting and decrypting the data is simple. For example:

If you want to encrypt the data to Bob, you encrypt it using Bob's public key (which you can get from the Public Keys Service), and Bob decrypts it with his private key. If Bob wants to encrypt some data to you, he encrypts it using your public key, and you decrypt it with your private key.

Crypto Library allows to encrypt the data for several types of recipient's user data like public key and password. This means that you can encrypt the data with some password or with a public key generated with the Crypto Library. 

Encrypt the text with a password:

```csharp
var textToEncrypt = "Encrypt me, Please!!!";
var password = "TafaSuf4";

var cipherText = CryptoHelper.Encrypt(textToEncrypt, password);
```

Encrypt the text with a public key:

```csharp
var keyPair = CryptoHelper.GenerateKeyPair();
var cipherText = CryptoHelper.Encrypt(textToEncrypt, "RecipientID" ,password);
```

And of course you can mix these types as well, see how it works in the example below:

```csharp
var textToEncrypt = "Encrypt me, Please!!!";
byte[] cipherData;

using (var cipher = new VirgilCipher())
{
    cipher.AddPasswordRecipient(password);
    cipher.AddKeyRecipient(keyRecepinet.Id, keyRecepinet.PublicKey);

    cipherData = cipher.Encrypt(Encoding.UTF8.GetBytes(textToEncrypt), true);
}
```

See a working example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/Crypto/Encryption.cs)

## Sign Data

Cryptographic digital signatures use public key algorithms to provide data integrity. When you sign the data with a digital signature, someone else can verify the signature and can prove that the data originated from you and was not altered after you had signed it.

The following example applies a digital signature to a public key identifier.

```csharp
var originalText = "Sign me, Please!!!";

var keyPair = CryptoHelper.GenerateKeyPair();
var signature = CryptoHelper.Sign(originalText, keyPair.PrivateKey());
```

See a working example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/Crypto/SingAndVerify.cs)

## Verify Data

To verify that the data was signed by a particular party, you need the following information:

*   the public key of the party that signed the data;
*   the digital signature;
*   the data that was signed.

The following example verifies a digital signature which was signed by the sender.

```csharp
var isValid = CryptoHelper.Verify(originalText, signature, keyPair.PublicKey());
```

See a working example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/Crypto/SingAndVerify.cs)

## Decrypt Data

The following example illustrates decryption of the encrypted data with a recipient's private key.

```csharp
var decryptedText = CryptoHelper.Decrypt(cipherText, "RecipientId", keyPair.PrivateKey());
```

Use a password to decrypt the data.

```csharp
var decryptedText = CryptoHelper.Decrypt(cipherText, password);
```

See a working example [here...](https://github.com/VirgilSecurity/virgil-net/blob/master/Examples/Crypto/Encryption.cs)

## See Also

* [Quickstart](https://virgilsecurity.com/developers/dot-net-csharp/quickstart)
* [Tutorial Keys SDK](https://virgilsecurity.com/developers/dot-net-csharp/keys-sdk)

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
