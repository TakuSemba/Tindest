//
//  SwipeViewController.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/07.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        textLabel.center = view.center
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 24)
        textLabel.text = "View Controller 1"
        view.addSubview(textLabel)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
