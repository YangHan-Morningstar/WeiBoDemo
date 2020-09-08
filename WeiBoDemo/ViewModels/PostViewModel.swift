//
//  PostViewModel.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/8.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

class PostViewModel: ObservableObject {
    @Published var postList: PostList
    
    init() {
        postList = PostList(list: [])
    }
    
    func loadPostListData(_ fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else{
            fatalError("Can not find the \(fileName) in main bundle!")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Can not load \(url)!")
        }
        
        guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
            fatalError("Can not parse post list json data!")
        }
        
        postList = list
    }
}
