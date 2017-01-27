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
    var newMatchedUsers: Variable<[User]> { get }
    var messageUsers: Variable<[User]> { get }

}

class MessageViewModel: MessageViewModelType {
    
    private let disposeBag = DisposeBag()
    
    //Input
    let collectionItemDidSelect = PublishSubject<IndexPath>()
    
    // Output
    let newMatchedUsers = Variable<[User]>([])
    let messageUsers = Variable<[User]>([])
    
        
    init() {
        getMessageUsers()
        getNewMatchedusers()
        
        self.collectionItemDidSelect
            .asObserver()
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
                return shot.user!
            })
            .toArray()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {[weak self] users in
                    self?.messageUsers.value.append(contentsOf: users)
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
                return shot.user!
            })
            .filter({ (user) -> Bool in
                return (user.name?.characters.count)! < 6
            })
            .toArray()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {[weak self] users in
                    self?.newMatchedUsers.value.append(contentsOf: users)
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    private func addUser() {
//        self.newMatchedUsers.value.append(User(id: 13, name: "taku"))
        self.newMatchedUsers.value.removeLast()
    }
    
}
