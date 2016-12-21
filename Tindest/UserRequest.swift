//
//  UserRequest.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/21.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import Alamofire
import RxSwift
import Alamofire
import ObjectMapper

extension Api {
    
    final class UserRequest {
        
        static var baseURL: String { return url }
        
        static var path: String { return "user" }
        
        //GET: /shots/
        static func getUsers() -> Observable<User> {
            return Observable.create{ observer -> Disposable in
                let request = Alamofire.request(baseURL + path, method: .get, headers: headers)
                    .responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            let user : User = Mapper<User>().map(JSONObject: value)!
                            observer.onNext(user)
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                }
                
                return Disposables.create(with: { request.cancel() })
            }
        }
    }
}
