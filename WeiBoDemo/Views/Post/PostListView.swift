//
//  PostListView.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/8.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    
    let postListCategory: PostListCategory
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            ForEach(userData.getPostList(for: postListCategory).list) { post in
                ZStack {
                    PostCell(post: post)
                    NavigationLink(destination: PostDetailView(post: post)) {
                        EmptyView()
                    }
                    .hidden()
                }
                .listRowInsets(EdgeInsets())
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(postListCategory: .recommand)
    }
}
