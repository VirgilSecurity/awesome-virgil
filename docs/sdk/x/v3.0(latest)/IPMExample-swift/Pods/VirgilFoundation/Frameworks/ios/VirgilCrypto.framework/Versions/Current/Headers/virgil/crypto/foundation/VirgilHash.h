/**
 * Copyright (C) 2015 Virgil Security Inc.
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

#ifndef VIRGIL_CRYPTO_HASH_H
#define VIRGIL_CRYPTO_HASH_H

#include <string>

#include <virgil/crypto/VirgilByteArray.h>
#include <virgil/crypto/foundation/asn1/VirgilAsn1Compatible.h>

namespace virgil { namespace crypto { namespace foundation {

/**
 * @name Forward declarations
 */
///@{
class VirgilHashImpl;
///@}

/**
 * @brief Provides hashing (message digest) algorithms.
 */
class VirgilHash : public virgil::crypto::foundation::asn1::VirgilAsn1Compatible {
public:
    /**
     * @name Creation methods
     * @brief Object creation with specific hash function.
     */
    ///@{
    static VirgilHash md5();

    static VirgilHash sha256();

    static VirgilHash sha384();

    static VirgilHash sha512();

    static VirgilHash withName(const virgil::crypto::VirgilByteArray& name);
    ///@}
    /**
     * @name Constructor / Destructor
     */
    ///@{
    /**
     * @brief Create object with undefined algorithm.
     * @warning SHOULD be used in conjunction with VirgilAsn1Compatible interface,
     *     i.e. VirgilHash hash = VirgilHash().fromAsn1(asn1);
     */
    VirgilHash();

    /**
     * @brief Polymorphic destructor.
     */
    virtual ~VirgilHash() throw();
    ///@}
    /**
     * @brief
     */
    /**
     * @name Info
     * @brief Provide detail information about object.
     */
    ///@{
    /**
     * @brief Returns name of the hash function.
     * @return Name of the hash function.
     */
    std::string name() const;

    /**
     * @brief Return underlying hash type
     * @note Used for internal purposes only
     */
    int type() const;
    ///@}

    /**
     * @name Immediate Hashing
     * @brief This methods can be used to get the message hash immediately.
     */
    ///@{
    /**
     * @brief Produce hash.
     *
     * Process the given message immediately and return it's hash.
     *
     * @param bytes - message to be hashed.
     * @return Hash of the given message.
     */
    virgil::crypto::VirgilByteArray hash(const virgil::crypto::VirgilByteArray& bytes) const;
    ///@}

    /**
     * @name Chain Hashing
     *
     * @brief This methods provide mechanism to hash long message,
     *     that can be splitted to a shorter chunks and be processed separately.
     */
    ///@{
    /**
     * @brief Initialize hashing for the new message hash.
     */
    void start();

    /**
     * @brief Update / process message hash.
     *
     * This method MUST be used after @link start() @endlink method only.
     * This method MAY be called multiple times to process long message splitted to a shorter chunks.
     *
     * @param bytes - message to be hashed.
     * @see @link start() @endlink
     */
    void update(const virgil::crypto::VirgilByteArray& bytes);

    /**
     * @brief Return final message hash.
     * @return Message hash processed by series of @link update() @endlink method.
     * @see @link start() @endlink
     * @see @link update() @endlink
     */
    virgil::crypto::VirgilByteArray finish();
    ///@}

    /**
     * @name HMAC Immediate Hashing
     * @brief This methods can be used to get the message HMAC hash immediately.
     */
    ///@{
    /**
     * @brief Produce HMAC hash.
     *
     * Process the given message immediately and return it's HMAC hash.
     *
     * @param key - secret key.
     * @param bytes - message to be hashed.
     * @return HMAC hash of the given message.
     */
    virgil::crypto::VirgilByteArray hmac(
            const virgil::crypto::VirgilByteArray& key,
            const virgil::crypto::VirgilByteArray& bytes) const;
    ///@}

    /**
     * @name HMAC Chain Hashing
     *
     * @brief This methods provide mechanism to get HMAC hash of the long message,
     *     that can be splitted to a shorter chunks and be processed separately.
     */
    ///@{
    /**
     * @brief Initialize HMAC hashing for the new message hash.
     * @param key - secret key.
     */
    void hmacStart(const virgil::crypto::VirgilByteArray& key);

    /**
     * @brief Reset HMAC hashing for the new message hash.
     */
    void hmacReset();

    /**
     * @brief Update / process message HMAC hash.
     *
     * This method MUST be used after @link hmacStart() @endlink or @link hmacReset() @endlink methods only.
     * This method MAY be called multiple times to process long message splitted to a shorter chunks.
     *
     * @param bytes - message to be hashed.
     * @see @link hmacStart() @endlink
     * @see @link hmacReset() @endlink
     */
    void hmacUpdate(const virgil::crypto::VirgilByteArray& bytes);

    /**
     * @brief Return final message HMAC hash.
     * @return Message HMAC hash processed by series of @link hmacUpdate() @endlink method.
     * @see @link hmacStart() @endlink
     * @see @link hmacReset() @endlink
     * @see @link hmacUpdate() @endlink
     */
    virgil::crypto::VirgilByteArray hmacFinish();
    ///@}
    /**
     * @name Copy constructor / assignment operator
     * @warning Copy constructor and assignment operator create copy of the object as it was created
     *          by on of the creation methods. All changes in the internal state,
     *          that was made after creation, are not copied!
     */
    ///@{
    VirgilHash(const VirgilHash& other);

    VirgilHash& operator=(const VirgilHash& rhs);
    ///@}
    /**
     * @name VirgilAsn1Compatible implementation
     */
    ///@{
    virtual size_t asn1Write(
            virgil::crypto::foundation::asn1::VirgilAsn1Writer& asn1Writer,
            size_t childWrittenBytes = 0) const;

    virtual void asn1Read(virgil::crypto::foundation::asn1::VirgilAsn1Reader& asn1Reader);
    ///@}
private:
    explicit VirgilHash(int type);

    explicit VirgilHash(const char* name);

    void checkState() const;

private:
    VirgilHashImpl* impl_;
};

}}}

#endif /* VIRGIL_CRYPTO_HASH_H */
