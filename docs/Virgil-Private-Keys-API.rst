## API
* [General statements](#general-statements)
* [Request encryption](#request-encryption)
* [Response decryption](#response-decryption)
* [Private Key](#private-key)
    * [POST /private-key](#post-private-key)
    * [POST /private-key/actions/grab](#post-private-keyactionsgrab)
    * [POST /private-key/actions/delete](#post-private-keyactionsdelete)
* [Appendix A. Responses](#appendix-a-responses)
* [Appendix B. X-VIRGIL-REQUEST-SIGN](#appendix-b-x-virgil-request-sign)
* [Appendix C. X-VIRGIL-REQUEST-ID](#appendix-c-x-virgil-request-id)
* [Appendix D. X-VIRGIL-ACCESS-TOKEN](#appendix-d-x-virgil-access-token)
* [Appendix E. response_password](#appendix-e-response_password)

## General statements

1. Make sure that you have registered and confirmed your account for the Public Keys Service.
2. Make sure that you have a public/private key pair and you have already uploaded the public key to the Public Keys Service.
3. Make sure that you have your private key on the local machine.
4. Make sure that you have registered an application at [Virgil Security, Inc](https://developer.virgilsecurity.com/account/signup).
5. Use Virgil Crypto Library to correctly generate a value for `X-VIRGIL-REQUEST-SIGN` header parameter. For more information please check [Appendix B. X-VIRGIL-REQUEST-SIGN](#appendix-b-x-virgil-request-sign) section.

## Request encryption

Every request to the Private Keys Service has to be encrypted with a public key from the Private Keys Service to prevent any man in the middle attack. You can find a public key for the Private Keys Service within the Public Keys Service. The final encrypted request is calculated according to these rules:

```
REQUEST_PARAMETERS = [parameter_1 => parameter_1_value, parameter_2 => parameter_2_value]
JSON_REQUEST = JSON_ENCODE(REQUEST_PARAMETERS)
VirgilCypher::addKeyRecipient(RECEPIENT_ID, PUBLIC_KEY)
ENCODED_REQUEST = VirgilCypher::encrypt(JSON_REQUEST, true)
BASE64_ENCODED_REQUEST = BASE64_ENCODE(ENCODED_REQUEST)
```

* **REQUEST_PARAMETERS** - the list of Request parameters.
* **JSON_REQUEST** - Request parameters int JSON format.
* **JSON_ENCODE** - Native JSON_ENCODE function.
* **RECEPIENT_ID** - Virgil Card ID of the Private Keys Service retrieved from the Public Keys Service.
* **PUBLIC_KEY** - public key for the Private Keys Service retrieved from the Public Keys Service.
* **VirgilCypher::addKeyRecipient** - Virgil Seсurity Library method to add a key recipient.
* **VirgilCypher::encrypt** - Virgil Security Library method to encrypt data with a public key.
* **BASE64_ENCODE** - native BASE64_ENCODE function.
* **BASE64_ENCODED_REQUEST** - base64 encoded result of a secure request to the Private Keys Service.

You should do all these steps and provide a secure base64 encoded request for any of Private Keys Service endpoints in case you are using direct calls to the Private Keys Service. If Virgil PHP SDK is used, these steps will be produced in the background of the SDK. The end result of this algorithm will be a base64 encoded string:

```
MIIB6wIBADCCAeQGCSqGSIb3DQEHA6CCAdUwggHRAgECMYIBnjCCAZoCAQKgJgQkNDU0YTQ3ZGQtZDJmMC00MzIzLTg4N2ItOWU3NmVmYzI0OGRjMBQGByqGSM49AgEGCSskAwMCCAEBDQSCAVUwggFRAgEAMIGbMBQGByqGSM49AgEGCSskAwMCCAEBDQOBggAEX+l2XvD08lsbLvmgb1Nn/2wWuj+riGvJOhC2v6ZFMzF893EpJI+6hWJfRi7LqOQmuLCDZNb1y0x7zjqYhlTPFScUYxsQyQJl0KNfM0XO4gegagUq1dfZBXRQWnebfS8tzWqA/FYmDNT1b0ssp4s6D4Ul0yp7XE8O26HjhETdxq4wGAYHKIGMcQIFATANBglghkgBZQMEAgIFADBBMA0GCWCGSAFlAwQCAgUABDCQgREpvGDc3zITXCzE1FhWpVcdSpnas1d386dMm4kq6qtyg3XUt6rVJnTkkW6BC5wwUTAdBglghkgBZQMEASoEEMk96Vpu7QtgAqC6hTfbQm4EMNZGmI7EwcBbM5scE37/0A+W3LhZR3Y5p0iY9l1cPe1iwI4PE6IKMMV3aV9QmoQS2DAqBgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBByDXwSlLfbrbG4KSbPbBIuVAex908PZ4/KCcskqHu5S3lEFgSFC520mjzb1QEETVpFGijy1hMmmHnFUCdKAOwfankTVXMwCK3FxW4yAHpGiqM/5eeIO025HGIDzSG27hSII/XWcjlS5u+ICh55fcxZOlX3UTWlaJU2POOIRC6r4z1JG7iAmaJJZzaBEWKC6KyE7m43C7wqvyYGu8lywIuMeyXU5F6T1EUgyoXHbdz1Sg==
```

Further in the text request data will be presented in unencrypted form for a correct understanding of the input parameters.

## Response decryption

Some of the responses from the Private Keys Service are encrypted to prevent any man in the middle attack. `Response_password` is used for response encryption. Please follow the rules to decrypt the encrypted response :

```
BASE64_ENCODED_REQUEST = "BASE64-ENCODED-REQUEST-STRING"
ENCODED_REQUEST = BASE64_DECODE(BASE64_ENCODED_REQUEST)
DECODED_JSON_REQUEST = VirgilCipher::decryptWithPassword(ENCODED_REQUEST, RESPONSE_PASSWORD)
ORIGINAL_REQUEST = JSON_DECODE(DECODED_JSON_REQUEST)
```

* **BASE64_ENCODED_REQUEST** - already encoded response in BASE64 format.
* **BASE64_DECODE** - native BASE64_DECODE function.
* **ENCODED_REQUEST** - original encoded response.
* **RESPONSE_PASSWORD** - password for response decryption.
* **VirgilCipher::decryptWithPassword** - Virgil Seсurity Library method to decrypt data with a password.
* **DECODED_JSON_REQUEST** - original response in JSON format.
* **JSON_DECODE** - native JSON_DECODE function.
* **ORIGINAL_REQUEST** - original response.

You should do all these steps to decrypt an encrypted response in case you are using direct calls to the Private Keys Service. If Virgil PHP SDK is used, these steps will be produced in the background of the SDK. The end result of this algorithm will be a decrypted response:

```
[parameter_1 => parameter_1_value, parameter_2 => parameter_2_value]
```

Further, in the text response, data will be presented in the unencrypted form for a correct understanding of the output parameters.

##Private Key
**`Private Key`** entity endpoints.

###POST /private-key
Load a private key into the Private Keys Service storage.

> **Note:**

> `X-VIRGIL-ACCESS-TOKEN` - For more information please check [Appendix D. X-VIRGIL-ACCESS-TOKEN](#appendix-d-x-virgil-access-token) section.

> `X-VIRGIL-REQUEST-SIGN` - For more information please check [Appendix B. X-VIRGIL-REQUEST-SIGN](#appendix-b-x-virgil-request-sign) section.

> `X-VIRGIL-REQUEST-ID` - Header parameter that holds a random uuid to guarantee the uniqueness of the request body. For more information please check [Appendix C. X-VIRGIL-REQUEST-ID](#appendix-c-x-virgil-request-id) section.

Header info
```http
X-VIRGIL-ACCESS-TOKEN: YOUR_ACCESS_TOKEN
X-VIRGIL-REQUEST-SIGN: SIGN-BASE64-ENCODED-STRING
X-VIRGIL-REQUEST-ID: 6cfe1068-4fbc-4921-942b-c92ce0805355
```

Request info
```html
HTTP Request method    POST
Request URL            https://keyring.virgilsecurity.com/v3/private-key
Authorization          Needed
```

Request body
```json
{
    "private_key": "PRIVATE-KEY-BASE64-ENCODED-STRING",
    "virgil_card_id": "837619cb-1709-8e1d-2324-12a29a3fd633"
}
```

Response body

```json
-
```

Request sample
```bash
curl -H 'X-VIRGIL-ACCESS-TOKEN: YOUR_ACCESS_TOKEN' -H 'X-VIRGIL-REQUEST-SIGN: REQUEST_SIGN' -H 'X-VIRGIL-REQUEST-ID: 6cfe1068-4fbc-4921-942b-c92ce0805355' -v -X POST https://keyring.virgilsecurity.com/v3/private-key -data {"virgil_card_id": "57e0a766-28ef-355e-7ca2-d8a2dcf23fc4","private_key": "PRIVATE-KEY-BASE64-ENCODED-STRING"}
```

###POST /private-key/actions/grab
Get an existing private key.

> **Note:**

> `X-VIRGIL-ACCESS-TOKEN` - For more information please check [Appendix D. X-VIRGIL-ACCESS-TOKEN](#appendix-d-x-virgil-access-token) section.

> `response_password` - Request parameter that holds randomly generated response password. It is used to encrypt the response to prevent any man in the middle attack. Should be less than 32 characters long.

> Endpoint returns an encoded response. The response is encoded with `response_password` parameter. Please check [Response Format](#response-format) section to learn how to decode encoded response.

Header info
```http
X-VIRGIL-ACCESS-TOKEN: YOUR_ACCESS_TOKEN
```

Request info
```html
HTTP Request method    POST
Request URL            https://keyring.virgilsecurity.com/v3/private-key/actions/grab
Authorization          Needed
```

Request body
```json
 "identity": {
    "type": "email",
    "value": "user@virgilsecurity.com",
    "validation_token": "MIGZMA0GCWCGSAFlAwQCAgUABIGHMIGEAkB0RVkqJ89UlvsbBDgA2nPNVEhRptbF8ZVFXrZGbzSmLU9OLw2A/pjTaUKhi9Z0iycISg0WRl/CA9qT4lKuQzurAkBlGNjWMNSr5PRzvPAPOooJZ9Ymlpr8LcfI966/MmBkVcTBTZAxhONOciNusPsAjRceAZ04jfNqCuHIpRu8vaZL"
 },
  "response_password": "RANDOMLY-GENERATED-RESPONSE-PASSWORD",
  "virgil_card_id": "57e0a766-28ef-355e-7ca2-d8a2dcf23fc4"
}
```

Response body
```json
{
    "private_key": "PRIVATE-KEY-BASE64-ENCODED-STRING",
    "virgil_card_id": "57e0a766-28ef-355e-7ca2-d8a2dcf23fc4"
}
```

Request sample
```bash
curl -H 'X-VIRGIL-ACCESS-TOKEN: YOUR_ACCESS_TOKEN' -v -X POST https://keyring.virgilsecurity.com/v3/private-key/actions/grab -data {"identity":{"type":"email","value":"user@virgilsecurity.com","validation_token":"MIGZMA0GCWCGSAFlAwQCAgUABIGHMIGEAkB0RVkqJ89UlvsbBDgA2nPNVEhRptbF8ZVFXrZGbzSmLU9OLw2A/pjTaUKhi9Z0iycISg0WRl/CA9qT4lKuQzurAkBlGNjWMNSr5PRzvPAPOooJZ9Ymlpr8LcfI966/MmBkVcTBTZAxhONOciNusPsAjRceAZ04jfNqCuHIpRu8vaZL"},"response_password":"RANDOMLY-GENERATED-RESPONSE-PASSWORD","virgil_card_id":"57e0a766-28ef-355e-7ca2-d8a2dcf23fc4"}
```

###POST /private-key/actions/delete
Delete a private key.

> **Note:**

> `X-VIRGIL-ACCESS-TOKEN` - For more information please check [Appendix D. X-VIRGIL-ACCESS-TOKEN](#appendix-d-x-virgil-access-token) section.

> `X-VIRGIL-REQUEST-SIGN` - For more information please check [Appendix B. X-VIRGIL-REQUEST-SIGN](#appendix-b-x-virgil-request-sign) section.

> `X-VIRGIL-REQUEST-ID` - Header parameter that holds a random uuid to guarantee the uniqueness of the request body. For more information please check [Appendix C. X-VIRGIL-REQUEST-ID](#appendix-c-x-virgil-request-id) section.

Header info
```http
X-VIRGIL-ACCESS-TOKEN: YOUR_ACCESS_TOKEN
X-VIRGIL-REQUEST-SIGN: SIGN-BASE64-ENCODED-STRING
X-VIRGIL-REQUEST-ID: 6cfe1068-4fbc-4921-942b-c92ce0805355
```

Request info
```html
HTTP Request method    POST
Request URL            https://keyring.virgilsecurity.com/v3/private-key/actions/delete
Authorization          Needed
```

Request body
```json
{
   "virgil_card_id": "57e0a766-28ef-355e-7ca2-d8a2dcf23fc4",
}
```

Response body
```json
```

Request sample
```bash
curl -H 'X-VIRGIL-ACCESS-TOKEN: YOUR_ACCESS_TOKEN' -H 'X-VIRGIL-REQUEST-SIGN: REQUEST_SIGN' -H 'X-VIRGIL-REQUEST-ID: 6cfe1068-4fbc-4921-942b-c92ce0805355' -v -X POST https://keyring.virgilsecurity.com/v3/private-key/actions/delete -data {"virgil_card_id": "57e0a766-28ef-355e-7ca2-d8a2dcf23fc4","request_sign_uuid": "837619cb-1709-8e1d-2324-12a29a3fd633"}
```

#Appendix A. Responses
Application uses standard HTTP response codes:
```html
200 - Success
400 - Request error
500 - Server error
```

Additional information about the error is returned as a JSON-object like:
```json
{
    "code": "{error-code}"
}
```

**`HTTP 501. Server error`** status is returned on internal server error

**`Internal Application errors.`**
```html
10000 - Internal application error.
```

**`Routes errors.`**
```html
10010 - Controller was not found.
10020 - Action was not found.
```

**`HTTP 400. Request error`** status is returned on request data validation errors

**`Request Validation errors.`**
```html
20000 - Request wrongly encrypted.
20010 - Request JSON invalid.
20020 - Request 'response_password' parameter invalid.
```

**`Private Key Validation errors.`**
```html
30010 - Private Key not specified.
30020 - Private Key not base64 encoded.
```

**`Virgil Card Validation errors.`**
```html
40000 - Virgil Card ID not specified.
40010 - Virgil Card ID has incorrect format.
40020 - Virgil Card ID not found.
40030 - Virgil Card ID already exists.
40040 - Virgil Card ID not found in Public Key service.
40050 - Virgil Card ID not found for provided Identity
```

**`Request Sign UUID errors.`**
```html
50000 - Request Sign UUID not specified.
50010 - Request Sign UUID has wrong format.
50020 - Request Sign UUID already exists.
50030 - Request Sign is incorrect.
```

**`Identity errors.`**
```html
60000 - Identity not specified.
60010 - Identity Type not specified.
60020 - Identity Value not specified.
60030 - Identity Token not specified.
```

**`External Service errors.`**
```html
90000 - Identity validation under RA service failed.
90010 - Access Token validation under Stats service failed.
```

#Appendix B. X-VIRGIL-REQUEST-SIGN

The request body sign that is used to make sure a user is the holder of the private key. This is the result of Virgil Crypto
Library sign process for the request data using user’s private key. For generating we are using [Virgil Crypto Lib PHP Wrapper](https://packagist.org/packages/virgil/crypto). The **X-VIRGIL-REQUEST-SIGN** hash is calculated on client side according to these rules:

```
REQUEST_TEXT = X-VIRGIL-REQUEST-ID + REQUEST_BODY_TEXT
SIGN = VirgilSigner::sign(REQUEST_TEXT, PRIVATE_KEY, PRIVATE_KEY_PWD)
SIGNED-DIGEST = base64_encode(SIGN)
```

* **REQUEST_TEXT** - the concatenation of the REQUEST_BODY_TEXT and X-VIRGIL-REQUEST-ID header.
* **REQUEST_BODY_TEXT** - the text representation of the request body to be sent to API.
* **VirgilSigner::sign** - Virgil Seсurity Library method to sign the data.
* **PRIVATE_KEY**, **PRIVATE_KEY_PWD** - private key / password pair for the user's certificate.

#Appendix C. X-VIRGIL-REQUEST-ID

Random UUID to guarantee the uniqueness of the request body.

#Appendix D. X-VIRGIL-ACCESS-TOKEN

The access token header (X-VIRGIL-ACCESS-TOKEN) is mandatory for each API call. The access token can be retrieved for each application at https://virgilsecurity.com/account/signup.
```
X-VIRGIL-ACCESS-TOKEN: { YOUR_ACCESS_TOKEN }
```

#Appendix E. response_password

Is used to encrypt a response from the Private Keys Service. 