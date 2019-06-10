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
        self.registerNotifications()
    }

    func registerNotifications(){
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(self.userAuthenticated), name: NSNotification.Name("USER_AUTHENTICATED"), object: nil)
        
        center.addObserver(self, selector: #selector(self.userRegistered), name: NSNotification.Name("USER_REGISTERED"), object: nil)
        
        center.addObserver(self, selector: #selector(self.userNotRegistered), name: NSNotification.Name("USER_NOT_REGISTERED"), object: nil)
    }
    
    @objc func userAuthenticated(){
        let navigation = MainNavigationController(rootViewController: CategoriesList())
        removeSpinner()
        self.present(navigation, animated: true, completion: nil)
        print("USER_AUTHENTICATED")
    }
    
    @objc func userRegistered(){
        removeSpinner()
    }
    
    @objc func userNotRegistered(notification: NSNotification){
        removeSpinner()
        if let error = notification.userInfo?["error"] as? String{
            self.showAlert(title: "Ops!", message: error)
        }
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func Login(_ sender: Any) {
        guard let email = self.emailField.text, let password = self.passwordField.text else {
            self.showAlert(title: "Invalid", message: "Please, fill all fields!")
            return
        }
        
        if(!email.isEmpty && !password.isEmpty){
            showSpinner(onView: self.view)
            ApplicationData.sharedInstance.login(email: email, password: password)
        }
    }
    

    @IBAction func register(_ sender: Any) {
        guard let email = self.emailField.text, let password = self.passwordField.text else {
            print("invalid login")
            return
        }
        
        if(!email.isEmpty && !password.isEmpty){
            showSpinner(onView: self.view)
            ApplicationData.sharedInstance.createUser(email: email, password: password)
        }
    }
    
}
