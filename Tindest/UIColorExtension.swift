//
//  UIColorExtension.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/09.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red   = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue  = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    struct TindestColor {
        static let mainRed = UIColor(hex: 0xF16464)
        static let darkGray = UIColor(hex: 0xE4E4E4)
        static let lightGray = UIColor(hex: 0xF8F9FC)
    }
}
