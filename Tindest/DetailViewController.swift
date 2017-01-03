//
//  DetailViewController.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/22.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var user: User?
    
    class func instantiateFromStoryboard() -> DetailViewController {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! DetailViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        if let imageUrl = user?.avatarUrl {
//            image.sd_setImage(with: URL(string: imageUrl)!)
//        }
//        name.text = user?.name
//        introduction.text = user?.bio
    }
    
    @IBAction func backToSwipe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
