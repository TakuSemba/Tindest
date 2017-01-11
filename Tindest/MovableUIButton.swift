//
//  MovableUIButton.swift
//  Tindest
//
//  Created by TakuSemba on 2017/01/11.
//  Copyright © 2017年 TakuSemba. All rights reserved.
//

import UIKit

class MovableUIButton: UIButton {
    
    let repeatCount: Float = 1
    let dumping: CGFloat = 15
    let duration: Double = 1
    let initialVelocity: CGFloat = 15
    
    let fromBottomKey = "appearFromBottom"
    let fromRightKey = "appearFromBottom"
    let fromLeftKey = "appearFromBottom"
    
    func appearFromBottom(){
        let animation = CASpringAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.damping = dumping
        animation.initialVelocity = initialVelocity
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y + 100))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y))
        
        self.layer.add(animation, forKey: fromBottomKey)
    }
    
    func appearFromRight(){
        let animation = CASpringAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.damping = dumping
        animation.initialVelocity = initialVelocity
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x + 100, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y))
        
        self.layer.add(animation, forKey: fromRightKey)
    }
    
    func appearFromLeft(){
        let animation = CASpringAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.damping = dumping
        animation.initialVelocity = initialVelocity
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 100, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y))
        
        self.layer.add(animation, forKey: fromLeftKey)
    }
}
