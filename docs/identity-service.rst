###########
Virgil Identity service
###########

* `POST /verify`_
* `POST /confirm`_
* `POST /validate`_
* `Appendix A. Response codes`_
* `Appendix B. Response sign`_

Virgil Identity service is responsible for validation of user's identities like email, application, etc. Typical
workflow for an email confirmation contains the following steps:

* The process is initiated by invocation of the ``/verify`` endpoint
* Identity service generates a confirmation code and sends it to the specified email
* Developer invokes ``/confirm`` endpoint with the confirmation code sent to the email and identity id from the previous step
* Identity service returns the ``token`` that can be used to prove that the user is the identity holder
* To verify that the user is identity holder, 3rd-party service invokes the ``/validate`` endpoint with the ``token`` from the previous step

==============
POST /verify
==============

Initiates a process to verify an ``Identity``. In some cases it could be necessary to pass some parameters to a ``/verify`` endpoint and receive them back in an email. For this special case an optional **extra_fields** map parameter can be used. All the keys and values are supposed to be strings that contain alphanumerical characters, underscores and dashes. If type of an identity is *email*, all
values passed in **extra_fields** parameter will be passed back in an email in a hidden form with extra hidden fields.

**Request info**

.. code::

  HTTP Request method    POST
  Request URL            https://identity.virgilsecurity.com/v1/verify

**Request body**

.. code::

  {
      "type": "email",
      "value": "user@virgilsecurity.com",
      ["extra_fields": {
          "parameter 1": "value-1",
          "parameter_2": "value2",
      }]
  }

**Response body**

.. code:: json

  {
      "action_id": "202b65f1-ee1c-4cc2-941a-9548c9cded1c"
  }

==============
POST /confirm
==============

Confirms the identity from the ``/verify`` step to obtain an identity confirmation token.

**Request info**

.. code::

  HTTP Request method    POST
  Request URL            https://identity.virgilsecurity.com/v1/confirm

**Request body**

.. code::

  {
      "confirmation_code": "4R6S3H",
      "action_id": "202b65f1-ee1c-4cc2-941a-9548c9cded1c",
      "token": {
          "time_to_live": 3600,
          "count_to_live": 12
      }
  }

**Response body**

.. code:: json

  {
      "type": "email",
      "value": "user@virgilsecurity.com",
      "validation_token": "MIGZMA0GCWCGSAFlAwQCAgUABIGHMIGEAkB0RVkqJ89UlvsbBDgA2nPNVEhRptbF8ZVFXrZGbzSmLU9OLw2A/pjTaUKhi9Z0iycISg0WRl/CA9qT4lKuQzurAkBlGNjWMNSr5PRzvPAPOooJZ9Ymlpr8LcfI966/MmBkVcTBTZAxhONOciNusPsAjRceAZ04jfNqCuHIpRu8vaZL"
  }

Token's :term:`count_to_live <Count to live>` parameter is used to restrict the number of token usages (maximum value is 100). Token's :term:`time_to_live <Time to live>` parameter is used to limit the lifetime of the token in seconds (maximum value is 60 * 60 * 24 * 365 = 1 year). Default ``time_to_live`` value is 3600 and ``count_to_live`` default value is 1, which means that the token can be used at most one time during one hour.

==============
POST /validate
==============

Validates the passed token.

**Request info**

.. code::

  HTTP Request method    POST
  Request URL            https://identity.virgilsecurity.com/v1/validate

**Request body**

.. code::

  {
      "type": "email",
      "value": "user@virgilsecurity.com",
      "validation_token": "MIGZMA0GCWCGSAFlAwQCAgUABIGHMIGEAkB0RVkqJ89UlvsbBDgA2nPNVEhRptbF8ZVFXrZGbzSmLU9OLw2A/pjTaUKhi9Z0iycISg0WRl/CA9qT4lKuQzurAkBlGNjWMNSr5PRzvPAPOooJZ9Ymlpr8LcfI966/MmBkVcTBTZAxhONOciNusPsAjRceAZ04jfNqCuHIpRu8vaZL"
  }

**Response body**

.. code:: json

  {}

**Response HTTP statuses**

.. code::

  200 - OK
  400 - Validation failed

==============
Appendix A. Response codes
==============

**HTTP error codes**

Application uses standard HTTP response codes:

.. code::

  200 - Success
  400 - Request error
  405 - Method not allowed
  500 - Server error

Additional information about the error is returned as JSON-object like:

.. code::

  {
      "code": {error-code}
  }

**HTTP 500. Server error** status is returned on internal application errors.

.. code::

  10000 - Internal application error

**HTTP 400. Request error** status is returned on request data validation errors.

.. code::

  40000 - JSON specified as a request body is invalid
  40100 - Identity type is invalid
  40110 - Identity's ttl is invalid
  40120 - Identity's ctl is invalid
  40130 - Identity's token parameter is missing
  40140 - Identity's token doesn't match parameters
  40150 - Identity's token has expired
  40160 - Identity's token cannot be decrypted
  40170 - Identity's token parameter is invalid
  40180 - Identity is not unconfirmed
  40190 - Hash to be signed parameter is invalid
  40200 - Email identity value validation failed
  40210 - Identity's confirmation code is invalid
  40300 - Application value is invalid
  40310 - Application's signed message is invalid
  41000 - Identity entity was not found
  41010 -  Identity's confirmation period has expired

==============
Appendix B. Response sign
==============

Every service response contains two additional headers:

- X-VIRGIL-RESPONSE-ID
- X-VIRGIL-RESPONSE-SIGN

``X-VIRGIL-RESPONSE-ID`` header is a uuid that is randomly generated for every response.

``X-VIRGIL-RESPONSE-SIGN`` - is a signature of the response that is calculated as shown below and can be used to make sure that the response comes from a valid `Virgil Identity` instance.

.. code::

  RESPONSE_TEXT = X-VIRGIL-RESPONSE-ID + RESPONSE_BODY_TEXT
  SIGN = VirgilSigner::sign(RESPONSE_TEXT, PUBLIC_KEY_UUID, PRIVATE_KEY, PRIVATE_KEY_PWD)
  X-VIRGIL-RESPONSE-SIGN = base64_encode(SIGN)
