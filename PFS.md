# Perfect Forward Secrecy

Perfect Forward Secrecy (PFS) Is a technique, that protects previously intercepted traffic from being decrypted even if the main private key is compromised. 

To provide PFS, we need to be able to store ephemeral public keys (cards) on server.

## Prerequisites

### Functions needed:

- KDF(SK, salt, info) - generates key material based on shared secret **SK** and optional **salt** and **info** values.
- ENCRYPT(k, n, ad, plaintext): Encrypts plaintext using the cipher key k and and nonce n which must be unique for the key k. Optional additional data **ad** can be supplied
- DECRYPT(k, n, ad, ciphertext): Decrypts ciphertext using a cipher key k, a nonce n, and associated data **ad**. Returns the **plaintext**, unless authentication fails, in which case an error is signaled to the caller.

### Suggested primitives:

**KDF** - HKDF
**ENCRYPT/DECRYPT** - AES-GCM or Chaha20-poly1305
**HASH** - SHA256/SHA512//Blake2b

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
To avoid situations when Bob does not have OTC key, either weak or both sessions are calculated during initial phase.
Alice must store both strong & weak sessions until Bob replies with one of them meaning he chose one.
Alice must encrypt messages with both strong & weak sessions until she receives a response from Bob.

Alice then sends Bob an initial message containing:
- Alice's identity CardID
- Alice's ephemeral public key **EK-A**
- The signature of **EK-A**
- Card IDs of **IC-B**, **LTC-B** and **OTC-B**  (if present)
- 16 bytes of random salt for **strong** session
- 16 bytes of random salt for **weak** session
- Ciphertext, encrypted with strong session symmetric key
- Ciphertext, encrypted with weak session symmetric key
