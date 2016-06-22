#Virgil Entities

- [Public Key](#public-key)
- [Private Key](#private-key)
- [Virgil Card](#virgil-card)
- [Signature](#signature)

## Public Key
Public Key entity is an entity that is implicitly created by using POST /virgil-card endpoint. A Public Key entity contains the associated Virgil Cards entities that are available via signed version of the GET /public-key/{public-key-id} endpoint.
[Read more...](https://github.com/VirgilSecurity/virgil-services-keys)

## Private Key
Private keys should never be stored verbatim or in plain text on a local computer. If you need to store a private key, you should use a secure key container depending on your platform. You also can use Virgil Keys Service to store and synchronize private keys. This will allows you to easily synchronize private keys between clients’ devices and their applications.

## Virgil Card
Virgil Card is the core entity of Virgil services. Virgil Cards are used to arrange the Web of Trust by signing each other to share the information between users and applications. So the Virgil Card is an entity that contains the information about the Public Key and Identity and the list of key/value pairs with custom values that can be used by different applications.
[Read more...](https://github.com/VirgilSecurity/virgil-services-keys)

## Signature
Cryptographic digital signatures use public key algorithms to provide data integrity. When you sign data with a digital signature, someone else can verify the signature, and can prove that the data originated from you and was not altered after you signed it.
