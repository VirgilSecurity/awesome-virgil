Objective C/Swift SDK Programming Guide
===============================================

Creating a Virgil Card
----------------------

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

``appID`` and ``appKey`` parameters are required to create a **Virgil Card** in your app scope.

Collect App Credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~

Collect an ``appID`` and ``appKey`` for your app:

Objective C
           
.. code-block:: objective-c
    :linenos:

    NSString *appId = <#Your appId#>;
    NSString *appKeyPassword = <#Your app key password#>;
    NSURL *appKeyDataURL = [[NSBundle mainBundle] URLForResource:<#Your app key name#> withExtension:@"virgilkey"];
    NSData *appKeyData = [NSData dataWithContentsOfURL:appKeyDataURL];

    VSSPrivateKey *appPrivateKey = [self.crypto importPrivateKeyFromData:appKeyData withPassword:appKeyPassword];

Swift
     
.. code-block:: objective-c
    :linenos:

    let appId = <#String: Your appId#>
    let appKeyPassword = <#String: You app key password#>
    let path = Bundle.main.url(forResource: <#Your app key name#>, withExtension: "virgilkey")
    let keyData = try! Data(contentsOf: path!)

    let appPrivateKey = self.crypto.importPrivateKey(from: keyData, withPassword: appKeyPassword)!

Generate New Keys
~~~~~~~~~~~~~~~~~~~

Generate a new Public/Private keypair using ``VirgilCrypto`` class:

Objective C        

.. code-block:: objective-c
    :linenos:

    VSSKeyPair *aliceKeys = [self.crypto generateKeyPair];

Swift
     
.. code-block:: swift
    :linenos:

    let aliceKeys = self.crypto.generateKeyPair()

Prepare Request
~~~~~~~~~~~~~~~

Objective C

.. code-block:: objective-c
    :linenos:

    NSData *exportedPublicKey = [self.crypto exportPublicKey:aliceKeys.publicKey];
    VSSCreateCardRequest *request = [VSSCreateCardRequest createCardRequestWithIdentity:@"alice" identityType:@"username" publicKey:exportedPublicKey];

Swift
     
.. code-block:: swift
    :linenos:

    let exportedPublicKey = self.crypto.export(publicKey: aliceKeys.publicKey)
    let request = VSSCreateCardRequest(identity: "alice", identityType: "username", publicKey: exportedPublicKey)

then, use ``VSSRequestSigner`` class to sign request with owner and app keys. 

Objective C

.. code-block:: objective-c
    :linenos:

    VSSRequestSigner *signer = [[VSSRequestSigner alloc] initWithCrypto:self.crypto];

    NSError *error1;
    [signer selfSignRequest:request withPrivateKey:aliceKeys.privateKey error:&error1];
    NSError *error2;
    [signer authoritySignRequest:request forAppId:appId withPrivateKey:appPrivateKey error:&error2];

Swift
     
.. code-block:: swift
    :linenos:

    let signer = VSSRequestSigner(crypto: self.crypto)

    do {
        try signer.selfSign(request, with: keyPair.privateKey)
          try signer.authoritySign(request, forAppId: kApplicationId, with: appPrivateKey)
    }
    catch let error as Error {
        //...
    }

Publish a Virgil Card
~~~~~~~~~~~~~~~~~~~~~

Objective C

.. code-block:: objective-c
    :linenos:

    [self.client createCardWithRequest:request completion:^(VSSCard *card, NSError *error) {
        //...
    }];

Swift
     
.. code-block:: swift
    :linenos:

    self.client.createCardWith(request) { card, error in
        //...
    }

Get a Virgil Card
------------------

Gets a Virgil Card by ID.

Objective C

 .. code-block:: objective-c
    :linenos:

    [self.client getCardWithId:cardIdentifier completion:^(VSSCard *foundCard, NSError *error) {
        //...
    }];
 

Swift

.. code-block:: swift
    :linenos:

    self.client.getCard(withId: cardIdentifier) { card, error in
        //...
    }

Search for Virgil Cards
---------------------------

You can search for **Virgil Cards** by identity value(s) and optional additional parameters can be set:

    - identity type ('email' or any type created by user). You can find more information about :term:`confirmed <Confirmed Card>` and :term:`unconfirmed <Unconfirmed Card>` **Virgil Cards**.
    - scope (by default it is 'application', can be 'global'). You can find more information about :term:`global <Global Virgil Card>` and :term:`application <Application Virgil Card>` **Virgil Cards**.

Objective C
           
.. code-block:: objective-c
    :linenos:

    VSSSearchCardsCritera *critera = [VSSSearchCardsCriteria searchCardsCriteriaWithScope:VSSCardScopeApplication identityType:@"username" identities:@[@"alice", @"bob"]];
    [self.client searchCardsUsingCriteria:searchCards completion:^(NSArray<VSSCard *>* foundCards, NSError *error) {
        //...
    }];

Swift
     
.. code-block:: swift
    :linenos:

    let criteria = VSSSearchCardsCriteria(scope: .application, identityType: "username", identities: ["alice", "bob"])
    self.client.searchCards(using: criteria) { foundCards, error in
        //...                
    }

Validating a Virgil Card
---------------------------

You might want to make sure that a received **Virgil Card** wasn't changed, Public Key is authentic, or validate any other fields.
This sample uses *built-in* ``VSSCardValidator`` to validate Virgil Service card responses. Default ``VSSCardValidator`` validates only *Cards Service* signature.

Objective C
           
.. code-block:: objective-c
    :linenos:

    VSSCardValidator *validator = [[VSSCardValidator alloc] initWithCrypto:self.crypto];

    // Your can also add another Public Key for verification.
    // [validator addVerifierWithId:<#Verifier card id#> publicKey:<#Verifier public key#>];

    BOOL isValid = [validator validateCardResponse:response];

Swift
     
.. code-block:: swift
    :linenos:

    let validator = VSSCardValidator(crypto: self.crypto)

    // Your can also add another Public Key for verification.
    // validator.addVerifier(withId: <#Verifier card id#>, publicKey: <#Verifier public key#>)

    let isValid = validator.validate(response)

For convenience you can embed validator into the client and all cards received from the Virgil service will be automatically validated for you.
If validation process failes during client queries, error will be generated.

Objective C

.. code-block:: objective-с
    :linenos:

    self.crypto = [[VSSCrypto alloc] init];

    VSSCardValidator *validator = [[VSSCardValidator alloc] initWithCrypto:self.crypto];
    [validator addVerifierWithId:<#Verifier card id#> publicKey:<#Verifier public key#>];

    VSSServiceConfig *config = [VSSServiceConfig serviceConfigWithToken:kApplicationToken];
    config.cardValidator = validator;

    self.client = [[VSSClient alloc] initWithServiceConfig:config];

Swift

.. code-block:: swift
    :linenos:

    self.crypto = VSSCrypto()

    let validator = VSSCardValidator(crypto: self.crypto)
    validator.addVerifier(withId: <#Verifier card id#>, publicKey: <#Verifier public key#>)

    let config = VSSServiceConfig(token: kApplicationToken)
    config.cardValidator = validator

    self.client = VSSClient(serviceConfig: config)

Revoking a Virgil Card
---------------------------

You can delete a **Virgil Card** in case the keys were compromised or lost, or for any other reason.

Objective C
           
.. code-block:: objective-c
    :linenos:

    VSSRevokeCardRequest *revokeRequest = [VSSRevokeCardRequest revokeCardRequestWithCardId:<#Your cardId#> reason:VSSCardRevocationReasonUnspecified];
    
    VSSRequestSigner *signer = [[VSSRequestSigner alloc] initWithCrypto:self.crypto];
    NSError *error;
    [signer authoritySignRequest:revokeRequest forAppId:appId withPrivateKey:appPrivateKey error:&error];

    [self.client revokeCardWithRequest:revokeRequest completion:^(NSError *error) {
        //...
    }];

Swift
     
.. code-block:: swift
    :linenos:

    let revokeRequest = VSSRevokeCardRequest(cardId: <#Your cardId#>, reason: .unspecified)

    let signer = VSSRequestSigner(crypto: self.crypto)
    do {
        try signer.authoritySign(revokeRequest, forAppId: appId, with: appPrivateKey)
    }
    catch {
        // ...
    }

    self.client.revokeCardWithRequest(revokeRequest) { error in
        //...
    }


Operations with Crypto Keys
---------------------------

Generate Keys
~~~~~~~~~~~~~

You can generate a keypair using ``VirgilCrypto`` class. The default algorithm is ``ed25519``. 

Objective C
           
.. code-block:: objective-c
    :linenos:

    VSSKeyPair *aliceKeys = [self.crypto generateKeyPair];

Swift
     
.. code-block:: swift
    :linenos:

    let aliceKeys = self.crypto.generateKeyPair()

Import and Export Keys
~~~~~~~~~~~~~~~~~~~~~~

If you need to import or export your Public/Private keys you can easily do it.
Simply call one of the Export methods:

Objective C
           
.. code-block:: objective-c
    :linenos:

    NSData *alicePrivateKey = [self.crypto exportPrivateKey:aliceKeys.privateKey withPassword:nil];
    NSData *alicePublicKey = [self.crypto exportPublicKey:aliceKeys.publicKey];

Swift
     
.. code-block:: swift
    :linenos:

    let alicePrivateKeyData = self.crypto.export(aliceKeys.privateKey, withPassword: nil)
    let alicePublicKeyData = self.crypto.export(aliceKeys.publicKey)

To import Public/Private keys, simply call one of the Import methods:

Objective C
           
.. code-block:: objective-c
    :linenos:

    VSSPrivateKey *alicePrivateKey = [self.crypto importPrivateKeyFromData:alicePrivateKeyData withPassword:nil];
    VSSPublicKey *alicePublicKey = [self.crypto importPublicKeyFromData:alicePublicKey];

Swift
     
.. code-block:: swift
    :linenos:

    let alicePrivateKey = self.crypto.import(from: alicePrivateKeyData, password: nil)
    let alicePublicKey = self.crypto.import(from: alicePublicKeyData)


Encryption and Decryption
---------------------------

Initialize Crypto API and generate keypair.

Objective C

.. code-block:: objective-c
    :linenos:

    VSSCrypto *crypto = [[VSSCrypto alloc] init];
    VSSKeyPair *keyPair = [crypto generateKeyPair];

Swift
     
.. code-block:: swift
    :linenos:

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

Objective C

.. code-block:: objective-c
    :linenos:

    NSData *plainText = [@"Hello, Bob!" dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSData *encryptedData = [self.crypto encryptData:plainText forRecipients:@[aliceKeys.publicKey] error:&error];

Swift
     
.. code-block:: swift
    :linenos:

    let plainTextData = "Hello, Bob!".data(using: .utf8)
    let encryptedData = try? crypto.encrypt(plainTextData, for: [aliceKeys.publicKey])

**Stream**

Objective C

.. code-block:: objective-c
    :linenos:

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:<#Your data file name#> withExtension:<#Your data file extension#>];
    NSInputStream *inputStreamForEncryption = [[NSInputStream alloc] initWithURL:fileURL];
    NSOutputStream *outputStreamForEncryption = [[NSOutputStream alloc] initToMemory];

    NSError *error;
    [self.crypto encryptStream:inputStreamForEncryption toOutputStream:outputStreamForEncryption forRecipients: @[aliceKeys.publicKey] error:&error];

Swift
     
.. code-block:: swift
    :linenos:

    let fileURL = Bundle.main.url(forResource: <#You data file name#>, withExtension: <#You data file extension#>)!
    let inputStreamForEncryption = InputStream(url: fileURL)!
    let outputStreamForEncryption = OutputStream.toMemory()

    do {
        try self.crypto.encrypt(inputStreamForEncryption, to: outputStreamForEncryption, for: [aliceKeys.publicKey])
        }
    catch {
        //...            
    }
     
Decrypt Data
~~~~~~~~~~~~

You can decrypt data using your private key. You have such options for decryption: 

    - stream;
    - byte array.

**Byte Array**

Objective C

.. code-block:: objective-c
    :linenos:

    NSError *error;
    NSData *decryptedData = [self.crypto decryptData:encryptedData withPrivateKey:aliceKeys.privateKey error:&error];

Swift
     
.. code-block:: swift
    :linenos:

    let decrytedData = try? self.crypto.decrypt(encryptedData, with: aliceKeys.privateKey)

**Stream**

Objective C

.. code-block:: objective-c
    :linenos:

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:<#Your encrypted data file name#> withExtension:<#Your encrypted data file extension#>];
    NSInputStream *inputStreamForDecryption = [[NSInputStream alloc] initWithURL:fileURL];
    NSOutputStream *outputStreamForDecryption = [[NSOutputStream alloc] initToMemory];

    NSError *error;
    [self.crypto decryptStream:inputStreamForDecryption toOutputStream:outputStreamForDecryption withPrivateKey:aliceKeys.privateKey error:&error];

Swift
     
.. code-block:: swift
    :linenos:

    let fileURL = Bundle.main.url(forResource: <#Your encrypted data file name#>, withExtension: <#Your encrypted data file extension#>)!
    let inputStreamForDecryption = InputStream(url: fileURL)!
    let outputStreamForDecryption = OutputStream.toMemory()

    do {
        try self.crypto.decrypt(inputStreamForDecryption, to: outputStreamForDecryption, with: aliceKeys.privateKey)
    }
    catch {
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

Objective C

.. code-block:: objective-c
    :linenos:

    NSData *plainTextData = [@"Hello, Bob!" dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSData *signature = [self.crypto generateSignatureForData:plainTextData withPrivateKey:keyPair.privateKey error:&error];

Swift
     
.. code-block:: swift
    :linenos:

    let plainTextData = "Hello, Bob!".data(using: .utf8)!
    let signature = try? self.crypto.generateSignature(for: plainTextData, with: aliceKeys.privateKey)

**Stream**

Objective C

.. code-block:: objective-c
    :linenos:

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:<#Your data file name#> withExtension:<#Your data file extension#>];
    NSInputStream *inputStreamForEncryption = [[NSInputStream alloc] initWithURL:fileURL];
    NSData *signature = [self.crypto generateSignatureForStream:inputStreamForEncryption withPrivateKey:aliceKeys.privateKey error:&error];

Swift
     
.. code-block:: swift
    :linenos:

    let fileURL = Bundle.main.url(forResource: <#Your data file name#>, withExtension: <#Your data file extension#>)!
    let inputStreamForSignature = InputStream(url: fileURL)!
    let signature = try? self.crypto.generateSignature(for: inputStreamForSignature, with: aliceKeys.privateKey)

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~

You can verify that a signature is authentic. You will verify the signature of the ``SHA-384`` fingerprint using the public key. Options for verification:

    - stream;
    - byte array.

**Byte Array**

Objective C

.. code-block:: objective-c
    :linenos:

    NSError *error;
    BOOL isVerified = [self.crypto verifyData:data withSignature:signature usingSignerPublicKey:aliceKeys.publicKey error:&error];

Swift

.. code-block:: swift
    :linenos:

    let isVerified = try? self.crypto.verifyData(data, withSignature: signature, usingSignerPublicKey: aliceKeys.publicKey)

**Stream**

Objective C

.. code-block:: objective-c
    :linenos:

    NSError *error;
    BOOL isVerified = [self.crypto verifyStream:strean withSignature:signature usingSignerPublicKey:aliceKeys.publicKey error:&error];

Swift
     
.. code-block:: swift
    :linenos:

    let isVerified = try? self.crypto.verifyStream(stream, withSignature: signature, usingSignerPublicKey: aliceKeys.publicKey)

Authenticated Encryption
------------------------

Authenticated Encryption provides both data confidentiality and data integrity assurances that the information is protected.

Sign then Encrypt
~~~~~~~~~~~~~~~~~~~~~

Objective C

.. code-block:: objective-c
    :linenos:

    NSError *error;
    NSData *signedAndEcnryptedData = [self.crypto signAndEncryptData:data withPrivateKey:senderPrivateKey forRecipients:@[receiverPublicKey] error:&error];

Swift
     
.. code-block:: swift
    :linenos:

    let signedAndEcryptedData = try? self.crypto.signAndEncrypt(data, with: senderPrivateKey, for: [receiverPublicKey])

Decrypt then Verify
~~~~~~~~~~~~~~~~~~~~~~~~

Objective C

.. code-block:: objective-c
    :linenos:

    NSError *error;
    NSData *decryptedAndVerifiedData = [self.crypto decryptAndVerifyData:signedAndEcnryptedData withPrivateKey:receiverPrivateKey usingSignerPublicKey:senderPublicKey error:&error];

Swift
     
.. code-block:: swift
    :linenos:

    let decryptedAndVerifiedData = try? self.crypto.decryptAndVerify(signedAndEcryptedData, with: receiverPrivateKey, using: senderPublicKey)

Fingerprint Generation
----------------------

The default Fingerprint algorithm is ``SHA-256``.

Objective C

.. code-block:: objective-c
    :linenos:

    VSSFingerprint *fingerprint = [self.crypto calculateFingerprintForData:data];

Swift    

.. code-block:: swift
    :linenos:

    let fingerprint = self.crypto.calculateFingerprint(for: data)

See Also: 
---------
`Source code <https://github.com/VirgilSecurity/virgil-sdk-x>`__