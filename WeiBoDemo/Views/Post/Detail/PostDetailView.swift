//
//  PostDetailView.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/12.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    
    var body: some View {
        List {
            PostCell(post: post)
                .listRowInsets(EdgeInsets())
            
            ForEach(1...10, id: \.self) { i in
                Text("评论\(i)")
            }
        }
        .navigationBarTitle("详情", displayMode: .inline)
    }
}
