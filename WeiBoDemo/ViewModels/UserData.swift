//
//  UserData.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/12.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation
import Combine

class UserData: ObservableObject {
    @Published var recommandPostList: PostList = loadPostListData("PostListData_recommend_1.json")
    @Published var hotPostList: PostList = loadPostListData("PostListData_hot_1.json")
    @Published var isRefreshing: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var loadingError: Error?
    
    var showingLoadingError: Bool {
        return loadingError != nil
    }
    
    var loadingErrorText: String {
        return loadingError?.localizedDescription ?? ""
    }
    
    private var recommandPostDict: [Int: Int] = [:] // id: Index
    private var hotPostDict: [Int: Int] = [:] // id: index
    
    init() {
        for i in 0..<recommandPostList.list.count {
            self.recommandPostDict[recommandPostList.list[i].id] = i
        }
        
        for i in 0..<hotPostList.list.count {
            self.hotPostDict[hotPostList.list[i].id] = i
        }
    }
    
    func refreshPostList(for postListCategory: PostListCategory) {
        switch postListCategory {
        case .recommand:
            NetworkAPI.getRecommendPostList { result in
                switch result {
                case let .success(list): self.handleRefreshPostList(list, for: postListCategory)
                case let .failure(error): self.handleLoadingError(error)
                }
                
                self.isRefreshing.toggle()
            }
        case .hot:
            NetworkAPI.getHotPostList { result in
                switch result {
                case let .success(list): self.handleRefreshPostList(list, for: postListCategory)
                case let .failure(error): self.handleLoadingError(error)
                }
                
                self.isRefreshing.toggle()
            }
        }
    }
    
    func loadMorePostList(for postListCategory: PostListCategory) {
        if self.isLoadingMore || getPostList(for: postListCategory).list.count > 10 {
            return
        }
        self.isLoadingMore.toggle()
        
        switch postListCategory {
        case .recommand:
            NetworkAPI.getHotPostList { result in
                switch result {
                case let .success(list): self.handleLoadMorePostList(list, for: postListCategory)
                case let .failure(error): self.handleLoadingError(error)
                }
                
                self.isLoadingMore.toggle()
            }
        case .hot:
            NetworkAPI.getRecommendPostList { result in
                switch result {
                case let .success(list): self.handleLoadMorePostList(list, for: postListCategory)
                case let .failure(error): self.handleLoadingError(error)
                }
                
                self.isLoadingMore.toggle()
            }
        }
    }
    
    private func handleRefreshPostList(_ postList: PostList, for postCategory: PostListCategory) {
        var tempList: [Post] = []
        var tempDict: [Int: Int] = [:]
        
        for (index, post) in postList.list.enumerated() {
            if tempDict[post.id] != nil {
                continue
            }
            tempList.append(post)
            tempDict[post.id] = index
        }
        
        switch postCategory {
        case .recommand:
            self.recommandPostList.list = tempList
            self.recommandPostDict = tempDict
        case .hot:
            self.hotPostList.list = tempList
            self.hotPostDict = tempDict
        }
    }
    
    private func handleLoadMorePostList(_ postList: PostList, for postCategory: PostListCategory) {
        switch postCategory {
        case .recommand:
            for post in postList.list {
                if self.recommandPostDict[post.id] != nil {
                    continue
                }
                
                self.recommandPostList.list.append(post)
                self.recommandPostDict[post.id] = self.recommandPostList.list.count - 1
            }
        case .hot:
            for post in postList.list {
                if self.hotPostDict[post.id] != nil {
                    continue
                }
                
                self.hotPostList.list.append(post)
                self.hotPostDict[post.id] = self.hotPostList.list.count - 1
            }
        }
    }
    
    private func handleLoadingError(_ error: Error) {
        self.loadingError = error
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadingError = nil
        }
    }
    
    // 获取特定种类的微博列表
    func getPostList(for postListCatogory: PostListCategory) -> PostList {
        switch postListCatogory {
        case .recommand:
            return recommandPostList
        case .hot:
            return hotPostList
        }
    }
    
    // 根据字典获取某条微博
    func getPost(forId id: Int) -> Post? {
        if let index = recommandPostDict[id] {
            return recommandPostList.list[index]
        }
        
        if let index = hotPostDict[id] {
            return hotPostList.list[index]
        }
        
        return nil
    }
    
    func updatePost(_ post: Post) {
        if let index = recommandPostDict[post.id] {
            recommandPostList.list[index] = post
        }
        
        if let index = hotPostDict[post.id] {
            hotPostList.list[index] = post
        }
    }
}
