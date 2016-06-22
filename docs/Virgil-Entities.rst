=========
Virgil Entities
=========

- `Action id`_
- [Card id](#card-id)
- [Confirmation code](#confirmation-code)
- [Confirmed Identity](#confirmed-identity)
- [Count to live](#count-to-live)
- [Custom Identity](#custom-identity)
- [Global Virgil Card](#global-virgil-card)
- [Hash](#hash)
- [PBKDF function](#pbkdf-function)
- [Private key](#private-key)
- [Private key password](#private-key-password)
- [Private Virgil Card](#private-virgil-card)
- [Public Key](#public-key)
- [Public key id](#public-key-id)
- [Recipient's identifier](#recipients-identifier)
- [Salt](#salt)
- [Signature](#signature)
- [Time to live](#time-to-live)
- [Unconfirmed Identity](#unconfirmed-identity)
- [Validation token](#validation-token)
- [Virgil Card](#virgil-card)

.. glossary::

  .. _Action id:
    Is used to compare confirmation code and validation action.	

  Card id	
    A unique identifier of any Virgil Card. It is used for every operation with Virgil Cards.
	
  Confirmation code	
    Is used to confirm ownership of a global identifier like email, phone number.	

  Confirmed Identity	  
    An identity which passed *verify* and *confirm* actions by Identity service.
	
  Count to live	
    This parameter is used to restrict the number of confirmation token usages (maximum value is 100). *count_to_live* default value is 1.	

  Custom identity	
    A type of Identity which is validated using concatenated type and value of the Identity signed by the application's :term:`private key <Private Key>`. 
    

  Global Virgil Card	
    A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc. Global Cards are created with the validation token received after verification in Virgil Identity Service. Any developer with Virgil account can create a global Virgil Card and you can be sure that the account with a particular email has been verified and the email owner is really the Identity owner.	

  Hash	
    A mathematical algorithm that maps data of arbitrary size to a bit string of a fixed size. `Read more <https://en.wikipedia.org/wiki/Cryptographic_hash_function>`_

  PBKDF function	
    A mechanism that produces a set of keys from keying material and some optional parameters. `Read more <https://en.wikipedia.org/wiki/Key_derivation_function>`_

  Private Key	
    Private keys should never be stored verbatim or in plain text on a local computer. If you need to store a private key, you should use a secure key container depending on your platform. You also can use Virgil Keys Service to store and synchronize private keys. This will allow you to easily synchronize private keys between clients’ devices and their applications.	

  Private key password	
    A password set for a private key adds additional security stage and prevents any data leakage after the private key has been compromised. It is optional but highly recommended to set this password.	

  Private Virgil Card	
    A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc. Private Cards are created when a developer is using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app’s Private Key created on our Developer portal.	

  Public Key	
    A Public Key is an entity that is implicitly created by using *POST /virgil-card* endpoint. A Public Key entity contains a list of associated Virgil Cards entities.	

  Public key id	
    A unique identifier of any public key. It is used for every operation with public keys.	

  Recipient's identifier	
    Identifier of recipient's Virgil Card.	

  Salt	
    Random data that is used as an additional input for a hash function. `Read more <https://en.wikipedia.org/wiki/Salt_(cryptography)>`_

  Signature	
    Cryptographic digital signatures use public key algorithms to provide data integrity. When you sign the data with a digital signature, someone else can verify the signature and can prove that the data originated from you and was not altered after you had signed it.
	
  Time to live	
    This parameter is used to limit the lifetime of the confirmation token in seconds (maximum value is 60 * 60 * 24 * 365 = 1 year). Default *time_to_live* value is 3600.	

  Unconfirmed Identity	
    An identity which hasn't passed verify and confirm actions by Identity service.	
	
  Validation token	
    A validation token is used to prevent unauthorized cards registration. The validation token is generated based on Application's Private Key and client Identity. The global ValidationToken is used for creating global Cards. The global ValidationToken can be obtained only by checking the ownership of the Identity on Virgil Identity Service. The private ValidationToken is used for creating Private Cards. The private ValidationToken can be generated on developer’s side using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app’s Private Key created on our Developer portal.	

  Virgil Card	
    A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc. The Virgil Card might be global and private. The difference is whether Virgil Services take part in the Identity verification.		
