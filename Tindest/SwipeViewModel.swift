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

protocol SwipeViewModelType: class {
    
    // Input
    var cardDidRunOut: PublishSubject<Void> { get }
    
    // Output
    var swipableUsers: Variable<[User]> { get }
    
}

class SwipeViewModel: SwipeViewModelType {
    
    private let disposeBag = DisposeBag()
    
    // Input
    let cardDidRunOut = PublishSubject<Void>()
    
    // Output
    let swipableUsers = Variable<[User]>([])
    
    init() {
        getSwipableUsers()
        
        cardDidRunOut.asObserver()
            .subscribe(
                onNext: { indexPath in
                    self.getSwipableUsers()
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    private func getSwipableUsers() {
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
                    self?.swipableUsers.value.append(contentsOf: users)
                }
            )
            .addDisposableTo(disposeBag)
    }
}
