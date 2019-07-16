//
//  CategoriesList.swift
//  BeBetter
//
//  Created by Fernanda Carvalho on 27/05/19.
//  Copyright © 2019 Fernanda Carvalho. All rights reserved.
//

import UIKit

class CategoriesList: UIViewController {

    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var ophthalmoButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Categorias"
        
//        self.speechButton.layer.cornerRadius = 75;
//        self.ophthalmoButton.layer.cornerRadius = 75;
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        let attributes = [NSAttributedString.Key.font: UIFont(name: fontName, size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        backButton.setTitleTextAttributes(attributes, for: .normal)
        backButton.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = backButton
    }


    @IBAction func chooseSpeechTherapy(_ sender: Any) {
        let category = Category.speech
        ApplicationData.sharedInstance.setSelectedCategory(category: category)
        self.goToExercises()
    }
    
    @IBAction func chooseOphthalmology(_ sender: Any) {
        let category = Category.ophthalmo
        ApplicationData.sharedInstance.setSelectedCategory(category: category)
        self.goToExercises()
    }
    
    
    func goToExercises(){
        let exercisesVC = ExercisesList()
        self.navigationController?.pushViewController(exercisesVC, animated: true)
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
