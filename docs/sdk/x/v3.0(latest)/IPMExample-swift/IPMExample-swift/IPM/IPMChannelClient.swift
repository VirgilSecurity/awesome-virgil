//
//  IPMChannelClient.swift
//  IPMExample-swift
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

import Foundation

class IPMChannelClient: NSObject {
    
    private(set) var userId: String
    private(set) var channel: IPMDataSource! = nil
    
    private var session: NSURLSession
    
    init(userId: String) {
        self.userId = userId
        self.session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
        super.init()
    }
    
    func joinChannel(name: String, listener: IPMDataSourceListener) -> NSError? {
        let urlString = "\(kBaseURL)/channels/\(name)/join"
        if let url = NSURL(string: urlString) {
            let dto = [kSenderIdentifier: self.userId]
            let httpBody = try? NSJSONSerialization.dataWithJSONObject(dto, options: NSJSONWritingOptions(rawValue: 0))
            
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = httpBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let async = XAsyncTask(action: { (weakTask) in
                let task = self.session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                    if error != nil {
                        weakTask?.result = error
                        weakTask?.fireSignal()
                        return
                    }
                    
                    let r = response as! NSHTTPURLResponse
                    if r.statusCode >= 400 {
                        let httpError = NSError(domain: "HTTPError", code: r.statusCode, userInfo: [ NSLocalizedDescriptionKey: NSLocalizedString(NSHTTPURLResponse.localizedStringForStatusCode(r.statusCode), comment: "No comments") ])
                        weakTask?.result = httpError
                        weakTask?.fireSignal()
                        return
                    }
                    
                    if data == nil {
                        weakTask?.result = NSError(domain: "JoinChannelError", code: -5767, userInfo: nil)
                        weakTask?.fireSignal()
                        return
                    }
                    
                    let dto = try? NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    if dto == nil {
                        weakTask?.result = NSError(domain: "JoinChannelError", code: -4534, userInfo: nil)
                        weakTask?.fireSignal()
                        return
                    }
                    
                    if let token = dto![kIdentityToken] as? String {
                        self.channel = IPMChannel(name: name, token: token)
                        self.channel.startListeningWithHandler(listener)
                        weakTask?.result = nil
                        weakTask?.fireSignal()
                        return
                    }
                    
                    weakTask?.result = NSError(domain: "JoinChannelError", code: -3436, userInfo: nil)
                    weakTask?.fireSignal()
                })
                task.resume()
            })
            async.awaitSignal()
            return async.error()
        }
        return NSError(domain: "JoinChannelError", code: -4545, userInfo: nil)
    }
    
    func leaveChannel() {
        self.channel.stopListening()
        self.channel = nil
    }
}