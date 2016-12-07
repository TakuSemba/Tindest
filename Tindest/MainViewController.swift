//
//  MainViewController.swift
//  Tindest
//
//  Created by TakuSemba on 2016/12/07.
//  Copyright © 2016年 TakuSemba. All rights reserved.
//

import UIKit
import PagingMenuController


class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        
        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .didMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            }
        }
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    private let myPageViewController = MyPageViewController.instantiateFromStoryboard()
    private let swipeViewController = SwipeViewController.instantiateFromStoryboard()
    private let messageViewController = MessageViewController.instantiateFromStoryboard()
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var defaultPage: Int {
        return 1
    }
    
    fileprivate var animationDuration: TimeInterval {
        return 0.000001
    }
    
    fileprivate var pagingControllers: [UIViewController] {
        return [myPageViewController, swipeViewController, messageViewController]
    }
    
    fileprivate struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .standard(widthMode: .flexible, centerItem: true, scrollingMode: .pagingEnabled)
        }
        var focusMode: MenuFocusMode {
            return .none
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2(), MenuItem3()]
        }
    }
    
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .image(image: UIImage(named: "ball")!, selectedImage: UIImage(named: "ball"))
        }
        
        var horizontalMargin: CGFloat {
            return 30
        }
    }
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .image(image: UIImage(named: "ball")!, selectedImage: UIImage(named: "ball"))
        }
        var horizontalMargin: CGFloat {
            return 30
        }
    }
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .image(image: UIImage(named: "ball")!, selectedImage: UIImage(named: "ball"))
        }
        var horizontalMargin: CGFloat {
            return 30
        }
    }
}
