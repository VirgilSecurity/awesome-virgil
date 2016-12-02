:orphan:

virgil-card-create
==================

.. program:: virgil-card-create


SYNOPSIS
--------

.. code:: bash

    virgil card-create [-o <file>] -k <file> [-p <arg>] [-s <arg>] [-t <arg>] -d <arg> [--data key:<value>] [--info device_name:<value> device:<value>] [-V...] [--]  
    virgil card-create (-h | --help)
    virgil card-create --version  
                              

DESCRIPTION 
-----------

    :program:`virgil card-create` creates a :term:`Virgil Card` entity. 


OPTIONS 
-------

.. option:: -o <file>, --out=<file>
    The Virgil Card. If omitted, stdout is used.

.. option:: -k <file>, --private-key=<file>
    :term:`Private Key`.
    
.. option:: -p <arg>, --private-key-password=<arg>
    The Private Key password (if exists).
    
.. option:: -s <global | application>, --scope=<global | application>
    * for :term:`global Virgil Card` the :term:`scope <scope>` must be ``global``;
    
    * for :term:`application Virgil Card` the scope must be ``application``;
    
    If omitted, ``application`` is used.

.. option:: -t <arg>, --identity-type=<arg>    
    * for :term:`confirmed Virgil Card` the :term:`identity-type` must be ``email``;
    
    * for :term:`segregated Virgil Card` the identity-type can be any value.
    
    If omitted, ``email`` is used.

.. option:: -d <arg>, --identity=<arg>

    * for confirmed Virgil Card the :term:`identity` must be a valid email;
    
    * for segregated Virgil Card the identity can be any value.

.. option:: --data=<arg>
    The :term:`data <data>` contains application specific parameters. Format: key:<value> (up to 16 positions).
    
.. option:: --info=<arg>
    The :term:`info <info>` contain information about the device on which the keypair was created. Format: device_name:<value> device:<value>. Both 'device_name' and 'device' must be used.
    
.. option:: -V, --VERBOSE
    Shows the detailed information.

.. option:: --
    Ignores the rest of the labeled arguments following this flag.

.. option:: -h,  --help
    Displays usage information and exits.

.. option:: --version
    Displays version information and exits.


EXAMPLES 
--------


Alice creates a confirmed Virgil Card for her application.

.. code:: bash

    virgil card-create -k private.key -d alice@mail.com -o AliceCard.vcard


SEE ALSO 
--------

:cli:ref:`virgil`
