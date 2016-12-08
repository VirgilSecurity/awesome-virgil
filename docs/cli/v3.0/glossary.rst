GLOSSARY
========


.. glossary::

    Alias : Crypto
    
        descr
        

.. glossary::

    Application Virgil Card : Crypto
    
        Application Virgil Cards are accessible only within the application they were created within. Their `scope` parameter is `application`.
    

.. glossary::

    Confirmed Virgil Card : Crypto
    
        descr
        

.. glossary::

    Content info : Crypto
    
        Meta information about the encrypted data.
        

.. glossary::

    Data : Crypto
    
        An associative array that contains application specific parameters. All keys must contain only latic characters and digits. The length of keys and values must not exceed 256 characters. Please note that you cannot persist more than 16 data items.


.. glossary::

    Global Virgil Card : Crypto
    
        Global Virgil Cards are available in all the applications. Their `scope` parameter is `global`.
        

.. glossary::

    Hash : Crypto
    
        A mathematical algorithm that maps data of arbitrary size to a bit string of a fixed size. 
        

.. glossary::

    Identity : Crypto
    
        Must be a valid email for a Confirmed Virgil Card and can be any value for a Segregated Virgil Card


.. glossary::

    Identity-type : Crypto
    
        Must be `email` for a Confirmed Virgil Card and can be any value for a Segregated Virgil Card.


.. glossary::

    Info : Crypto
    
        An associative array with predefined keys that contain information about the device on which the keypair was created. The keys are always `device_name` and `device` and the values must not exceed 256 characters. Both keys must be used if info parameter is specified.
        
        
.. glossary::

    Keypass : Crypto
    
        Keypass consists of the given password used as the Recipient's identifier or the Private Key associated with the Public Key used for encryption.
        
        
.. glossary::

    PBKDF function : Crypto
    
        A mechanism that produces a set of keys from keying material and some optional parameters. 


.. glossary::

    Private Key : Crypto
    
        A Private Key represents the secret part of the Asymmetric Keypair. It is used to sign and decrypt data. The Private Keys should never be stored verbatim or in plain text on a local computer. If you need to store a Private Key, you should use a secure key container depending on your platform.
        

.. glossary::

    Private Key password : Crypto
    
        A password set for a Private Key during its creation adds additional security stage and prevents any data leakage after the private key has been compromised. It is optional but highly recommended to set this password.


.. glossary::

    Public Key : Crypto
    
        A Public Key represents the public part of the Asymmetric Keypair. It is used to encrypt data or verify a signature.


.. glossary::

    Recipient-id : Crypto 
    
        Recipient's identifier will be associated with the Public Key used for the encryption. These can be: the Public Key itself, the Virgil Card, the Virgil Card id, the valid email.
        

.. glossary::

    Revocation reason : Crypto
    
        The `revocation reason` must be `unspecified` or `compromised`. The default value is `unspecified`.
        

.. glossary::

    Salt : Crypto
    
        Random data that is used as an additional input for a hash function. 
        
        
.. glossary::

    Scope : Crypto
    
        Determines a Virgil Card scope that can be either `global` (for Global Virgil Cards) or `application` (for Application Virgil Cards. The default value is `application`.


.. glossary::

    Segregated Virgil Card : Crypto
    
        descr


.. glossary::

    Virgil Card : Crypto
    
        A Virgil Card is the main entity of the Virgil Keys Service. It contains the information about the user and his public key.
        
        
.. glossary::

    Virgil Card id : Crypto
    
        A unique identifier of any Virgil Card.


.. glossary::

    Virgil Keys Service : Crypto
    
        descr
