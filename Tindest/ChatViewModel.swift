//
//  ChatViewModel.swift
//  Tindest
//
//  Created by TakuSemba on 2017/01/26.
//  Copyright © 2017年 TakuSemba. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Bond

protocol ChatViewModelType: class {
    
    //Input
    
    // Output
    var messages: MutableObservableArray<Message> { get }
    
}

class ChatViewModel: ChatViewModelType {
    
    private let disposeBag = DisposeBag()
    
    // Output
    let messages = MutableObservableArray<Message>([])
    
    init() {
        getMessages()
    }
    
    private func getMessages() {
        let messages = [
            Message(content: "hogehoge", date: "hogehoge", from: .me),
            Message(content: "hogehoge", date: "hogehoge", from: .me),
            Message(content: "hogehoge", date: "hogehoge", from: .me),
            Message(content: "hogehoge", date: "hogehoge", from: .me),
            Message(content: "hogehoge", date: "hogehoge", from: .me),
            Message(content: "hogehoge", date: "hogehoge", from: .me),
            Message(content: "hogehoge", date: "hogehoge", from: .me),
            Message(content: "hogehoge", date: "hogehoge", from: .me),
            Message(content: "hogehoge", date: "hogehoge", from: .me),
            Message(content: "hogehoge", date: "hogehoge", from: .me)
        ]
        
        Observable.of(messages)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {[weak self] messages in
                    self?.messages.batchUpdate({ (data) in
                        for message in messages {
                            data.append(message)
                        }
                    })
                }
            )
            .addDisposableTo(disposeBag)
    }
}
