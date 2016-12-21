//
//  Shot.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/21.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import ObjectMapper

struct Shot: Mappable{
    
    var id: Int?
    var title: String?
    var description: String?
    var width: Int?
    var height: Int?
    var viewsCount: Int?
    var likesCount: Int?
    var commentsCount: Int?
    var user: User?
    var image: Image?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.title <- map["title"]
        self.description <- map["description"]
        self.width <- map["width"]
        self.height <- map["height"]
        self.viewsCount <- map["view_count"]
        self.likesCount <- map["likes_count"]
        self.commentsCount <- map["comments_count"]
        self.user <- map["user"]
        self.image <- map["image"]
    }
}
