//
//  ExercisesList.swift
//  BeBetter
//
//  Created by Fernanda Carvalho on 10/04/19.
//  Copyright © 2019 Fernanda Carvalho. All rights reserved.
//

import UIKit

class ExercisesList: UIViewController {
    
    var category : Category!
    var exercises : [Exercise]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Exercícios"
        let right = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: navHeight - 20))
        right.titleLabel?.font = UIFont(name: fontName, size: 17)
        right.setTitle("Criar", for: .normal)
        right.titleLabel?.textAlignment = .right
        right.addTarget(self, action: #selector(self.goToCreateExercise), for: .touchUpInside)
        let rightButton = UIBarButtonItem(customView: right)
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.category = ApplicationData.sharedInstance.getSelectedCategory()
        self.getExercises()
    }

    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        let attributes = [NSAttributedString.Key.font: UIFont(name: fontName, size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        backButton.setTitleTextAttributes(attributes, for: .normal)
        backButton.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = backButton
    }

    @objc func goToCreateExercise(){
        let createExerciseVC = CreateExercise()
        self.navigationController?.pushViewController(createExerciseVC, animated: true)
    }
    
    func getExercises(){
        ApplicationData.sharedInstance.getExercisesByCategory(category: self.category) { (exercises) in
            self.exercises = exercises as! [Exercise]
        }
    }
}
