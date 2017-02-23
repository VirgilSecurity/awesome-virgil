Programming guide
=============================

This guide is a practical introduction to creating Ruby(Ruby on Rails) apps for that make use of Virgil Security services.

In this guide you will find code for every task you need to implement in order to create an application using Virgil Security. It also includes a description of the main objects and methods. The aim of this guide is to get you up and running quickly. You should be able to copy and paste the code provided here into your own apps and use it with minimal changes.

Setting up your project
----------------------

Follow instructions `here <getting-started>`__ to setup your project environment.

User and App Credentials
------------------------

To start using Virgil Services you first have to create an account at `Virgil 
Developer Portal <https://developer.virgilsecurity.com/account/signup>`__.

After you create an account, or if you already have an account, sign in and 
create a new application. Make sure you save the *appKey* that is 
generated for your application at this point as you will need it later. 
After your application is ready, create a *token* that your app will 
use to make authenticated requests to Virgil Services. One more thing that 
you're going to need is your application's *appID* which is an identifier 
of your application's Virgil Card.

Usage
~~~~~~~~~~~~~~~~~~~

Now that you have your account and application in place you can start making 
requests to Virgil Services.

Initializing
------------------------


.. code-block:: ruby

    require "virgil/sdk"
    include Virgil::SDK::HighLevel

