##############
IP messaging
##############

A group of users want to exchange text messages in a secure chat.

.. image:: ../images/IPMessagingUseCase.png
  :width: 50 %

**Chat participants create Virgil accounts with a pair of asymmetric keys**:

- public key on Virgil cloud in Keys service;

.. code:: 

  byte[] publicKey;
  byte[] privateKey;
  
  using (var keyPair new VirgilKeyPair())
  {
      publicKey = keyPair.PublicKey();
      privateKey = keyPair.PrivateKey();
  }

- private key on Virgil cloud in Private Keys service;
 
.. code:: 

  var password = Encoding.UTF8.GetBytes("my_password-:)")
  
  using (var keyPair = new VirgilKeyPair(password))
  {
      ...
  }

- or private key locally.

**Participants log in a chat with user data from Virgil Security.**

**Sent message is encrypted with public keys of all chat participants using Keys service.**

.. code:: 

  byte[] encryptedData;
  
  using (var cipher = new VirgilCipher())
  {
      byte[] recepientId = Encoding.UTF8.GetBytes(recepientPublicKey.PublicKeyId.ToString());
      byte[] data = Encoding.UTF8.GetBytes("Some data to be encrypted");
  
      cipher.AddKeyRecipient(recepientId, recepientPublicKey.Key);
      encryptedData = cipher.Encrypt(data, true);
  }

**Encrypted message is sent to a recipient or a group of recipients via IP of messaging API.**

**The message is decrypted for every chat participant with his private key using Private Keys service.**

.. code:: 

  var recepientContainerPassword = "UhFC36DAtrpKjPCE";
  
  var recepientPrivateKeysClient = new KeyringClient(new Connection(Constants.ApplicationToken));
  recepientPrivateKeysClient.Connection.SetCredentials(
      new Credentials("recepient.email@server.hz", recepientContainerPassword));
  
  var recepientPrivateKey = await recepientPrivateKeysClient.PrivateKeys.Get(recepientPublicKey.PublicKeyId);
  
  byte[] decryptedDate;
  using (var cipher = new VirgilCipher())
  {
      decryptedDate = cipher.DecryptWithKey(encryptedData, recepientId, recepientPrivateKey.Key);
  }

**Decrypted message is displayed in the chat.**
