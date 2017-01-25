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

protocol MessageViewModelType: class {
    
    //Input
    var collectionItemDidSelect: PublishSubject<IndexPath> { get }
    
    // Output
    var newMatchedUsers: MutableObservableArray<User> { get }
    var messageUsers: MutableObservableArray<User> { get }

}

class MessageViewModel: MessageViewModelType {
    
    private let disposeBag = DisposeBag()
    
    let collectionItemDidSelect = PublishSubject<IndexPath>()
    
    let newMatchedUsers = MutableObservableArray<User>([])
    let messageUsers = MutableObservableArray<User>([])
    
        
    init() {
        getMessageUsers()
        getNewMatchedusers()
        
        self.collectionItemDidSelect.asObserver()
            .subscribe(
                onNext: { indexPath in
                    self.addUser()
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    private func getMessageUsers() {
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
                    self?.messageUsers.batchUpdate({ (data) in
                        for user in users {
                            data.append(user!)
                        }
                    })
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    private func getNewMatchedusers(){
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
                    self?.newMatchedUsers.batchUpdate({ (data) in
                        for user in users {
                            data.append(user!)
                        }
                    })
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    private func addUser() {
        self.newMatchedUsers.batchUpdate({ (data) in
            data.append(User(id: 13, name: "taku"))
        })
    }
    
}
