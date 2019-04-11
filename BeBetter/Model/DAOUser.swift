//
//  DAOUser.swift
//  BeBetter
//
//  Created by Fernanda Carvalho on 08/04/19.
//  Copyright © 2019 Fernanda Carvalho. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

private let data = DAOUser()

class DAOUser : NSObject
{
    class var sharedInstance : DAOUser {
        return data
    }
    
    override init()
    {
        super.init()
        
        
    }
    
    func createUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if(error != nil){
                print(error!)
            } else if let currentUser = user {
                print(currentUser)
            }
        }
    }
}
