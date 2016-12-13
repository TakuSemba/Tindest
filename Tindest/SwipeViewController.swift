//
//  SwipeViewController.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/07.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Koloda

class SwipeViewController: UIViewController{
    
    @IBOutlet var kolodaView: KolodaView!

    class func instantiateFromStoryboard() -> SwipeViewController {
        let storyboard = UIStoryboard(name: "Swipe", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! SwipeViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.TindestColor.lightGray
        kolodaView.backgroundColor = UIColor.TindestColor.lightGray
        kolodaView.dataSource = self
        kolodaView.delegate = self
        print("view did load")
    }
    
    @IBAction func returnTapped(_ sender: Any) {
        print("returnTapped")
    }
    
    @IBAction func nopeTapped(_ sender: Any) {
        kolodaView?.swipe(SwipeResultDirection.left)
    }
    
    @IBAction func likeTapped(_ sender: Any) {
        kolodaView?.swipe(SwipeResultDirection.right)
    }
    
    @IBAction func superLikeTapped(_ sender: Any) {
        print("superLikeTapped")
    }
    
}

extension SwipeViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "swipe", image: UIImage(named: "fire"))
    }
}

extension SwipeViewController: KolodaViewDataSource, KolodaViewDelegate {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return 10
    }
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func kolodaShouldTransparentizeNextCard(koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldMoveBackgroundCard(koloda: KolodaView) -> Bool {
        return false
    }
    
//    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
//        return Bundle.main.loadNibNamed("SwipeOverlayView", owner: self, options: nil)![0] as? OverlayView
//    }
}
