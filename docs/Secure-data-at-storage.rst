# Secure data at storage
User wants a secure online data storage.

![SecureStorage](https://github.com/VirgilSecurity/virgil/blob/master/images/SecureStorage.png)

- User creates a Virgil account with a pair of asymmetric keys:
 - public key on Virgil cloud in Keys service;
 - private key on Virgil cloud in Private Keys service;
 - or private key locally.
- User determines a source folder with data and a target folder for encrypted data.
- The data is encrypted with user’s public key in Virgil crypto library and then stored in the target folder.
- Data in the cloud storage is securely synchronised via API of the cloud storage.
- Encrypted data is automatically updated when data in the source folder is changed or added.
- Data is decrypted in reverse sequence when it is retrieved by the user.