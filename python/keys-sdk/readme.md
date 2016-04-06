- [Introduction](#introduction)
- [Install](#installation)
- [Obtaining an Access Token](#obtaining-an-access-token)
- [Identity Check](#identity-check)
      - [Request Verification](#request-verification)
      - [Confirm and Get an Identity Token](#confirm-and-get-an-identity-token)
- [Cards and Public Keys](#cards-and-public-keys)
      - [Publish a Virgil Card](#publish-a-virgil-card)
      - [Search for Cards](#search-for-cards)
      - [Search for Application Cards](#search-for-application-cards)
      - [Trust a Virgil Card](#trust-a-virgil-card)
      - [Untrust a Virgil Card](#untrust-a-virgil-card)
      - [Revoke a Virgil Card](#revoke-a-virgil-card)
      - [Get a Public Key](#get-a-public-key)
- [Private Keys](#private-keys)
      - [Stash a Private Key](#stash-a-private-key)
      - [Get a Private Key](#get-a-private-key)
      - [Destroy a Private Key](#destroy-a-private-key)

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

## Identity Check

All the Virgil Security services are strongly interconnected with the Identity Service. It determines the ownership of the identity being checked using particular mechanisms and as a result it generates a temporary token to be used for the operations which require an identity verification. 

#### Request Verification

Initialize the identity verification process.

```python
verifyResponse = virgil_hub.identity.verify('email',
										'example@virgilsecurity.com')
```

#### Confirm and Get an Identity Token

Confirm the identity and get a temporary token.

```python
identResponse = virgil_hub.identity.confirm('%CONFIRMATION_CODE%',
										verifyResponse['action_id'])
```

## Cards and Public Keys

A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc.

The Virgil Card might be created with a confirmed or unconfirmed Identity. The difference is whether Virgil Services take part in the [Identity verification.](#identity-check) With confirmed Cards you can be sure that the account with a particular email has been verified and the email owner is really the Identity owner. Be careful using unconfirmed Cards because they could have been created by any user.

#### Publish a Virgil Card

An identity token which can be received [here](#identity-check) is used during the registration.

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

Search for the Virgil Card by provided parameters.

```python
search_result = virgil_hub.virgilcard.search_card('example@virgilsecurity.com')
```

Search for the Virgil Cards including the cards with unconfirmed Identities.

```python
search_result = card = virgil_hub.virgilcard.search_card('example@virgilsecurity.com', None, None, True)
```

#### Search for Application Cards

Search for the Virgil Cards by a defined pattern. The example below returns a list of applications for Virgil Security company.

```python
my_app = virgil_hub.virgilcard.search_app('My application')
```

#### Trust a Virgil Card

Any Virgil Card user can act as a certification center within the Virgil Security ecosystem. Every user can certify another's Virgil Card and build a net of trust based on it.

The example below demonstrates how to certify a user's Virgil Card by signing its hash attribute. 

```python
virgil_hub.virgilcard.sign_card
					("%SIGNED_CARD_ID%", 
					"%SIGNER_CARD_ID%", 
					"%PRIVATE_KEY%", 
					"%PASSWORD%")
```

#### Untrust a Virgil Card

Naturally it is possible to stop trusting the Virgil Card owner as in all relations. This is not an exception in Virgil Security system.

```python
virgil_hub.virgilcard.unsign_card
						("%SIGNED_CARD_ID%", 
						"%SIGNER_CARD_ID%", 
						"%PRIVATE_KEY%", 
						"%PASSWORD%")
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
