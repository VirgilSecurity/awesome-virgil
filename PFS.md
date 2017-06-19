# Perfect Forward Secrecy

The security of communications transmitted across the Internet can be improved by using public key cryptography. However if the public and private keys used in those communications are compromised it can reveal the data exchanged in that session as well as the data exchanged in previous sessions.

Perfect Forward Secrecy (PFS) Is a technique, that protects previously intercepted traffic from being decrypted even if the main private key is compromised. With PFS enabled communication, a hacker could only access information that is actively transmitted because PFS forces a system to create different keys every time a new message is sent. In other words, PFS makes sure there is no master key to decrypt all the traffic.

In PFS you use Diffie-Hellman's algorithms, where the master key is not used. In such connection the master key is used to authenticate the parameters for the algorithm. After the parameters are agreed on, the key exchange takes place using those parameters, and a secret of both parties. The parameters are not secret, and the secrets the parties used are discarded after the session key is established (ephemeral). This way if you discover the master key you can't discover the session key.

![PFS](https://github.com/VirgilSecurity/virgil/blob/master/images/pfs.png)




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


