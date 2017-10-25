//
//  ChatViewController.swift
//  ChitChat
//
//  Created by Renan Avrahami on 10/24/17.
//  Copyright © 2017 Renan Avrahami. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    
    
    
    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    @IBAction func sendPressed(_ sender: Any) {
    }
    
    
//    Log out the user and send them back to WelcomeViewController
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
