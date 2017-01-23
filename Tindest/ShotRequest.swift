//
//  ShotRequest.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/21.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import Alamofire
import RxSwift
import ObjectMapper

extension Api {
    
    final class ShotRequest {
        
        static var baseURL: String { return url }
        
        static var path: String { return "shots" }
        
        //GET: /shots/
        static func getShots(_ perPage: Int) -> Observable<[Shot]> {
            let parameters = ["per_page": perPage]
            return Observable.create{ observer -> Disposable in
                let request = Alamofire.request(baseURL + path, method: .get, parameters: parameters, headers: headers)
                    .responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            let shots : [Shot] = Mapper<Shot>().mapArray(JSONObject: value)!
                            observer.onNext(shots)
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
