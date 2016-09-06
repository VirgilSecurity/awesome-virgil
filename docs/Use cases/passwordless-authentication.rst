######
Passwordless authentication
######

A developer needs to implement passwordless registration and authentication into a system.

.. image:: docs/Images/PasswordlessAuth.png

- An app receives permission to authorize users with Virgil account.
- A public key is generated for new users in Keys service to further access the system without a password.
- The app requests authorization from Virgil Security when users logs into the system without a password.
- Virgil verifies whether the app is trusted and receives user’s private key for further access to the system.
- Virgil authenticates the user and returns authorization code to the app.
- The app receives a token to grant unique data transmission.
- The app retrieves required accessible user data to fill in his profile in the system.
