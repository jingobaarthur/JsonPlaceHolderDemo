//
//  APIManager.swift
//  JsonPlaceHolderDemo
//
//  Created by Arthur on 2021/9/1.
//

import UIKit
import Alamofire
import RxSwift

enum NetworkResult<Value>{
    case success(Value)
    case failure(Error)
}
struct NetworkResponse{
    var statusCode: Int{
        return response.statusCode
    }
    var data: Data
    var response: HTTPURLResponse
}

enum APIError: Error {
    case cantParseJSON
    case networkFailed
    case unknowError
}

class APIManager: NSObject{
    
    static let share:  APIManager = APIManager()
    
    private override init() {}
    
}
extension APIManager{
    func request(router: APIRouter) -> Single<(NetworkResult<NetworkResponse>)>{
        
        return Single<(NetworkResult<NetworkResponse>)>.create { single in
            
            AF.request(router.fullURL, method: router.method).responseData { (dataResponse) in
                
                guard let response = dataResponse.response else {
                    single(.error(APIError.networkFailed))
                    return
                }
                
                switch dataResponse.result{
                case .success(let data):
                    let response = NetworkResponse(data: data, response: response)
                    guard response.statusCode != 401 else{
                        single(.error(APIError.networkFailed))
                        return
                    }
                    single(.success(.success(response)))
                case .failure(let error):
                    single(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
