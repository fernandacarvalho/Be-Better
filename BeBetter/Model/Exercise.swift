//
//  Exercise.swift
//  BeBetter
//
//  Created by Fernanda Carvalho on 30/05/19.
//  Copyright © 2019 Fernanda Carvalho. All rights reserved.
//

import Foundation

class Exercise : NSObject
{
    
    var name : String!
    var date : NSDate!
    var numberOfWeeks : Int!
    var weekRepetitions : Int!
    var totalToDo : Int!
    var totalDone : Int!
    var progressAverage : Int!
    var tutorial : String?
    var id : Int!
    
    init(name: String, date: NSDate, numberOfWeeks: Int, weekRepetitions: Int, totalToDo: Int, totalDone: Int, progressAverage: Int, tutorial: String?)
    {
        self.name = name
        self.date = date
        self.numberOfWeeks = numberOfWeeks
        self.weekRepetitions = weekRepetitions
        self.totalToDo = totalToDo
        self.totalDone = totalDone
        self.progressAverage = progressAverage
        self.tutorial = tutorial
        
        super.init()
    }
}
