//
//  SwipeToDetailTransition.swift
//  Tindest
//
//  Created by TakuSemba on 2017/01/11.
//  Copyright © 2017年 TakuSemba. All rights reserved.
//

import UIKit

class PresentedAnimater : NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        
        let container = transitionContext.containerView
        
        let imageView = ((fromVC as! MainViewController).childViewControllers[0] as! SwipeViewController).copyImageView()
        let destImageViewRect = (toVC as! DetailViewController).copyImageView().frame
        container.addSubview(toVC.view)
        container.addSubview(imageView)
        toVC.view.alpha = 0.0
        UIView.animate(withDuration: duration, delay: 0.01, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            toVC.view.alpha = 1.0
            imageView.frame = destImageViewRect
        }, completion: {_ in
            imageView.isHidden = true
            transitionContext.completeTransition(true)
        })
    }
}

class DismissedAnimater : NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        
        let container = transitionContext.containerView
        
        let imageView = (fromVC as! DetailViewController).copyImageView()
        let destImageViewRect = ((toVC as! MainViewController).childViewControllers[0] as! SwipeViewController).copyImageView().frame
        container.addSubview(toVC.view)
        container.addSubview(imageView)
        toVC.view.alpha = 0.0
        UIView.animate(withDuration: duration, delay: 0.01, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            toVC.view.alpha = 1.0
            imageView.frame = destImageViewRect
        }, completion: {_ in
            transitionContext.completeTransition(true)
        })
    }
}
