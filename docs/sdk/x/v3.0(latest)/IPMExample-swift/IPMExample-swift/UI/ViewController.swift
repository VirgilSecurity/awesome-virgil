//
//  ViewController.swift
//  IPMExample-swift
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet private var tvChat: UITableView!
    @IBOutlet private var lTitle: UILabel!
    @IBOutlet private var lIdentity: UILabel!
    @IBOutlet private var tfMessage: UITextField!
    @IBOutlet private var lcBottom: NSLayoutConstraint!
    
    private var loadingController: LoadingViewController! = nil
    private var messages = [Dictionary<String, String>]()

    private var ipmSecurity: IPMSecurityManager! = nil
    private var ipmClient: IPMChannelClient! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.loadingController = storyboard.instantiateViewControllerWithIdentifier("LoadingViewController") as! LoadingViewController
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShowNotification(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHideNotification(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let listener: IPMDataSourceListener = { secureMessage, sender in
            if !self.ipmSecurity.checkSignature(secureMessage.signature, data: secureMessage.message, identity: sender) {
                print("Error verifying sender's signature.")
                return
            }
            
            if let plainData = self.ipmSecurity.decryptData(secureMessage.message), text = NSString(data: plainData, encoding: NSUTF8StringEncoding) {
                self.messages.append([kIPMMessageText: text as String, kIPMMessageSender: sender])
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tvChat.reloadData()
                }
                return
            }
            
            print("Error decrypting sender's message.")
        }
        
        let ipmChannelSetup = {
            self.ipmClient = IPMChannelClient(userId: self.ipmSecurity.identity)
            if let error = self.ipmClient.joinChannel(kAppChannelName, listener: listener) {
                dispatch_async(dispatch_get_main_queue()) {
                    self.dismissViewControllerAnimated(false, completion: nil)
                }
                print("Error joining the channel: \(error.localizedDescription)")
                return
            }

            dispatch_async(dispatch_get_main_queue()) {
                self.dismissViewControllerAnimated(false, completion: nil)
                self.lIdentity.text = self.ipmSecurity.identity
            }
        }
        
        let introduction = UIAlertController(title: nil, message: NSLocalizedString("Enter your email", comment: ""), preferredStyle: .Alert)
        introduction.modalPresentationStyle = .OverCurrentContext
        introduction.addTextFieldWithConfigurationHandler { textField in
            textField.keyboardType = .EmailAddress
            textField.returnKeyType = .Done
        }
        let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .Default) { _ in
            let tf = introduction.textFields![0]
            if let text = tf.text {
                self.presentViewController(self.loadingController, animated: false, completion: nil)
                self.ipmSecurity = IPMSecurityManager(identity: text)
                if let signinerror = self.ipmSecurity.signin() {
                    if signinerror.code == -5555 {
                        if let signuperror = self.ipmSecurity.signup() {
                            self.dismissViewControllerAnimated(false, completion: nil)
                            print("Error: \(signuperror.localizedDescription)")
                            return
                        }
                        
                        ipmChannelSetup()
                        return
                    }
                    
                    self.dismissViewControllerAnimated(false, completion: nil)
                    print("Error: \(signinerror.localizedDescription)")
                    return
                }
                
                ipmChannelSetup()
            }
        }
        
        introduction.addAction(ok)
        self.presentViewController(introduction, animated: true, completion: nil)
    }

    func sendMessage(text: String) {
        self.presentViewController(self.loadingController, animated: false, completion: nil)
        
        let participants = self.ipmClient.channel.getParticipants()
        if participants.count > 0 {
            if let plaindata = text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                if let encrypted = self.ipmSecurity.encryptData(plaindata, identities: participants) {
                    if let signature = self.ipmSecurity.composeSignatureOnData(encrypted) {
                        let ipm = IPMSecureMessage(message: encrypted, signature: signature)
                        if let error = self.ipmClient.channel.sendMessage(ipm) {
                            print("Error: \(error.localizedDescription)")
                            self.dismissViewControllerAnimated(false, completion: nil)
                            return
                        }
                        /// success
                        self.tfMessage.text = nil
                        self.dismissViewControllerAnimated(false, completion: nil)
                        return
                    }
                }
            }
        }
        
        print("No participants on the channel.")
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func keyboardWillShowNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
        
        self.lcBottom.constant = convertedKeyboardEndFrame.size.height
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func keyboardWillHideNotification(notification: NSNotification) {
        self.lcBottom.constant = 20.0
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
}

extension ViewController {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kIPMChatCell, forIndexPath: indexPath)
        
        let content = self.messages[indexPath.row]
        cell.textLabel?.text = content[kIPMMessageText]
        cell.detailTextLabel?.text = content[kIPMMessageSender]
        
        return cell
    }
    
}

extension ViewController {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let text = textField.text {
            self.sendMessage(text)
        }
        
        textField.resignFirstResponder()
        return true
    }
    
}

