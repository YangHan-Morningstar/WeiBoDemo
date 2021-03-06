//
//  PostListView.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/8.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI
import BBSwiftUIKit

struct PostListView: View {
    
    let postListCategory: PostListCategory
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        BBTableView(userData.getPostList(for: postListCategory).list) { post in
            NavigationLink(destination: PostDetailView(post: post)) {
                PostCell(post: post)
            }
            .buttonStyle(OriginalButtonStyle())
        }
        .bb_setupRefreshControl({ control in
            control.attributedTitle = NSAttributedString(string: "加载中")
        })
        .bb_pullDownToRefresh(isRefreshing: $userData.isRefreshing) {
            self.userData.refreshPostList(for: self.postListCategory)
        }
        .bb_pullUpToLoadMore(bottomSpace: 30) {
            self.userData.loadMorePostList(for: self.postListCategory)
        }
        .overlay (
            Text(self.userData.loadingErrorText)
            .bold()
                .frame(width: 200, height: 200)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray)
                    .opacity(0.8)
            )
            .scaleEffect(self.userData.showingLoadingError ? 1 : 0.5)
            .animation(.spring(dampingFraction: 0.5))
            .opacity(self.userData.showingLoadingError ? 1 : 0)
            .animation(.easeInOut)
        )
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(postListCategory: .recommand)
    }
}
