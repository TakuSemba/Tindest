//
//  MainViewController.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/07.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import XLPagerTabStrip

//open class MainViewController: BaseButtonBarPagerTabStripViewController<ButtonBarViewCell> {
//    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    
//    required public init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//        buttonBarItemSpec = ButtonBarItemSpec.nibFile(nibName: "TabItemCell", bundle: Bundle(for: TabItemCell.self), width: { (cell: IndicatorInfo) -> CGFloat in
//            return 55.0
//        })
//    }
//
//    override open func viewDidLoad() {
//        // change selected bar color
//        super.viewDidLoad()
//    }
//    
//    override open func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
//        let child_1 = ChildExampleViewController(itemInfo: IndicatorInfo(title: " ACCOUNT", image: UIImage(named: "ball")))
//        let child_2 = ChildExampleViewController(itemInfo: IndicatorInfo(title: " ACCOUNT", image: UIImage(named: "ball")))
//        let child_3 = ChildExampleViewController(itemInfo: IndicatorInfo(title: " ACCOUNT", image: UIImage(named: "ball")))
//        return [child_1, child_2, child_3]
//    }
//    
//    open override func configureCell(cell: YoutubeIconCell, for indicatorInfo: IndicatorInfo) {
//        cell.iconImage.image = indicatorInfo.image?.withRenderingMode(.alwaysTemplate)
//    }
//    
//    override open func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//}


//open class MainViewController: BaseButtonBarPagerTabStripViewController<TabItemCell> {
//    
//    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        initialize()
//    }
//    
//    public required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        initialize()
//    }
//    
//    open func initialize(){
//        buttonBarItemSpec = .nibFile(nibName: "TabItemCell", bundle: Bundle(for: TabItemCell.self), width:{ [weak self] (childItemInfo) -> CGFloat in
//            let label = UILabel()
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.font = self?.settings.style.buttonBarItemFont ?? label.font
//            label.text = childItemInfo.title
//            let labelSize = label.intrinsicContentSize
//            return labelSize.width + CGFloat(self?.settings.style.buttonBarItemLeftRightMargin ?? 8 * 2)
//        })
//    }
//    
//    override open func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
//        let child_1 = ChildExampleViewController(itemInfo: IndicatorInfo(title: " ACCOUNT", image: UIImage(named: "ball")))
//        let child_2 = ChildExampleViewController(itemInfo: IndicatorInfo(title: " ACCOUNT", image: UIImage(named: "ball")))
//        let child_3 = ChildExampleViewController(itemInfo: IndicatorInfo(title: " ACCOUNT", image: UIImage(named: "ball")))
//        return [child_1, child_2, child_3]
//    }
//
//}

class MainViewController: BaseButtonBarPagerTabStripViewController<TabItemCell> {
    
    let redColor = UIColor(red: 221/255.0, green: 0/255.0, blue: 19/255.0, alpha: 1.0)
    let unselectedIconColor = UIColor(red: 73/255.0, green: 8/255.0, blue: 10/255.0, alpha: 1.0)
    
    
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
        settings.style.buttonBarMinimumLineSpacing = 100
        settings.style.buttonBarLeftContentInset = 150
        settings.style.buttonBarRightContentInset = 150
        settings.style.buttonBarItemLeftRightMargin = 0
        
        changeCurrentIndexProgressive = {(oldCell: TabItemCell?, newCell: TabItemCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
                guard changeCurrentIndex == true else { return }
                oldCell?.imageView.tintColor = .gray
                newCell?.imageView.tintColor = .red
    
        }
        super.viewDidLoad()
    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = ChildExampleViewController(itemInfo: IndicatorInfo(title: "profile", image: UIImage(named: "profile")))
        let child_2 = ChildExampleViewController(itemInfo: IndicatorInfo(title: "fire", image: UIImage(named: "fire")))
        let child_3 = ChildExampleViewController(itemInfo: IndicatorInfo(title: "message", image: UIImage(named: "message")))
        return [child_1, child_2, child_3]
    }
    
    
    override func configure(cell: TabItemCell, for indicatorInfo: IndicatorInfo) {
        cell.imageView.image = indicatorInfo.image?.withRenderingMode(.alwaysTemplate)
    }
    
    //    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
    //        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
    //        if indexWasChanged && toIndex > -1 && toIndex < viewControllers.count {
    //            let child = viewControllers[toIndex] as! IndicatorInfoProvider
    //            UIView.performWithoutAnimation({ [weak self] () -> Void in
    //                guard let me = self else { return }
    //                me.navigationItem.leftBarButtonItem?.title =  child.indicatorInfo(for: me).title
    //            })
    //        }
    //    }
}



