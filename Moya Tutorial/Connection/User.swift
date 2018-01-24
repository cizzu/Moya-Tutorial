//
//  User.swift
//  Moya Tutorial
//
//  Created by Afriyandi Setiawan on 24/01/18.
//  Copyright © 2018 Afriyandi Setiawan. All rights reserved.
//

import Moya
import SwiftyJSON

enum UserServices {
    case login(username:String, password: String)
}

extension UserServices: CustomTarget {
    var path: String {
        switch self {
        case .login:
            return "post"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let username, let password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: JSONEncoding.default)
        }
    }
}

struct userDo: Request {
    typealias T = UserServices
    typealias callBackType = JSON
    
    let provider = MoyaProvider<UserServices>()
    
    func request(target: UserServices,
                 success successCallback: @escaping (JSON) -> Void,
                 error errorCallback: @escaping (Error) -> Void,
                 failure failureCallback: @escaping (MoyaError) -> Void, finish isFinish: @escaping () -> Void) {
        self.provider.request(target) { (_response) in
            defer {
                isFinish()
            }
            switch _response {
            case .success(let result):
                do {
                    let _ = try result.filterSuccessfulStatusCodes()
                    let json = try JSON(result.mapJSON())
                    successCallback(json)
                } catch let err {
                    errorCallback(err)
                }
            case .failure(let err):
                failureCallback(err)
            }
        }
    }
}
