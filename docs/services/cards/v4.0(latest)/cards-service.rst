=============================
Virgil Cards service API v4.0
=============================

Topics
======

-  `Overview <#overview>`__
-  `Endpoints <#endpoints>`__

    -  `POST /card <#post-card>`__
    -  `GET /card/{card-id} <#get-cardcard-id>`__
    -  `POST /card/actions/search <#post-cardactionssearch>`__
    -  `DELETE /card/{card-id} <#delete-cardcard-id>`__
-  `Appendix A. Response codes <#appendix-a-response-codes>`__
-  `Appendix B. Authorization header <#appendix-b-authorization-header>`__

Overview
========

**Virgil Cards service** allows you to perform all the operations with public keys to provide a secure system.

Every user is represented with a **Virgil Card** which contains all necessary information to identify him
and to obtain his **Public Key** for further operations.  

``fingerprint`` 
---------------

is an identifier of a **Virgil Card**. Virgil Card's JSON representation is used to calculate the ``fingerprint``:

::

    vigrilCardFingerprint = SHA256( virgilCardJsonData )


Endpoints
=========

POST /card
----------

This endpoint creates a **Virgil Card**. You can create a **Virgil Card** by passing the Card's ``content_snapshot`` and ``signs`` to **Virgil Cards service**.

``content_snapshot`` 
---------------------

is a base64-encoded string with JSON representation of data required for an operation.

::

    content_snapshot = BASE64_ENCODE( virgilCardJsonData )
    content_snapshot = BASE64_ENCODE( cardID, revocation_reason)

.. note:: Example

    *Original Virgil Card's representation*

    ::

        public_key    = "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPSm9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t";
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

    *Virgil Card's JSON representation* 

    This byte representation will be persisted and is not supposed to be changed within the **Virgil Card's** lifetime.

    ::

        virgilCardJsonData = {"public_key":"LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPSm9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t","identity_type":"email","identity":"user@virgilsecurity.com","scope":"global","data":{"custom_key_1":"custom_value_1","custom_key_2":"custom_value_2"},"info":{"device":"iPhone6s","device_name":"Space grey one"}}

    *content_snapshot*

    ::

        eyJwdWJsaWNfa2V5IjoiTFMwdExTMUNSVWRKVGlCUVZVSk1TVU1nUzBWWkxTMHRMUzBLVFVsSFlrMUNVVWRDZVhGSFUwMDBPVUZuUlVkRFUzTnJRWGROUTBOQlJVSkVVVTlDWjJkQlJVTmhWM2s1VlZWVk1ERldjamRRTHpFeFdIcHViazB2UkFvd1RpOUtPRGhuWTBkTVYzcFlNR0ZMYUdjeFNqZGliM0I2UkdWNGIwUXdhVmwzYWxGWFZVcFdjVnBKUWpSTGRGVm5lRzlJY1M4MWMybHliVUkyY1cxT0NsTkZPRE54Y1RabWJpdFBTbTlxZVVwR015dEtZMUF3VFVwMVdYUlZabnBIYmpndlVIbEhWa3AxVEVWSGFpczBOVGxLV1RSV2J6ZEtiMXBuUzJoQlQyNEtjV0ozVWpSbGNUWTBjaXRsVUVwTmNVcHBNRDBLTFMwdExTMUZUa1FnVUZWQ1RFbERJRXRGV1MwdExTMHQiLCJpZGVudGl0eSI6InVzZXJAdmlyZ2lsc2VjdXJpdHkuY29tIiwiaWRlbnRpdHlfdHlwZSI6ImVtYWlsIiwic2NvcGUiOiJnbG9iYWwiLCJpbmZvIjp7ImRldmljZSI6ImlQaG9uZSIsImRldmljZV9uYW1lIjoiU3BhY2UgZ3JleSBvbmUifX0=

``signs``
---------

is mandatory to authorize a **Virgil Card** creation by the Virgil Card holder himself and by the application. It is nested into the ``meta`` request parameter, an associative array with signer's ``fingerprint`` as keys and base64-encoded signs as values. The **signed\_digest** is calculated as

::

    BASE64_ENCODE(SIGN(FINGERPRINT, PRIVATE_KEY)) 

Private key must belong to the Virgil Card holder, application or **Virgil Identity** service.

Structure of ``signs`` parameter:

