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
    var selectedCategory : Category?
    
    class var sharedInstance : ApplicationData {
        return data
    }
    
    override init()
    {
        super.init()
    }
    
    //category
    
    func setSelectedCategory(category: Category){
        self.selectedCategory = category
    }
    
    func getSelectedCategory() -> Category? {
        if self.selectedCategory != nil {
            return self.selectedCategory
        }
        return nil
    }
    
    //user
    
    func login(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let user = Auth.auth().currentUser {
                let email = user.email
                let id = user.uid
                DAOUser.sharedInstance.setCurrentUser(email: email!, id: id)
                NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "USER_AUTHENTICATED")))
                //TO DO: persistir local usuario logado
            }
        }
    }
    
    func createUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if(error != nil){
                let errorDescription:[String: String] = ["error": error!.localizedDescription]
                NotificationCenter.default.post(name:  Notification.Name(rawValue: "USER_NOT_REGISTERED"), object: nil, userInfo: errorDescription)
                
            } else if let currentUser = user {
                NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "USER_REGISTERED")))
                let database = Database.database().reference().child("users").child("\(currentUser.uid)")
                let newUserDict = ["email": email, "id": currentUser.uid]
                self.setValueToDatabase(database: database, dict: newUserDict)
            }
        }
    }
    
    //exercise
    
    func createExercise(name: String, numberOfWeeks: Int, weekRepetitions: Int)
    {
        let totalToDo = numberOfWeeks * weekRepetitions
        let totalDone = 0
        let progressAverage = 0
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        dateFormatter.locale = Locale(identifier: "en_US")
        let dateString = dateFormatter.string(from: date)
        let category = self.selectedCategory!.rawValue
        
        var dict = ["name" : name, "date" : dateString, "numberOfWeeks" : numberOfWeeks, "weekRepetitions" : weekRepetitions, "totalToDo" : totalToDo, "totalDone" : totalDone, "progressAverage" : progressAverage, "category": category] as [String : Any]
        
        if let currentUser = DAOUser.sharedInstance.getCurrentUser() {
            if let id = currentUser.id  {
                let userKey = String(id)
                let randon = arc4random()
                let stringRandon = String(randon)
                let exerciseId =  userKey + stringRandon + removeSpacesFromString(str: dateString)
                dict["id"] = exerciseId
                let database = Database.database().reference().child("users").child(userKey).child("exercises")
                self.getAllUserExercises(userKey: userKey) { (exercisesArray) in
                    let exercises = exercisesArray.adding(dict) as NSArray
                    
                    database.setValue(exercises) {
                        (error:Error?, ref:DatabaseReference) in
                        if let error = error {
                            print("Data could not be saved: \(error).")
                            //TO DO: tratar erro
                        } else {
                            print("Data saved successfully!")
                            NotificationCenter.default.post(name:  Notification.Name(rawValue: "EXERCISE_CREATED"), object: nil)
                        }
                    }
                }
            }
        }
    }
    
    func getAllUserExercises(userKey: String, completion: @escaping (NSArray) -> ()) {
        var exercises : NSArray = []
        let database = Database.database().reference().child("users").child(userKey).child("exercises")
        database.observeSingleEvent(of: .value) { (snapshot) in
            if let exercisesArray = snapshot.value as? NSArray {
                exercises = exercisesArray as NSArray
            }
            completion(exercises)
        }
    }
    
    func getExercisesByCategory(category: Category, completion: @escaping (NSArray) -> ()) {
        var exercises : NSArray = []
        if let currentUser = DAOUser.sharedInstance.getCurrentUser() {
            if let id = currentUser.id  {
                let userKey = String(id)
                let database = Database.database().reference().child("users").child(userKey).child("exercises")
                
                database.observeSingleEvent(of: .value) { (snapshot) in
                    if let exercisesArray = snapshot.value as? NSArray {
                        
                        for item in exercisesArray  {
                            let exercise = item as! NSDictionary
                            let cat = exercise["category"] as! Int
                            let name = exercise["name"] as! String
                            let dateString = exercise["date"] as! String
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateStyle = .long
                            dateFormatter.timeStyle = .long
                            dateFormatter.locale = Locale(identifier: "en_US")
                            let date = dateFormatter.date(from: dateString) ?? Date()
                            let numberOfWeeks = exercise["numberOfWeeks"] as! Int
                            let weekRepetitions = exercise["weekRepetitions"] as! Int
                            let totalToDo = exercise["totalToDo"] as! Int
                            let totalDone = exercise["totalDone"] as! Int
                            let progressAverage = exercise["progressAverage"] as! Int
                            let tutorial = "vazio"
                            let id = exercise["id"] as! String
                            let exObject = Exercise(name: name, date: date as NSDate, numberOfWeeks: numberOfWeeks, weekRepetitions: weekRepetitions, totalToDo: totalToDo, totalDone: totalDone, progressAverage: progressAverage, tutorial: tutorial, id: id)
                            if cat == category.rawValue {
                                exercises = exercises.adding(exObject) as NSArray
                            }
                        }
                    }
                    completion(exercises)
                }
            }
        }
    }
    
//    func getCategory(category: Category?) -> NSNumber {
//        if let cat = category {
//            switch cat {
//            case Category.speech:
//                return 0
//            case Category.ophthalmo:
//                return 1
//            }
//        }
//        return 0
//    }
    
    func setValueToDatabase(database: DatabaseReference, dict: [String: Any]){
        database.setValue(dict) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
    }
    
    //MARK: Auxiliar methods
    
    func removeSpacesFromString(str: String) -> String {
        if !str.isEmpty {
            let formattedString = str.replacingOccurrences(of: " ", with: "")
            return formattedString
        }
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        dateFormatter.locale = Locale(identifier: "en_US")
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}
