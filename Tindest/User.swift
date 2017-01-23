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
    var avatarUrl: String?
    var location: String?
    var bio: String?
    
    init?(map: Map) {
        
    }

    init(name: String, location: String, avatarUrl: String) {
        self.name = name
        self.location = location
        self.avatarUrl = avatarUrl
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.avatarUrl <- map["avatar_url"]
        self.location <- map["location"]
        self.bio <- map["bio"]
    }
}
