# Perfect Forward Secrecy

The security of communications transmitted across the Internet can be improved by using public key cryptography. However if the public and private keys used in those communications are compromised it can reveal the data exchanged in that session as well as the data exchanged in previous sessions.

Perfect Forward Secrecy (PFS) Is a technique, that protects previously intercepted traffic from being decrypted even if the main private key is compromised. With PFS enabled communication, a hacker could only access information that is actively transmitted because PFS forces a system to create different keys every time a new message is sent. In other words, PFS makes sure there is no master key to decrypt all the traffic.

In PFS you use Diffie-Hellman's algorithms, where the master key is not used. In such connection the master key is used to authenticate the parameters for the algorithm. After the parameters are agreed on, the key exchange takes place using those parameters, and a secret of both parties. The parameters are not secret, and the secrets the parties used are discarded after the session key is established (ephemeral). This way if you discover the master key you can't discover the session key.



## Prerequisites

### Functions needed:

- KDF(SK, salt, info) - generates key material based on shared secret **SK** and optional **salt** and **info** values.
- ENCRYPT(k, n, ad, plaintext): Encrypts plaintext using the cipher key k and and nonce n which must be unique for the key k. Optional additional data **ad** can be supplied
- DECRYPT(k, n, ad, ciphertext): Decrypts ciphertext using a cipher key k, a nonce n, and associated data **ad**. Returns the **plaintext**, unless authentication fails, in which case an error is signaled to the caller.


### Bob side (receiver)
Before Bob can use PFS he must do the following:

1. Have a main (identity) Virgil card **IC-B** registered at Virgil cloud
2. Generate a long-term ephemeral card **LTC-B**, sign it with the main card and post it on server
3. Generate a set of one-time ephemeral cards **OTC-B** (100 by default), sign them with the main card and post them on server

### Alice side (sender)
1. Have a main (identity) Virgil card **IC-A** in the cloud
2. Get Bob's identity card, long-term ephemeral card and (if exists) one-time ephemeral card



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

Sample message structure
```js
{
    "id":"230948203482",
    "eph": "woecwecWEcwec==",
    "sign": "23fFF23cswf==",
    "ic_id": "239ff0239809faadd",
    "ltc_id": "234234abc",
    "otc_id": "2394823049820349bcd",
    "salt_s": "4rqervQERVqrevwed==",
    "salt_w": "ddqervQERVqrevwed==",
    "ciphertext_s": "qervQERVqrevqERVqERVSfgvbwf=="
    "ciphertext_w": "qervQERVqrevqERVqERVSfgvbwf=="
}
```

### Receiving an Initial Message

Upon receiving Alice's initial message, Bob retrieves Alice's identity card and ephemeral key from the message. Bob also loads his identity card's private key, and the private key(s) corresponding to whichever long-term and one-time ephemeral cards (if any) Alice used.
Using these keys, Bob repeats the DH and KDF calculations from the previous section to derive SK, and then deletes the DH values.
Bob then constructs the AD byte sequence the same way same as Alice, as described in the previous section. 

**Bob must use strong session if he is able to calculate it.**

### Getting Response from Bob

Upon getting response from Bob,  Alice must drop either weak or strong session( if she had two), depending which one Bob choose

**Till that time Alice must send messages to Bob using both sessions**

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

##### Decripting Message

1. read 16 byte salt
2. If Initiator == true then SK = **SK-B** else **SK-A**
3. message_key, nonce = KDF (SK, salt, "Virgil")
4. plaintext= DECRYPT (message_key, nonce, AD, ciphertext)

### Maintaining state

Bob must upload new one time ephemeral cards as soon as they get used, maintain their amount periodically.

Also, Bob must renew his long-term ephemeral card every several days.
