============
Tutorial C/C++ Keys SDK
============

- `Introduction`_
- `Obtaining an Access Token`_
- `Cards and Public Keys`_
    - `Publish a Virgil Card`_
    - `Search for Cards`_
    - `Revoke a Virgil Card`_
    - `Get a Public Key`_
- `Private Keys`_
    - `Stash a Private Key`_
    - `Get a Private Key`_
    - `Destroy a Private Key`_
- `Identities`_
    - `Obtaining a global ValidationToken`_
    - `Obtaining a private ValidationToken`_

*********
Introduction
*********

This tutorial explains how to use the Public Keys Service with SDK library in CPP applications.

*********
Obtaining an Access Token
*********

First you must create a Virgil Security developer's account by signing up `here <https://developer.virgilsecurity.com/account/signup>`_. Once you have your account you can `sign in <https://developer.virgilsecurity.com/account/signin>`_ and generate an access token for your application.

The access token provides an authenticated secure access to the Public Keys Service and is passed with each API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Simply add your access token to the class builder.

.. code-block:: cpp

     vsdk::ServicesHub servicesHub("<ACCESS_TOKEN>")

*********
Cards and Public Keys
*********

A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.

The Virgil Card might be *global* and *private*. The difference is whether Virgil Services take part in the Identity verification Identities_. 

*Global Cards* are created with the validation token received after verification in Virgil Identity Service. Any developer with Virgil account can create a global Virgil Card and you can be sure that the account with a particular email has been verified and the email owner is really the Identity owner.

*Private Cards* are created when a developer is using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app's Private Key created on our `Developer portal <https://developer.virgilsecurity.com/dashboard/>`_.   

Publish a Virgil Card
=========

Creating a *private* Virgil Card with a newly generated key pair and **ValidationToken**. See how to obtain a **ValidationToken** here...`Obtaining a private ValidationToken`_

.. code-block:: cpp

  std::string userEmail = "bob@mailinator.com";
  std::string obfuscatorIdentityValue = vsdk::util::
      obfuscate(userEmail, "salt");
  std::string obfuscatorIdentityType = "obfuscated-email";
  vsdk::dto::Identity obfuscatedIdentity(
       obfuscatorIdentityValue, obfuscatorIdentityType);
  
  std::string kPrivateKeyPassword = "J,gh&UpY\\6AJm(6{'aJQa:q,BY[I.rA";
  vcrypto::VirgilKeyPair keyPair(vcrypto::str2bytes(kPrivateKeyPassword));
  vcrypto::VirgilByteArray userPublicKey = keyPair.publicKey();
  vcrypto::VirgilByteArray userPrivateKey = keyPair.privateKey();
  vsdk::Credentials userCredentials(userPrivateKey, 
       virgil::crypto::str2bytes(kPrivateKeyPassword));
  
      vsdk::models::CardModel privateCard = servicesHub.card().create(
              generateValidatedIdentity(obfuscatedIdentity, appCredentials), 
              userPublicKey, userCredentials);

Creating an unauthorized *private* Virgil Card without **ValidationToken**. Pay attention that you will have to set an additional attribute to include the private Cards without verification into your search, see an example `Search for cards`_.

.. code-block:: cpp

  vsdk::models::CardModel unauthorizedPrivateCard = servicesHub.card()
  .create(obfuscatedIdentity, userPublicKey, userCredentials);

Creating a *global* Virgil Card. See how to obtain a **ValidationToken** here...`Obtaining a global ValidationToken`_

.. code-block:: cpp

  vsdk::models::CardModel globalCard = servicesHub.card()
  .create(validatedIdentity, userPublicKey, userCredentials);

Search for Cards
=========

Search for a *global* Virgil Card.

.. code-block:: cpp

   // search for email card.
   std::vector<vsdk::models::CardModel> foundGlobalCard = 
        servicesHub.card().searchGlobal(userEmail, 
   vsdk::dto::IdentityType::Email);
   
   // search for application card.
   std::vector<vsdk::models::CardModel> foundAppCard = 
        servicesHub.card().searchGlobal("com.virgilsecurity.mail", 
   vsdk::dto::IdentityType::Application);

Search for a *private* Virgil Card.

.. code-block:: cpp

  std::vector<vsdk::models::CardModel> foundPrivateCard = 
  servicesHub.card().search(obfuscatedIdentity.getValue(),
  obfuscatedIdentity.getType());
  
  // or search for Virgil Cards including unauthorized ones.
  bool includeUnauthorized = true;
  std::vector<vsdk::models::CardModel> foundUnauthorizedPrivateCard = 
  servicesHub.card().search(obfuscatedIdentity.getValue(), 
  obfuscatedIdentity.getType(), includeUnauthorized);

Revoke a Virgil Card
=========

