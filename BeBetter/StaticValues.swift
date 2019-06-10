//
//  StaticValues.swift
//  BeBetter
//
//  Created by Fernanda Carvalho on 07/04/19.
//  Copyright © 2019 Fernanda Carvalho. All rights reserved.
//

import Foundation
import UIKit

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

//colors
let color_green = UIColor(hexString: "#009a98")

//font
let fontName : String = "Avenir-Light"

//nav bar e status bar
var statusBar : CGFloat = UIApplication.shared.statusBarFrame.size.height
let navHeight : CGFloat = 44 + statusBar

//margins
let leftMargin : CGFloat = 10
let rightMargin : CGFloat = 10
