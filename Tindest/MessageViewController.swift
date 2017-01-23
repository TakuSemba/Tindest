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
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sections: [MultipleSectionModel] = [
            .newMatchRowSection(title: "Section 1",
                                    items: [.newMatchRowItem()]),
            .messageUsersSection(title: "Section 2",
                               items: [.messageUsersItem(user: User(name: "taku", location: "japan", avatarUrl: "https://developers.cyberagent.co.jp/blog/wp-content/uploads/2017/01/chateau_top.jpg"))])
        ]
        
        let dataSource = RxTableViewSectionedReloadDataSource<MultipleSectionModel>()
        skinTableViewDataSource(dataSource)
        self.tableView.delegate = self
        
        Observable.just(sections)
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        let _ = viewModel.newMatchedUsers.observeNext { [weak self] e in
            switch e.change {
                case .endBatchEditing:
                    self?.collectionView.reloadData()
                    break
                default:
                    break
            }
        }
    
    }
    
    func skinTableViewDataSource(_ dataSource: RxTableViewSectionedReloadDataSource<MultipleSectionModel>) {
        dataSource.configureCell = { (dataSource, table, indexPath, _) in
            switch dataSource[indexPath] {
            case .newMatchRowItem:
                let cell: MessageCollectionView = Bundle.main.loadNibNamed("MessageCollectionView", owner: self, options: nil)?.first as! MessageCollectionView
                cell.collectionView.dataSource = self
                self.collectionView = cell.collectionView
                
                let nib = UINib(nibName: "MatchCollectionViewCell", bundle: nil)
                cell.collectionView.register(nib, forCellWithReuseIdentifier: "MatchCollectionViewCell")
                return cell
            case let .messageUsersItem(user):
                let cell = Bundle.main.loadNibNamed("MessageTableViewCell", owner: self, options: nil)?.first as! MessageTableViewCell
                cell.name.text = user.name
                cell.message.text = user.location
                if let thumbnail = user.avatarUrl {
                    cell.thumbnail.sd_setImage(with: URL(string: thumbnail)!)
                }
                return cell
            }
        }
    }

}

extension MessageViewController: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "message", image: UIImage(named: "message"))
    }
}

extension MessageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.newMatchedUsers.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchCollectionViewCell", for: indexPath as IndexPath) as! MatchCollectionViewCell
            cell.name.text = viewModel.newMatchedUsers[indexPath.item].name
            if let thumbnail = viewModel.newMatchedUsers[indexPath.item].avatarUrl {
                cell.thumbnail.sd_setImage(with: URL(string: thumbnail)!)
            }
        return cell
    }
}

extension MessageViewController : UITableViewDelegate {
    
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

enum MultipleSectionModel {
    case newMatchRowSection(title: String, items: [SectionItem])
    case messageUsersSection(title: String, items: [SectionItem])
}

enum SectionItem {
    case newMatchRowItem()
    case messageUsersItem(user: User)
}

extension MultipleSectionModel: SectionModelType {
    
    var items: [SectionItem] {
        switch  self {
        case .newMatchRowSection(title: _, items: let items):
            return items.map {$0}
        case .messageUsersSection(title: _, items: let items):
            return items.map {$0}
        }
    }
    
    init(original: MultipleSectionModel, items: [SectionItem]) {
        switch original {
        case let .newMatchRowSection(title: title, items: _):
            self = .newMatchRowSection(title: title, items: items)
        case let .messageUsersSection(title, _):
            self = .messageUsersSection(title: title, items: items)
        }
    }
}



