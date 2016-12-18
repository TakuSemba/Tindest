//
//  MainViewController.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/07.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MainViewController: BaseButtonBarPagerTabStripViewController<TabItemCell> {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        buttonBarItemSpec = ButtonBarItemSpec.nibFile(nibName: "TabItemCell", bundle: Bundle(for: TabItemCell.self), width: { (cell: IndicatorInfo) -> CGFloat in
            return 55.0
        })
    }
    
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = .clear
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = false
        settings.style.buttonBarMinimumLineSpacing = view.frame.width/4
        settings.style.buttonBarLeftContentInset = 200
        settings.style.buttonBarRightContentInset = 200
        settings.style.buttonBarItemLeftRightMargin = 0
        
        changeCurrentIndexProgressive = {(oldCell: TabItemCell?, newCell: TabItemCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
                guard changeCurrentIndex == true else { return }
                oldCell?.imageView.tintColor = UIColor.TindestColor.darkGray
                newCell?.imageView.tintColor = UIColor.TindestColor.mainRed
    
        }
        
        moveToViewController(at: 1, animated: false)
        super.viewDidLoad()
    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [ProfileViewController.instantiateFromStoryboard(), SwipeViewController.instantiateFromStoryboard(), MessageViewController.instantiateFromStoryboard()]
    }
    
    
    override func configure(cell: TabItemCell, for indicatorInfo: IndicatorInfo) {
        cell.imageView.image = indicatorInfo.image?.withRenderingMode(.alwaysTemplate)
    }
}


