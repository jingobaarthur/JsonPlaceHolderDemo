//
//  APIRouter.swift
//  JsonPlaceHolderDemo
//
//  Created by Arthur on 2021/9/1.
//

import Foundation
import Alamofire

protocol NetworkService {
    var baseURL: String {get}
    var path: String {get}
    var fullURL: String {get}
    var method: HTTPMethod {get}
}

enum APIRouter{
    case photos
}
extension APIRouter: NetworkService{
    
    var fullURL: String {
        return baseURL + path
    }
    
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self{
        case .photos:
            return "/photos"
        }
    }

    var method: HTTPMethod {
        switch self{
        case .photos:
            return .get
        }
    }
    
}
