//
//  LoginViewModel.swift
//  HsbcTest
//
//  Created by Ankit Vyas on 11/08/19.
//  Copyright © 2019 Ankit Vyas. All rights reserved.
//

import Foundation
import Moya
//
// MARK: - LoginModel
struct LoginModel: Codable {
    let success: Bool
    let token: String
}

class LoginViewModel {
    var userName: String
    var password: String
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    
    func login(completion: @escaping (_ response: LoginModel?, _ error: String?)->()) {
        let provider = MoyaProvider<WebService>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.loginUser(userName: userName, password: password)) { result in
            switch result {
            case let .success(loginResponse):
                do {
                    let apiResponse = try loginResponse.map(LoginModel.self)
                    completion(apiResponse, nil)
                } catch {
                    completion(nil, "Authentication Failed. Please Enter Valid UserName and Password")
                }
            case .failure(_):
                completion(nil, "Something Went Wrong Please try again")
            }
        }
    }
    
}
