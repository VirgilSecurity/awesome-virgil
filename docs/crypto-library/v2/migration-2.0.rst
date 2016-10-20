Migrating from Virgil Crypto 1.8 to Virgil Crypto 2.0
=====================================================

-  `Features <#features>`__
-  `X25519 and Ed25519 <#x25519-and-ed25519>`__
-  `New functions <#new-functions>`__
-  `Changes <#changes>`__
-  `Migration to C++11 <#migration-to-c++11>`__
-  `New error handling model <#new-error-handling-model>`__
-  `Named constructors gone <#named-constructors-gone>`__
-  `Unimplemented elliptic curves were dropped <#unimplemented-elliptic-curves-were-dropped>`__
-  `Dropped "Default" key pair type <#dropped-default-key-pair-type>`__
-  `VirgilChunkCipher class API was totally redesigned <#virgilchunkcipher-class-api-was-totally-redesigned>`__
-  `ContentInfo is embedded to the cryptogram by default <#contentinfo-is-embedded-to-the-cryptogram-by-default>`__
-  `Changes in binaries <#changes-in-binaries>`__

Features
--------

This section describes new features that were added in the version 2.0.

X25519 and Ed25519
~~~~~~~~~~~~~~~~~~

Fast elliptic curve algorithms were added:

-  Curve25519 - elliptic curve used for ECDH operations;
-  Ed25519 - elliptic curve used for EdDSA and ECDH operations.

Mentioned algorithms are accessible via
``VirgilKeyPair::Type::FAST_EC_X25519`` and
``VirgilKeyPair::Type::FAST_EC_ED25519`` enumeration values.

Algorithms implementation is based on
`SUPERCOP <http://bench.cr.yp.to/supercop.html>`__ reference
implementation, so it contains optimizations for AMD64 processor
architecture.

See also:

-  `Ed25519 and X25519 keys format <https://tools.ietf.org/html/draft-ietf-curdle-pkix-01>`__
-  `EdDSA <https://www.ietf.org/id/draft-irtf-cfrg-eddsa-08.txt>`__
-  `X25519 <https://tools.ietf.org/html/rfc7748>`__

New functions
~~~~~~~~~~~~~

``VirgilKeyPair::``

   -  ``encryptPrivateKey()`` - encrypt given private key and store it
      in the PKCS#8 format
   -  ``decryptPrivateKey()`` - decrypt given private key and store it
      in the corresponding plain private key format
   -  ``generateRecommended()`` - generate new key pair with recommended
      safest type
   -  ``extractPublicKey()`` - extract public key from the private key
   -  ``publicKeyToPEM()`` - convert given public key to the PEM format
   -  ``publicKeyToDER()`` - convert given public key to the DER format
   -  ``privateKeyToPEM()`` - convert given private key to the PEM
      format
   -  ``privateKeyToDER()`` - convert given private key to the DER
      format

Changes
-------

This section describes changes to the library API 2.0 that are not
compatible with API 1.8.

Migration to C++11
~~~~~~~~~~~~~~~~~~

1. Target compiler must be able to compile C++11 standard.
2. All enumerations were replaced with scoped enums.
3. Move semantic is used instead of 'shallow' copying.

New error handling model
~~~~~~~~~~~~~~~~~~~~~~~~

Now library produces only exceptions of type ``VirgilCryptoException``.
Produced exceptions can contain nested exceptions. To get all error
messages (including nested) function
``virgil::crypto::backtrace_exception()`` can be used.

Exception details are defined by specific error code and corresponding
error category.

Error categories are:

-  ``VirgilCryptoErrorCategory`` - category that handles generic error
   codes defined in enum ``VirgilCryptoError``;
-  ``VirgilSystemCryptoErrorCategory`` - category that handles error
   codes from the system crypto library (MbedTLS).

Named constructors gone
~~~~~~~~~~~~~~~~~~~~~~~

Named constructors such as ``VirgilHash::sha256()`` were replaced with
constructor that accepts corresponding enumeration value.

-  ``VirgilHash::sha256()`` with
   ``VirgilHash(VirgilHash::Algorithm::SHA256)``, and so on;
-  ``VirgilPBKDF::pbkdf2()`` with
   ``VirgilPBKDF(VirgilPBKDF::Algorithm::PBKDF2)``, and so on;
-  ``VirgilPBE::pkcs5()`` with
   ``VirgilPBE(VirgilPBE::Algorithm::PKCS5)``, and so on;
-  ``VirgilSymmetricCipher::aes256()`` with
   ``VirgilSymmetricCipher(VirgilSymmetricCipher::Algorithm::AES_256_GCM)``,
   and so on.

Unimplemented elliptic curves were dropped
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Dropped enumeration values that were represented as unimplemented
algorithms:

-  ``VirgilKeyPair::Type::EC_M221``
-  ``VirgilKeyPair::Type::EC_M255``
-  ``VirgilKeyPair::Type::EC_M383``
-  ``VirgilKeyPair::Type::EC_M511``

Dropped "Default" key pair type
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Enumeration value ``VirgilKeyPair::Type::Default`` was replaced with
function ``VirgilKeyPair::generateRecommended()``

VirgilChunkCipher class API was totally redesigned
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now ``VirgilChunkCipher`` class has the same interface as class
``VirgilStreamCipher``, but the main difference is the way data is
proceeded.

``VirgilChunkCipher`` treats each data portion as separate data to be
proceeded. So each encrypted data chunk contains encrypted data and
verification tag.

ContentInfo is embedded to the cryptogram by default
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Default value of 2nd parameter ``embedContentInfo`` of function
   ``VirgilCipher::encrypt()`` is now true by default.
2. Default value of 3rd parameter ``embedContentInfo`` of function
   ``VirgilStreamCipher::encrypt()`` is now true by default.

Changes in binaries
~~~~~~~~~~~~~~~~~~~

1. Change name for Apple frameworks: ``VirgilCrypto.framework`` to
   ``VSCCrypto.framework``.
2. Remove support of OS X universal binaries.
3. Dropped AS3 support.
