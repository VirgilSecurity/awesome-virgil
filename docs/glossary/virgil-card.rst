====================================
Virgil Entities - Virgil Card
====================================

.. glossary::

	**Virgil Card**

		A Virgil Card is the main entity of the Public Keys Service, it includes the information about the user and his public key. The Virgil Card identifies the user by one of his available types, such as an email, a phone number, etc. The Virgil Card might be global and private. The difference is whether Virgil Services take part in the Identity verification.

		Card ID	- A unique identifier of any Virgil Card. It is used for every operation with Virgil Cards.

		Virgil Card representation

::

    public_key    = "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFW
    cjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPS
    m9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIE
    tFWS0tLS0t";

    identity_type = "email";

    identity      = "user@virgilsecurity.com";

    scope         = "global";

    data          = {
        "custom_key_1": "custom_value_1",
        "custom_key_2": "custom_value_2"
    };

    info = {
        "device": "iPhone6s",
        "device_name": "Space grey one"
    };

+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| Data Parameter     | Requirement                                                                                                                                 |
+====================+=============================================================================================================================================+
| ``public_key``     | (required) Must contain a base64-encoded public key value in DER or PEM format                                                              |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``identity_type``  | (required) Must be ``email`` for a :term:`confirmed <Confirmed Card>` **Virgil Card** and can be any value for a :term:`segregated <Unconfirmed Card>` one                              |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``identity``       | (required) Must be a valid email for a confirmed **Virgil Card** with an identity type of *email* and can be any value for a segregated one |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``scope``          | (required) Determines a **Virgil Card** scope that can be either :term:`global <Global Virgil Card>` or :term:`application <Application Virgil Card>`                    |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``data``           | (optional) An associative array that contains application specific parameters. All keys must contain only latic characters and digits. The  |
|                    | length of keys and values must not exceed 256 characters. Please note that you cannot persist more than 16 data items                       |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``info``           | (optional) An associative array with predefined keys that contain information about the device on which the keypair was created. The keys   |
|                    | are always *device\_name* and *device* and the values must not exceed 256 characters. Both keys are optional but at least one of them must  |
|                    | be specified if ``info`` parameter is specified                                                                                             |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``signs``          | (required) Must always contain **Virgil Card** holder's sign and either application sign or **Virgil Identity** sign (or both).             |
|                    | More about `signs`_                                                                                                                         |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+	    