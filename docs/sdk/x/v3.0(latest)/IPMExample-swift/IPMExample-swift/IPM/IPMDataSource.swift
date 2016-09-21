//
//  IPMDataSource.swift
//  IPMExample-swift
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

import Foundation

typealias IPMDataSourceListener = (IPMSecureMessage, String) -> ()

protocol IPMDataSource {
    
    func startListeningWithHandler(handler: IPMDataSourceListener)
    func stopListening()

    func getParticipants() -> Array<String>
    func sendMessage(message: IPMSecureMessage) -> NSError?

}