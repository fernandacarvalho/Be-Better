//
//  User.swift
//  BeBetter
//
//  Created by Fernanda Carvalho on 22/05/19.
//  Copyright © 2019 Fernanda Carvalho. All rights reserved.
//

import Foundation

class User : NSObject
{
    
    var name : String?
    var email : String!
    var id : String!
    
    init(name: String?, email: String, id: String)
    {
        self.id = id
        self.name = name
        self.email = email
        
        super.init()
    }
}
