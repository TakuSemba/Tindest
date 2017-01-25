//
//  ChatViewController.swift
//  Tindest
//
//  Created by TakuSemba on 2017/01/25.
//  Copyright © 2017年 TakuSemba. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    class func instantiateFromStoryboard() -> ChatViewController {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! ChatViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
