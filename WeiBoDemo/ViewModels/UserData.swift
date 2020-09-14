//
//  UserData.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/12.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Combine

class UserData: ObservableObject {
    @Published var recommandPostList: PostList = loadPostListData("PostListData_recommend_1.json")
    @Published var hotPostList: PostList = loadPostListData("PostListData_hot_1.json")
    @Published var isRefershing: Bool = false
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
