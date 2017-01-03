//
//  CardView.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/10.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import SDWebImage

class CardView: UIView {
    
    var user: User? {
        didSet {
            update()
        }
    }

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func update(){
        name.text = "\((user?.name)!), \(Int(arc4random_uniform(20)) + 20)"
        if let imageUrl = user?.avatarUrl {
            image.sd_setImage(with: URL(string: imageUrl)!)
        }
    }
    
}
