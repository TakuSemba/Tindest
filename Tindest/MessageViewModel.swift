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
        
        let user = User(name: "taku", location: "japan", avatarUrl: "https://developers.cyberagent.co.jp/blog/wp-content/uploads/2017/01/chateau_top.jpg")

        
        newMatchedUsers.value.append(user)
        newMatchedUsers.value.append(user)
        newMatchedUsers.value.append(user)
        newMatchedUsers.value.append(user)
        newMatchedUsers.value.append(user)
        newMatchedUsers.value.append(user)
        newMatchedUsers.value.append(user)
        newMatchedUsers.value.append(user)
        newMatchedUsers.value.append(user)
        
        messageUsers.value.append(user)
        messageUsers.value.append(user)
        messageUsers.value.append(user)
        messageUsers.value.append(user)
        messageUsers.value.append(user)
        messageUsers.value.append(user)
        messageUsers.value.append(user)
        messageUsers.value.append(user)
        messageUsers.value.append(user)
        messageUsers.value.append(user)
        messageUsers.value.append(user)
        messageUsers.value.append(user)
        
        sections.value = [
            .newMatchSection(title: "Section 1", items: [.newMatch]),
            .messageSection(title: "Section 2", items: [.message])
        ]

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
    case newMatchSection(title: String, items: [SectionItem])
    case messageSection(title: String, items: [SectionItem])
}

enum SectionItem {
    case newMatch
    case message
}

extension MultipleSectionModel: SectionModelType {
    
    var title: String {
        switch self {
        case .newMatchSection(title: let title, items: _):
            return title
        case .messageSection(title: let title, items: _):
            return title
        }
    }
    
    var items: [SectionItem] {
        switch  self {
        case .newMatchSection(title: _, items: let items):
            return items.map {$0}
        case .messageSection(title: _, items: let items):
            return items.map {$0}
        }
    }
    
    init(original: MultipleSectionModel, items: [SectionItem]) {
        switch original {
        case let .newMatchSection(title: title, items: _):
            self = .newMatchSection(title: title, items: items)
        case let .messageSection(title, _):
            self = .messageSection(title: title, items: items)
        }
    }
}

