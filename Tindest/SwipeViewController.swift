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
import Pulsator

class SwipeViewController: UIViewController{
    
    internal let viewModel = SwipeViewModel()
    
    @IBOutlet weak var kolodaView: CustomKolodaView!
    @IBOutlet weak var sourceView: UIView!
    @IBOutlet weak var image: UIImageView!

    var selectedImage: UIImageView!
    
    let pulsator = Pulsator()
    
    class func instantiateFromStoryboard() -> SwipeViewController {
        let storyboard = UIStoryboard(name: "Swipe", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! SwipeViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.TindestColor.lightGray
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        image.layer.superlayer?.insertSublayer(pulsator, below: image.layer)
        pulsator.backgroundColor = UIColor.TindestColor.mainRed.cgColor
        pulsator.radius = 180.0
        pulsator.numPulse = 3
        startPulse()
        
        let _ = viewModel.swipableUsers.observeNext { [weak self] e in
            switch e.change {
            case .endBatchEditing:
                self?.kolodaView.reloadData()
                break
            default:
                break
            }
        }
    }
    
    internal func startPulse(){
        if(!pulsator.isPulsating){
            pulsator.start()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        image.layer.layoutIfNeeded()
        pulsator.position = image.layer.position
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

extension SwipeViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return viewModel.swipableUsers.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let cardView: CardView = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CardView
        cardView.user = viewModel.swipableUsers[index]
        return cardView
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("SwipeOverlayView",owner: self, options: nil)![0] as? SwipeOverlayView
    }
}

extension SwipeViewController: KolodaViewDelegate {
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        
        let detail = DetailViewController.instantiateFromStoryboard()
        detail.user = viewModel.swipableUsers[index]
        selectedImage = (koloda.viewForCard(at: index) as! CardView).image
        self.present(detail, animated: true, completion: nil)
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        viewModel.getSwipableUsers()
    }
}

extension SwipeViewController {
    
    func copyImageView() -> UIImageView {
        let image = UIImageView(image: self.selectedImage.image)
        image.frame = self.selectedImage.convert(self.selectedImage.bounds, to: self.parent?.view)
        image.contentMode = self.selectedImage.contentMode
        return image
    }
}
