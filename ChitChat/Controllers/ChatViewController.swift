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
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        let messageArray = ["First message", "Second message", "Third message"]
        
        cell.messageBody.text = messageArray[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
            self.heightConstraint.constant = 320
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
