//
//  CreateExercise.swift
//  BeBetter
//
//  Created by Fernanda Carvalho on 30/05/19.
//  Copyright © 2019 Fernanda Carvalho. All rights reserved.
//

import UIKit

class CreateExercise: UIViewController {
    
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var repetitionsField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.registerNotifications()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func registerNotifications(){
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(self.exerciseCreated), name: NSNotification.Name("EXERCISE_CREATED"), object: nil)
    }
    
    @objc func exerciseCreated(){
        removeSpinner()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createExercise(_ sender: Any) {
        guard let description = self.descriptionField.text, let duration = self.durationField.text, let repetitions = self.repetitionsField.text else {
            self.showAlert(title: "Invalid", message: "Please, fill all fields!")
            return
        }
        
        if let weeks = Int(duration), let times = Int(repetitions) {
            showSpinner(onView: self.view)
            ApplicationData.sharedInstance.createExercise(name: description, numberOfWeeks: weeks, weekRepetitions: times)
        }
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
