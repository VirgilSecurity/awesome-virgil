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

#ifndef VIRGIL_CHUNK_CIPHER_H
#define VIRGIL_CHUNK_CIPHER_H

#include <cstddef>

#include <virgil/crypto/VirgilCipherBase.h>
#include <virgil/crypto/VirgilByteArray.h>

namespace virgil { namespace crypto {

/**
 * @brief This class provides high-level interface to encrypt / decrypt data splitted to chunks.
 * @note Virgil Security keys is used for encryption and decryption.
 * @note This class algorithms are not compatible with VirgilCipher and VirgilStreamCipher class algorithms.
 */
class VirgilChunkCipher : public VirgilCipherBase {
public:
    /**
     * @name Constants
     */
    ///@{
    enum {
        kPreferredChunkSize = 1024 * 1024 - 1 ///< 1MiB - 1b for padding
    };
    ///@}
public:
    /**
     * @brief Initialize data chunk encryption with given chunk size.
     * @return Actual chunk size.
     */
    size_t startEncryption(size_t preferredChunkSize = kPreferredChunkSize);

    /**
     * @brief Initialize multipart decryption with given private key.
     * @return Actual chunk size.
     */
    size_t startDecryptionWithKey(
            const VirgilByteArray& recipientId, const VirgilByteArray& privateKey,
            const VirgilByteArray& privateKeyPassword = VirgilByteArray());

    /**
     * @brief Initialize multipart decryption with given private key.
     * @return Actual chunk size.
     */
    size_t startDecryptionWithPassword(const VirgilByteArray& pwd);

    /**
     * @brief Encrypt / Decrypt given data chunk.
     * @return Encrypted / Decrypted data chunk.
     */
    VirgilByteArray process(const VirgilByteArray& data);

    /**
     * @brief Finalize encryption or decryption process.
     * @note Call this method after encryption or decryption are done to prevent security issues.
     */
    void finish();

    /**
     * @brief Polymorphic destructor.
     */
    virtual ~VirgilChunkCipher() throw();

private:
    /**
     * @brief Store actual chunk size in the custom parameters.
     */
    void storeChunkSize(size_t chunkSize);

    /**
     * @brief Retrieve actual chunk size from the custom parameters.
     */
    size_t retrieveChunkSize() const;
};

}}

#endif /* VIRGIL_CHUNK_CIPHER_H */
