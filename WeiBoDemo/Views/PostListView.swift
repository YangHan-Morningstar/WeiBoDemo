//
//  PostListView.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/8.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    
    @ObservedObject var postVM = PostViewModel()
    
    init() {
        // 隐藏UITableView默认分割线
        UITableView.appearance().separatorStyle = .none
        // 取消点击每个UITableView的Cell时瞬间变暗效果
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        List {
            ForEach(postVM.postList.list) { post in
                PostCell(post: post)
                    .listRowInsets(EdgeInsets())
            }
        }
        .onAppear() {
            self.postVM.loadPostListData("PostListData_recommend_1.json")
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
