//
//  Image.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/21.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import ObjectMapper

struct Image: Mappable{
    
    var hidpi: String?
    var normal: String?
    var teaser: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.hidpi <- map["hidpi"]
        self.normal <- map["normal"]
        self.teaser <- map["teaser"]
    }
}
