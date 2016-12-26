//
//  MessageViewModel.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/21.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Bond

class MessageViewModel {
    
    private let disposeBag = DisposeBag()
    
    internal let observableNewMatchedUsers = MutableObservableArray<User>([])
    internal let observableMessageUsers = MutableObservableArray<User>([])
        
    init() {
        
        
    }
    
    func getMessageUsers() {        
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
                    self?.observableMessageUsers.batchUpdate({ (data) in
                        for user in users {
                            self?.observableMessageUsers.append(user!)
                        }
                    })
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    func getNewMatchedusers(){
        Api.ShotRequest.getShots(100)
            .flatMap({ shots -> RxSwift.Observable<Shot> in
                return RxSwift.Observable<Shot>.from(shots)
            })
            .map({ shot in
                return shot.user
            })
            .filter({ (user) -> Bool in
                return (user!.name?.characters.count)! < 6
            })
            .toArray()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {[weak self] users in
                    self?.observableNewMatchedUsers.batchUpdate({ (data) in
                        for user in users {
                            data.append(user!)
                        }
                    })
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    func addUser() {
        self.observableMessageUsers.batchUpdate({ (data) in
            data.append(User(id: 13, name: "takutkuatkau"))
        })
    }
    
}
