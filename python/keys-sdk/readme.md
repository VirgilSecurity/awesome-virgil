- [Introduction](#introduction)
- [Install](#installation)
- [Obtaining an Access Token](#obtaining-an-access-token)
- [Cards and Public Keys](#cards-and-public-keys)
      - [Publish a Virgil Card](#publish-a-virgil-card)
      - [Search for Cards](#search-for-cards)
      - [Revoke a Virgil Card](#revoke-a-virgil-card)
      - [Get a Public Key](#get-a-public-key)
- [Private Keys](#private-keys)
      - [Stash a Private Key](#stash-a-private-key)
      - [Get a Private Key](#get-a-private-key)
      - [Destroy a Private Key](#destroy-a-private-key)
- [Identity](#identity)
      - [Obtaining a global ValidationToken](#obtaining-a-global-validationtoken)
      - [Obtaining a private ValidationToken](#obtaining-a-private-validationtoken)

## Introduction

This tutorial explains how to use the Public Keys Service with SDK library in Python applications. 

## Installation

To install package use the command below:

```
python setup.py install
```

You can easily add an SDK dependency to your project, just add the following code:

```python
from VirgilSDK import virgilhub
import VirgilSDK.virgil_crypto.cryptolib as cryptolib
```

## Obtaining an Access Token

First you must create a free Virgil Security developer's account by signing up [here](https://developer.virgilsecurity.com/account/signup). Once you have your account you can [sign in](https://developer.virgilsecurity.com/account/signin) and generate an access token for your application.

The access token provides an authenticated secure access to the Public Keys Service and is passed with each API call. The access token also allows the API to associate your app's requests with your Virgil Security developer's account.

Simply add your access token to the client constructor.

```python
identity_link = '%IDENTITY_SERVICE_URL%'
virgil_card_link = '%VIRGIL_CARD_SERVICE_URL%'
private_key_link = '%PRIVATE_KEY_SERVICE_URL%'
virgil_hub = virgilhub.VirgilHub('%ACCESS_TOKEN%', 
								identity_link, 
								virgil_card_link, 
								private_key_link)
```


## Cards and Public Keys
A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.

The Virgil Card might be global and private. The difference is whether Virgil Services take part in the [Identity verification.](#identity).

Global Cards are created with the validation token received after verification in Virgil Identity Service. Any developer with Virgil account can create a global Virgil Card and you can be sure that the account with a particular email has been verified and the email owner is really the Identity owner.

Private Cards are created when a developer is using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app's Private Key created on our [Developer portal](https://developer.virgilsecurity.com/dashboard/).

#### Publish a Virgil Card

Creating a private Virgil Card with a newly generated key pair and ValidationToken. See how to obtain a ValidationToken [here](#identity).

```python
Add_data ={'Field1': 'Data1', 'Field2': 'Data2'}
new_card = virgil_hub.virgilcard.create_card
					('email', 
					'example@virgilsecurity.com', 
					data, 
					identResponse['validation_token'], 
					keys['private_key'], 
					'%Password%', 
					keys['public_key'])
```

Creating a Card without an Identity verification. Pay attention that you will have to set an additional attribute to include the Cards with unconfirmed Identities into your search, see an [example](#search-for-cards).

```python
Add_data ={'Field1': 'Data1', 'Field2': 'Data2'}
new_card = virgil_hub.virgilcard.create_card
					('email', 
					'example@virgilsecurity.com', 
					data, 
					None, 
					keys['private_key'], 
					'%Password%', 
					keys['public_key'])
```

#### Search for Cards

Search for a global Virgil Card.

```python
# Search for email card
search_result = virgil_hub.virgilcard.search_card('example@virgilsecurity.com')

# Search for application card
my_app = virgil_hub.virgilcard.search_app('My application')
```

Search for a private Virgil Card.

```python
search_result = card = virgil_hub.virgilcard.search_card('example@virgilsecurity.com', None, None, True)
```

#### Revoke a Virgil Card

This operation is used to delete the Virgil Card from the search and mark it as deleted. 

```python
verifyResponse = virgil_hub.identity.verify('email',
										'example@virgilsecurity.com')
identResponse = virgil_hub.identity.confirm('%CONFIRMATION_CODE%',
										 verifyResponse['action_id'])
virgil_hub.virgilcard.delete_card('email', 
								'example@virgilsecurity.com',
								identResponse['validation_token'], 
								'%CARD_ID%', 
								'%PRIVATE_KEY%', 
								'%PASSWORD%')
```

#### Get a Public Key

Gets a public key from the Public Keys Service by the specified ID.

```python
pk = virgil_hub.virgilcard.get_public_key('%PUBLIC_KEY_ID%')
```

## Private Keys

The security of private keys is crucial for the public key cryptosystems. Anyone who can obtain a private key can use it to impersonate the rightful owner during all communications and transactions on intranets or on the internet. Therefore, private keys must be in the possession only of authorized users, and they must be protected from unauthorized use.

Virgil Security provides a set of tools and services for storing private keys in a safe storage which lets you synchronize your private keys between the devices and applications.

Usage of this service is optional.

#### Stash a Private Key

Private key can be added for storage only in case you have already registered a public key on the Public Keys Service.

Use the public key identifier on the Public Keys Service to save the private keys. 

The Private Keys Service stores private keys the original way as they were transferred. That's why we strongly recommend transferring the keys which were generated with a password.

```python
recipient_card = virgil_hub.virgilcard.search_app
							('com.virgilsecurity.private-keys')
for card in recipient_card:
  recipient_id = card['id']
  recipient_pub_key = card['public_key']['public_key']
virgil_hub.privatekey.load_private_key(recipient_pub_key, 
										recipient_id, 
										"%PRIVATE_KEY%", 
										"%SIGNER_CARD_ID%", 
										"%PASSWORD%")
```

#### Get a Private Key

To get a private key you need to pass a prior verification of the Virgil Card where your public key is used.
  
```python
verifyResponse = virgil_hub.identity.verify('email', 
									'example@virgilsecurity.com')
identResponse = virgil_hub.identity.confirm("%CONFIRMATION_CODE%", 
									verifyResponse['action_id'])
recipient_card = virgil_hub.virgilcard.search_app
									('com.virgilsecurity.private-keys')
for card in recipient_card:
  recipient_id = card['id']
  recipient_pub_key = card['public_key']['public_key']
private_key_from_service = virgil_hub.privatekey.grab_private_key
									(recipient_pub_key, 
									recipient_id, 
									'email', 
									'example@virgilsecurity.com',
									identResponse['validation_token'], 
									'%PASSWORD%', 
									"%SIGNER_CARD_ID%")
```

#### Destroy a Private Key

This operation deletes the private key from the service without a possibility to be restored. 
  
```python
recipient_card = virgil_hub.virgilcard.search_app
									('com.virgilsecurity.private-keys')
for card in recipient_card:
  recipient_id = card['id']
  recipient_pub_key = card['public_key']['public_key']
virgil_hub.privatekey.delete_private_key
									(recipient_pub_key, 
									recipient_id, 
									"%PRIVATE_KEY%", 
									"%SIGNER_CARD_ID%", 
									"%PASSWORD%")
```

## Identity

#### Obtaining a global ValidationToken

The global ValidationToken is used for creating global Cards. The global ValidationToken can be obtained only by checking the ownership of the Identity on Virgil Identity Service.

In the example below you can see how to obtain a ValidationToken for creating a global Virgil Card.

```python
verifyResponse = virgil_hub.identity.verify('email',
										'example@virgilsecurity.com')
identResponse = virgil_hub.identity.confirm('%CONFIRMATION_CODE%',
										verifyResponse['action_id'])
validation_token = identResponse['validation_token']
```

#### Obtaining a private ValidationToken

The private ValidationToken is used for creating Private Cards. The private ValidationToken can be generated on developer's side using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app's Private Key created on our Developer portal.

In the example below you can see, how to generate a ValidationToken using the SDK library.

```python
validation_token = ValidationTokenGenerator.generate(value, virgilhub.IdentityType.custom, 
							PRIVATE_KEY, PRIVATE_KEY_PASSWORD)
```
