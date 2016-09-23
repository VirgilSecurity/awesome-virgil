====================================
Virgil Entities - Validation Token
====================================

.. glossary::

	**Validation Token**

		A validation token is used to prevent unauthorized cards registration. The validation token is generated based on Application's Private Key and client Identity. The global ValidationToken is used for creating global Cards. The global ValidationToken can be obtained only by checking the ownership of the Identity on Virgil Identity Service. The private ValidationToken is used for creating Private Cards. The private ValidationToken can be generated on developer’s side using his own service for verification instead of Virgil Identity Service or avoids verification at all. In this case validation token is generated using app’s Private Key created on our Developer portal.