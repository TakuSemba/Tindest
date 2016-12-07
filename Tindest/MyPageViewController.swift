//
//  MyPageViewController.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/07.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MyPageViewController: UIViewController, IndicatorInfoProvider {
        
    class func instantiateFromStoryboard() -> MyPageViewController {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! MyPageViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "ball")
    }

}
