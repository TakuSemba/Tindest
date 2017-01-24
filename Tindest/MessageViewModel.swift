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
    
    var itemDidSelect = PublishSubject<IndexPath>()
    
    let newMatchedUsers = Variable<[User]>([])
    
    let messageUsers = Variable<[User]>([])
    
    let sections = Variable<[MultipleSectionModel]>([])

    init() {
//        getMessageUsers()
//        getNewMatchedusers()
        
        
        let users = [
            User(name: "taku", location: "japan", avatarUrl: "https://developers.cyberagent.co.jp/blog/wp-content/uploads/2017/01/chateau_top.jpg"),
            User(name: "taku", location: "japan", avatarUrl: "https://developers.cyberagent.co.jp/blog/wp-content/uploads/2017/01/chateau_top.jpg")
        ]
        
        let user = User(name: "taku", location: "japan", avatarUrl: "https://developers.cyberagent.co.jp/blog/wp-content/uploads/2017/01/chateau_top.jpg")

        
        newMatchedUsers.value.append(user)
        
        messageUsers.value =  users
        
        sections.value = [
            .newMatchRowSection(title: "Section 1", items: [.newMatchRowItem()]),
            .messageUsersSection(title: "Section 2", items: [.messageUsersItem(user: User(name: "taku", location: "japan", avatarUrl: "https://developers.cyberagent.co.jp/blog/wp-content/uploads/2017/01/chateau_top.jpg"))])
        ]
        
        self.messageUsers.asObservable()
            .bindTo(sections.value[1] = )
            .addD
                
        self.itemDidSelect.subscribe(
            onNext: {[weak self] indexPath in
                print("item selected")
                self?.newMatchedUsers.value.append(user)
                
            }
        ).addDisposableTo(disposeBag)
        
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
    
}

enum MultipleSectionModel {
    case newMatchRowSection(title: String, items: [SectionItem])
    case messageUsersSection(title: String, items: [SectionItem])
}

enum SectionItem {
    case newMatchRowItem()
    case messageUsersItem(user: User)
}

extension MultipleSectionModel: SectionModelType {
    
    var title: String {
        switch self {
        case .newMatchRowSection(title: let title, items: _):
            return title
        case .messageUsersSection(title: let title, items: _):
            return title
        }
    }
    
    var items: [SectionItem] {
        switch  self {
        case .newMatchRowSection(title: _, items: let items):
            return items.map {$0}
        case .messageUsersSection(title: _, items: let items):
            return items.map {$0}
        }
    }
    
    init(original: MultipleSectionModel, items: [SectionItem]) {
        switch original {
        case let .newMatchRowSection(title: title, items: _):
            self = .newMatchRowSection(title: title, items: items)
        case let .messageUsersSection(title, _):
            self = .messageUsersSection(title: title, items: items)
        }
    }
}

