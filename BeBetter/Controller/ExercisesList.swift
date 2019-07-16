//
//  ExercisesList.swift
//  BeBetter
//
//  Created by Fernanda Carvalho on 10/04/19.
//  Copyright © 2019 Fernanda Carvalho. All rights reserved.
//

import UIKit

class ExercisesList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
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
        self.registerNotifications()
        self.getExercises()
        self.configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        let attributes = [NSAttributedString.Key.font: UIFont(name: fontName, size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        backButton.setTitleTextAttributes(attributes, for: .normal)
        backButton.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = backButton
    }
    
    func registerNotifications(){
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(self.exerciseCreated), name: NSNotification.Name("EXERCISE_CREATED"), object: nil)
    }
    
    @objc func exerciseCreated(){
        self.getExercises()
    }

    @objc func goToCreateExercise(){
        let createExerciseVC = CreateExercise()
        self.navigationController?.pushViewController(createExerciseVC, animated: true)
    }
    
    func getExercises(){
        showSpinner(onView: self.view)
        ApplicationData.sharedInstance.getExercisesByCategory(category: self.category) { (exercises) in
    
            self.exercises = exercises as? [Exercise]
            self.tableView.reloadData()
            self.removeSpinner()
        }
    }
    
    func configureTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    //MARK: TableView Protocols
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        cell.selectionStyle = .none
        if self.exercises != nil {
            cell.textLabel?.text =  self.exercises[indexPath.row].name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercises != nil ? self.exercises.count : 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
