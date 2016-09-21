//
//  IPMSecureMessage.swift
//  IPMExample-swift
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

import Foundation

class IPMSecureMessage: NSObject {
    
    private(set) var message: NSData
    private(set) var signature: NSData

    init(message: NSData, signature: NSData) {
        self.message = message
        self.signature = signature
        super.init()
    }
    
    func toDTO() -> NSDictionary {
        let dto = NSMutableDictionary()
        dto[kSMMessage] = self.message.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        dto[kSMSignature] = self.signature.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        return dto as NSDictionary
    }
    
    class func fromDTO(dto: NSDictionary) -> IPMSecureMessage? {
        if dto.count == 0 {
            return nil
        }
        
        if let msg64 = dto[kSMMessage] as? String,
            message = NSData.init(base64EncodedString: msg64, options: .IgnoreUnknownCharacters),
            sig64 = dto[kSMSignature] as? String,
            signature = NSData.init(base64EncodedString: sig64, options: .IgnoreUnknownCharacters) {
            
            return IPMSecureMessage(message: message, signature: signature)
        }

        return nil
    }
    
    func toJSON() -> NSData {
        let dto = self.toDTO()
        if let data = try? NSJSONSerialization.dataWithJSONObject(dto, options: NSJSONWritingOptions(rawValue: 0)) {
            return data
        }
        
        return NSData()
    }
    
    class func fromJSON(json: NSData) -> IPMSecureMessage? {
        if let dto = (try? NSJSONSerialization.JSONObjectWithData(json, options: .AllowFragments)) as? NSDictionary {
            return IPMSecureMessage.fromDTO(dto)
        }
        
        return nil
    }
    
}