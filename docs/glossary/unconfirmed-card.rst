======================================
Virgil Entities - Unconfirmed Card
======================================

.. glossary::

	**Unconfirmed Card**

		A **Virgil Card** which hasn't passed verify and confirm actions by **Identity service**.	

In order to create an unconfirmed segregated **Virgil Card** it is enough to set ``scope`` request parameter to **application** and pass valid application sign item in signs list.

``identity_type`` parameter of **Virgil Card** is any value except **email**