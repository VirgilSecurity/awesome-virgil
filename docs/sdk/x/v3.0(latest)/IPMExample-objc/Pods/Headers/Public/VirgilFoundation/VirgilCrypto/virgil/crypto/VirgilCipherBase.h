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

#ifndef VIRGIL_CIPHER_BASE_H
#define VIRGIL_CIPHER_BASE_H

#include <map>
#include <set>

#include <virgil/crypto/VirgilByteArray.h>
#include <virgil/crypto/VirgilCustomParams.h>

/**
 * @name Forward declaration
 */
/// @{
namespace virgil { namespace crypto {
class VirgilCipherBaseImpl;
}}

namespace virgil { namespace crypto { namespace foundation {
class VirgilSymmetricCipher;
}}}
/// @}

namespace virgil { namespace crypto {

/**
 * @brief This class provides configuration methods to all Virgil*Cipher classes.
 */
class VirgilCipherBase {
public:
    /**
     * @brief Initialize randomization module used by encryption.
     */
    VirgilCipherBase();

    /**
     * @brief Dispose used resources.
     */
    virtual ~VirgilCipherBase() throw();

public:
    /**
     * @name Recipent management
     */
    ///@{
    /**
     * @brief Add recipient defined with id and public key.
     */
    void addKeyRecipient(const VirgilByteArray& recipientId, const VirgilByteArray& publicKey);

    /**
     * @brief Remove recipient with given id.
     * @note If recipient with given id is absent - do nothing.
     */
    void removeKeyRecipient(const VirgilByteArray& recipientId);

    /**
     * @brief Check whether recipient with given identifier exists.
     *
     * Search order:
     *     1. Local structures - useful when cipher is used for encryption.
     *     2. ContentInfo structure - useful when cipher is used for decryption.
     *
     * @param recipientId - recipient's unique identifier.
     * @return true if recipient with given identifier exists, false - otherwise.
     */
    bool keyRecipientExists(const VirgilByteArray& recipientId) const;

    /**
     * @brief Add recipient defined with password.
     */
    void addPasswordRecipient(const VirgilByteArray& pwd);

    /**
     * @brief Remove recipient with given password.
     * @note If recipient with given password is absent - do nothing.
     */
    void removePasswordRecipient(const VirgilByteArray& pwd);

    /**
     * @brief Remove all recipients.
     */
    void removeAllRecipients();
    ///@}
    /**
     * @name Content Info Access / Management
     *
     * Content info is a structure that contains all necessary information
     *     for future decription in secure form.
     */
    ///@{
    /**
     * @brief Returns encrypted data info.
     */
    /**
     * @brief Return content info.
     * @note Call this method after encryption process.
     */
    VirgilByteArray getContentInfo() const;

    /**
     * @brief Create content info object from ASN.1 structure.
     * @note Call this method before decryption process.
     */
    void setContentInfo(const VirgilByteArray& contentInfo);

    /**
     * @brief Read content info size as part of the data.
     * @return Size of the content info if it is exist as part of the data, 0 - otherwise.
     */
    static size_t defineContentInfoSize(const VirgilByteArray& data);
    /**
     * @brief Provide access to the object that handles custom parameters.
     * @note Use this method to add custom parameters to the content info object.
     * @note Use this method before encryption process.
     */
    ///@}
    /**
     * @name Custom parameters Access / Management
     *
     * Custom parameters is a structure that contains additional user defined information
     *     about encrypted data.
     * @note This information is stored as part of the content info in unencrypted format.
     */
    ///@{
    VirgilCustomParams& customParams();

