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
    var loggedUser: User?
    
    class var sharedInstance : DAOUser {
        return data
    }
    
    override init()
    {
        super.init()
        
    }
    
    func setCurrentUser(email: String, id: String){
        if(self.loggedUser != nil){
            self.loggedUser!.email = email
            self.loggedUser!.id = id
        }
        else {
            self.loggedUser = User(name: "", email: email, id: id)
        }
    }
    
    func getCurrentUser() -> User? {
        return self.loggedUser
    }
}
