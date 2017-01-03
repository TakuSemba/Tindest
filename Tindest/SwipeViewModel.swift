//
//  SwipeViewModel.swift
//  Tindest
//
//  Created by TakuSemba on 2017/01/03.
//  Copyright © 2017年 TakuSemba. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Bond

class SwipeViewModel {
    
    private let disposeBag = DisposeBag()
    
    internal var swipableUsers = MutableObservableArray<User>([])
    
    init() {
        getSwipableUsers()
    }
    
    func getSwipableUsers() {
        Api.ShotRequest.getShots(10)
            .flatMap({ shots -> RxSwift.Observable<Shot> in
                return RxSwift.Observable.from(shots)
            })
            .map({ shot in
                return shot.user
            })
            .toArray()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {[weak self] users in
                    self?.swipableUsers.batchUpdate({ (data) in
                        for user in users {
                            data.append(user!)
                        }
                    })
                }
            )
            .addDisposableTo(disposeBag)
    }
}
