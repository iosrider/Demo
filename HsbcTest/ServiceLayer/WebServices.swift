//
//  WebServices.swift
//  HsbcTest
//
//  Created by Ankit Vyas on 11/08/19.
//  Copyright © 2019 Ankit Vyas. All rights reserved.
//

import Foundation
import Moya

enum WebService {
    case loginUser(userName: String, password: String)
    case getBooks(dictionary: [String: String])
    case addNewBook(dictionary: [String: String])
}

// MARK: - TargetType Protocol Implementation
extension WebService: TargetType {
    
    var baseURL: URL { return URL(string: "http://13.70.7.71:8080/api")!}
    
    var path: String {
        switch self {
        case .loginUser(_,_):
              return "/signin"
        case .getBooks(_):
            return "/book"
        case .addNewBook(_):
            return "/book"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loginUser:
            return .post
        case .getBooks:
            return .get
        case .addNewBook:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .loginUser(userName,password):
             return .requestParameters(parameters:["username": userName, "password": password], encoding: JSONEncoding.default)
        case let .getBooks(dictionary):
            return .requestParameters(parameters: dictionary, encoding: URLEncoding.queryString)
        case let .addNewBook(dictionary):
            return .requestParameters(parameters: dictionary, encoding: JSONEncoding.default)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .loginUser(let userName, let password):
            return "{\"username\": \"\(userName)\", \"password\": \"\(password)\"}".utf8Encoded
        case .getBooks, .addNewBook:
            return Data()
            
        }
    }
    
    var headers: [String : String]? {
         return ["Content-type": "application/json"]
    }
    
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
