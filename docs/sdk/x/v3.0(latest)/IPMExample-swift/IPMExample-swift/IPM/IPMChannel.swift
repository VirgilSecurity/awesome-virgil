//
//  IPMChannel.swift
//  IPMExample-swift
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

import Foundation

class IPMChannel: NSObject, IPMDataSource {

    private(set) var name: String
    private var token: String
    
    private var listener: IPMDataSourceListener! = nil
    private var timer: dispatch_source_t! = nil
    private var lastMessageId: String! = nil
    
    private var session: NSURLSession

    init(name: String, token: String) {
        self.name = name
        self.token = token
        self.session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
        super.init()
    }
    
    deinit {
        self.stopListening()
    }
    
    func startListeningWithHandler(handler: IPMDataSourceListener) {
        self.stopListening()
        
        self.listener = handler
        self.startTimer()
    }
    
    func stopListening() {
        self.stopTimer()
        self.listener = nil
    }
    
    func getParticipants() -> Array<String> {
        let urlString = "\(kBaseURL)/channels/\(self.name)/members"
        if let url = NSURL(string: urlString) {
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "GET"
            request.setValue(self.token, forHTTPHeaderField: kIdentityTokenHeader)
            
            let async = XAsyncTask(action: { (weakTask) in
                var members = Array<String>()
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
                    
                    if data?.length == 0 {
                        weakTask?.result = nil
                        weakTask?.fireSignal()
                        return
                    }
                    
                    do {
                        if let participants = (try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as? Array<Dictionary<String, String>> {
                            for participant in participants {
                                let sender = participant[kSenderIdentifier]
                                if sender != nil {
                                    members.append(sender!)
                                }
                            }
                        }
                        else { throw NSError(domain: "GetParticipantsError", code: -8989, userInfo: nil) }
                    }
                    catch let err as NSError {
                        weakTask?.result = err
                        weakTask?.fireSignal()
                        return
                    }
                    weakTask?.result = members
                    weakTask?.fireSignal()
                })
                task.resume()
            })
            async.awaitSignal()
            if let participants = async.result as? Array<String> {
                return participants
            }
        }
        return Array<String>()
    }
    
    func sendMessage(message: IPMSecureMessage) -> NSError? {
        let urlString = "\(kBaseURL)/channels/\(self.name)/messages"
        if let url = NSURL(string: urlString) {
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = message.toJSON()
            request.setValue(self.token, forHTTPHeaderField: kIdentityTokenHeader)
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
                    
                    weakTask?.result = nil
                    weakTask?.fireSignal()
                })
                task.resume()
            })
            async.awaitSignal()
            return async.error()
        }
        
        return NSError(domain: "ParticipantsError", code: -7676, userInfo: nil)
    }
    
    func startTimer() {
        self.stopTimer()
        
        if let t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            dispatch_source_set_timer(t, DISPATCH_TIME_NOW, kTimerInterval * NSEC_PER_SEC, NSEC_PER_SEC)
            dispatch_source_set_event_handler(t) {
                let query = (self.lastMessageId == nil) ? "" : "?last_message_id=\(self.lastMessageId!)"
                let urlString = "\(kBaseURL)/channels/\(self.name)/messages\(query)"
                if let url = NSURL(string: urlString) {
                    let request = NSMutableURLRequest(URL: url)
                    request.HTTPMethod = "GET"
                    request.setValue(self.token, forHTTPHeaderField: kIdentityTokenHeader)
                    
                    let task = self.session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                        if error != nil {
                            print("Error getting messages from datasource: \(error!.localizedDescription)")
                            return
                        }
                        
                        let r = response as! NSHTTPURLResponse
                        if r.statusCode >= 400 {
                            print("HTTP Error: \(NSHTTPURLResponse.localizedStringForStatusCode(r.statusCode))")
                            return
                        }
                        
                        if data == nil || data!.length == 0 {
                            return
                        }
                        
                        do {
                            if let messages = (try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as? Array<Dictionary<String, AnyObject>> {
                                if let lastMessageId = messages.last?[kMessageId] as? String {
                                    self.lastMessageId = lastMessageId
                                }
                                for message in messages {
                                    let content = IPMSecureMessage.fromDTO(message)
                                    if content == nil {
                                        continue
                                    }
                                    let sender = message[kMessageSender] as? String ?? ""
                                    self.listener?(content!, sender)
                                }
                            }
                            else { throw NSError(domain: "GetMessagesError", code: -6565, userInfo: nil) }
                        }
                        catch let err as NSError {
                            print("Error: \(err.localizedDescription)")
                            return
                        }
                    })
                    task.resume()
                }
            }
            dispatch_resume(t)
            self.timer = t
        }
    }
    
    func stopTimer() {
        if self.timer != nil {
            dispatch_source_cancel(self.timer)
            self.timer = nil
        }
    }
}