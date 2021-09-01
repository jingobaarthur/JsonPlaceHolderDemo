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
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = nil
        tableview.delegate = nil
        tableview.estimatedRowHeight = UITableView.automaticDimension
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellID)
        return tableview
    }()
    
    private lazy var searchControl: UISearchController = {
        let searchControl = UISearchController(searchResultsController: nil)
        searchControl.obscuresBackgroundDuringPresentation = false
        searchControl.searchBar.placeholder = "Please enter to search"
        return searchControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        binding()
        viewModel.getPhotosData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
extension MainViewController{
    func setUpUI(){
        title = "Json Place Holder"
        view.backgroundColor = .white
        navigationItem.searchController = searchControl
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func binding(){
        
        viewModel.needShowPhotosDataArray.bind(to: tableView.rx.items(cellIdentifier: MainTableViewCell.cellID)){ (row, photo, cell) in
            guard let cell = cell as? MainTableViewCell else {return}
            cell.configuration(with: photo)
        }.disposed(by: disposeBag)

        searchControl.searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .filter({ !$0.isEmpty })
            .subscribe(onNext: { [weak self] (query) in
                print("Search bar did enter text: \(query)")
                self?.viewModel.search(with: query)
            }).disposed(by: disposeBag)
        
        searchControl.searchBar.rx
            .cancelButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] (event) in
                print("Search bar did tapped cancel")
                self?.searchControl.searchBar.resignFirstResponder()
                self?.viewModel.didTappedSearchCancel()
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Photo.self).subscribe(onNext: { (model) in
            print("Cell didSelected--->", model)
            }).disposed(by: disposeBag)
        
    }
}