::

    "meta": {      
        "signs": {          
            CARD_HOLDER_FINGERPRINT: VIRGIL_CARD_BASE64_ENCODED_SIGN_OF_THE_FINGERPRINT,          
            APPLICATION_FINGERPRINT: VIRGIL_CARD_BASE64_ENCODED_SIGN_OF_THE_FINGERPRINT, 
            ...     
        }  
    }

+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| Data Parameter     | Requirement                                                                                                                                 |
+====================+=============================================================================================================================================+
| ``public_key``     | (required) Must contain a base64-encoded public key value in DER or PEM format                                                              |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``identity_type``  | (required) Must be 'email' for a confirmed [#]_ **Virgil Card** and can be any value for a segregated [#]_ one                              |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``identity``       | (required) Must be a valid email for a confirmed **Virgil Card** with an identity type of *email* and can be any value for a segregated one |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``scope``          | (required) Determines a **Virgil Card** scope that can be either **global** [#]_ or **application** [#]_                                    |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``data``           | (optional) An associative array that contains application specific parameters. All keys must contain only latic characters and digits. The length of keys and values must not exceed 256 characters. Please note that you cannot persist more than 16 data items                                                        |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``info``           | (optional) An associative array with predefined keys that contain information about the device on which the keypair was created. The keys are always *device\_name* and *device* and the values must not exceed 256 characters. Both keys are optional but at least one of them must be specified if ``info`` parameter is specified 
                                                                                                                                                                   |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``signs``          | (required) Must always contain **Virgil Card** holder's sign and either application sign or **Virgil Identity** sign (or both). More about `signs`_ 
                                                                                                                                                                   |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+

.. [#] In order to create a confirmed **Virgil Card** it's necessary to delegate the card creation to the **Virgil Identity** service.
.. [#] In order to create an unconfirmed segregated **Virgil Card** it is enough to set *scope* request parameter to *application* and pass valid application sign item in signs list. 
.. [#] Global **Virgil Cards** are available in all the applications.
.. [#] Application **Virgil Cards** are accessible only within the application they were created within. 

**Request info**

::

    HTTP Request method    POST
    Request URL            https://cards.virgilecurity.com/v4/card
    Authorization          Required

**Request body**

.. code:: json

    {
        "content_snapshot":"eyJwdWJsaWNfa2V5IjoiTFMwdExTMUNSVWRKVGlCUVZVSk1TVU1nUzBWWkxTMHRMUzBLVFVsSFlrMUNVVWRDZVhGSFUwMDBPVUZuUlVkRFUzTnJRWGROUTBOQlJVSkVVVTlDWjJkQlJVTmhWM2s1VlZWVk1ERldjamRRTHpFeFdIcHViazB2UkFvd1RpOUtPRGhuWTBkTVYzcFlNR0ZMYUdjeFNqZGliM0I2UkdWNGIwUXdhVmwzYWxGWFZVcFdjVnBKUWpSTGRGVm5lRzlJY1M4MWMybHliVUkyY1cxT0NsTkZPRE54Y1RabWJpdFBTbTlxZVVwR015dEtZMUF3VFVwMVdYUlZabnBIYmpndlVIbEhWa3AxVEVWSGFpczBOVGxLV1RSV2J6ZEtiMXBuUzJoQlQyNEtjV0ozVWpSbGNUWTBjaXRsVUVwTmNVcHBNRDBLTFMwdExTMUZUa1FnVUZWQ1RFbERJRXRGV1MwdExTMHQiLCJpZGVudGl0eSI6InVzZXJAdmlyZ2lsc2VjdXJpdHkuY29tIiwiaWRlbnRpdHlfdHlwZSI6ImVtYWlsIiwic2NvcGUiOiJnbG9iYWwiLCJpbmZvIjp7ImRldmljZSI6ImlQaG9uZSIsImRldmljZV9uYW1lIjoiU3BhY2UgZ3JleSBvbmUifX0=",
        "meta": {
            "signs": {
                "af6799a2f26376731abb9abf32b5f2ac0933013f42628498adb6b12702df1a87":"MIGaMA0GCWCGSAFlAwQCAgUABIGIMIGFAkAUkHTx9vEXcUAq9O5bRsfJ0K5s8Bwm55gEXfzbdtAfr6ihJOXA9MAdXOEocqKtH6DuU7zJAdWgqfTrweih7jAkEAgN7CeUXwZwS0lRslWulaIGvpK65czWphRwyuwN++hI6dlHOdPABmhMSqimwoRsLN8xsivhPqQdLow5rDFic7A==",
                "767b6b12702df1a873f42628498f32b5f31abb9ab12ac09af6799a2f263330ad":"MIGaMA0GCWCGSAFlAwQCAgUABIGIMIGFAkBg9WJPxgq1ObqxPpXdomNIDxlOvyGdI9wrgZYXu+YAibJd+8Vf0uFce9QrB7yiG2U2zTNVqwsg4f7bd1SKVleAkEAplvCmFJ6v3sYQVBXerr8Yb25UllbTDuCw5alWSfBw2j3ueFiXTiyY885y0detX08YFEWYgbAoKtJgModQTEcQ=="
            }
        }
    }

**Response body**

.. code:: json

    {
        "content_snapshot":"eyJwdWJsaWNfa2V5IjoiTFMwdExTMUNSVWRKVGlCUVZVSk1TVU1nUzBWWkxTMHRMUzBLVFVsSFlrMUNVVWRDZVhGSFUwMDBPVUZuUlVkRFUzTnJRWGROUTBOQlJVSkVVVTlDWjJkQlJVTmhWM2s1VlZWVk1ERldjamRRTHpFeFdIcHViazB2UkFvd1RpOUtPRGhuWTBkTVYzcFlNR0ZMYUdjeFNqZGliM0I2UkdWNGIwUXdhVmwzYWxGWFZVcFdjVnBKUWpSTGRGVm5lRzlJY1M4MWMybHliVUkyY1cxT0NsTkZPRE54Y1RabWJpdFBTbTlxZVVwR015dEtZMUF3VFVwMVdYUlZabnBIYmpndlVIbEhWa3AxVEVWSGFpczBOVGxLV1RSV2J6ZEtiMXBuUzJoQlQyNEtjV0ozVWpSbGNUWTBjaXRsVUVwTmNVcHBNRDBLTFMwdExTMUZUa1FnVUZWQ1RFbERJRXRGV1MwdExTMHQiLCJpZGVudGl0eSI6InVzZXJAdmlyZ2lsc2VjdXJpdHkuY29tIiwiaWRlbnRpdHlfdHlwZSI6ImVtYWlsIiwic2NvcGUiOiJnbG9iYWwiLCJpbmZvIjp7ImRldmljZSI6ImlQaG9uZSIsImRldmljZV9uYW1lIjoiU3BhY2UgZ3JleSBvbmUifX0=",
        "meta": {
            "fingerprint": "bb5db5084dab511135ec24c2fdc5ce2bca8f7bf6b0b83a7fa4c3cbdcdc740a59",
            "created_at": "2015-12-22T07:03:42+0000",
            "card_version": "4.0",
            "signs": {
                "af6799a2f26376731abb9abf32b5f2ac0933013f42628498adb6b12702df1a87":"MIGaMA0GCWCGSAFlAwQCAgUABIGIMIGFAkAUkHTx9vEXcUAq9O5bRsfJ0K5s8Bwm55gEXfzbdtAfr6ihJOXA9MAdXOEocqKtH6DuU7zJAdWgqfTrweih7jAkEAgN7CeUXwZwS0lRslWulaIGvpK65czWphRwyuwN++hI6dlHOdPABmhMSqimwoRsLN8xsivhPqQdLow5rDFic7A==",
                "767b6b12702df1a873f42628498f32b5f31abb9ab12ac09af6799a2f263330ad":"MIGaMA0GCWCGSAFlAwQCAgUABIGIMIGFAkBg9WJPxgq1ObqxPpXdomNIDxlOvyGdI9wrgZYXu+YAibJd+8Vf0uFce9QrB7yiG2U2zTNVqwsg4f7bd1SKVleAkEAplvCmFJ6v3sYQVBXerr8Yb25UllbTDuCw5alWSfBw2j3ueFiXTiyY885y0detX08YFEWYgbAoKtJgModQTEcQ==",
                "ab799a2f26333c09af6628496b12702df1a80ad767b73f42b9ab12a8f32b5f31":"MIGaMA0GCWCGSAFlAwQCAgUABf7bd1SKVleAkEAplvCmFJ6v3sYQVBXerr8Yb25UllbTDuCw5alWSfBw2j3ueFiXTiyY88bAoKtJgModQTEc9WJPxgq1Obqx5y0dIGIMIGFAkBgwrgZYXu+YAibJd+8Vf0uFce9QrB7yiG2U2zTNVqwsg4etX08YFEWYgPpXdomNIDxlOvyGdI9Q=="
            }
        }
    }

.. note::

    The request to create a **Virgil Card** contained two signs items: for the application holder and for the application. After passing **Virgil Cards service** the signs list was filled with a sign of the service.

    So all **Virgil Card** data is passed in ``content_snapshot`` parameter and **Virgil Cards service** creates an additional sign item with its own fingerprint used as a key to prove that it really created this **Virgil Card**.

GET /card/{card-id}
-------------------

This endpoint returns the information about the **Virgil Card** by its ID (which is the `fingerprint`_).

**Request info**

::

    HTTP Request method    GET
    Request URL            https://cards-ro.virgilecurity.com/v4/card/{card-id}

**Response body**

.. code:: json

    {
        "content_snapshot":"eyJwdWJsaWNfa2V5IjoiTFMwdExTMUNSVWRKVGlCUVZVSk1TVU1nUzBWWkxTMHRMUzBLVFVsSFlrMUNVVWRDZVhGSFUwMDBPVUZuUlVkRFUzTnJRWGROUTBOQlJVSkVVVTlDWjJkQlJVTmhWM2s1VlZWVk1ERldjamRRTHpFeFdIcHViazB2UkFvd1RpOUtPRGhuWTBkTVYzcFlNR0ZMYUdjeFNqZGliM0I2UkdWNGIwUXdhVmwzYWxGWFZVcFdjVnBKUWpSTGRGVm5lRzlJY1M4MWMybHliVUkyY1cxT0NsTkZPRE54Y1RabWJpdFBTbTlxZVVwR015dEtZMUF3VFVwMVdYUlZabnBIYmpndlVIbEhWa3AxVEVWSGFpczBOVGxLV1RSV2J6ZEtiMXBuUzJoQlQyNEtjV0ozVWpSbGNUWTBjaXRsVUVwTmNVcHBNRDBLTFMwdExTMUZUa1FnVUZWQ1RFbERJRXRGV1MwdExTMHQiLCJpZGVudGl0eSI6InVzZXJAdmlyZ2lsc2VjdXJpdHkuY29tIiwiaWRlbnRpdHlfdHlwZSI6ImVtYWlsIiwic2NvcGUiOiJnbG9iYWwiLCJpbmZvIjp7ImRldmljZSI6ImlQaG9uZSIsImRldmljZV9uYW1lIjoiU3BhY2UgZ3JleSBvbmUifX0=",
        "meta": {
            "fingerprint": "bb5db5084dab511135ec24c2fdc5ce2bca8f7bf6b0b83a7fa4c3cbdcdc740a59",
            "created_at": "2015-12-22T07:03:42+0000",
            "card_version": "4.0",
            "signs": {
                "af6799a2f26376731abb9abf32b5f2ac0933013f42628498adb6b12702df1a87":"MIGaMA0GCWCGSAFlAwQCAgUABIGIMIGFAkAUkHTx9vEXcUAq9O5bRsfJ0K5s8Bwm55gEXfzbdtAfr6ihJOXA9MAdXOEocqKtH6DuU7zJAdWgqfTrweih7jAkEAgN7CeUXwZwS0lRslWulaIGvpK65czWphRwyuwN++hI6dlHOdPABmhMSqimwoRsLN8xsivhPqQdLow5rDFic7A==",
                "767b6b12702df1a873f42628498f32b5f31abb9ab12ac09af6799a2f263330ad":"MIGaMA0GCWCGSAFlAwQCAgUABIGIMIGFAkBg9WJPxgq1ObqxPpXdomNIDxlOvyGdI9wrgZYXu+YAibJd+8Vf0uFce9QrB7yiG2U2zTNVqwsg4f7bd1SKVleAkEAplvCmFJ6v3sYQVBXerr8Yb25UllbTDuCw5alWSfBw2j3ueFiXTiyY885y0detX08YFEWYgbAoKtJgModQTEcQ==",
                "ab799a2f26333c09af6628496b12702df1a80ad767b73f42b9ab12a8f32b5f31":"MIGaMA0GCWCGSAFlAwQCAgUABf7bd1SKVleAkEAplvCmFJ6v3sYQVBXerr8Yb25UllbTDuCw5alWSfBw2j3ueFiXTiyY88bAoKtJgModQTEc9WJPxgq1Obqx5y0dIGIMIGFAkBgwrgZYXu+YAibJd+8Vf0uFce9QrB7yiG2U2zTNVqwsg4etX08YFEWYgPpXdomNIDxlOvyGdI9Q=="
            }
        }
    }

POST /card/actions/search
-------------------------

This endpoint performs the **Virgil Cards** search by set criteria.

+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| Data Parameter     | Requirement                                                                                                                                 |
+====================+=============================================================================================================================================+
| ``identities``     | (required) Value to search for                                                                                                              |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``identity_type``  | (optional) Specifies the ``identity_type`` of a **Virgil Card** to be found                                                                 |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``scope``          | (optional) Specifies the scope to perform search on. Either 'global' or 'application'. The default value is 'application'                   |
+--------------------+---------------------------------------------------------------------------------------------------------------------------------------------+

**Request info**

::

    HTTP Request method    POST
    Request URL            https://cards-ro.virgilecurity.com/v4/card/actions/search

**Request body**

::

    {
        "identities": ["user@virgilsecurity.com", "another.user@virgilsecurity.com"],
        ["identity_type"]: "email",
        ["scope"]: "global"
    }

**Response body**

.. code:: json

    [
        {
            "content_snapshot":"eyJwdWJsaWNfa2V5IjoiTFMwdExTMUNSVWRKVGlCUVZVSk1TVU1nUzBWWkxTMHRMUzBLVFVsSFlrMUNVVWRDZVhGSFUwMDBPVUZuUlVkRFUzTnJRWGROUTBOQlJVSkVVVTlDWjJkQlJVTmhWM2s1VlZWVk1ERldjamRRTHpFeFdIcHViazB2UkFvd1RpOUtPRGhuWTBkTVYzcFlNR0ZMYUdjeFNqZGliM0I2UkdWNGIwUXdhVmwzYWxGWFZVcFdjVnBKUWpSTGRGVm5lRzlJY1M4MWMybHliVUkyY1cxT0NsTkZPRE54Y1RabWJpdFBTbTlxZVVwR015dEtZMUF3VFVwMVdYUlZabnBIYmpndlVIbEhWa3AxVEVWSGFpczBOVGxLV1RSV2J6ZEtiMXBuUzJoQlQyNEtjV0ozVWpSbGNUWTBjaXRsVUVwTmNVcHBNRDBLTFMwdExTMUZUa1FnVUZWQ1RFbERJRXRGV1MwdExTMHQiLCJpZGVudGl0eSI6InVzZXJAdmlyZ2lsc2VjdXJpdHkuY29tIiwiaWRlbnRpdHlfdHlwZSI6ImVtYWlsIiwic2NvcGUiOiJnbG9iYWwiLCJpbmZvIjp7ImRldmljZSI6ImlQaG9uZSIsImRldmljZV9uYW1lIjoiU3BhY2UgZ3JleSBvbmUifX0=",
            "meta": {
                "fingerprint": "bb5db5084dab511135ec24c2fdc5ce2bca8f7bf6b0b83a7fa4c3cbdcdc740a59",
                "created_at": "2015-12-22T07:03:42+0000",
                "card_version": "4.0",
                "signs": {
                    "af6799a2f26376731abb9abf32b5f2ac0933013f42628498adb6b12702df1a87":"MIGaMA0GCWCGSAFlAwQCAgUABIGIMIGFAkAUkHTx9vEXcUAq9O5bRsfJ0K5s8Bwm55gEXfzbdtAfr6ihJOXA9MAdXOEocqKtH6DuU7zJAdWgqfTrweih7jAkEAgN7CeUXwZwS0lRslWulaIGvpK65czWphRwyuwN++hI6dlHOdPABmhMSqimwoRsLN8xsivhPqQdLow5rDFic7A==",
                    "767b6b12702df1a873f42628498f32b5f31abb9ab12ac09af6799a2f263330ad":"MIGaMA0GCWCGSAFlAwQCAgUABIGIMIGFAkBg9WJPxgq1ObqxPpXdomNIDxlOvyGdI9wrgZYXu+YAibJd+8Vf0uFce9QrB7yiG2U2zTNVqwsg4f7bd1SKVleAkEAplvCmFJ6v3sYQVBXerr8Yb25UllbTDuCw5alWSfBw2j3ueFiXTiyY885y0detX08YFEWYgbAoKtJgModQTEcQ==",
                    "ab799a2f26333c09af6628496b12702df1a80ad767b73f42b9ab12a8f32b5f31":"MIGaMA0GCWCGSAFlAwQCAgUABf7bd1SKVleAkEAplvCmFJ6v3sYQVBXerr8Yb25UllbTDuCw5alWSfBw2j3ueFiXTiyY88bAoKtJgModQTEc9WJPxgq1Obqx5y0dIGIMIGFAkBgwrgZYXu+YAibJd+8Vf0uFce9QrB7yiG2U2zTNVqwsg4etX08YFEWYgPpXdomNIDxlOvyGdI9Q=="
                }
            }
        }
    ]

DELETE /card/{card-id}
----------------------

This endpoint revokes a **Virgil Card**.

+------------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| Data Parameter         | Requirement                                                                                                                                 |
+========================+=============================================================================================================================================+
| ``id``                 | (required) `fingerprint`_ of the card to be removed                                                                                         |
+------------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``revocation_reason``  | (required) The code from the list:                                                                                                          |
|                        |      - unspecified                                                                                                                          |
|                        |      - compromised                                                                                                                          |  
+------------------------+---------------------------------------------------------------------------------------------------------------------------------------------+
| ``meta.signs``         | (required) Must contain an entry with the application sign. More about `signs`_                                                             |
+------------------------+---------------------------------------------------------------------------------------------------------------------------------------------+

**Request info**

::

    HTTP Request method    DELETE
    Request URL            https://cards.virgilecurity.com/v4/card/{card-id}
    Authorization          Required

**Request body**

.. code:: json

    {
        "content_snapshot":"eyJwdWJsaWNfa2V5IjoiTFMwdExTMUNSVWRKVGlCUVZVSk1TVU1nUzBWWkxTMHRMUzBLVFVsSFlrMUNVVWRDZVhGSFUwMDBPVUZuUlVkRFUzTnJRWGROUTBOQlJVSkVVVTlDWjJkQlJVTmhWM2s1VlZWVk1ERldjamRRTHpFeFdIcHViazB2UkFvd1RpOUtPRGhuWTBkTVYzcFlNR0ZMYUdjeFNqZGliM0I2UkdWNGIwUXdhVmwzYWxGWFZVcFdjVnBKUWpSTGRGVm5lRzlJY1M4MWMybHliVUkyY1cxT0NsTkZPRE54Y1RabWJpdFBTbTlxZVVwR015dEtZMUF3VFVwMVdYUlZabnBIYmpndlVIbEhWa3AxVEVWSGFpczBOVGxLV1RSV2J6ZEtiMXBuUzJoQlQyNEtjV0ozVWpSbGNUWTBjaXRsVUVwTmNVcHBNRDBLTFMwdExTMUZUa1FnVUZWQ1RFbERJRXRGV1MwdExTMHQiLCJpZGVudGl0eSI6InVzZXJAdmlyZ2lsc2VjdXJpdHkuY29tIiwiaWRlbnRpdHlfdHlwZSI6ImVtYWlsIiwic2NvcGUiOiJnbG9iYWwiLCJpbmZvIjp7ImRldmljZSI6ImlQaG9uZSIsImRldmljZV9uYW1lIjoiU3BhY2UgZ3JleSBvbmUifX0=",
        "meta": {
            "signs": {
                "af6799a2f26376731abb9abf32b5f2ac0933013f42628498adb6b12702df1a87":"MIGaMA0GCWCGSAFlAwQCAgUABIGIMIGFAkAUkHTx9vEXcUAq9O5bRsfJ0K5s8Bwm55gEXfzbdtAfr6ihJOXA9MAdXOEocqKtH6DuU7zJAdWgqfTrweih7jAkEAgN7CeUXwZwS0lRslWulaIGvpK65czWphRwyuwN++hI6dlHOdPABmhMSqimwoRsLN8xsivhPqQdLow5rDFic7A=="
            }
        }
    }

The ``content_snapshot`` parameter is a JSON representation that contains these parameters:

::

    {
        "id": "af6799a2f26376731abb9abf32b5f2ac0933013f42628498adb6b12702df1a87",
        "revocation_reason": "unspecified"
    }

**Response body**

.. code:: json

    {

    }

Appendix A. Response codes
==========================

HTTP error codes
----------------

Application uses standard HTTP response codes:

::

    200 - Success
    400 - Request error
    401 - Authentication error
    403 - Forbidden
    404 - Entity not found
    405 - Method not allowed
    500 - Server error

Additional information about the error is returned as JSON-object like:

::

    {
        "code": "{error-code}"
    }

HTTP 500. Server error
----------------------

This status is returned in extremely rare cases of internal application errors

::

    10000 - Internal application error. You know, shit happens, so do internal server errors. Just take a deep breath and try harder.

HTTP 401. Auth error
--------------------

This status is returned on authorization errors

::

    20300 - The Virgil access token or token header was not specified or is invalid
    20301 - The Virgil authenticator service responded with an error
    20302 - The Virgil access token validation has failed on the Virgil Authenticator service
    20303 - The application was not found for the access token
    20400 - Request sign is invalid or missing
    20401 - Request sign header is missing

HTTP 403. Forbidden
-------------------

This status is returned when a request is not granted permission to the resource

::

    20500 - The Virgil Card is not available in this application

HTTP 400. Request error
-----------------------

This status is returned on request data errors

::

    30000 - JSON specified as a request is invalid
    30010 - A data inconsistency error
    30100 - Global Virgil Card identity type is invalid because it can be only an 'email'
    30101 - Virgil Card scope must be either 'global' or 'application'
    30102 - Virgil Card id validation failed
    30103 - Virgil Card data parameter cannot contain more than 16 entries
    30104 - Virgil Card info parameter cannot be empty if specified and must contain 'device' and/or 'device_name' key
    30105 - Virgil Card info parameters length validation failed. The length cannot exceed 256 characters
    30106 - Virgil Card data parameter must be an associative array https://en.wikipedia.org/wiki/Associative_array
    30107 - A CSR parameter (content_snapshot) is missing or is incorrect
    30111 - Virgil Card identities passed to search endpoint must be a list of non-empty strings
    30113 - Virgil Card identity type is invalid
    30114 - Segregated Virgil Card custom identity value must be a not empty string
    30115 - Virgil Card identity email is invalid
    30116 - Virgil Card identity application is invalid
    30117 - Public key length is invalid. It goes from 16 to 2048 bytes
    30118 - Public key must be a base64-encoded string
    30119 - Virgil Card data parameter must be a key/value list of strings
    30120 - Virgil Card data parameters must be strings
    30121 - Virgil Card custom data entry value length validation failed. It mustn_'t exceed 256 characters
    30122 - Identity validation token is invalid
    30123 - SCR signs list parameter is missing or is invalid
    30126 - SCR sign item signer card id is irrelevant and doesn_'t match Virgil Card id or Application Id
    30127 - SCR sign item signed digest is invalid for the Virgil Card public key
    30128 - SCR sign item signed digest is invalid for the application
    30131 - Virgil Card id specified in the request body must match the one passed in the URL
    30134 - Virgil Card data parameters key must be alphanumerical
    30135 - Virgil Card validation token must be an object with value parameter
    30136 - SCR sign item signed digest is invalid for the Virgil Identity service
    30137 - Global Virgil Card cannot be created unconfirmed (which means that Virgil Identity service sign is mandatory)
    30138 - Virgil Card with the same fingerprint already exists 
    30139 - Virgil Card revocation reason isn't specified or is invalid

Appendix B. Authorization header
================================

The **Authorization** HTTP header is mandatory for each API call. The
access token can be retrieved for each application on the `Virgil
Development Portal <https://developer.virgilsecurity.com/dashboard/>`__.

::

    GET /v4/card/a6f7b874ea69329372ad75353314d7bcacd8c0be365023dab195bcac015d6009
    Host: cards.virgilsecurity.com
    Authorization: VIRGIL { YOUR_APPLICATION_TOKEN }
