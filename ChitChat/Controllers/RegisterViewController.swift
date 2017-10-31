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
import SVProgressHUD

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
        SVProgressHUD.show()
        FIRAuth.auth()?.createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
            if error != nil {
                // failure
                print(error!)
                SVProgressHUD.dismiss()
            }
            else {
                // success
                print("Registration sucessful")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        })
    }
    
}
