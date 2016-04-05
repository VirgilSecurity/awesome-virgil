# Crypto Library Reference API 
- [CryptoHelper](#CryptoHelper)
- [Decrypt(cipherTextBase64,recipientId,privateKey,privateKeyPassword)](#decrypt(ciphertextbase64,recipientid,privatekey,privatekeypassword))
- [Decrypt(cipherData,recipientId,privateKey,privateKeyPassword)](#decrypt(cipherdata,recipientid,privatekey,privatekeypassword))
- [Decrypt(cipherTextBase64,password)](#decrypt(ciphertextbase64,password))
- [Decrypt(cipherData,password)](#decrypt(cipherdata,password))
- [Encrypt(text,recipientId,recipientPublicKey)](#encrypt(text,recipientid,recipientpublickey))
- [Encrypt(text,recipients)](#encrypt(text,recipients))
- [Encrypt(data,recipients)](#encrypt(data,recipients))
- [Encrypt(text,password)](#encrypt(text,password))
- [Encrypt(data,password)](#encrypt(data,password))
- [GenerateKeyPair(password)](#generatekeypair(password))
- [Sign(text,privateKey,privateKeyPassword)](#sign(text,privatekey,privatekeypassword))
- [Sign(data,privateKey,privateKeyPassword)](#sign(data,privatekey,privatekeypassword))
- [Verify(text,signBase64,publicKey)](#verify(text,signbase64,publickey))
- [Verify(data,signData,publicKey)](#verify(data,signdata,publickey))


# Virgil.Crypto.Wrapper

<a name='CryptoHelper'></a>
## CryptoHelper
##### Namespace

Virgil.Crypto

##### Summary

Performs cryptographic operations like encryption and decryption using the Virgil Crypto Library.

<a name='decrypt(ciphertextbase64,recipientid,privatekey,privatekeypassword)'></a>
## Decrypt(cipherTextBase64,recipientId,privateKey,privateKeyPassword) 

##### Summary

Decrypts the data that was previously encrypted with a public key.

##### Returns

The decrypted data.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| cipherTextBase64 | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The text to decrypt in Base64 format. |
| recipientId | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The unique recipient ID, that identifies a public key. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | A byte array that represents a private key. |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key's password. |

##### Remarks

This method decrypts the data that is encrypted using the [Encrypt](#encrypt(text,recipientid,recipientpublickey)) method.

<a name='decrypt(cipherdata,recipientid,privatekey,privatekeypassword)'></a>
## Decrypt(cipherData,recipientId,privateKey,privateKeyPassword)

##### Summary

Decrypts the data that was previously encrypted with a public key.

##### Returns

The decrypted data.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| cipherData | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The data to decrypt. |
| recipientId | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The unique recipient ID, that identifies a public key. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | A byte array that represents a private key. |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key's password. |

##### Remarks

This method decrypts the data that was encrypted using the [Encrypt](#encrypt(text,recipientid,recipientpublickey)) method.

<a name='decrypt(ciphertextbase64,password)'></a>
## Decrypt(cipherTextBase64,password) 

##### Summary

Decrypts the data that was previously encrypted with the specified password.

##### Returns

The decrypted text.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| cipherTextBase64 | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The text to decrypt in Base64 format. |
| password | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The password that was used to encrypt the specified data. |

##### Remarks

This method decrypts the data that was encrypted using the [Encrypt](#encrypt(text,password)) method.

<a name='decrypt(cipherdata,password)'></a>
## Decrypt(cipherData,password)
##### Summary

Decrypts the data that was previously encrypted with the specified password.

##### Returns

The decrypted data.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| cipherData | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The data to decrypt. |
| password | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The password that was used to encrypt the specified data. |

##### Remarks

This method decrypts the data that was encrypted using the [Encrypt](#encrypt(data,password)) method.

<a name='encrypt(text,recipientid,recipientpublickey)'></a>
## Encrypt(text,recipientId,recipientPublicKey)

##### Summary

Encrypts the text for the specified recipient's public key.

##### Returns

The encrypted text in Base64 format.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| text | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The text to be encrypted. |
| recipientId | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The unique recipient ID, that identifies a public key. |
| recipientPublicKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | A byte array that represents a public key. |

##### Remarks

This method encrypts the data that was decrypted using the [Decrypt](#decrypt(ciphertextbase64,recipientid,privatekey,privatekeypassword)) method.

<a name='encrypt(text,recipients)'></a>
## Encrypt(text,recipients) 
##### Summary

Encrypts the text for the specified dictionary of recipients.

##### Returns

The encrypted text in Base64 format.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| text | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The text to be encrypted. |
| recipients | [System.Collections.Generic.IDictionary{System.String,System.Byte[]}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Collections.Generic.IDictionary 'System.Collections.Generic.IDictionary{System.String,System.Byte[]}') | The dictionary of recipients with their public keys. |

##### Remarks

This method encrypts the data that was decrypted using the [Decrypt](#decrypt(ciphertextbase64,recipientid,privatekey,privatekeypassword)) method.

<a name='encrypt(data,recipients)'></a>
## Encrypt(data,recipients) 
##### Summary

Encrypts the data for the specified dictionary of recipients.

##### Returns

The encrypted data.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| data | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The data to be encrypted. |
| recipients | [System.Collections.Generic.IDictionary{System.String,System.Byte[]}](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Collections.Generic.IDictionary 'System.Collections.Generic.IDictionary{System.String,System.Byte[]}') | The dictionary of recipients with their public keys. |

##### Remarks

This method encrypts a data that is decrypted using the [Decrypt](#decrypt(cipherdata,recipientid,privatekey,privatekeypassword)) method.

<a name='encrypt(text,password)'></a>
## Encrypt(text,password) 
##### Summary

Encrypts the text with the specified password.

##### Returns

The encrypted text in Base64 format.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| text | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The text to be encrypted. |
| password | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The password which will be used to encrypt the specified data. |

##### Remarks

This method encrypts the text that will be decrypted using the [Decrypt](#decrypt(ciphertextbase64,password)) method.

<a name='encrypt(data,password)'></a>
## Encrypt(data,password) 
##### Summary

Encrypts the data with the specified password.

##### Returns

The encrypted data.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| data | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The data to be encrypted. |
| password | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The password that will be used to encrypt the specified data. |

##### Remarks

This method encrypts the data that will be decrypted using the [Decrypt](#decrypt(cipherdata,password)) method.

<a name='generatekeypair(password)'></a>
## GenerateKeyPair(password) 
##### Summary

Generates a random public/private key pair to be used for encryption and decryption.

##### Returns

The generated instance of Virgil Key Pair.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| password | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password |

<a name='sign(text,privatekey,privatekeypassword)'></a>
## Sign(text,privateKey,privateKeyPassword) 

##### Summary

Computes the hash value of the specified string and signs the resulting hash value.

##### Returns

The digital signature in Base64 format for the specified data.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| text | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The input text for which the hash is computed. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | A byte array that represents a private key. |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. |

##### Remarks

This method creates a digital signature that is verified using the [Verify](#verify(text,signbase64,publickey)) method.

<a name='sign(data,privatekey,privatekeypassword)'></a>
## Sign(data,privateKey,privateKeyPassword) 

##### Summary

Computes the hash value of the specified byte array and signs the resulting hash value.

##### Returns

The digital signature for the specified data.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| data | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The input data for which the hash is computed. |
| privateKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | A byte array that represents a private key. |
| privateKeyPassword | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The private key password. |

##### Remarks

This method creates a digital signature that is verified using the [Verify](#verify(data,signdata,publickey)) method.

<a name='verify(text,signbase64,publickey)'></a>
## Verify(text,signBase64,publicKey)
##### Summary

Verifies the specified signature by comparing it to the signature computed for the specified text.

##### Returns

`true` if the signature is verified as valid; otherwise, `false`.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| text | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The text that was signed. |
| signBase64 | [System.String](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.String 'System.String') | The signature text in Base64 format to be verified. |
| publicKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | A byte array that represents a public key. |

##### Remarks

This method verifies the digital signature produced by the [Sign](#sign(text,privatekey,privatekeypassword)) method.

<a name='verify(data,signdata,publickey)'></a>
## Verify(data,signData,publicKey) 

##### Summary

Verifies the specified signature by comparing it to the signature computed for the specified data.

##### Returns

`true` if the signature is verified as valid; otherwise, `false`.

##### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| data | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The data that was signed. |
| signData | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | The signature data to be verified. |
| publicKey | [System.Byte[]](http://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k:System.Byte[] 'System.Byte[]') | A byte array that represents a public key. |

##### Remarks

This method verifies the digital signature produced by the [Sign](#sign(data,privatekey,privatekeypassword)) method.
