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
import RxDataSources

class MessageViewModel {
    
    private let disposeBag = DisposeBag()
    
    let sections: [MultipleSectionModel] = [
        .newMatchRowSection(items: [.newMatchRowItem()]),
        .messageUsersSection(items: [.messageUsersItem(user: User(name: "taku", location: "japan", avatarUrl: "https://developers.cyberagent.co.jp/blog/wp-content/uploads/2017/01/chateau_top.jpg"))])
    ]
    
    let newMatchedUsers = Observable.just([User(name: "taku", location: "japan", avatarUrl: "https://developers.cyberagent.co.jp/blog/wp-content/uploads/2017/01/chateau_top.jpg")])
    
    init() {
        getMessageUsers()
        getNewMatchedusers()
    }
    
    func getMessageUsers() {        
//        Api.ShotRequest.getShots(10)
//            .flatMap({ shots -> RxSwift.Observable<Shot> in
//                return RxSwift.Observable.from(shots)
//            })
//            .map({ shot in
//                return shot.user
//            })
//            .toArray()
//            .observeOn(MainScheduler.instance)
//            .subscribe(
//                onNext: {[weak self] users in
//                    self?.messageUsers.batchUpdate({ (data) in
//                        for user in users {
//                            data.append(user!)
//                        }
//                    })
//                }
//            )
//            .addDisposableTo(disposeBag)
    }
    
    func getNewMatchedusers(){
//        Api.ShotRequest.getShots(100)
//            .flatMap({ shots -> RxSwift.Observable<Shot> in
//                return RxSwift.Observable<Shot>.from(shots)
//            })
//            .map({ shot in
//                return shot.user
//            })
//            .filter({ (user) -> Bool in
//                return (user!.name?.characters.count)! < 6
//            })
//            .toArray()
//            .observeOn(MainScheduler.instance)
//            .subscribe(
//                onNext: {[weak self] users in
//                    self?.newMatchedUsers.batchUpdate({ (data) in
//                        for user in users {
//                            data.append(user!)
//                        }
//                    })
//                }
//            )
//            .addDisposableTo(disposeBag)
    }
    
    func addUser(){
        
    }
    
}

enum MultipleSectionModel {
    case newMatchRowSection(items: [SectionItem])
    case messageUsersSection(items: [SectionItem])
}

enum SectionItem {
    case newMatchRowItem()
    case messageUsersItem(user: User)
}

extension MultipleSectionModel: SectionModelType {
    
    var items: [SectionItem] {
        switch  self {
        case .newMatchRowSection(items: let items):
            return items.map {$0}
        case .messageUsersSection(items: let items):
            return items.map {$0}
        }
    }
    
    init(original: MultipleSectionModel, items: [SectionItem]) {
        switch original {
        case .newMatchRowSection(items: _):
            self = .newMatchRowSection(items: items)
        case .messageUsersSection(items: _):
            self = .messageUsersSection(items: items)
        }
    }
}