To initialize the SDK Api, you need the *token* that you created for 
your application on [Virgil Developer Portal](https://developer.virgilsecurity.com/)

This inializes a VirgilApi class without application *token* (works only with global Virgil Cards)

.. code-block:: ruby

    virgil = VirgilApi.new

.. code-block:: ruby 

    virgil = VirgilApi.new(access_token: "[YOUR_ACCESS_TOKEN_HERE]")

Initialize high-level SDK using context class

.. code-block:: ruby 

    context = VirgilContext.new(
        access_token: "[YOUR_ACCESS_TOKEN_HERE]",
        # Credentials are required only in case of publish and revoke local Virgil Cards.
        credentials: VirgilAppCredentials.new(app_id: "[YOUR_APP_ID_HERE]",
                                            app_key_data: VirgilBuffer.from_file("[YOUR_APP_KEY_PATH_HERE]"),
                                            app_key_password: "[YOUR_APP_KEY_PASSWORD_HERE]"),
        card_verifiers: [ VirgilCardVerifierInfo.new("[YOUR_CARD_ID_HERE]", 
                                                    VirgilBuffer.from_base64("[YOUR_PUBLIC_KEY_HERE]"))]
    )

    virgil = VirgilApi.new(context: context)

At this point you can start creating and publishing *Virgil Cards* for your
users.

> *Virgil Card* is the main entity of Virgil Services, it includes the user's 
> identity and their public key.

There are two ways to create a Virgil Card. 

The first way is to create the Virgil Card in application scope. The cards created this way will only be available to your application (i.e. will only be returned in response to a request presenting your application's *token*). 

The second way is to create the Virgil Card in global scope. The cards created in global scope will be available within all Virgil Services and to find them you doin't need an application *token*.

Every user is represented with a **Virgil Card** so creating them for users is a required step. A **Virgil Card** is the central entity of the Virgil Services, it includes information about the user for further actions in Virgil Security system. The **Virgil Card** identifies the user/device by one of his types. You can find more information about :term:`Virgil Cards <Virgil Card>`.

Registering Virgil Card
--------------------------

Generate user's Key and create a Virgil Card

.. code-block:: ruby
    :linenos:

    // initialize Virgil SDK
    virgil = VirgilApi.new(access_token: "[YOUR_ACCESS_TOKEN_HERE]")

    // generate and save alice's Key
    alice_key = virgil.keys.generate.save("[KEY_NAME]", "[KEY_PASSWORD]")
    // create alice's Card using her Key
    alice_card = virgil.cards.create("alice", alice_key)

    //You can create alice's Card with information about her device and some another data. 
    alice_card = virgil.cards.create("alice", alice_key, {device: "iPhone", device_name: "Space grey one", data: {some_key1: "some value 1", some_key2: "some value 2"}})
    

Transmit alice's Card to the server side where it would be signed, validated and published on the Virgil Services. 

.. code-block:: ruby

    // export alice's Card to string
    exported_alice_card = alice_card.export
    
Publish a Virgil Card on Server-Side

.. code-block:: ruby
    :linenos:

    // initialize Virgil SDK high-level instance.
    virgil = VirgilApi.new(context: VirgilContext.new(
    access_token: "[YOUR_ACCESS_TOKEN_HERE]",
    credentials: VirgilAppCredentials.new(app_id: "[YOUR_APP_ID_HERE]",
                                          app_key_data: VirgilBuffer.from_file("[YOUR_APP_KEY_PATH_HERE]"),
                                          app_key_password: "[YOUR_APP_KEY_PASSWORD_HERE]"))
    )   


    // import Alice's Card from its string representation.
    alice_card = virgil.cards.import(exported_alice_card)

    // verify Alice's Card information before publishing it on the Virgil services.

    // alice_card.identity
    // alice_card.identity_type
    // alice_card.data
    // alice_card.info

    // publish alice's Card on Virgil Services
    virgil.cards.publish(alice_card)
    // alice_card.publish

Revoking Virgil Card
--------------------------

.. code-block:: ruby
    :linenos:

    // initialize Virgil SDK high-level instance.
    virgil = VirgilApi.new(context: VirgilContext.new(
    access_token: "[YOUR_ACCESS_TOKEN_HERE]",
    credentials: VirgilAppCredentials.new(app_id: "[YOUR_APP_ID_HERE]",
                                          app_key_data: VirgilBuffer.from_file("[YOUR_APP_KEY_PATH_HERE]"),
                                          app_key_password: "[YOUR_APP_KEY_PASSWORD_HERE]"))
    )   


    // get Alice's Card by ID
    alice_card = virgil.cards.get("[ALICE_CARD_ID]")

    // revoke Alice's Card from Virgil Services.
    virgil.cards.revoke(alice_card)

Registering Global Virgil Card
--------------------------

.. code-block:: ruby
    :linenos:

    // initialize Virgil's high-level instance.
    virgil = VirgilApi.new(access_token: "[YOUR_ACCESS_TOKEN_HERE]")

    // generate and save Alice's Key.
    alice_key = virgil.keys.generate.save("[KEY_NAME]", "[KEY_PASSWORD]")

    // create Alice's Card using her newly generated Key.
    alice_card = virgil.cards.create_global(
        identity: "alice@virgilsecurity.com",
        identity_type: VirgilIdentity::EMAIL,
        owner_key: alice_key
    )

    // initiate an identity verification process.
    attempt = alice_card.check_identity

    // confirm a Card's identity using confirmation code retrived on the email.
    token = attempt.confirm(VirgilIdentity::EmailConfirmation.new("[CONFIRMATION_CODE]"))

    // publish a Card on the Virgil Security services.
    virgil.cards.publish_global(alice_card, token)
    // alice_card.publish_as_global(token) 

Revoking Global Virgil Cards
----------------------------

.. code-block:: ruby
    :linenos:

    // initialize Virgil SDK high-level
    virgil = VirgilApi.new(access_token: "[YOUR_ACCESS_TOKEN_HERE]")

    // load Alice's Key from secure storage provided by default.
    alice_key = virgil.keys.load("[KEY_NAME]", "[KEY_PASSWORD]")

    // load Alice's Card from Virgil Security services.
    alice_card = virgil.cards.get("[ALICE_CARD_ID]")

    // initiate Card's identity verification process.
    attempt = alice_card.check_identity()

    // confirm Card's identity using confirmation code and grub validation token.
    token = attempt.confirm(VirgilIdentity::EmailConfirmation.new("[CONFIRMATION_CODE]"))

    // revoke Virgil Card from Virgil Security services.
    virgil.cards.revoke_global(alice_card, alice_key, token); 

Export & Import Virgil Cards
-------------------------------
.. code-block:: ruby
    :linenos:

    virgil = VirgilApi.new(access_token: "[YOUR_ACCESS_TOKEN_HERE]")

    alice_key = virgil.keys.generate
    alice_card = virgil.cards.create("alice", alice_key)

    // export a Virgil Card to its string representation.
    exported_card = alice_card.export

    // import a Virgil Card to from its string representation
    imported_card = virgil.cards.import(exported_card)


Search for Virgil Cards
-------------------------------
.. code-block:: ruby
    :linenos:

    virgil = VirgilApi.new(access_token: "[YOUR_ACCESS_TOKEN_HERE]")

    // search for all Alice's Cards.
    alice_cards = virgil.cards.find("alice")

    // search for all Bob's Cards with type 'member'
    bob_cards = virgil.cards.find("bob")

    // search for all Bob's global Cards with identity type 'email'
    bo_global_cards = virgil.cards.find_global(VirgilIdentity::EMAIL, "bob@virgilsecurity.com")


Encryption
-------------------------------
Initialize Virgil High Level API and generate the Virgil Key.

.. code-block:: ruby

    virgil = VirgilApi.new(access_token: "[YOUR_ACCESS_TOKEN_HERE]")

Encrypting Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: ruby
    :linenos:

    // search for Alice's and bob's Cards
    recipients = virgil.cards.find("bob", "alice")

    message = "Hey, are you crazy?"

    // encrypt the message for multiple recipients
    ciphertext = recipients.encrypt(message).to_base64
    
Decrypting Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: ruby
    :linenos:

    // load Bob's Key from secure storage provided by default.
    bob_key = virgil.keys.load("[KEY_NAME]", "[KEY_PASSWORD]")

    // decrypt message using Bob's Key.
    original_message = bob_key.decrypt(ciphertext).to_s

Encrypting & Signing Data
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: ruby
    :linenos:

    // load Alice's Key from secure storage defined by default
    alice_key = virgil.keys.load("[KEY_NAME]", "[KEY_PASSWORD]")

    // search for Bob's Cards
    bob_cards = await virgil.cards.find("bob")

    message = "Hey Bob, are you crazy?"

    // encrypt and sign message for multiple recipients
    ciphertext = alice_key.sign_then_encrypt(message, bob_cards).to_base64

Decrypting & Verifying Data
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: ruby
    :linenos:

    // load Bob's Key from secure storage defined by default
    bob_key = virgil.keys.load("[KEY_NAME]", "[KEY_PASSWORD]")

    // search for Alice's Card
    alice_cards = virgil.cards.find("alice")
    alice_card = alice_cards.find{|v| v.device == "iPhone 7"}
    

    // decrypt cipher message using Bob's Key and verify it using alice's Card
    original_message = bob_key.decrypt_then_verify(ciphertext, alice_card).to_s

Generating and Verifying Signatures
-----------------------------------
This section walks you through the steps necessary to use the VirgilCrypto to generate a digital signature for data and to verify that a signature is authentic.

.. code-block:: ruby

    // initialize Virgil SDK high-level API instance
    virgil = VirgilApi.new(access_token: "[YOUR_ACCESS_TOKEN_HERE]")

Generating a Signature
~~~~~~~~~~~~~~~~~~~~~~~~~~
To generate the signature, simply call one of the sign methods:

.. code-block:: ruby
    :linenos:

    // load Alice's Key from protected storage
    alice_key = virgil.keys.load("[KEY_NAME]", "[KEY_PASSWORD]")

    message = "Hey Bob, hope you are doing well."

    // generate signature of message using alice's key pair
    signature = alice_key.sign(message)

Verifying a Signature
~~~~~~~~~~~~~~~~~~~~~~~~~~
The signature can now be verified by calling the verify method:

.. code-block:: ruby
    :linenos:

    // search for Alice's Card
    alice_cards = virgil.cards.find("alice")
    alice_card = alice_cards.find{|v| v.device == "iPhone 7"}

    unless alice_key.verify(message, signature)
    
        raise "Damn Alice it's not you.a" 
    end
