//
//  Message.swift
//  Tindest
//
//  Created by TakuSemba on 2017/01/26.
//  Copyright © 2017年 TakuSemba. All rights reserved.
//

import UIKit
import ObjectMapper

struct Message: Mappable{
    
    var id: Int?
    var content: String?
    var date: String?
    var from: From?
    
    init?(map: Map) {
        
    }
    
    init(content: String, date: String, from: From) {
        self.content = content
        self.date = date
        self.from = from
    }
    
    mutating func mapping(map: Map) {
        
    }
    
    enum From {
        case me
        case opponent
    }
}
