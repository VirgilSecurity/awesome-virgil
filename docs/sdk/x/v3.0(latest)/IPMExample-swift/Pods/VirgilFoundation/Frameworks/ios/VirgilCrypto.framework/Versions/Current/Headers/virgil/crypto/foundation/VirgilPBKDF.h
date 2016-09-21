/**
 * Copyright (C) 2016 Virgil Security Inc.
 *
 * Lead Maintainer: Virgil Security Inc. <support@virgilsecurity.com>
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 *     (1) Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *
 *     (2) Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *
 *     (3) Neither the name of the copyright holder nor the names of its
 *     contributors may be used to endorse or promote products derived from
 *     this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ''AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef VIRGIL_CRYPTO_PBKDF_H
#define VIRGIL_CRYPTO_PBKDF_H

#include <string>

#include <virgil/crypto/VirgilByteArray.h>
#include <virgil/crypto/foundation/asn1/VirgilAsn1Compatible.h>

namespace virgil { namespace crypto { namespace foundation {

/**
 * @name Forward declarations
 */
///@{
class VirgilPBKDFImpl;
///@}

/**
 * @brief Provides password based key derivation function.
 */
class VirgilPBKDF : public virgil::crypto::foundation::asn1::VirgilAsn1Compatible {
public:
    /**
     * @property kIterationCount_Default
     * @brief Default iteration count.
     */
    static const unsigned int kIterationCount_Default = 2048;
public:
    /**
     * @brief Defines specific password based key derivation function algorithm
     */
    typedef enum {
        Algorithm_None = 0, ///< No algorithm defined
        Algorithm_PBKDF2    ///< Defines PBKDF2 algorithm (https://www.ietf.org/rfc/rfc2898.txt)
    } Algorithm;
    /**
     * @brief Defines specific underlying hash algorithm for the password based key derivation function algorithm
     * @note Start numbering from 1, 0 is reserved.
     */
    typedef enum {
        Hash_SHA1 = 1, ///< Defines SHA1 hash algorithm
        Hash_SHA224,   ///< Defines SHA-224 hash algorithm
        Hash_SHA256,   ///< Defines SHA-256 hash algorithm
        Hash_SHA384,   ///< Defines SHA-384 hash algorithm
        Hash_SHA512    ///< Defines SHA-512 hash algorithm
    } Hash;

    /**
     * @name Constructor / Destructor
     */
    ///@{
    /**
     * @brief Create object with undefined algorithms.
     * @warning SHOULD be used in conjunction with VirgilAsn1Compatible interface,
     *     i.e. VirgilPBKDF pbkdf = VirgilPBKDF().fromAsn1(asn1);
     */
    VirgilPBKDF();

    /**
     * @brief Create object with default algorithm.
     *
     * @param salt - salt to use when generating key, the best practice is to pass random value.
     * @param iterationCount - iteration count, the best practice is to pass random value.
     */
    VirgilPBKDF(const virgil::crypto::VirgilByteArray& salt, unsigned int iterationCount = kIterationCount_Default);

    /**
     * @brief Polymorphic destructor.
     */
    virtual ~VirgilPBKDF() throw();
    ///@}
    /**
     * @brief
     */
    /**
     * @name Configuration / Info
     * @brief Provide methods that allow precise algorithm configuration and get information about it.
     */
    ///@{
    /**
     * @brief Return salt.
     */
    VirgilByteArray getSalt() const;

    /**
     * @brief Return iteration count.
     */
    unsigned int getIterationCount() const;

    /**
     * @brief Set specific algorithm of the password based key derivation function.
     */
    void setAlgorithm(VirgilPBKDF::Algorithm alg);

    /**
     * @brief Return current algorithm of the password based key derivation function.
     */
    VirgilPBKDF::Algorithm getAlgorithm() const;

    /**
     * @brief Set underlying digest algorithm.
     */
    void setHash(Hash hash);

    /**
     * @brief Returns underlying digest algorithm.
     */
    VirgilPBKDF::Hash getHash() const;

    /**
     * @brief Involve security check for used parameters.
     * @note Enabled by default.
     */
    void enableRecommendationsCheck();

    /**
     * @brief Ignore security check for used parameters.
     * @warning It's strongly recommended do not disable recommendations check.
     */
    void disableRecommendationsCheck();
    ///@}
    /**
     * @name Process password based key derivation
     */
    ///@{
    /**
     * @brief Derive key from the given key material.
     *
     * @param pwd - password to use when generating key.
     * @param outSize - size of the output sequence, if 0 - then size of the underlying hash will be used.
     * @return Output sequence.
     */
    virgil::crypto::VirgilByteArray derive(const virgil::crypto::VirgilByteArray& pwd, size_t outSize = 0);
    ///@}
    /**
     * @name VirgilAsn1Compatible implementation
     * @code
     * Marshalling format:
     *     KeyDerivationFunction ::= AlgorithmIdentifier {{ PBKDFAlgorithms }}
     *     PBKDFAlgorithms AlgorithmIdentifier ::= {
     *         { OID id-PBKDF2 PARMS BKDF2-params },
     *         ... -- additional algorithms ---
     *     }
     *
     *     PBKDF2-params ::= SEQUENCE {
     *         salt CHOICE {
     *             specified OCTET STRING,
     *             otherSource AlgorithmIdentifier {{PBKDF2-SaltSources}}
     *         },
     *         iterationCount INTEGER (1..MAX),
     *         keyLength INTEGER (1..MAX) OPTIONAL,
     *         prf AlgorithmIdentifier {{PBKDF2-PRFs}} DEFAULT
     *         algid-hmacWithSHA1
     *      }
     * @endcode
     */
    ///@{
    virtual size_t asn1Write(
            virgil::crypto::foundation::asn1::VirgilAsn1Writer& asn1Writer,
            size_t childWrittenBytes = 0) const;

    virtual void asn1Read(virgil::crypto::foundation::asn1::VirgilAsn1Reader& asn1Reader);
    ///@}
private:
    /**
     * @brief If internal state is not initialized with specific algorithm exception will be thrown.
     */
    void checkState() const;

    /**
     * @brief If security recommendations is not satisfied exception will be thrown.
     */
    void checkRecommendations(const VirgilByteArray& pwd) const;

private:
    VirgilPBKDF::Algorithm algorithm_;
    VirgilPBKDF::Hash hash_;
    VirgilByteArray salt_;
    unsigned int iterationCount_;
    unsigned int iterationCountMin_;
    bool checkRecommendations_;
};

}}}

#endif /* VIRGIL_CRYPTO_PBKDF_H */
