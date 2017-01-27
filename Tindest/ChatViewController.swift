//
//  ChatViewController.swift
//  Tindest
//
//  Created by TakuSemba on 2017/01/25.
//  Copyright © 2017年 TakuSemba. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip
import SDWebImage
import Bond

class ChatViewController: UIViewController {
    
    class func instantiateFromStoryboard() -> ChatViewController {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! ChatViewController
    }
    
    internal let disposeBag = DisposeBag()
    
    internal let viewModel = ChatViewModel()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "MyselfCell", bundle: nil), forCellReuseIdentifier: "MyselfCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let _ = viewModel.messages.observeNext { e in
            switch e.change {
            case .endBatchEditing:
                self.tableView.reloadData()
                break
            default:
                break
            }
        }
    
    }

    @IBAction func tapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ChatViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int{
        return self.viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MyselfCell", for: indexPath) as! MyselfCell
        self.tableView.rowHeight = 85
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
