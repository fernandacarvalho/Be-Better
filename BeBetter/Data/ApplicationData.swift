//
//  ApplicationData.swift
//  BeBetter
//
//  Created by Fernanda Carvalho on 08/04/19.
//  Copyright © 2019 Fernanda Carvalho. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

private let data = ApplicationData()

class ApplicationData : NSObject
{
    class var sharedInstance : ApplicationData {
        return data
    }
    
    override init()
    {
        super.init()
    }
    
    func login(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let user = Auth.auth().currentUser {
                print(user.email)
            }
        }
    }
}
