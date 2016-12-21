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
    
    internal let user = BehaviorSubject<User>(value: User(id: 1, name: "hogehoge"))
    internal let state = Variable<ViewState>(.loading)
    
    internal let events: Variable<[User]> = Variable([])
    internal let requestState = Variable(RequestState.Stopped)
    
    init() {
        
        
    }
    
    func getUsers() {
        self.state.value = .loading
        
        let mockUsers = [
            User(id: 1, name: "Lilly"),
            User(id: 2, name: "Brick"),
            User(id: 3, name: "Tom"),
            User(id: 4, name: "Chris")
        ]
        
        Observable.from(mockUsers)
            .subscribe(
                onNext: {[weak self] user in
                    self?.user.onNext(user)
                    self?.state.value = .complete
            })
            .addDisposableTo(disposeBag)
    }
    
    func addUser() {
        user.onNext(User(id: 13, name: "takutkuatkau"))
        self.state.value = .complete
    }
    
}