This operation is used to delete the Virgil Card from the search and mark it as deleted.

.. code-block:: cpp

  // Revoke a Global Virgil Card
  servicesHub.card().
  revoke(globalCard.getId(), validatedIdentity, userCredentials);
  
  // Revoke a Private Virgil Card
  servicesHub.card().revoke(privateCard.getId(), generateValidatedIdentity(
              obfuscatedIdentity, appCredentials), userCredentials);
  
  // Revoke a unauthorized Private Virgil Card
  servicesHub.card().revoke(unauthorizedPrivateCard.getId(), 
  obfuscatedIdentity, userCredentials);

Get a Public Key
=========

This operation gets a public key from the Public Keys Service by the specified ID.

.. code-block:: cpp

  vsdk::models::PublicKeyModel foundPublicKey = 
   servicesHub.publicKey().get(publicKeyId);

*********
Private Keys
*********

The security of private keys is crucial for the public key cryptosystems. Anyone who can obtain a private key can use it to impersonate the rightful owner during all communications and transactions on intranets or on the internet. Therefore, private keys must be in the possession only of authorized users, and they must be protected from unauthorized use.

Virgil Security provides a set of tools and services for storing private keys in a safe storage which lets you synchronize your private keys between the devices and applications.

Usage of this service is optional.

Stash a Private Key
=========

Private key can be added for storage only in case you have already registered a public key on the Public Keys Service.

Use the public key identifier on the Public Keys Service to save the private keys.

The Private Keys Service stores private keys the original way as they were transferred. That's why we strongly recommend transferring the keys which were generated with a password.

.. code-block:: cpp

  // a Global Virgil Card
  servicesHub.privateKey().add(globalCard.getId(), userCredentials);
  
  // a Private Virgil Card
  servicesHub.privateKey().add(privateCard.getId(), userCredentials);

Get a Private Key
=========

This operation is used to get a private key. You must pass a prior verification of the Virgil Card in which your public key is used. And then you must obtain a **ValidationToken** depending on your Virgil Card (global `Obtaining a global ValidationToken`_ or  private `Obtaining a private ValidationToken`_).

.. code-block:: cpp

  // a Global Virgil Card
  vsdk::models::PrivateKeyModel privateKey = servicesHub.privateKey().get(
              globalCard.getId(), validatedIdentity);
  
  // a Private Virgil Card
  vsdk::models::PrivateKeyModel privateKey = 
  servicesHub.privateKey().get(privateCard.getId(),
  generateValidatedIdentity(obfuscatedIdentity,appCredentials));

Destroy a Private Key
=========

This operation deletes the private key from the service without a possibility to be restored.

.. code-block:: cpp

  // a Global Virgil Card
  servicesHub.privateKey().del(globalCard.getId(), userCredentials);
  
  // a Private Virgil Card
  servicesHub.privateKey().del(privateCard.getId(), userCredentials);

*********
Identities
*********

Obtaining a global ValidationToken
=========

The *global* **ValidationToken** is used for creating *global Cards*. The *global* **ValidationToken** can be obtained only by checking the ownership of the Identity on Virgil Identity Service.

In the example below you can see how to obtain a **ValidationToken** for creating a *global* Virgil Card.

.. code-block:: cpp

  // send a verification request for specified identity type.
  std::string actionId = servicesHub.identity().
  verify(userEmail, vsdk::dto::VerifiableIdentityType::Email);
  
  // confirm an identity using code received on email address.
  vsdk::dto::ValidatedIdentity validatedIdentity = servicesHub.identity().
  confirm(actionId, "<CONFIRMATION_CODE>");

Obtaining a private ValidationToken
=========

The *private* **ValidationToken** is used for creating *Private Cards*. The *private* **ValidationToken** can be generated on developer's side using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app's Private Key created on our [`Developer portal <https://developer.virgilsecurity.com/dashboard/>`_.   

In the example below you can see, how to generate a **ValidationToken** using the SDK library.

.. code-block:: cpp

  vsdk::dto::ValidatedIdentity generateValidatedIdentity(
  const vsdk::dto::Identity& obfuscatedIdentity, 
  const vsdk::Credentials& appCredentials) {
      std::string validationToken = vsdk::util::generate_validation_token(
              obfuscatedIdentity.getValue(), obfuscatedIdentity.getType(),
   appCredentials);
      return vsdk::dto::ValidatedIdentity(obfuscatedIdentity, 
  validationToken);
  }

See full examples:

1. `A Global Virgil Card <https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/master/examples/src/card_create_global.cxx>`_
2. `A Private Virgil Card <https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/master/examples/src/card_create_private.cxx>`_
3. `An unauthorized Private Virgil Card <https://github.com/VirgilSecurity/virgil-sdk-cpp/blob/master/examples/src/card_create_private_unauthorized.cxx>`_
