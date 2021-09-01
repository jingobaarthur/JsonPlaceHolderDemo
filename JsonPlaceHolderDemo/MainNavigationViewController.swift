//
//  MainNavigationViewController.swift
//  JsonPlaceHolderDemo
//
//  Created by Arthur on 2021/9/1.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let mainViewController = MainViewController()
        viewControllers = [mainViewController]
        view.backgroundColor = .white
        navigationBar.isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
