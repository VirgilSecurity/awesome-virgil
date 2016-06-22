# Virgil Public Keys API service v3

# Topics
* [Public Key](#public-key)
  * [GET /public-key/{public-key-id}](#get-public-keypublic-key-id)
  * [DELETE /public-key/{public-key-id}](#delete-public-keypublic-key-id)
* [Virgil Card](#virgil-card)
  * [POST /virgil-card](#post-virgil-card)
  * [GET /virgil-card/{virgil-card-id}](#get-virgil-cardvirgil-card-id)
  * [POST /virgil-card/{virgil-card-id}/actions/sign](#post-virgil-cardvirgil-card-idactionssign)
  * [POST /virgil-card/{virgil-card-id}/actions/unsign](#post-virgil-cardvirgil-card-idactionsunsign)
  * [POST /virgil-card/actions/search](#post-virgil-cardactionssearch)
  * [POST /virgil-card/actions/search/app](#post-virgil-cardactionssearchapp)
  * [DELETE /virgil-card/{virgil-card-id}](#delete-virgil-cardvirgil-card-id)
* [Appendix A. Response codes](#appendix-a-response-codes)
* [Appendix B. Authentication](#appendix-b-authentication)
* [Appendix C. Access token](#appendix-c-access-token)
* [Appendix D. Response sign](#appendix-d-response-sign)

# Public Key
`Public Key` entity is an entity that is implicitly created by using *POST /virgil-card* endpoint. A `Public Key` entity
contains the associated `Virgil Cards` entities that are available via signed version of the
*GET /public-key/{public-key-id}* endpoint.

## GET /public-key/{public-key-id}
Returns the information about the `Public Key` by the ID. For unsigned requests the response will contain only basic
information without a list of associated `Virgil Cards`. In case the request is signed the associated `Virgil Cards`
collection will be returned.

**Request info**

```
HTTP Request method    GET
Request URL            https://keys.virgilsecurity.com/v3/public-key/{public-key-id}
Authentication         Optional
```

**Response body for unsigned request**
```json
{
    "id": "e33898de-6302-4756-8f0c-5f6c5218e02e",
    "public_key": "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPSm9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t",
    "created_at": "2015-12-22T07:03:42+0000"
}
```

**Response body for signed request**
```json
{
    "id": "e33898de-6302-4756-8f0c-5f6c5218e02e",
    "public_key": "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPSm9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t",
    "created_at": "2015-12-22T07:03:42+0000",
    "virgil_cards": [
        {
            "id": "d4de27e5-361d-4b50-a40a-91de41727e22",
            "created_at": "2015-12-22T07:03:42+0000",
            "is_confirmed": "true",
            "hash": "eyJpZCI6IjQ0NDQ0NDQ0LTQ0NDQtNDQ0NC00NDQ0LTQ0NDQ0NDQ0NDQ0NCIsImNyZWF0ZWRfYXQiOiIyMDE1LTExLTIzIDEzOjA3OjQ0IiwiZGF0YSI6W10sImlzX2NvbmZpcm1lZCI6dHJ1ZSwicHVibGljX2tleV9pZCI6IjIyMjIyMjIyLTIyMjItMjIyMi0yMjIyLTIyMjIyMjIyMjIyMiIsImlkZW50aXR5X2lkIjoiMzMzMzMzMzMtMzMzMy0zMzMzLTMzMzMtMzMzMzMzMzMzMzMzIn0=",
            "public_key": {
                "id": "09dcb19b-85d6-4063-8c28-2e4dfb88ca71",
                "public_key": "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPSm9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t",
                "created_at": "2015-10-12 08:15:17"
            },
            "identity": {
                "id": "607bc05d-3810-4e60-9ccd-0d0c4842350b",
                "type": "email",
                "value": "username@virgilsecurity.com",
                "is_confirmed": "true",
                "created_at": "2015-12-22T07:03:42+0000"
            },
            "data": {
                "parameter": "value"
            }
        },
        {
            "id": "09dcb19b-85d6-4063-8c28-2e4dfb88ca71",
            "created_at": "2015-12-22T07:03:42+0000",
            "is_confirmed": "false",
            "hash": "eyJpZCI6IjQ0NDQ0NDQ0LTQ0NDQtNDQ0NC00NDQ0LTQ0NDQ0NDQ0NDQ0OCIsImNyZWF0ZWRfYXQiOiIyMDE1LTExLTIzIDEzOjIyOjE2IiwiZGF0YSI6W10sImlzX2NvbmZpcm1lZCI6dHJ1ZSwicHVibGljX2tleV9pZCI6IjIyMjIyMjIyLTIyMjItMjIyMi0yMjIyLTIyMjIyMjIyMjIyMiIsImlkZW50aXR5X2lkIjoiMzMzMzMzMzMtMzMzMy0zMzMzLTMzMzMtMzMzMzMzMzMzMzM1In0=",
            "public_key": {
                "id": "47806ab6-3b5e-4591-b1a6-825a1b7ef670",
                "public_key": "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPSm9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t",
                "created_at": "2015-12-22 14:22:18"
            },
            "identity": {
                "id": "47806ab6-3b5e-4591-b1a6-825a1b7ef670",
                "type": "email",
                "value": "username2@virgilsecurity.com",
                "is_confirmed": "false",
                "created_at": "2015-12-22T07:03:42+0000"
            },
            "data": {
                "another_parameter": "another_value"
            }
        }
    ]
}
```

## DELETE /public-key/{public-key-id}
Revoke a `Public Key` endpoint. To revoke the `Public Key` it's mandatory to pass validation tokens obtained on
`Virgil Identity` service for all confirmed `Virgil Cards` for this `Public Key`.

**Request info**
```
HTTP Request method    POST
Request URL            https://keys.virgilsecurity.com/v3/public-key/{public-key-id}
Authentication         Required
```

**Request body**

```
{
    "identities": [
        {
            "type": "email",
            "value": "user@virgilsecurity.com",
            "validation_token": "0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alF"
        },
        ...
    ]
}
```

**Response body**

```json
[]
```

# Virgil Card
`Virgil Card` is the core entity of Virgil services. `Virgil Cards` are used to arrange the Web of Trust by signing
each other to share the information between users and applications. So the `Virgil Card` is an entity that contains the
information about the `Public Key` and `Identity` and the list of key/value pairs with custom values that can be used by
different applications.

## POST /virgil-card
The endpoint creates a `Virgil Card` entity.

Please be aware that `X-VIRGIL-REQUEST-SIGN-VIRGIL-CARD-ID` header is skipped for this endpoint and
`X-VIRGIL-REQUEST-SIGN` header is calculated based on the `Public Key` passed in request body.

Parameters notes:
 - it's mandatory to specify either *public_key_id* or *public_key* parameter;
 - in order to attach the `Virgil Card` to the existing `Public Key` you should pass *public_key_id* request parameter that holds the `Public Key`'s ID;
 - in order to create new `Public Key` instance you should pass *public_key* request parameter that contains the base64-encoded string with the public key;
 - the *identity* request parameter stands for the `Virgil Card` identity that can have a type of 'email';
 - to create a confirmed `Identity` it's necessary to pass *validation_token* parameter obtained from the *Virgil Identity* service;
 - if created `Virgil Card` is unconfirmed it will not appear in the search results by default;
 - to automatically create a list of signs for created `Virgil Card` it's possible to pass the list of signs as optional `signs` parameter.

**Request info**
```
HTTP Request method    POST
Request URL            https://keys.virgilsecurity.com/v3/virgil-card
Authentication         Required
```

**Request body**

```
{
    ["public_key_id": "9ab9d4a4-0440-499f-bdc6-f99c83f900dd",]
    ["public_key": "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPSm9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t",]
    "identity": {
        "type": "email",
        "value": "user@virgilsecurity.com",
        ["validation_token": "0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alF"]
    },
    "data": {
        "custom_key_1": "custom_value_1",
        "custom_key_2": "custom_value_2"
    },
    ["signs": [
        {
            "signed_virgil_card_id": "d4de27e5-361d-4b50-a40a-91de41727e22",
            "signed_digest": "MIGZMA0GCWCGSAFlAwQCAgUABIGHMIGEAkAM29/DTFvTTDrab8hH7QDWGR6a5Igq+4Qw39fg3mLXtRWCv2YG2D/fsIn+CcdtvsDNQT8aWjTBbbY+J0BZQV40AkBElUXjYBZINHiWsC/Q4yhgeRDjip9wGjpXqUH5FU38P8HqPIHCwJE/1ErhQzL6xdiRUWXhXR+1PhNJ1H5DZV7j",
            ["data": {
                "parameter1": "value1",
                "parameter2": "value2",
            }]
        }
    ]]
}
```

**Response body**

```json
{
    "id": "7ce00bab-4660-4fbf-bf81-4f26d6659424",
    "created_at": "2015-12-22T07:03:42+0000",
    "data": {
        "custom_key_1": "custom_value_1",
        "custom_key_2": "custom_value_2"
    },
    "is_confirmed": "false",
    "hash": "eyJpZCI6IjdjZTAwYmFiLTQ2NjAtNGZiZi1iZjgxLTRmMjZkNjY1OTQyNCIsImNyZWF0ZWRfYXQiOiIyMDE1LTExLTIzIDE0OjI0OjIxIiwiZGF0YSI6eyJmaXJzdF9uYW1lIjoiYWxleGFuZGVyIiwibGFzdF9uYW1lIjoibWV0ZWlrbyJ9LCJpc19jb25maXJtZWQiOmZhbHNlLCJwdWJsaWNfa2V5X2lkIjoiMjIyMjIyMjItMjIyMi0yMjIyLTIyMjItMjIyMjIyMjIyMjIyIiwiaWRlbnRpdHlfaWQiOiJjY2E2ZDIyNC0xNjE2LTQzN2EtYTlmMi05ZTg3OThjMGFmZTEifQ==",
    "public_key": {
        "id": "22222222-2222-2222-2222-222222222222",
        "public_key": "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPSm9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t",
        "created_at": "2015-11-23 14:24:20"
    },
    "identity": {
        "id": "cca6d224-1616-437a-a9f2-9e8798c0afe1",
        "type": "email",
        "value": "user@virgilsecurity.com",
        "is_confirmed": "false",
        "created_at": "2015-12-22T07:03:42+0000"
    }
}
```

## GET /virgil-card/{virgil-card-id}
Returns the information about the `Virgil Card` by the ID.

**Request info**
```
HTTP Request method    GET
Request URL            https://keys.virgilsecurity.com/v3/virgil-card/{virgil-card-id}
Authentication         Not needed
```

**Response body for unsigned request**
```json
{
    "id": "e33898de-6302-4756-8f0c-5f6c5218e02e",
    "public_key": "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPSm9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t",
    "created_at": "2015-12-22T07:03:42+0000"
}
```

**Response body for signed request**
```json
{
    "id": "d4de27e5-361d-4b50-a40a-91de41727e22",
    "created_at": "2015-12-22T07:03:42+0000",
    "is_confirmed": "true",
    "hash": "eyJpZCI6IjQ0NDQ0NDQ0LTQ0NDQtNDQ0NC00NDQ0LTQ0NDQ0NDQ0NDQ0NCIsImNyZWF0ZWRfYXQiOiIyMDE1LTExLTIzIDEzOjA3OjQ0IiwiZGF0YSI6W10sImlzX2NvbmZpcm1lZCI6dHJ1ZSwicHVibGljX2tleV9pZCI6IjIyMjIyMjIyLTIyMjItMjIyMi0yMjIyLTIyMjIyMjIyMjIyMiIsImlkZW50aXR5X2lkIjoiMzMzMzMzMzMtMzMzMy0zMzMzLTMzMzMtMzMzMzMzMzMzMzMzIn0=",
    "public_key": {
        "id": "22222222-2222-2222-2222-222222222222",
        "public_key": "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPSm9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t",
        "created_at": "2015-11-23 14:24:20"
    },
    "identity": {
        "id": "607bc05d-3810-4e60-9ccd-0d0c4842350b",
        "type": "email",
        "value": "username@virgilsecurity.com",
        "is_confirmed": "true",
        "created_at": "2015-12-22T07:03:42+0000"
    }
}
```

## POST /virgil-card/{virgil-card-id}/actions/sign
Signs another `Virgil Card` addressed in the request to share the information for the signed `Virgil Card`. The
*signed_digest* request parameter is base64-encoded sign of the *hash* property of the signed `Virgil Card`.

**Request info**

```
HTTP Request method    POST
Request URL            https://keys.virgilsecurity.com/v3/virgil-card/{virgil-card-id}/actions/sign
Authentication         Required
```

**Request body**

```
{
    "signed_virgil_card_id": "9ab9d4a4-0440-499f-bdc6-f99c83f900dd",
    "signed_digest": "MIGZMA0GCWCGSAFlAwQCAgUABIGHMIGEAkBmtz5SCxMjd2mAFN1aZqynga4GfRM/kd01MHIfOQ7s5mNG9AQF5wd54RO8rH2urpiM/zElFp5wDTz8FrTjjcseAkAPjpZLU5e2FLl54RY3Xgb1744Ynvg7EBtPxHejpIHm4e7bhs3dWnvF40KMmweG/FjeeOlL60vj1E6ax0pMvC6Z"
}
```

**Response body**

```json
{
    "id": "9e0bb253-879b-4fbd-a504-829faae7e958",
    "created_at": "2015-12-22T07:03:42+0000",
    "signer_virgil_card_id": "84a66d5b-a6c7-45e9-b87b-06d5ac53ed2c",
    "signed_virgil_card_id": "9ab9d4a4-0440-499f-bdc6-f99c83f900dd",
    "signed_digest": "MIGZMA0GCWCGSAFlAwQCAgUABIGHMIGEAkAM29/DTFvTTDrab8hH7QDWGR6a5Igq+4Qw39fg3mLXtRWCv2YG2D/fsIn+CcdtvsDNQT8aWjTBbbY+J0BZQV40AkBElUXjYBZINHiWsC/Q4yhgeRDjip9wGjpXqUH5FU38P8HqPIHCwJE/1ErhQzL6xdiRUWXhXR+1PhNJ1H5DZV7j"
}
```

## POST /virgil-card/{virgil-card-id}/actions/unsign
Removes the `Sign` of another `Virgil Card`.

**Request info**

```
HTTP Request method    POST
Request URL            https://keys.virgilsecurity.com/v3/virgil-card/{virgil-card-id}/actions/unsign
Authentication         Required
```

**Request body**

```
{
    "signed_virgil_card_id": "9ab9d4a4-0440-499f-bdc6-f99c83f900dd"
}
```

**Response body**

```json
{}
```

## POST /virgil-card/actions/search

Performs the search by search criteria:
- the *value* request parameter is mandatory;
- the *type* request parameter is optional and specifies the type of `Virgil Card`'s `Identity`;
- the *relations* request parameter is optional and contains the list of `Virgil Cards` UDIDs to perform the search within;
- the *include_unconfirmed* request parameter specifies whether an unconfirmed `Virgil Cards` should be returned.

Please note that for `Virgil Card` to be retrieved as a search result, it must sign the application that initiates the
search.

**Request info**

```
HTTP Request method    POST
Request URL            https://keys.virgilsecurity.com/v3/virgil-card/actions/search
Authentication         Not required
```

**Request body**

```
{
    "value": "user@virgilsecurity.com",
    ["type": "email"],
    ["relations": ["b5f0e24c-932c-45f2-922e-9077772b0d61", "5f27120a-c38e-4eb1-81f6-f8e615db5f21"]],
    ["include_unconfirmed": "true"]
}
```

**Response body**

```json
[
    {
        "id": "62b6f34f-ffd7-427f-ba88-8c1b098f42dd",
        "created_at": "2015-12-22T07:03:42+0000",
        "data": {},
        "is_confirmed": "true",
        "hash": "eyJpZCI6IjQ0NDQ0NDQ0LTQ0NDQtNDQ0NC00NDQ0LTQ0NDQ0NDQ0NDQ0NCIsImNyZWF0ZWRfYXQiOiIyMDE1LTExLTIzIDE1OjMzOjM0IiwiZGF0YSI6W10sImlzX2NvbmZpcm1lZCI6dHJ1ZSwicHVibGljX2tleV9pZCI6IjIyMjIyMjIyLTIyMjItMjIyMi0yMjIyLTIyMjIyMjIyMjIyMiIsImlkZW50aXR5X2lkIjoiMzMzMzMzMzMtMzMzMy0zMzMzLTMzMzMtMzMzMzMzMzMzMzMzIn0=",
        "public_key": {
            "id": "7ccd696c-9b59-491d-aa66-afcd91e0ff44'",
            "public_key": "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPSm9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t",
            "created_at": "2015-12-22T07:03:42+0000"
        },
        "identity": {
            "id": "d646ae1b-decc-4ccb-8918-aa4f755a563d",
            "type": "email",
            "value": "username@virgilsecurity.com",
            "is_confirmed": "true",
            "created_at": "2015-12-22T07:03:42+0000"
        }
    }
]
```

## POST /virgil-card/actions/search/app
Performs the global search for the applications' `Virgil Cards`
- the *value* request parameter is mandatory. It is possible to specify the wildcard for the last term of the value
which allows searching for all the applications inside the organization.

**Request info**

```
HTTP Request method    POST
Request URL            https://keys.virgilsecurity.com/v3/virgil-card/actions/search/app
Authentication         Not required
```

**Request body**

```
{
    "value": "com.virgilsecurity.pass" | "com.virgilsecurity.*",
}
```

**Response body**

```json
[
    {
        "id": "62b6f34f-ffd7-427f-ba88-8c1b098f42dd",
        "created_at": "2015-12-22T07:03:42+0000",
        "data": {},
        "is_confirmed": "true",
        "hash": "eyJpZCI6IjQ0NDQ0NDQ0LTQ0NDQtNDQ0NC00NDQ0LTQ0NDQ0NDQ0NDQ0NCIsImNyZWF0ZWRfYXQiOiIyMDE1LTExLTIzIDE1OjMzOjM0IiwiZGF0YSI6W10sImlzX2NvbmZpcm1lZCI6dHJ1ZSwicHVibGljX2tleV9pZCI6IjIyMjIyMjIyLTIyMjItMjIyMi0yMjIyLTIyMjIyMjIyMjIyMiIsImlkZW50aXR5X2lkIjoiMzMzMzMzMzMtMzMzMy0zMzMzLTMzMzMtMzMzMzMzMzMzMzMzIn0=",
        "public_key": {
            "id": "7ccd696c-9b59-491d-aa66-afcd91e0ff44'",
            "public_key": "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alFXVUpWcVpJQjRLdFVneG9IcS81c2lybUI2cW1OClNFODNxcTZmbitPSm9qeUpGMytKY1AwTUp1WXRVZnpHbjgvUHlHVkp1TEVHais0NTlKWTRWbzdKb1pnS2hBT24KcWJ3UjRlcTY0citlUEpNcUppMD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t",
            "created_at": "2015-12-22T07:03:42+0000"
        },
        "identity": {
            "id": "d646ae1b-decc-4ccb-8918-aa4f755a563d",
            "type": "email",
            "value": "username@virgilsecurity.com",
            "is_confirmed": "true",
            "created_at": "2015-12-22T07:03:42+0000"
        }
    }
]
```

## DELETE /virgil-card/{virgil-card-id}

Revoke a `Virgil Card` endpoint.

**Request info**

```
HTTP Request method    POST
Request URL            https://keys.virgilsecurity.com/v3/virgil-card
Authentication         Required
```

**Request body**

```
{
    "identity": {
        "type": "email",
        "value": "user@virgilsecurity.com",
        "validation_token": "0KTUlHYk1CUUdCeXFHU000OUFnRUdDU3NrQXdNQ0NBRUJEUU9CZ2dBRUNhV3k5VVVVMDFWcjdQLzExWHpubk0vRAowTi9KODhnY0dMV3pYMGFLaGcxSjdib3B6RGV4b0QwaVl3alF"
    }
}
```

**Response body**

```json
[]
```

# Appendix A. Response codes

**`HTTP error codes`**
Application uses standard HTTP response codes:
```
200 - Success
400 - Request error
401 - Authentication error
404 - Entity not found
405 - Method not allowed
500 - Server error
```

Additional information about the error is returned as JSON-object like:
```
{
    "code": "{error-code}"
}
```

**`HTTP 500. Server error`** status is returned on internal application errors
```
10000 - Internal application error
```

**`HTTP 401. Auth error`** status is returned on authorization errors
```
20100 - The request ID header was used already
20101 - The request ID header is invalid
20200 - The request sing header not found
20201 - The Virgil Card ID header not specified or incorrect
20202 - The request sign header is invalid
20203 - Public Key value is required in request body
20204 - Public Key value in request body must be base64 encoded value
20205 - Public Key IDs in URL part and public key for the Virgil Card retrieved from X-VIRGIL-REQUEST-SIGN-VIRGIL-CARD-ID header must match
20206 - The public key id in the request body is invalid
20208 - Virgil card ids in url and authentication header must match
20300 - The Virgil application token was not specified or invalid
20301 - The Virgil statistics application error
```

**`HTTP 400. Request error`** status is returned on request data validation errors
```
30000 - JSON specified as a request body is invalid
30100 - Public Key ID is invalid
30101 - Public key length invalid
30102 - Public key must be base64-encoded string
30201 - Identity type is invalid. Valid types are: 'email', 'application'
30202 - Email value specified for the email identity is invalid
30203 - Cannot create unconfirmed application identity
30204 - Application value specified for the application identity is invalid
30300 - Signed Virgil Card not found by UUID provided
30301 - Virgil Card's signs list contains an item with invalid signed_id value
30302 - Virgil Card's one of signed digests is invalid
30303 - Virgil Card's data parameters must be strings
30304 - Virgil Card's data parameters must be an array of strings
30305 - Virgil Card custom data entry value length validation failed
30400 - Sign object not found for id specified
30402 - The signed digest value is invalid
30403 - Sign Signed digest must be base64 encoded string
30404 - Cannot save the Sign because it exists already
31000 - Value search parameter is mandatory
31010 - Search value parameter is mandatory for the application search
31020 - Virgil Card's signs parameter must be an array
31030 - Identity validation token is invalid
31040 - Virgil Card revocation parameters do not match Virgil Card's identity
31050 - Virgil Identity service error
31060 - Identities parameter is invalid
31070 - Identity validation failed
```

# Appendix B. Authentication
In order to authenticate a user the API expects a valid set of HTTP headers:
**`X-VIRGIL-REQUEST-ID`**, **`X-VIRGIL-REQUEST-SIGN`** and **`X-VIRGIL-REQUEST-SIGN-VIRGIL-CARD-ID`**. These headers
must be set on each request to endpoints with authorization marked as **REQUIRED**:

```
POST /v3/virgil-card/{virgil-card-id}/actions/unsign
Host: keys.virgilsecurity.com
X-VIRGIL-REQUEST-ID: 6cfe1068-4fbc-4921-942b-c92ce0805334
X-VIRGIL-REQUEST-SIGN-VIRGIL-CARD-ID: 3a768eea-cbda-4926-a82d-831cb89092aa 
X-VIRGIL-REQUEST-SIGN: MIG5DAZTSEEyNTYEgYgwgYUCQQCJLqIZilQM6MT+UpBbrMkuvIW5Nj0hRwu5kH1PjocYhlBffillHnC/rw+BMsU0qiV0ZXRKKwrMRhbgVoUdVygkAkBm2QCQf88honRdxp5+Vr5HE7XbqAlUYuYlMmSHSsdXtF4M3Q7/oFgwJRxr0Yb4XFllZbm5Qf57YlGJ41KXXt7xDCRmYzAxM2ZmZS0yYjViLTRjMDQtZmQzNC1jMTM5ZThkY2Y3Yjg=
```

A request uniqueness header along with a request body gets signed on the client side using user’s private key and this
digest will be used as a **`X-VIRGIL-REQUEST-SIGN`** header. In order to verify the data fingerprint, additional header
**`X-VIRGIL-REQUEST-SIGN-VIRGIL-CARD-ID`** must contain the **ID** of the `Virgil Card` used to sign the data.
Later on, these headers are used to make sure the request body specified is unchanged and came from the valid client.

## Client Authentication calculation

The **X-VIRGIL-REQUEST-SIGN** hash is calculated on client side according to these rules:

```
REQUEST_TEXT = X-VIRGIL-REQUEST-ID + REQUEST_BODY_TEXT
SIGN = VirgilSigner::sign(REQUEST_TEXT, PRIVATE_KEY, PRIVATE_KEY_PWD)
SIGNED-DIGEST = base64_encode(SIGN->toAsn1())
```

* **REQUEST_TEXT** - the concatenation of the REQUEST_BODY_TEXT and X-VIRGIL-REQUEST-ID header
* **REQUEST_BODY_TEXT** - the text representation of the request body to be sent to API
* **VirgilSigner::sign** - Virgil Seсurity Library method to sign the data
* **PRIVATE_KEY**, **PRIVATE_KEY_PWD** - private key / password pair for the user's certificate

## Authentication hash cardinality
In order to provide good authentication headers cardinality and to prevent cases when the authorization headers for the
resource become static, we need to add a special header that holds the request ID. This header's value must be a
**`uuid`** value and passed as **X-VIRGIL-REQUEST-ID** header.
All IDs used in authorized requests got stored in the database and are valid only once. The request will be returned
with a **`401 Auth Error`** HTTP status on each further request with an already used ID.


# Appendix C. Access token
The access token header **X-VIRGIL-ACCESS-TOKEN** is mandatory for each API call. The access token can be retrieved for
each application on https://virgilsecurity.com/account/signup.

```
X-VIRGIL-ACCESS-TOKEN: { YOUR_APPLICATION_TOKEN }
```

# Appendix D. Response sign
Every service response contains two additional headers:

- `X-VIRGIL-RESPONSE-ID` - an ID that is randomly generated for every response
- `X-VIRGIL-RESPONSE-SIGN` - a signature of the response that is calculated as shown below and can be used to make sure that the response comes from a valid `Virgil Keys` instance

```
RESPONSE_TEXT = X-VIRGIL-RESPONSE-ID + RESPONSE_BODY_TEXT
SIGN = VirgilSigner::sign(RESPONSE_TEXT, PRIVATE_KEY)
X-VIRGIL-RESPONSE-SIGN = base64_encode(SIGN)
```
