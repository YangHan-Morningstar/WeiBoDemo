//
//  NetworkAPI.swift
//  NetWorkDemo
//
//  Created by Tony Young on 2020/9/13.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation
import Alamofire

class NetworkAPI {
    
    @discardableResult
    static func getRecommendPostList(completion: @escaping (Result<PostList, Error>) -> Void) -> DataRequest {
        NetworkManager.shared.requestGet(path: "PostListData_recommend_1.json", parameters: nil) { result in
            switch result {
            case let .success(data):
                let result: Result<PostList, Error> = self.parseData(data)
                completion(result)
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    @discardableResult
    static func getHotPostList(completion: @escaping (Result<PostList, Error>) -> Void) ->DataRequest {
        NetworkManager.shared.requestGet(path: "PostListData_hot_1.json", parameters: nil) { result in
            switch result {
            case let .success(data):
                let parseResult: Result<PostList, Error> = self.parseData(data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func createPost(_ text: String, completion: @escaping (Result<Post, Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "createpost", parameters: ["text": text]) { result in
            switch result {
            case let .success(data):
                let parseResult: Result<Post, Error> = self.parseData(data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private static func parseData<T: Decodable>(_ data: Data) -> Result<T, Error> {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            let error = NSError(domain: "NetworkAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not parse data!"])
            return .failure(error)
        }
        return .success(decodedData)
    }
}
