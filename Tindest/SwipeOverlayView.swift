//
//  SwipeOverlayView.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/13.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import Koloda

private let overlayRightImageName = "nope_overlay"
private let overlayLeftImageName = "like_overlay"

class SwipeOverlayView: OverlayView {


    @IBOutlet lazy var overlayImageView: UIImageView! = {
        [unowned self] in
        
        var imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        
        return imageView
        }()
    
    
    override var overlayState: SwipeResultDirection? {
        didSet {
            switch overlayState {
            case .left? :
                print("left")
                overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .right? :
                print("right")
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
        }
    }

}
