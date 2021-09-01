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
    
    var needShowPhotosDataArray: PublishSubject<[Photo]> = PublishSubject()
    
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
                    strongSelf.needShowPhotosDataArray.onNext(strongSelf.photosDataArray)
                case .failure(let error):
                    print(error)
                }
            case .error(let error):
                print(error)
            }
            
        }.disposed(by: disposeBag)
        
    }
    
    func search(with text: String){
        guard !text.isEmpty else {
            needShowPhotosDataArray.onNext(photosDataArray)
            return
        }
        let filterPhotos = photosDataArray.filter {
            $0.title.localizedStandardContains(text)
        }
        print("Search count: \(filterPhotos.count)")
        needShowPhotosDataArray.onNext(filterPhotos)
    }
    
    func didTappedSearchCancel(){
        needShowPhotosDataArray.onNext(photosDataArray)
    }
    
}
