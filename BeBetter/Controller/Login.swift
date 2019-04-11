//
//  Login.swift
//  BeBetter
//
//  Created by Fernanda Carvalho on 07/04/19.
//  Copyright © 2019 Fernanda Carvalho. All rights reserved.
//

import UIKit

class Login: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loginButton.layer.cornerRadius = 5;
        self.registerButton.layer.cornerRadius = 5;
    }


    @IBAction func Login(_ sender: Any) {
        guard let email = self.emailField.text, let password = self.passwordField.text else {
            print("invalid login")
            return
        }
        
        if(!email.isEmpty && !password.isEmpty){
            ApplicationData.sharedInstance.login(email: email, password: password)
        }
    }
    

    @IBAction func register(_ sender: Any) {
        guard let email = self.emailField.text, let password = self.passwordField.text else {
            print("invalid login")
            return
        }
        
        if(!email.isEmpty && !password.isEmpty){
            DAOUser.sharedInstance.createUser(email: email, password: password)
        }
    }
    
}
