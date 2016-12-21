//
//  User.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/21.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import ObjectMapper

struct User: Mappable{
    
    var id: Int?
    var name: String?
    var avatorUrl: String?
    var location: String?
    
    init?(map: Map) {
        
    }

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.avatorUrl <- map["avator_url"]
        self.location <- map["location"]
    }
}
