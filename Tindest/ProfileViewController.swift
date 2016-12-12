//
//  ProfileViewController.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/07.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProfileViewController: UIViewController {
        
    class func instantiateFromStoryboard() -> ProfileViewController {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! ProfileViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.TindestColor.lightGray
    }

}

extension ProfileViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "profile", image: UIImage(named: "profile"))
    }
}
