//
//  MainNavigationController.swift
//  BeBetter
//
//  Created by Fernanda Carvalho on 22/05/19.
//  Copyright © 2019 Fernanda Carvalho. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.barTintColor = color_green;
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: fontName, size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
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
