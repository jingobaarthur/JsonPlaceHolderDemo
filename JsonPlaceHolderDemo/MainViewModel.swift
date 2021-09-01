//
//  MainViewModel.swift
//  JsonPlaceHolderDemo
//
//  Created by Arthur on 2021/9/1.
//

import Foundation
import RxSwift

class MainViewModel{
    
    private let disposeBag = DisposeBag()
    
    var photosDataArray: [Photo] = []
    
    var needShowPhotosDataArray: [Photo] = []
    
    func getPhotosData(){
        APIManager.share.request(router: .photos).subscribe { [weak self] (event) in
            guard let strongSelf = self else {return}
            switch event{
            case .success(let response):
                switch response{
                case .success(let dataResponse):
                    guard let parser = try? JSONDecoder().decode([Photo].self, from: dataResponse.data) else {
                        return
                    }
                    strongSelf.photosDataArray = parser
                    //print("PhotoDataArray count:\(strongSelf.photosDataArray.count)")
                case .failure(let error):
                    print(error)
                }
            case .error(let error):
                print(error)
            }
            
        }.disposed(by: disposeBag)
        
    }
    
}
