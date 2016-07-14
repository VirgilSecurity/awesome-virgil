============
Tutorial Java/Android Keys SDK
============

- `Introduction`_
- `Install`_ 
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

This tutorial explains how to use the Public Keys Service with SDK library in Java applications. 

*********
Install
*********

You can easily add SDK dependency to your project, just follow the examples below:

Maven
=========

.. code-block:: html

    <dependencies>
      <dependency>
        <groupId>com.virgilsecurity.sdk</groupId>
        <artifactId>client</artifactId>
        <version>3.2.0</version>
      </dependency>
    </dependencies>

Gradle
=========

.. code-block:: html

    compile 'com.virgilsecurity.sdk:android:3.2.0@aar'
    compile 'com.squareup.retrofit2:retrofit:2.0.0'
    compile 'com.squareup.retrofit2:converter-gson:2.0.0'

*********
Obtaining an Access Token
*********

First you must create a Virgil Security developer's account by signing up `here <https://developer.virgilsecurity.com/account/signup>`_. Once you have your account you can `sign in <https://developer.virgilsecurity.com/account/signin>`_ and generate an access token for your application.

The access token provides an authenticated secure access to the Public Keys Service and is passed with each API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer's account.

Simply add your access token to the class builder.

.. code-block:: java

    ClientFactory factory = new ClientFactory("{ACCESS_TOKEN}");

*********
Cards and Public Keys
*********

A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.

The Virgil Card might be *global* and *private*. The difference is whether Virgil Services take part in the Identity verification Identities_. 

*Global Cards* are created with the validation token received after verification in Virgil Identity Service. Any developer with Virgil account can create a global Virgil Card and you can be sure that the account with a particular email has been verified and the email owner is really the Identity owner.

*Private Cards* are created when a developer is using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app's Private Key created on our `Developer portal <https://developer.virgilsecurity.com/dashboard/>`_.   

Publish a Virgil Card
=========

Creating a *private* Virgil Card with a newly generated key pair and **ValidationToken**. See how to obtain a **ValidationToken** here... `Obtaining a private ValidationToken`_

.. code-block::  java

    KeyPair keyPair = KeyPairGenerator.generate();
    
    ValidatedIdentity identity = new ValidatedIdentity(PRIVATE_IDENTITY_TYPE,
     identityValue);
    identity.setToken("{VALIDATION_TOKEN}");
    
    VirgilCardTemplate.Builder vcBuilder = new VirgilCardTemplate.Builder()
        .setIdentity(identity)
        .setPublicKey(keyPair.getPublic());
    VirgilCard cardInfo = factory.getPublicKeyClient()
    .createCard(vcBuilder.build(), keyPair.getPrivate());

Creating an unauthorized *private* Virgil Card without **ValidationToken**. Pay attention that you will have to set an additional attribute to include the private Cards without verification into your search, see an example `Search for cards`_.

.. code-block::  java

    KeyPair keyPair = KeyPairGenerator.generate();
    
    ValidatedIdentity identity = new ValidatedIdentity(PRIVATE_IDENTITY_TYPE,
     identityValue);
    
    VirgilCardTemplate.Builder vcBuilder = new VirgilCardTemplate.Builder()
        .setIdentity(identity)
        .setPublicKey(keyPair.getPublic());
    VirgilCard cardInfo = factory.getPublicKeyClient()
    .createCard(vcBuilder.build(), keyPair.getPrivate());

Creating a *global* Virgil Card. See how to obtain a **ValidationToken** here... `Obtaining a global ValidationToken`_

.. code-block:: java

    KeyPair keyPair = KeyPairGenerator.generate();
    
    String actionId = factory.getIdentityClient()
    .verify(IdentityType.EMAIL, email);
    
    // get the confirmation code from received email message.
    
    ValidatedIdentity identity = factory.getIdentityClient()
    .confirm(actionId, "{CONFIRMATION_CODE}");
    
    VirgilCardTemplate.Builder vcBuilder = new VirgilCardTemplate.Builder()
        .setIdentity(identity)
        .setPublicKey(keyPair.getPublic());
    VirgilCard cardInfo = factory.getPublicKeyClient()
    .createCard(vcBuilder.build(), keyPair.getPrivate());

