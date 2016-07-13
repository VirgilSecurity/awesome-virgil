============
Create an Application
============

First you must create a free Virgil Security developer’s account by signing up `here <https://developer-stg.virgilsecurity.com/account/signup>`_. Once you have your account you can `sign in <https://developer-stg.virgilsecurity.com/account/signin>`_ and create an application with an access token.

1. Add an application with some description:

.. image:: Images/CreateApp.png

2. You need a key pair to perform cryptographic actions. 

2a.	*Generate using Virgil*

We recommend using Virgil Services to create a key pair, this way you don’t have to worry about taking care of your keys. Add a password for your private key and save it in a secure place – we won’t be able to help if you lose this password.

.. image:: Images/KeysGenerate.png

2b. *Create keys manually*

You can also add an existing key pair or generate it using Virgil CLI tool. Upload the file with your public key, it can be generated with commands provided in our wizard.

.. image:: Images/KeysCreate.png

One more step

.. image:: Images/CompleteKeysCreate.png

3. Don’t forget to save your generated private key, because it won’t be available when the app creation wizard closes.

.. image:: Images/CompleteKeysGenerate.png

4. Your app is created, it’s time to :doc:`add-access-token`.
