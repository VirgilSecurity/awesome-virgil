============
Tutorial Python SDK
============

- `Introduction`_
- `Installation`_ 
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

This tutorial explains how to use the Public Keys Service with SDK library in Python applications. 

*********
Installation
*********

To install `package <https://cdn.virgilsecurity.com/virgil-crypto/python/>`_ use the command below:

.. code-block:: html

    python setup.py install

You can easily add an SDK dependency to your project, just add the following code:

.. code-block:: python

    from VirgilSDK import virgilhub
    import VirgilSDK.virgil_crypto.cryptolib as cryptolib

*********
Obtaining an Access Token
*********

First you must create a free Virgil Security developer's account by signing up `here <https://developer.virgilsecurity.com/account/signup>`_. Once you have your account you can `sign in <https://developer.virgilsecurity.com/account/signin>`_ and generate an access token for your application.

The access token provides an authenticated secure access to the Public Keys Service and is passed with each API call. The access token also allows the API to associate your app's requests with your Virgil Security developer's account.

Simply add your access token to the client constructor.

.. code-block:: python

    identity_link = 'https://identity.virgilsecurity.com/v1'
    virgil_card_link = 'https://keys.virgilsecurity.com/v3'
    private_key_link = 'https://keys-private.virgilsecurity.com/v3'
    virgil_hub = virgilhub.VirgilHub('%ACCESS_TOKEN%', identity_link, virgil_card_link, private_key_link)

*********
Cards and Public Keys
*********

A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.

The Virgil Card might be global and private. The difference is whether Virgil Services take part in the Identity verification Identities_.

Global Cards are created with the validation token received after verification in Virgil Identity Service. Any developer with Virgil account can create a global Virgil Card and you can be sure that the account with a particular email has been verified and the email owner is really the Identity owner.

Private Cards are created when a developer is using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app's Private Key created on our `Developer portal <https://developer.virgilsecurity.com/dashboard/>`_.

Publish a Virgil Card
=========

Creating a private Virgil Card with a newly generated key pair and ValidationToken. ee how to obtain a **ValidationToken**  here... `Obtaining a private ValidationToken`_

.. code-block:: python

    Add_data = {'Field1': 'Data1', 'Field2': 'Data2'}
    new_card = virgil_hub.virgilcard.create_card('email', 'example@virgilsecurity.com', data, identResponse['validation_token'], keys['private_key'], '%Password%', keys['public_key'])


Creating a Card without an Identity verification. Pay attention that you will have to set an additional attribute to include the Cards with unconfirmed Identities into your search, see an example `Search for cards`_.

.. code-block:: python

    Add_data = {'Field1': 'Data1', 'Field2': 'Data2'}
    new_card = virgil_hub.virgilcard.create_card('email', 'example@virgilsecurity.com', data, None, keys['private_key'], '%Password%', keys['public_key'])

Search for Cards
=========

Search for a global Virgil Card.

.. code-block:: python

    # Search for email card
    search_result = virgil_hub.virgilcard.search_card('example@virgilsecurity.com')
    
    # Search for application card
    my_app = virgil_hub.virgilcard.search_app('My application')

Search for a private Virgil Card.

.. code-block:: python

    search_result = card = virgil_hub.virgilcard.search_card('example@virgilsecurity.com', None, None, True)

Revoke a Virgil Card
==============

This operation is used to delete the Virgil Card from the search and mark it as deleted. 

.. code-block:: python

    verifyResponse = virgil_hub.identity.verify('email', 'example@virgilsecurity.com')
    identResponse = virgil_hub.identity.confirm('%CONFIRMATION_CODE%', verifyResponse['action_id'])
    virgil_hub.virgilcard.delete_card('email', 'example@virgilsecurity.com', identResponse['validation_token'], '%CARD_ID%', '%PRIVATE_KEY%', '%PASSWORD%')

Get a Public Key
=========

Gets a public key from the Public Keys Service by the specified ID.

.. code-block:: python

    pk = virgil_hub.virgilcard.get_public_key('%PUBLIC_KEY_ID%')

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

.. code-block:: python

    recipient_card = virgil_hub.virgilcard.search_app('com.virgilsecurity.private-keys')
    for card in recipient_card:
        recipient_id = card['id']
        recipient_pub_key = card['public_key']['public_key']
    virgil_hub.privatekey.load_private_key(recipient_pub_key, recipient_id, "%PRIVATE_KEY%", "%SIGNER_CARD_ID%", "%PASSWORD%")


Get a Private Key
=========

To get a private key you need to pass a prior verification of the Virgil Card where your public key is used.
  
.. code-block:: python

    verifyResponse = virgil_hub.identity.verify('email', 'example@virgilsecurity.com')
    identResponse = virgil_hub.identity.confirm("%CONFIRMATION_CODE%", verifyResponse['action_id'])
    recipient_card = virgil_hub.virgilcard.search_app('com.virgilsecurity.private-keys')
    for card in recipient_card:
        recipient_id = card['id']
        recipient_pub_key = card['public_key']['public_key']
    private_key_from_service = virgil_hub.privatekey.grab_private_key(recipient_pub_key, recipient_id, 'email', 'example@virgilsecurity.com', identResponse['validation_token'], '%PASSWORD%', "%SIGNER_CARD_ID%")


Destroy a Private Key
=========

This operation deletes the private key from the service without a possibility to be restored. 
  
.. code-block:: python

    recipient_card = virgil_hub.virgilcard.search_app('com.virgilsecurity.private-keys')
    for card in recipient_card:
        recipient_id = card['id']
        recipient_pub_key = card['public_key']['public_key']
    virgil_hub.privatekey.delete_private_key(recipient_pub_key, recipient_id, "%PRIVATE_KEY%", "%SIGNER_CARD_ID%", "%PASSWORD%")


*********
Identities
*********

Obtaining a global ValidationToken
=========

The global ValidationToken is used for creating global Cards. The global ValidationToken can be obtained only by checking the ownership of the Identity on Virgil Identity Service.

In the example below you can see how to obtain a ValidationToken for creating a global Virgil Card.

.. code-block:: python

    verifyResponse = virgil_hub.identity.verify('email', 'example@virgilsecurity.com')
    identResponse = virgil_hub.identity.confirm('%CONFIRMATION_CODE%', verifyResponse['action_id'])
    validation_token = identResponse['validation_token']

Obtaining a private ValidationToken
=========

The private ValidationToken is used for creating Private Cards. The private ValidationToken can be generated on developer's side using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app's Private Key created on our `Developer portal <https://developer.virgilsecurity.com/dashboard/>`_.   

In the example below you can see, how to generate a ValidationToken using the SDK library.

.. code-block:: python

    validation_token = ValidationTokenGenerator.generate(value, virgilhub.IdentityType.custom, PRIVATE_KEY, PRIVATE_KEY_PASSWORD)
