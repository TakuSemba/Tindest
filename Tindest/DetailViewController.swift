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
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var introduction: UILabel!
    @IBOutlet weak var superlikeButton: MovableUIButton!
    @IBOutlet weak var nopeButton: MovableUIButton!
    @IBOutlet weak var likeButton: MovableUIButton!
    
    class func instantiateFromStoryboard() -> DetailViewController {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! DetailViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self

        if let imageUrl = user?.avatarUrl {
            image.sd_setImage(with: URL(string: imageUrl)!)
        }
        name.text = "\((user?.name)!), \(Int(arc4random_uniform(20)) + 20)"
        introduction.text = user?.bio
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        superlikeButton.appearFromBottom()
        nopeButton.appearFromLeft()
        likeButton.appearFromRight()
    }
    
    @IBAction func superlikeTapped(_ sender: Any) {

    }
    
    @IBAction func backToSwipe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    func copyImageView() -> UIImageView {
        let image = UIImageView(image: self.image.image)
        image.frame = self.image.convert(self.image.bounds, to: self.view)
        image.contentMode = self.image.contentMode
        return image
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentedAnimater()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissedAnimater()
    }
}
