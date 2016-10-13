Objective C/Swift SDK Programming Guide
===============================================

Creating a Virgil Card
----------------------

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

``appID`` and ``appKey`` parameters are required to create a **Virgil Card** in your app scope.

Collect App Credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~

Collect an ``appID`` and ``appKey`` for your app:

Objective-C
           
.. code-block:: objectivec
    :linenos:

    NSString *appId = <#Your appId#>;
    NSString *appKeyPassword = <#Your app key password#>;
    NSURL *appKeyDataURL = [[NSBundle mainBundle] URLForResource:<#Your app key name#> withExtension:@"virgilkey"];
    NSData *appKeyData = [NSData dataWithContentsOfURL:appKeyDataURL];

    VSSPrivateKey *appPrivateKey = [self.crypto importPrivateKey:appKeyData password:appKeyPassword];

Swift
     
.. code-block:: swift
    :lineos:

    let appId = <#T##String: Your appId#>
    let appKeyPassword = <#T##String: You app key password#>
    let path = Bundle.main.url(forResource: <#Your app key name#>, withExtension: "virgilkey")
    let keyData = try? Data(contentsOf: path!)

    let appPrivateKey = self.crypto.importPrivateKey(keyData!, password: appKeyPassword)!

Generate New Keys
~~~~~~~~~~~~~~~~~~~

Generate a new Public/Private keypair using ``VirgilCrypto`` class:

Objective-C        

.. code-block:: objectivec
    :linenos:

    VSSKeyPair *aliceKeys = [self.crypto generateKeyPair];

Swift
     
.. code-block:: swift
    :lineos:

    let aliceKeys = self.crypto.generateKeyPair()

Prepare Request
~~~~~~~~~~~~~~~

Objective-C

.. code-block:: objectivec
    :linenos:

    NSData *exportedPublicKey = [self.crypto exportPublicKey:aliceKeys.publicKey];
    VSSCard *card = [VSSCard cardWithIdentity:@"alice" identityType:@"username" publicKey:exportedPublicKey];

Swift
     
.. code-block:: swift
    :lineos:

    let exportedPublicKey = self.crypto.export(publicKey: aliceKeys.publicKey)
    let card = VSSCard(identity: "alice", identityType: "username", publicKey: exportedPublicKey)

then, use *VSSRequestSigner* class to sign request with owner and app keys: 

Objective-C

.. code-block:: objectivec
    :linenos:

    VSSRequestSigner *requestSigner = [[VSSRequestSigner alloc] initWithCrypto:self.crypto];

    NSError *error1;
    [requestSigner applicationSignRequest:card withPrivateKey:aliceKeys.privateKey error:&error1];
    NSError *error2;
    [requestSigner authoritySignRequest:card appId:appId withPrivateKey:appPrivateKey error:&error2];

Swift
     
.. code-block:: swift
    :lineos:

    let requestSigner = VSSRequestSigner(crypto: self.crypto)

    do {
        try requestSigner.applicationSignRequest(card, with: keyPair.privateKey)
        try requestSigner.authoritySignRequest(card, appId: kApplicationId, with: appPrivateKey)
    }
    catch let error as Error {
        //...
    }

Publish a Virgil Card
~~~~~~~~~~~~~~~~~~~~~

Objective-C

.. code-block:: objectivec
    :linenos:

    [self.client createCard:card completion:^(VSSCard *card, NSError *error) {
        //...
    }];

Swift
     
.. code-block:: swift
    :lineos:

    self.client.createCard(card) { card, error in
        //...
    }


Search for Virgil Cards
---------------------------

You can search for **Virgil Cards** by identity value(s) and optional additional parameters can be set:

    - identity type ('email' or any type created by user). You can find more information about :term:`confirmed <Confirmed Identity>` and :term:`uncofirmed <Unconfirmed Identity>` **Virgil Cards**.
    - scope (by default it is 'application', can be 'global'). You can find more information about :term:`global <Global Virgil Card>` and :term:`application <Application Virgil Card>` **Virgil Cards**.

Objective-C
           
.. code-block:: objectivec
    :linenos:

    VSSSearchCards *searchCards = [VSSSearchCards searchCardsWithScope:VSSCardScopeApplication identityType:@"username" identities:@[@"alice", @"bob"]];
    [self.client searchCards:searchCards completion:^(NSArray<VSSCard *>* cards, NSError *error) {
        //...
    }];

Swift
     
.. code-block:: swift
    :lineos:

    let searchCards = VSSSearchCards(scope: .application, identityType: "username", identities: ["alice", "bob"])
    self.client.searchCards(searchCards) { cards, error in
        //...                
    }

Validating a Virgil Card
---------------------------

You might want to make sure that a received **Virgil Card** wasn't changed, Public Key is authentic, or validate any other fields.
This sample uses built-in ``CardValidator`` to validate **Virgil Cards**. By default ``CardValidator`` validates only Cards Service signature.

Objective-C
           
.. code-block:: objectivec
    :linenos:

    VSSCardValidator *validator = [[VSSCardValidator alloc] initWithCrypto:self.crypto];

    // Your can also add another Public Key for verification.
    // [validator addVerifierWithId:<#Verifier card id#> publicKey:<#Verifier public key#>];

    BOOL isValid = [validator validateCard:card];

Swift
     
.. code-block:: swift
    :lineos:

    let validator = VSSCardValidator(crypto: self.crypto)

    // Your can also add another Public Key for verification.
    // validator.addVerifier(withId: <#Verifier card id#>, publicKey: <#Verifier public key#>)

    let isValid = validator.validate(card)

Revoking a Virgil Card
---------------------------

You can delete a **Virgil Card** in case the keys were compromised or lost, or for any other reason.

Objective-C
           
.. code-block:: objectivec
    :linenos:

    VSSRevokeCard *revokeCard = [VSSRevokeCard revokeCardWithId:<#Your cardId#> reason:VSSCardRevocationReasonUnspecified];

    VSSRequestSigner *requestSigner = [[VSSRequestSigner alloc] initWithCrypto:self.crypto];
    NSError *error;
    [requestSigner authoritySignRequest:revokeCard appId:appId withPrivateKey:appPrivateKey error:&error];

    [self.client revokeCard:revokeCard completion:^(NSError *error) {
        //...
    }];

Swift
     
.. code-block:: swift
    :lineos:

    let revokeCard = VSSRevokeCard(id: <#Your cardId#>, reason: .unspecified)

    let requestSigner = VSSRequestSigner(crypto: self.crypto)
    do {
        try requestSigner.authoritySignRequest(revokeCard, appId: appId, with: appPrivateKey)
    }
    catch let error as Error {
        // ...
    }

    self.client.revokeCard(revokeCard) { error in
        //...
    }


Operations with Crypto Keys
---------------------------

Generate Keys
~~~~~~~~~~~~~

You can generate a keypair using ``VirgilCrypto`` class. The default algorithm is ``ed25519``. 

Objective-C
           
.. code-block:: objectivec
    :linenos:

    VSSKeyPair *aliceKeys = [self.crypto generateKeyPair];

Swift
     
.. code-block:: swift
    :lineos:

    let aliceKeys = self.crypto.generateKeyPair()

Import and Export Keys
~~~~~~~~~~~~~~~~~~~~~~

If you need to import or export your Public/Private keys you can easily do it.
Simply call one of the Export methods:

Objective-C
           
.. code-block:: objectivec
    :linenos:

    NSData *exportedPrivateKey = [self.crypto exportPrivateKey:aliceKeys.privateKey password:nil];
    NSData *exportedPublicKey = [self.crypto exportPublicKey:aliceKeys.privateKey];

Swift
     
.. code-block:: swift
    :lineos:

    let exportedPrivateKey = self.crypto.export(aliceKeys.privateKey, password: nil)
    let exportedPublicKey = self.crypto.export(aliceKeys.publicKey)

To import Public/Private keys, simply call one of the Import methods:

Objective-C
           
.. code-block:: objectivec
    :linenos:

    VSSPrivateKey *privateKey = [self.crypto importPrivateKey:exportedPrivateKey password:nil];
    VSSPublicKey *publicKey = [self.crypto importPublicKey:exportedPublicKey];

Swift
     
.. code-block:: swift
    :lineos:

    let privateKey = self.crypto.import(exportedPrivateKey, password: nil)
    let publicKey = self.crypto.export(aliceKeys.publicKey)


Encryption and Decryption
---------------------------

Initialize Crypto API and generate keypair.

Objective-C

.. code-block:: objectivec
    :linenos:

    VSSCrypto *crypto = [[VSSCrypto alloc] init];
    VSSKeyPair *keyPair = [crypto generateKeyPair];

Swift
     
.. code-block:: swift
    :lineos:

    let crypto = VSSCrypto()
    let keyPair = crypto.generateKeyPair()

Encrypt Data
~~~~~~~~~~~~

You can enrypt some data, ECIES scheme with ``AES-GCM`` is used in **Virgil Security**. You have several options for encryption:

    - stream encryption;
    - byte array encryption;
    - one recipient;
    - multiple recipients (public keys of every user are used for encryption).

**Byte Array**

Objective-C

.. code-block:: objectivec
    :linenos:

    NSData *plainText = [@"Hello, Bob!" dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSData *encryptedData = [self.crypto encryptData:plainText forRecipients:@[aliceKeys.publicKey] error:&error];

Swift
     
.. code-block:: swift
    :lineos:

    let plainText = "Hello, Bob!".data(using: String.Encoding.utf8)
    let encryptedData = try? crypto.encryptData(plainText, forRecipients: [aliceKeys.publicKey])

**Stream**

Objective-C

.. code-block:: objectivec
    :linenos:

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:<#Your data file name#> withExtension:<#Your data file extension#>];
    NSInputStream *inputStreamForEncryption = [[NSInputStream alloc] initWithURL:fileURL];
    NSOutputStream *outputStreamForEncryption = [[NSOutputStream alloc] initToMemory];

    NSError *error;
    [self.crypto encryptStream:inputStreamForEncryption outputStream:outputStreamForEncryption forRecipients: @[aliceKeys.publicKey] error:&error];

Swift
     
.. code-block:: swift
    :lineos:

    let fileURL = Bundle.main.url(forResource: <#You data file name#>, withExtension: <#You data file extension#>)!
    let inputStreamForEncryption = InputStream(url: fileURL)!
    let outputStreamForEncryption = OutputStream.toMemory()

    do {
        try self.crypto.encryptStream(inputStreamForEncryption, outputStream: outputStreamForEncryption, forRecipients: [aliceKeys.publicKey])
    }
    catch let error as Error {
        //...            
    }
     
Decrypt Data
~~~~~~~~~~~~

You can decrypt data using your private key. You have such options for decryption: 

    - stream;
    - byte array.

**Byte Array**

Objective-C

.. code-block:: objectivec
    :linenos:

    NSError *error;
    NSData *decryptedData = [self.crypto decryptData:encryptedData privateKey:aliceKeys.privateKey error:&error];

Swift
     
.. code-block:: swift
    :lineos:

    let decrytedData = try? self.crypto.decryptData(encryptedDta, privateKey: aliceKeys.privateKey)

**Stream**

Objective-C

.. code-block:: objectivec
    :linenos:

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:<#Your encrypted data file name#> withExtension:<#Your encrypted data file extension#>];
    NSInputStream *inputStreamForDecryption = [[NSInputStream alloc] initWithURL:fileURL];
    NSOutputStream *outputStreamForDecryption = [[NSOutputStream alloc] initToMemory];

    NSError *error;
    [self.crypto decryptStream:inputStreamForDecryption outputStream:outputStreamForDecryption privateKey:aliceKeys.privateKey error:&error];

Swift
     
.. code-block:: swift
    :lineos:

    let fileURL = Bundle.main.url(forResource: <#Your encrypted data file name#>, withExtension: <#Your encrypted data file extension#>)!
    let inputStreamForDecryption = InputStream(url: fileURL)!
    let outputStreamForDecryption = OutputStream.toMemory()

    do {
        try self.crypto.decryptStream(inputStreamForDecryption, outputStream: outputStreamForDecryption, privateKey: aliceKeys.privateKey)
    }
    catch let error as Error {
        //...            
    }

Generating and Verifying Signatures
-----------------------------------

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~

You can generate a digital signature for data. Options for signing data:

    - stream;
    - byte array.

**Byte Array**

Objective-C

.. code-block:: objectivec
    :linenos:

    NSData *plainText = [@"Hello, Bob!" dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSData *signature = [self.crypto signData:data privateKey:keyPair.privateKey error:&error];

Swift
     
.. code-block:: swift
    :lineos:

    let plainText = "Hello, Bob!".data(using: String.Encoding.utf8)
    let signature = try? self.crypto.sign(plainText, privateKey: aliceKeys.privateKey)

**Stream**

Objective-C

.. code-block:: objectivec
    :linenos:

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:<#Your data file name#> withExtension:<#Your data file extension#>];
    NSInputStream *inputStreamForEncryption = [[NSInputStream alloc] initWithURL:fileURL];
    NSData *signature = [self.crypto signStream:inputStreamForEncryption privateKey:aliceKeys.privateKey error:&error];

Swift
     
.. code-block:: swift
    :lineos:

    let fileURL = Bundle.main.url(forResource: <#Your data file name#>, withExtension: <#Your data file extension#>)!
    let inputStreamForSignature = InputStream(url: fileURL)!
    let signature = try? self.crypto.sign(inputStreamForSignature, privateKey: aliceKeys.privateKey)

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~

You can verify that a signature is authentic. You will verify the signature of the ``SHA-384`` fingerprint using the public key. Options for verification:

    - stream;
    - byte array.

**Byte Array**

Objective-C

.. code-block:: objectivec
    :linenos:

    NSError *error;
    BOOL isVerified = [self.crypto verifyData:data signature:signature signerPublicKey:aliceKeys.publicKey error:&error];

Swift

.. code-block:: swift
    :lineos:

    let isVerified = try? self.crypto.verifyData(data, signature: signature, signerPublicKey: aliceKeys.publicKey)

**Stream**

.. code-block:: objectivec
    :linenos:

    NSError *error;
    BOOL isVerified = [self.crypto verifyStream:strean signature:signature signerPublicKey:aliceKeys.publicKey error:&error];

Swift
     
.. code-block:: swift
    :lineos:

    let isVerified = try? self.crypto.verifyStream(stream, signature: signature, signerPublicKey: aliceKeys.publicKey)

Fingerprint Generation
----------------------

The default Fingerprint algorithm is ``SHA-256``.

Objective-C

.. code-block:: objectivec
    :linenos:

    VSSFingerprint *fingerprint = [self.crypto calculateFingerprintForData:data];

Swift    

.. code-block:: swift
    :lineos:

    let fingerprint = self.crypto.calculateFingerprint(for: data)

See Also: 
---------
`Source code <https://github.com/VirgilSecurity/virgil-sdk-x>`__