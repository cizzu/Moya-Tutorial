//
//  Connector.swift
//  Moya Tutorial
//
//  Created by Afriyandi Setiawan on 24/01/18.
//  Copyright © 2018 Afriyandi Setiawan. All rights reserved.
//

import Moya

extension Bundle {
    
    var baseURL: URL {
        guard let info = self.infoDictionary,
            let urlString = info["Base URL"] as? String,
            let url = URL(string: urlString) else {
                fatalError("Cannot get base url from info.plist")
        }
        return url
    }
    
    var AppKey: String {
        guard let info = self.infoDictionary,
            let appKey = info["App Key"] as? String else {
                fatalError("Cannot get App Key from info.plist")
        }
        
        return appKey
    }
}

extension URL {
    static var baseURL: URL {
        return Bundle.main.baseURL
    }
}

func joinDictionary(from arrayDict: Array<Dictionary<String, Any>>) -> Dictionary<String, Any> {
    var some = Dictionary<String, Any>()
    for dict in arrayDict {
        some += dict
    }
    return some
}

func += <K, V> (left: inout [K : V], right: [K : V]) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

protocol CustomTarget: TargetType {
}

extension CustomTarget {
    var baseURL: URL {
        return Bundle.main.baseURL
    }
    
    var headers: [String : String]? {
        return joinDictionary(from: [
            ["App-key": Bundle.main.AppKey],
            ["User-Agent": "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) (app for \(UIDevice.current.model); iOS version \(UIDevice.current.systemVersion)) ~ phe"]
            ]) as? [String: String]
    }
}

protocol Request {
    associatedtype T
    associatedtype callBackType
    func request(target: T,
                 success successCallback: @escaping (callBackType) -> Void,
                 error errorCallback: @escaping (_ statusCode: Error) -> Void,
                 failure failureCallback: @escaping (MoyaError) -> Void,
                 finish isFinish: @escaping () -> Void)
}
