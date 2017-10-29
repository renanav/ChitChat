//
//  ChatViewController.swift
//  ChitChat
//
//  Created by Renan Avrahami on 10/24/17.
//  Copyright © 2017 Renan Avrahami. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var messageArray: [Message] = [Message]()
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTextfield.delegate = self
        
//        When the message table view itslef is tapped, it will collapse the keyboard, and slide the message textfield down
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        // Register the custom cell xib file
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        configureTableView()
        retreiveMessages()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "egg")
        print("func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell has been called")
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    @objc func tableViewTapped() { //@objc was added to satisfy the #selector
        messageTextfield.endEditing(true)
    }
    
    //    Adjust the messages cell height to its content
    func configureTableView() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    //MARK:- TextField Delegate Methods.  These mthods will adjust and control the appearance of the keyboard when typing a message
    //    Height increase
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, animations: {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        })
    }
    
    //    Height decrease
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, animations: {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        })
    }
    
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    @IBAction func sendPressed(_ sender: Any) {
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false

        let messagesDB = FIRDatabase.database().reference().child("Messages")
        let messageDictionary = ["Sender" : FIRAuth.auth()?.currentUser?.email,
                                 "MessageBody" : messageTextfield.text!]
        // save the messages in a messageDictionary distionary
        if self.messageTextfield.text!.isEmpty{
            print("Cant send and empty message")
            messageTextfield.endEditing(false)
            messageTextfield.isEnabled = true
            sendButton.isEnabled = true
        } else {
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, ref) in
            if error != nil {
            print (error)
            } else {
                print("Message saved successfully")
                
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                // clear the message text field after sending the message
                self.messageTextfield.text = ""
            }
        }
        }
    }
    
    func retreiveMessages() {
        let messageDB = FIRDatabase.database().reference().child("Messages")
        messageDB.observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            
            self.configureTableView()
            self.messageTableView.reloadData()
            
            })
    }
    
    //    Log out the user and send him back to the WelcomeViewController
    @IBAction func logOutPressed(_ sender: Any) {
        
        do {
            try FIRAuth.auth()?.signOut()
            navigationController?.popToRootViewController(animated: true) //will navigate to the welcome screen
        }
        catch {
            print("Error: there was a problem signing out")
        }
    }
    
}
