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

enum RequestState {
    case Stopped
    case Requesting
    case Error(Error)
    case Response([User])
}

enum ViewState {
    case none
    case loading
    case error
    case complete
}

class MessageViewModel {
    
    private let disposeBag = DisposeBag()
    
    internal let messageUsers = BehaviorSubject<User>(value: User(id: 1, name: "hogehoge"))
    internal let messageUsersState = Variable<ViewState>(.none)
    
    internal let events: Variable<[User]> = Variable([])
    internal let requestState = Variable(RequestState.Stopped)
    
    internal let observableNewMatchedUsers = MutableObservableArray<User>([])
    internal let observableMessageUsers = MutableObservableArray<User>([])
        
    init() {
        
        
    }
    
    func getMessageUsers() {
        self.messageUsersState.value = .loading
        
        Api.ShotRequest.getShots(10)
            .flatMap({ shots -> RxSwift.Observable<Shot> in
                return RxSwift.Observable.from(shots)
            })
            .map({ shot in
                return shot.user
            })
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {[weak self] user in
                    self?.messageUsers.onNext(user!)
                },
                onCompleted: { [weak self] () in
                    self?.messageUsersState.value = .complete
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
        messageUsers.onNext(User(id: 13, name: "takutkuatkau"))
        self.messageUsersState.value = .complete
    }
    
}
