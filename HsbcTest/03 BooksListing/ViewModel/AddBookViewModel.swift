//
//  AddBookViewModel.swift
//  HsbcTest
//
//  Created by Ankit Vyas on 12/08/19.
//  Copyright © 2019 Ankit Vyas. All rights reserved.
//

import Foundation
import Moya


// MARK: - AddBook Model
struct AddBook: Codable {
    let success: Bool
    let msg: String
}

class AddBookViewModel {
    
    var bookTitle: String
    var bookAuthor: String
    var bookPublisher: String
    var bookisbn: String
    var bookImage: String

    init(bookTitle: String, bookAuthor: String,bookPublisher: String, bookisbn: String,bookImage: String ) {
        self.bookTitle = bookTitle
        self.bookAuthor = bookAuthor
        self.bookPublisher = bookPublisher
        self.bookisbn = bookisbn
        self.bookImage = bookImage
    }

    func addBook(headers: [String: String], completion: @escaping(_ response: AddBook?, _ error: String?) -> ()) {
        let ourEndpointClosure = { (target: WebService) -> Endpoint in
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            let endpoint = Endpoint(url: url,
                                    sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                    method: target.method,
                                    task: target.task,
                                    httpHeaderFields: headers)
            return endpoint
        }
        let dictionary = ["title": bookTitle, "author": bookAuthor, "isbn" : bookisbn, "publisher" : bookPublisher, "image" : bookImage]
        let provider = MoyaProvider<WebService>(endpointClosure: ourEndpointClosure)
        provider.request(.addNewBook(dictionary: dictionary)) { result in
            switch result {
            case let .success(bookResponse):
                do {
                    let apiResponse = try bookResponse.map(AddBook.self)
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
