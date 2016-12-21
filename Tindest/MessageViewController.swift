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

class MessageViewController: UIViewController {
    
    class func instantiateFromStoryboard() -> MessageViewController {
        let storyboard = UIStoryboard(name: "Message", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! MessageViewController
    }
    
    internal let disposeBag = DisposeBag()
    
    internal let viewModel = MessageViewModel()
    
    internal var messageUsers: [User] = []
    
    internal var newMatchedUsers: [User] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsetsMake(0, 0, -20, 0);
        
        viewModel.messageUsers.subscribe(onNext: { (user) in
                self.messageUsers.append(user)
            }).addDisposableTo(disposeBag)
        
        viewModel.newMatchedUsers.subscribe(onNext: { (user) in
            self.newMatchedUsers.append(user)
        }).addDisposableTo(disposeBag)
        
        viewModel.messageUsersState.asObservable().subscribe(onNext: { (viewState) in
            switch viewState {
                case .complete :
                    self.tableView.reloadData()
                    break
                default: break
            }
        }).addDisposableTo(disposeBag)
        
        viewModel.newMatchedUsersState.asObservable().subscribe(onNext: { (viewState) in
            switch viewState {
            case .complete :
                self.collectionView.reloadData()
                break
            default: break
            }
        }).addDisposableTo(disposeBag)
        
        viewModel.getMessageUsers()
        viewModel.getNewMatchedusers()
    }

}

extension MessageViewController: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "message", image: UIImage(named: "message"))
    }
}

extension MessageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print (newMatchedUsers.count)
        return newMatchedUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchCollectionViewCell", for: indexPath as IndexPath) as! MatchCollectionViewCell
            cell.name.text = newMatchedUsers[indexPath.item].name
            if let thumbnail = self.messageUsers[indexPath.item].avatarUrl {
                cell.thumbnail.sd_setImage(with: URL(string: thumbnail)!)
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
            sectionNum = self.messageUsers.count
        }
        
        return sectionNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.section == 0 {
            let cell: MessageCollectionView = Bundle.main.loadNibNamed("MessageCollectionView", owner: self, options: nil)?.first as! MessageCollectionView
            cell.collectionView.dataSource = self
            collectionView = cell.collectionView
            
            let nib = UINib(nibName: "MatchCollectionViewCell", bundle: nil)
            cell.collectionView.register(nib, forCellWithReuseIdentifier: "MatchCollectionViewCell")
            return cell
            
        } else{
            let cell = Bundle.main.loadNibNamed("MessageTableViewCell", owner: self, options: nil)?.first as! MessageTableViewCell
            cell.name.text = self.messageUsers[indexPath.item].name
            cell.message.text = self.messageUsers[indexPath.item].location
            if let thumbnail = self.messageUsers[indexPath.item].avatarUrl {
                cell.thumbnail.sd_setImage(with: URL(string: thumbnail)!)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.addUser()
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