    /**
     * @brief Provide readonly access to the object that handles custom parameters.
     * @note Use this method to read custom parameters from the content info object.
     */
    const VirgilCustomParams& customParams() const;
    ///@}
    /**
     * @name Helpers to create shared key with Diffie–Hellman algorithms
     */
    ///@{
    /**
     * @brief Compute shared secret key on a given keys
     *
     * @param publicKey - alice public key.
     * @param privateKey - bob private key.
     * @param privateKeyPassword - bob private key password.
     *
     * @throw VirgilCryptoException - if keys are invalid or keys are not compatible.
     *
     * @warning Keys SHOULD be of the identical type, i.e. both of type Curve25519.
     *
     * @see VirgilKeyPair::generate(const VirgilKeyPair&, const VirgilByteArray&, const VirgilByteArray&)
     */
    static VirgilByteArray computeShared(
            const VirgilByteArray& publicKey,
            const VirgilByteArray& privateKey, const VirgilByteArray& privateKeyPassword = VirgilByteArray());
    ///@}

protected:
    /**
     * @brief Make attempt to read content info from the encrypted data.
     *
     * Payload content info if was detected in the encrypted data.
     *
     * @param encryptedData - data that was encrypted.
     * return Encrypted data without content info.
     */
    VirgilByteArray tryReadContentInfo(const VirgilByteArray& encryptedData);

    /**
     * @brief Configures symmetric cipher for encryption.
     * @return Configured cipher.
     * @note cipher's key randomly generated.
     * @note cipher's input vector is randomly generated.
     */
    virgil::crypto::foundation::VirgilSymmetricCipher& initEncryption();
    /**
     * @brief Configures symmetric cipher for encryption.
     */
    /**
     * @brief Configures symmetric cipher for decryption.
     * @param encryptedDataInfo - serialized encrypted data info.
     * @param recipientId - id that corresponds to the user's private key.
     * @param privateKey - user's private key.
     * @param privateKeyPassword - user's private key password.
     * @return Configured cipher.
     */
    virgil::crypto::foundation::VirgilSymmetricCipher& initDecryption(
            const VirgilByteArray& encryptedDataInfo,
            const VirgilByteArray& recipientId, const VirgilByteArray& privateKey,
            const VirgilByteArray& privateKeyPassword = VirgilByteArray());

    /**
     * @brief Configures symmetric cipher for decryption based on the recipient's password.
     * @param pwd - recipient's password.
     * @return Configured cipher.
     */
    virgil::crypto::foundation::VirgilSymmetricCipher& initDecryptionWithPassword(const VirgilByteArray& pwd);

    /**
     * @brief Configures symmetric cipher for decryption based on the recipient's id and private key.
     * @param recipientId - recipient's id.
     * @param privateKey - recipient's private key.
     * @param privateKeyPassword - recipient's private key password.
     * @return Configured cipher.
     */
    virgil::crypto::foundation::VirgilSymmetricCipher& initDecryptionWithKey(
            const VirgilByteArray& recipientId,
            const VirgilByteArray& privateKey, const VirgilByteArray& privateKeyPassword);

    /**
     * @brief Return symmetric cipher configure by one of the methods:
     *     initEncryption(), initDecryptionWithPassword(), initDecryptionWithKey.
     */
    virgil::crypto::foundation::VirgilSymmetricCipher& getSymmetricCipher();

    /**
     * @brief Build VirgilContentInfo object.
     *
     * This method SHOULD be called after encryption process is finished.
     * @note This method SHOULD be called after encryption process is finished.
     */
    void buildContentInfo();

    /**
     * @brief Clear all information related to the cipher.
     *
     * Clear symmetric cipher and correspond internal states.
     * @note This method SHOULD be called after encryption or decryption process is finished.
     * @note You CAN not use symmetric cipher returned by the method @link getSymmetricCipher () @endlink,
     *     after this method call.
     */
    void clearCipherInfo();

private:
    VirgilCipherBase(const VirgilCipherBase& other);

    VirgilCipherBase& operator=(const VirgilCipherBase& rhs);

private:
    VirgilCipherBaseImpl* impl_;
};

}}

#endif /* VIRGIL_CIPHER_BASE_H */
