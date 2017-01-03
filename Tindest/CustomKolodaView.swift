//
//  CustomKolodaView.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/10.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import Koloda

class CustomKolodaView: KolodaView {
    
    override func frameForCard(at index: Int) -> CGRect {
        return CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
}
