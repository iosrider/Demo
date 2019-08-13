//
//  BooksListingViewModel.swift
//  HsbcTest
//
//  Created by Ankit Vyas on 12/08/19.
//  Copyright © 2019 Ankit Vyas. All rights reserved.
//

import Foundation
import Moya

// MARK: - BooksModelElement
struct BooksModelElement: Codable {
    let id, isbn: String
    let title, author: String?
    let publisher: String
    let image: String
    let v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case isbn, title, author, publisher, image
        case v = "__v"
    }
}

typealias BooksModel = [BooksModelElement]

class BooksListingViewModel {
    func getBooks(dictionary: [String: String], completion: @escaping (_ response: BooksModel?, _ error: String?)->()) {
        let ourEndpointClosure = { (target: WebService) -> Endpoint in
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        let endpoint = Endpoint(url: url,
                                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: dictionary)
            return endpoint
       }
        
        let provider = MoyaProvider<WebService>(endpointClosure: ourEndpointClosure)
        provider.request(.getBooks(dictionary: [:])) { result in
            switch result {
            case let .success(bookResponse):
                do {
                    let apiResponse = try bookResponse.map(BooksModel.self)
                    completion(apiResponse, nil)
                } catch {
                    print(error)
                    completion(nil, error.localizedDescription)
                }
            case let .failure(error):
                print("error \(error)")
                completion(nil, error.errorDescription)
            }
        }
    }
}
