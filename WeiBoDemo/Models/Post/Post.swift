//
//  Post.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/8.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import Foundation

struct PostList: Codable {
    var list: [Post]
}

struct Post: Codable, Identifiable {
    let id: Int //用户id
    let avatar: String //用户头像
    let vip: Bool //是否是VIP
    let name: String //用户昵称
    let date: String //发布微博日期
    var isFollowed: Bool //是否被关注
    let text: String //微博内容
    let images: [String] //微博图片
    var commentCount: Int //评论数目
    var likeCount: Int //喜欢数目
    var isLiked: Bool //是否喜欢
}

extension Post {
    var commentCountText: String {
        if commentCount <= 0 {
            return "评论"
        } else if commentCount < 1000 {
            return "\(commentCount)"
        } else {
            return String(format: "%.1fK", Double(commentCount) / 1000)
        }
    }
    
    var likeCountText: String {
        if likeCount <= 0 {
            return "点赞"
        } else if likeCount < 1000 {
            return "\(likeCount)"
        } else {
            return String(format: "%.1fK", Double(likeCount) / 1000)
        }
    }
}

extension Post: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

func loadPostListData(_ fileName: String) -> PostList {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else{
        fatalError("Can not find the \(fileName) in main bundle!")
    }
    
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Can not load \(url)!")
    }
    
    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
        fatalError("Can not parse post list json data!")
    }
    
    return list
}