Search for Cards
=========

Search for a *global* Virgil Card.

.. code-block:: java

    // search for email card.
    
    Builder criteriaBuilder = new Builder()
        .setType(IdentityType.EMAIL)
        .setValue(email);
    List<VirgilCard> cards = factory.getPublicKeyClient()
    .search(criteriaBuilder.build());
    
    // search for application card.
    
    SearchCriteria criteria = new SearchCriteria();
        criteria.setType(IdentityType.APPLICATION);
        criteria.setValue("com.virgilsecurity.mail");
    
    List<VirgilCard> appCards = factory.getPublicKeyClient().search(criteria);

Search for a *private* Virgil Card.

.. code-block:: java

    Builder criteriaBuilder = new Builder().setValue(identityValue);
    List<VirgilCard> cards = factory.getPublicKeyClient()
    .search(criteriaBuilder.build());
    
    // or search for Virgil Cards including unauthorized ones.
    
    Builder criteriaBuilder = new Builder()
        .setValue(identityValue)
        .setIncludeUnauthorized(true);
    List<VirgilCard> cards = factory.getPublicKeyClient()
    .search(criteriaBuilder.build());

Revoke a Virgil Card
=========

This operation is used to delete the Virgil Card from the search and mark it as deleted. 

.. code-block::  java

    factory.getPublicKeyClient()
    .deleteCard(identity, cardInfo.getId(), keyPair.getPrivate());

Get a Public Key
=========

This operation gets a public key from the Public Keys Service by the specified ID.

.. code-block:: java

    PublicKeyInfo publicKey = factory.getPublicKeyClient()
    .getKey(cardInfo.getPublicKey().getId());

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

.. code-block:: java

    SearchCriteria criteria = new SearchCriteria();
    criteria.setType(IdentityType.APPLICATION);
    criteria.setValue("com.virgilsecurity.private-keys");
    
    List<VirgilCard> cards = factory.getPublicKeyClient().search(criteria);
    VirgilCard serviceCard = cards.get(0);
    
    factory.getPrivateKeyClient(serviceCard)
    .stash(cardInfo.getId(), keyPair.getPrivate());

Get a Private Key
=========

This operation is used to get a private key. You must pass a prior verification of the Virgil Card in which your public key is used. And then you must obtain a **ValidationToken** depending on your Virgil Card (global `Obtaining a global ValidationToken`_ or  private `Obtaining a private ValidationToken`_).
  
.. code-block:: java

    PrivateKeyInfo privateKey = factory.getPrivateKeyClient(serviceCard)
    .get(cardInfo.getId(), identity);

Destroy a Private Key
=========

This operation deletes the private key from the service without a possibility to be restored. 
  
.. code-block:: java

    factory.getPrivateKeyClient(serviceCard)
    .destroy(cardInfo.getId(), keyPair.getPrivate());

*********
Identities
*********

Obtaining a global ValidationToken
=========

The *global* **ValidationToken** is used for creating *global Cards*. The *global* **ValidationToken** can be obtained only by checking the ownership of the Identity on Virgil Identity Service.

In the example below you can see how to obtain a **ValidationToken** for creating a *global* Virgil Card.

.. code-block:: java

    // send a verification request for specified identity type. 
    
    String actionId = factory.getIdentityClient()
    .verify(IdentityType.EMAIL, email);
        
    // confirm an identity using code received on email address.
        
    ValidatedIdentity identity = factory.getIdentityClient()
    .confirm(actionId, confirmationCode);

Obtaining a private ValidationToken
=========

The *private* **ValidationToken** is used for creating *Private Cards*. The *private* **ValidationToken** can be generated on developer's side using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app's Private Key created on our `Developer portal <https://developer.virgilsecurity.com/dashboard/>`_.   

In the example below you can see, how to generate a **ValidationToken** using the SDK library.

.. code-block:: java

    String validationToken = ValidationTokenGenerator
    .generate(PRIVATE_IDENTITY_TYPE, identityValue,
        	"{APP_PRIVATE_KEY}", "{APP_PRIVATE_KEY_PASSWORD}");
