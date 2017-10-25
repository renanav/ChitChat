//
//  RegisterViewController.swift
//  ChitChat
//
//  Created by Renan Avrahami on 10/21/17.
//  Copyright © 2017 Renan Avrahami. All rights reserved.
//
//  This is the View Controller which registers new users with Firebase

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerPressed(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
            if error != nil {
                // failure
                print(error!)
            }
            else {
                // success
                print("Registration sucessful")
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        })
    }
    
}
