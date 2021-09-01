//
//  ViewController.swift
//  JsonPlaceHolderDemo
//
//  Created by Arthur on 2021/9/1.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    fileprivate let viewModel = MainViewModel()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = UITableView.automaticDimension
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellID)
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewModel.getPhotosData()
    }
}
extension MainViewController{
    func setUpUI(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellID, for: indexPath) as! MainTableViewCell
        return cell
    }

}
