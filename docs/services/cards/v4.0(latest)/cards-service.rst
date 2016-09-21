Virgil Cards API service v4.0
=============================

Topics
======

-  `Virgil Card`_
-  `POST /virgil-card`_
-  `GET /virgil-card/{virgil-card-id}`_
-  `POST /virgil-card/actions/search`_
-  `DELETE /virgil-card/{virgil-card-id}`_
-  `Appendix A. Response codes`_
-  `Appendix B. Access token`_
-  `Appendix C. Request sign`_
-  `Appendix D. Response sign`_

Virgil Card
===========

A ``Virgil Card`` is the core entity of Virgil services. The
``Virgil Card`` contains all necessary information to identify a user
and to obtain his ``Public Key`` fo further operations.

POST /virgil-card
-----------------

The endpoint creates a ``Virgil Card`` entity.

Each ``Virgil Card`` will have it’s fingerprint that can be used to
identify each ``Virgil Card``. So the pingerprint value will be
calculated as an ordered concatenation of all the request fields (all
keys must be ordered in alphabetical order):

::

    FINGERPRINT = BASE64 (
        SHA256( ID + PUBLIC_KEY + IDENTITY_TYPE + IDENTITY + SCOPE + IS_CONFIRMED + [DATA_KEY_1 + DATA_VALUE_1 + DATA_KEY_2 + DATA_VALUE_2 + ...] + INFO_DEVICE + INFO_DEVICE_NAME ) 
    );

Parameters notes: - **public\_key** request parameter must contain a
base64-encoded public key value; - **id** parameter is mandatory and
must be a valid `uuid`_; - **scope** parameter determines a
``Virgil Card`` scope that can be either *‘global’* or *‘application’*.
Application ``Virgil Cards`` are accessible only within the application
they were created within. Global ``Virgil Cards`` are available in all
the applications. - in order to create a global ``Virgil Card`` it’s
necessary to pass a *virgil\_card\_validation\_token* parameter obtained
from the *Virgil Identity* service and to set *scope* request parameter
to *‘global’*; - in order to create a confirmed segregated
``Virgil Card`` it’s necessary to pass a
*virgil\_card\_validation\_token* parameter obtained from the *Virgil
Identity* service and to set *scope* request parameter to
*‘application’*; - in order to create an unconfirmed segregated
``Virgil Card`` it enough just to set *scope* request parameter to
*‘application’*; - **data** parameter is a key-value storage that
contains application specific parameters; - **info** parameter is a
key-value storage with predefined keys that contain information about
the device on which the keypair was created; - **signs** parameter is
mandatory to authorize a Virgil Card creation by the Virgil Card
key-pair itself and by the application; - **signs** parameter must
contain exactly two items with predefined structure. The
**signed\_digest** is calculated as base64\_encode(SIGN(FINGERPRINT,
APPLICATION\_PRIVATE\_KEY \| VIRGIL\_CARD\_PRIVATE\_KEY)); -
**is\_confirmed** parameter set to *true*

.. _Virgil Card: #virgil-card
.. _POST /virgil-card: #post-virgil-card
.. _GET /virgil-card/{virgil-card-id}: #get-virgil-cardvirgil-card-id
.. _POST /virgil-card/actions/search: #post-virgil-cardactionssearch
.. _DELETE /virgil-card/{virgil-card-id}: #delete-virgil-cardvirgil-card-id
.. _Appendix A. Response codes: #appendix-a-response-codes
.. _Appendix B. Access token: #appendix-b-access-token
.. _Appendix C. Request sign: #appendix-c-request-sign
.. _Appendix D. Response sign: #appendix-d-response-sign
.. _uuid: https://en.wikipedia.org/wiki/Universally_unique_identifier
