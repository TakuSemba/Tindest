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
import RxDataSources

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
        
        self.tableView.register(UINib(nibName: "NewMatchView", bundle: nil), forCellReuseIdentifier: "NewMatchView")
        self.tableView.register(UINib(nibName: "MessageView", bundle: nil), forCellReuseIdentifier: "MessageView")
        
        let dataSource = RxTableViewSectionedReloadDataSource<MultipleSectionModel>()

        dataSource.configureCell = { (dataSource, table, indexPath, _) in
            switch dataSource[indexPath] {
            case .newMatch:
                self.tableView.rowHeight =  120
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewMatchView", for: indexPath) as! NewMatchView
                cell.collectionView.register(UINib(nibName: "MatchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MatchCollectionViewCell")
                
                self.viewModel.newMatchedUsers.asObservable()
                    .bindTo(cell.collectionView.rx.items(cellIdentifier: "MatchCollectionViewCell", cellType: MatchCollectionViewCell.self)) { index, user, cell in
                        cell.name.text = user.name
                        if let thumbnail = user.avatarUrl {
                            cell.thumbnail.sd_setImage(with: URL(string: thumbnail)!)
                        }
                    }
                    .addDisposableTo(self.disposeBag)
        
                return cell
            case .message:
//                self.tableView.rowHeight =  CGFloat(self.viewModel.messageUsers.value.count * 100)
                self.tableView.rowHeight =  1000
                
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "MessageView", for: indexPath) as! MessageView
                cell.collectionView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellWithReuseIdentifier: "MessageTableViewCell")
                
                self.viewModel.newMatchedUsers.asObservable()
                    .bindTo(cell.collectionView.rx.items(cellIdentifier: "MessageTableViewCell", cellType: MessageTableViewCell.self)) { index, user, cell in
                        cell.name.text = user.name
                        if let thumbnail = user.avatarUrl {
                            cell.thumbnail.sd_setImage(with: URL(string: thumbnail)!)
                        }
                    }
                    .addDisposableTo(self.disposeBag)
                
                return cell
            }
        }
        
//        self.tableView.rx.setDelegate(self)
//            .addDisposableTo(disposeBag)
        
        self.tableView.rx.itemSelected
            .bindTo(self.viewModel.itemDidSelect)
            .addDisposableTo(self.disposeBag)
        
        self.viewModel.sections.asObservable()
            .bindTo(self.tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
    }

}

extension MessageViewController: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "message", image: UIImage(named: "message"))
    }
}

extension MessageViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("MessageSectionHeaderView", owner: self, options: nil)?.first as! MessageSectionHeaderView
        view.title.text = self.viewModel.sections.value[section].title
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}



