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
    internal let newMatchedUsers = BehaviorSubject<User>(value: User(id: 1, name: "hugahuga"))
    internal let messageUsersState = Variable<ViewState>(.none)
    internal let newMatchedUsersState = Variable<ViewState>(.none)
    
    internal let events: Variable<[User]> = Variable([])
    internal let requestState = Variable(RequestState.Stopped)
    
    init() {
        
        
    }
    
    func getMessageUsers() {
        self.messageUsersState.value = .loading
        
        Api.ShotRequest.getShots(10)
            .flatMap({ shots -> Observable<Shot> in
                return Observable.from(shots)
            })
            .map({ shot in
                return shot.user
            })
            .subscribe(
                onNext: {[weak self] user in
                    self?.messageUsers.onNext(user!)
                    self?.messageUsersState.value = .complete
            })
            .addDisposableTo(disposeBag)
    }
    
    func getNewMatchedusers(){
        self.newMatchedUsersState.value = .loading
        
        Api.ShotRequest.getShots(100)
            .flatMap({ shots -> Observable<Shot> in
                return Observable.from(shots)
            })
            .map({ shot in
                return shot.user
            })
            .filter({ (user) -> Bool in
                return (user!.name?.characters.count)! < 6
            })
            .subscribe(
                onNext: {[weak self] user in
                    self?.newMatchedUsers.onNext(user!)
                    self?.newMatchedUsersState.value = .complete
            })
            .addDisposableTo(disposeBag)
    }
    
    func addUser() {
        messageUsers.onNext(User(id: 13, name: "takutkuatkau"))
        self.messageUsersState.value = .complete
    }
    
}
