//
//  NetworkManager.swift
//  NetWorkDemo
//
//  Created by Tony Young on 2020/9/13.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkRequestResult = Result<Data, Error>
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void

private let NetworkAPIBaseURL = "https://raw.githubusercontent.com/xiaoyouxinqing/PostDemo/master/PostDemo/Resources/"

class NetworkManager {
    // 将NetworkManager设置为单例模式
    static let shared = NetworkManager()
    
    private init() {}
    
    var commonHeaders: HTTPHeaders {
        return ["Users_id": "123", "token": "XXXXXX"]
    }
    
    @discardableResult
    func requestGet(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   parameters: parameters,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15 })
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
                }
        }
    }
    
    @discardableResult
    func requestPost(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.prettyPrinted,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15 })
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
                }
        }
    }
    
    private func handleError(_ error: AFError) -> NetworkRequestResult {
        if let underlyingError = error.underlyingError {
            let nsError = underlyingError as NSError
            let code = nsError.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost {
                var userInfo = nsError.userInfo
                userInfo[NSLocalizedDescriptionKey] = "网络连接有点问题哦～"
                let currentError = NSError(domain: nsError.domain, code: code, userInfo: userInfo)
                
                return .failure(currentError)
            }
        }
        
        return .failure(error)
    }
}
