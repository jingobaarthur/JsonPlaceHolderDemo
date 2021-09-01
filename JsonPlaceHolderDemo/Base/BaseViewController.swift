//
//  BaseViewController.swift
//  JsonPlaceHolderDemo
//
//  Created by Arthur on 2021/9/1.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        binding()
    }
    
    func setUpUI(){
        
    }
    
    func binding(){
        
    }
}
