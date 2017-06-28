# Perfect Forward Secrecy Protocol

Perfect Forward Secrecy (PFS) is a technique, that protects previously intercepted traffic from being decrypted even if the main private key is compromised. 

To provide PFS, Virgil enables the storage of ephemeral public keys (cards) which allows apps and Iot devices to create temporary end to end encrypted sessions that are not based on the main device private key.


## Prerequisites

### Functions needed:

- KDF(SK, salt, info) - generates key material based on shared secret **SK** and optional **salt** and **info** values.
- ENCRYPT(k, n, ad, plaintext): Encrypts plaintext using the cipher key k and and nonce n which must be unique for the key k. Optional additional data **ad** can be supplied
- DECRYPT(k, n, ad, ciphertext): Decrypts ciphertext using a cipher key k, a nonce n, and associated data **ad**. Returns the **plaintext**, unless authentication fails, in which case an error is signaled to the caller.

### Suggested primitives:
- **ASYMMETRIC**  - ed25519/curve25519
- **KDF** - HKDF
- **ENCRYPT/DECRYPT** - AES-GCM or Chaha20-poly1305
- **HASH** - SHA256/SHA512//Blake2b

Default Cipher primitives used are: ed25519/curve25519, HKDF, AES-GCM, SHA256.

### Bob side (receiver)
Before Bob can use PFS he must do the following:

1. Have a main (identity) Virgil card **IC-B** registered at Virgil cloud
2. Generate a long-term ephemeral card **LTC-B**, sign it with the main card and post it on server
3. Generate a set of one-time ephemeral cards **OTC-B** (100 by default), sign them with the main card and post them on server

### Alice side (sender)
1. Have a main (identity) Virgil card **IC-A** in the cloud
2. Get Bob's identity card, long-term ephemeral card and (if exists) one-time ephemeral card

## Protocol

The set of keys used:

- Bob's Identity card **IC-B**
- Bob's long-term ephemeral card **LTC-B**
- Bob's one-time ephemeral card **OTC-B**
- Alice's Identity card **IC-A**
- Alice's ephemeral key **EK-A**

All public keys have a corresponding private key, but to simplify description we will focus on the public keys.

### Initial Phase

Alice calculates the following DHs:

1. DH1 = DH(**IC-A**, **LTC-B**)
2. DH2 = DH(**EK-A**, **IC-B**)
3. DH3 = DH(**EK-A**, **LTC-B**)
4. DH4 = DH(**EK-A**, **OTC-B**)

### Strong and Weak Sessions

Strong session is formed when DH4 is present.
Strong shared secret **SKs** = 128 bytes of KDF ( DH1 || DH2 || DH3 || DH4) 
Weak shared secret **SKw** = 128 bytes of KDF ( DH1 || DH2 || DH3)

Following statements are common for both session types:

First 64 bytes is Alice's send/Bob's receive secret **SK-A**, second 64 bytes is Alice's receive/Bob's send secret **SK-B**

After calculating **SK-A**, **SK-B**, Alice deletes her ephemeral private key and the DH outputs.

Alice then calculates an "additional  data" byte sequence AD that contains identity card IDs for both parties: 

Strong session additional data= Card IDs of (**IC-A** || **IC-B** || **LTC-B**  || **OTC-B** || "Virgil")

Weak session additional data = Card IDs of (**IC-A** || **IC-B** || **LTC-B** ||"Virgil")

Alice may optionally append additional information to AD, such as Alice and Bob's usernames, certificates, or other identifying information (app decides).

If no OTC is present, Alice calculates **only** weak session, else **only** the strong one

Alice then sends Bob an initial message containing:
- Alice's identity CardID
- Alice's ephemeral public key **EK-A**
- The signature of **EK-A**
- Card IDs of **IC-B**, **LTC-B** and **OTC-B**  (if present)
- 16 bytes of random salt
- Ciphertext

Sample message structure
```js
{
    initiator_ic_id: "66b1132a0173910b01ee3a15ef4e69583bbf2f7f1e4462c99efbe1b9ab5bf808",
    responder_ic_id: "cee24f45f19fae05c538c90778145867019ef06f1668e956f5ee1bca30b85b3c",
    responder_ltc_id: "e451a4189f3e1d1df8f87cb6023d3b2fc7d3c266042f4945532c25f9dfe34e8c",
    responder_otc_id: "5f8569f6458f2928e06e48953b3f11f76a8de0657ec616b5481b9b2343a62863",
    eph: "woecwecWEcwec==",
    sign: "23fFF23cswf==",
    salt: "ddqervQERVqrevwed==",
    ciphertext: "qervQERVqrevqERVqERVSfgvbwf=="
}
```

### Receiving an Initial Message

Upon receiving Alice's initial message, Bob retrieves Alice's identity card and ephemeral key from the message. Bob also loads his identity card's private key, and the private key(s) corresponding to whichever long-term and one-time ephemeral cards (if any) Alice used.
Using these keys, Bob repeats the DH and KDF calculations from the previous section to derive SK, and then deletes the DH values.
Bob then constructs the AD byte sequence the same way same as Alice, as described in the previous section. 


### Session

Session consists of **SK-A**, **SK-B**, **AD**

SessionID is calculated as HASH (SK || AD || "Virgil") and sent along the encrypted message to identify messages from different sessions

#### Encrypting & Decrypting actual Messages

##### Encrypting Message

1. Generate 16 byte random salt
2. If Initiator == true then SK = **SK-A** else **SK-B**
3. message_key, nonce = KDF (SK, salt, "Virgil")
4. ciphertext = ENCRYPT (message_key, nonce, AD, plaintext)
5. Send SessionID , salt, ciphertext

Multiple messages can be sent at once, for different sessions

```js
[
  {
    "session_id": "000qervQERVqrevqEwweRVqERVSfgvbwf==",
    "salt": "qervQERVqrevwed==",
    "ciphertext": "qervQERVqrevqEwef23f23f23fefwefFFFwef3f3f2FFFwedfJj5RVqERVSfgvbwf=="
  },
  {
    "session_id": "111qervQERVqrevqEwweRVqERVSfgvbwf==",
    "salt": "qervQERVqrevwed==",
    "ciphertext": "qervQERVqrevqEwef23f23f23fefwefFFFwef3f3f2FFFwedfJj5RVqERVSfgvbwf=="
  }
]
```

##### Decrypting Message

1. read 16 byte salt
2. If Initiator == true then SK = **SK-B** else **SK-A**
3. message_key, nonce = KDF (SK, salt, "Virgil")
4. plaintext= DECRYPT (message_key, nonce, AD, ciphertext)

### Maintaining state

Bob must upload new one time ephemeral cards as soon as they get used, maintain their amount periodically.

Also, Bob must renew his long-term ephemeral card every several days.
