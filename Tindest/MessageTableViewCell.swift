//
//  MessageTableViewCell.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/12.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
