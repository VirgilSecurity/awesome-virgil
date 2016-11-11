:orphan:

virgil-card-create
==============

SYNOPSIS
--------
::

  virgil card-create -k <file> [-p <arg>] -s <arg> -t <arg> -d <arg> [--data <arg>] [--info <arg>] [-o <file>] [-V] [--]
  
  virgil card-create (-h | --help)

  virgil card-create --version  
                              

DESCRIPTION 
-----------

:program:`virgil card-create` creates a :term:`Virgil Card <Virgil Card>` entity. 


OPTIONS 
-------

**Basic**

.. option:: -k <file>; --private-key <file>
    :term:`Private Key <Private Key>`
    
.. option:: -p <arg>; --private-key-password <file>
    The Private Key password (if exists).
    
.. option:: -s <arg>; --scope <arg>
    The scope must be ``global`` for :term:`global Virgil Cards <Global Virgil Card>` or ``application`` for :term:`application Virgil Cards <Application Virgil Card>`.

.. option:: -t <arg>; --identity-type <arg>
    
    * for :term:`confirmed Virgil Card <Confirmed Virgil Card>` the :term:`identity-type <identity-type>` must be 'email';
    
    * for :term:`segregated Virgil Card <Segregated Virgil Card>` the identity-type can be any value.

.. option:: -d <arg>; --identity <arg>

    * for confirmed Virgil Card the :term:`identity <identity>` must be a valid email;
    
    * for segregated Virgil Card the identity can be any value.

.. option:: --data <arg>
    The :term:`data <data>` contains application specific parameters.
    
.. option:: --info <arg>
    The :term:`info <info>` contain information about the device on which the keypair was created. Format: [device_name]:<value> [device]:<value>. Both 'device_name' and 'device' must be used.
    
.. option:: -o <file>; --out <file>
    The Virgil Card. If omitted, stdout is used.

.. option:: -V; --VERBOSE
   Shows the detailed information.

.. option:: --; --ignore_rest
   Ignores the rest of the labeled arguments following this flag.


**Common**

.. option:: -h,  --help
    Displays usage information and exits.

.. option:: --version
    Displays version information and exits.


EXAMPLES 
--------





SEE ALSO 
--------

:cliref:`cli-virgil`
:cliref:`cli-config`
:cliref:`cli-keygen`
