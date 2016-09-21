//
//  IPMSecurityManager.swift
//  IPMExample-swift
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

import UIKit

class IPMSecurityManager: NSObject {
    
    private(set) var identity: String
    private(set) var privateKey: VSSPrivateKey! = nil
    
    private var cardCache: NSMutableDictionary
    private var client: VSSClient

    private var clientSetUp: Bool
    private var mutex: NSObject
    
    init(identity: String) {
        self.identity = identity
        
        self.cardCache = NSMutableDictionary()
        self.client = VSSClient(applicationToken: kAppToken)
        
        self.clientSetUp = false
        self.mutex = NSObject()
        
        super.init()
    }
    
    func cacheCardsForIdentities(identities: Array<String>) {
        let async = XAsyncTask { (weakTask) in
            var itemsCount = identities.count
            for identity in identities {
                if synchronized(self.mutex, closure: { () -> VSSCard? in
                    return self.cardCache[identity] as? VSSCard
                }) != nil {
                    itemsCount -= 1;
                    if itemsCount == 0 {
                        weakTask?.fireSignal()
                        return
                    }
                    continue
                }
                
                self.client.searchCardWithIdentityValue(identity, type: kIPMExampleCardType, unauthorized: false, completionHandler: { (cards, error) in
                    if error != nil {
                        print("Error searching for card: \(error!.localizedDescription)")
                    }
                    else {
                        if let candidates = cards where candidates.count > 0 {
                            synchronized(self.mutex) {
                                self.cardCache[identity] = candidates[0]
                            }
                        }
                    }
                    
                    itemsCount -= 1;
                    if itemsCount == 0 {
                        weakTask?.fireSignal()
                        return
                    }
                })
            }
        }
        async.awaitSignal()
    }
    
    func checkSignature(signature: NSData, data: NSData, identity: String) -> Bool {
        self.cacheCardsForIdentities([identity])
        let task = XAsyncTask { (weakTask) in
            if let sender = synchronized(self.mutex, closure: {() -> VSSCard? in
                self.cardCache[identity] as? VSSCard
            }) {
                let verifier = VSSSigner()
                do {
                    try verifier.verifySignature(signature, data: data, publicKey: sender.publicKey.key, error: ())
                    weakTask?.result = true
                }
                catch {
                    weakTask?.result = false
                }
            }
        }
        task.await()
        if let ok = task.result as? Bool {
            return ok
        }
        
        return false
    }
    
    func encryptData(data: NSData, identities: Array<String>) -> NSData? {
        self.cacheCardsForIdentities(identities)
        
        let task = XAsyncTask { (weakTask) in
            let cryptor = VSSCryptor()
            for identity in identities {
                if let recipient = synchronized(self.mutex, closure: {() -> VSSCard? in
                    self.cardCache[identity] as? VSSCard
                }) {
                    do {
                        try cryptor.addKeyRecipient(recipient.Id, publicKey: recipient.publicKey.key, error: ())
                    }
                    catch {}
                }
            }
            
            weakTask?.result = try? cryptor.encryptData(data, embedContentInfo: true, error: ())
        }
        task.await()
        return task.result as? NSData
    }
    
    func decryptData(data: NSData) -> NSData? {
        self.cacheCardsForIdentities([self.identity])
        
        let task = XAsyncTask { (weakTask) in
            if let recipient = synchronized(self.mutex, closure: { () -> VSSCard? in
                return self.cardCache[self.identity] as? VSSCard
            }) {
                let decryptor = VSSCryptor()
                weakTask?.result = try? decryptor.decryptData(data, recipientId: recipient.Id, privateKey: self.privateKey.key, keyPassword: self.privateKey.password, error: ())
            }
        }
        task.await()
        return task.result as? NSData
    }
    
    func composeSignatureOnData(data: NSData) -> NSData? {
        let task = XAsyncTask { (weakTask) in
            let signer = VSSSigner()
            weakTask?.result = try? signer.signData(data, privateKey: self.privateKey.key, keyPassword: self.privateKey.password, error: ())
        }
        task.await()
        return task.result as? NSData
    }
    
    
    func signin() -> NSError? {
        let async = XAsyncTask { (weakTask) in
            self.cacheCardsForIdentities([self.identity])
            if synchronized(self.mutex, closure: { () -> VSSCard? in
                return self.cardCache[self.identity] as? VSSCard
            }) != nil {
                let pkStorage = VSSKeychainValue(id: kPrivateKeyStorage, accessGroup: nil)
                self.privateKey = pkStorage.objectForKey(self.identity) as? VSSPrivateKey
                if self.privateKey == nil {
                    print("Private key should be present.")
                    weakTask?.result = NSError(domain: "SignInError", code: -6660, userInfo: nil)
                    assert(true)
                }
            }
            else {
                weakTask?.result = NSError(domain: "SignInError", code: -5555, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("No cards found for given identity", comment: "")])
            }
        }
        async.await()
        return async.error()
    }
    
    func signup() -> NSError? {
        let async = XAsyncTask { (weakTask) in
            let pair = VSSKeyPair(password: nil)
            self.privateKey = VSSPrivateKey(key: pair.privateKey(), password: nil)
            let appKey = VSSPrivateKey(key: kAppPrivateKey.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, password: kAppPrivateKeyPassword)
            let info = VSSIdentityInfo(type: kIPMExampleCardType, value: self.identity, validationToken: nil)
            VSSValidationTokenGenerator.setValidationTokenForIdentityInfo(info, privateKey: appKey, error: nil)
            self.client.createCardWithPublicKey(pair.publicKey(), identityInfo: info, data: nil, privateKey: self.privateKey, completionHandler: { (card, error) in
                if error != nil || card == nil {
                    weakTask?.result = error
                    weakTask?.fireSignal()
                    return
                }
                
                synchronized(self.mutex) {
                    self.cardCache[self.identity] = card!
                }
                
                let pkStorage = VSSKeychainValue(id: kPrivateKeyStorage, accessGroup: nil)
                pkStorage.setObject(self.privateKey, forKey: self.identity)
                
                weakTask?.result = nil
                weakTask?.fireSignal()
            })
        }
        async.awaitSignal()
        return async.error()
    }
}
