//
//  Api.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/21.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

final class Api {
    
    // Building for base URL
    internal static var url: String {
        
        // Http or Https
        let httpProtocol = "https"
        
        // The domain of common endpoint
        let domainName = "api.dribbble.com/v1"
        
        return httpProtocol + "://" + domainName + "/"
        
    }
    
    internal static var headers: [String : String] {
        return ["Authorization":" Bearer " + "cf612df2c668cdf3141cf97718747d4b9c41cca0d1a398554793e97c77043d9e"]
    }
}
