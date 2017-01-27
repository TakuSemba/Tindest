//
//  MessageViewController.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/07.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip
import SDWebImage
import Bond

class MessageViewController: UIViewController {
    
    class func instantiateFromStoryboard() -> MessageViewController {
        let storyboard = UIStoryboard(name: "Message", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! MessageViewController
    }
    
    internal let disposeBag = DisposeBag()
    
    internal let viewModel = MessageViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MessageCollectionView", bundle: nil), forCellReuseIdentifier: "MessageCollectionView")
        self.tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -20, 0);
        
        self.tableView.rx.itemSelected
            .subscribe(
                onNext: { indexPath in
                    let chat = ChatViewController.instantiateFromStoryboard()
                    let navigationController = UINavigationController(rootViewController: chat)
                    self.present(navigationController, animated: true, completion: nil)
                }
            )
            .addDisposableTo(self.disposeBag)
        
        viewModel.messageUsers
            .asObservable()
            .subscribe(
                onNext: { [weak self] users in
                    self?.tableView.reloadData()
                }
            )
            .addDisposableTo(disposeBag)
    
    }

}

extension MessageViewController: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "message", image: UIImage(named: "message"))
    }
}

extension MessageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.newMatchedUsers.value.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchCollectionViewCell", for: indexPath as IndexPath) as! MatchCollectionViewCell
            cell.name.text = viewModel.newMatchedUsers.value[indexPath.item].name
            if let thumbnail = viewModel.newMatchedUsers.value[indexPath.item].avatarUrl {
                cell.thumbnail.sd_setImage(with: URL(string: thumbnail)!)
            } else {
                cell.thumbnail.image = UIImage(named: "profile_picture.png")
            }
        return cell
    }
}

extension MessageViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int{
        var sectionNum: Int = 0
        
        if section == 0 {
            sectionNum = 1
        } else if section == 1{
            sectionNum = self.viewModel.messageUsers.value.count
        }
        
        return sectionNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.section == 0 {
            self.tableView.rowHeight = 120
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "MessageCollectionView", for: indexPath) as! MessageCollectionView

            cell.collectionView.dataSource = self
            
            viewModel.newMatchedUsers
                .asObservable()
                .subscribe(
                    onNext: {users in
                        cell.collectionView.reloadData()
                    }
                )
                .addDisposableTo(disposeBag)
            
            cell.collectionView.rx.itemSelected
                .bindTo(self.viewModel.collectionItemDidSelect)
                .addDisposableTo(self.disposeBag)
            
            
            let nib = UINib(nibName: "MatchCollectionViewCell", bundle: nil)
            cell.collectionView.register(nib, forCellWithReuseIdentifier: "MatchCollectionViewCell")
            return cell
            
        } else{
            self.tableView.rowHeight = 100
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
            cell.name.text = self.viewModel.messageUsers.value[indexPath.item].name
            cell.message.text = self.viewModel.messageUsers.value[indexPath.item].location
            if let thumbnail = self.viewModel.messageUsers.value[indexPath.item].avatarUrl {
                cell.thumbnail.sd_setImage(with: URL(string: thumbnail)!)
            } else {
                cell.thumbnail.image = UIImage(named: "profile_picture.png")
            }
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("MessageSectionHeaderView", owner: self, options: nil)?.first as! MessageSectionHeaderView
        
        if section == 0 {
            view.title.text = "New Matches"
        } else if section == 1 {
         view.title.text = "Messages"
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}
