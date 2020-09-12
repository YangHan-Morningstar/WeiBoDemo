//
//  CommentInputView.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/12.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct CommentInputView: View {
    
    let post: Post
    
    @State private var text: String = ""
    @State private var showEmptyTextHUD: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userData: UserData
    @ObservedObject private var keyBoardResponder = KeyboardResponder()
    
    var body: some View {
        VStack(spacing: 0) {
            CommentTextView(beginEdittingOnAppear: true, text: $text)
            
            HStack(spacing: 0) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("取消")
                        .padding()
                }
                
                Spacer()
                
                Button(action: {
                    if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        self.showEmptyTextHUD.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            self.showEmptyTextHUD.toggle()
                        }
                    } else {
                        var post = self.post
                        
                        post.commentCount += 1
                        self.userData.updatePost(post)
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("发送")
                        .padding()
                }
            }
            .font(.system(size: 18))
            .foregroundColor(.black)
        }
        .overlay(
            Text("评论不能为空")
                .scaleEffect(showEmptyTextHUD ? 1 : 0.5)
                .animation(.spring(dampingFraction: 0.5))
                .opacity(showEmptyTextHUD ? 1 : 0)
                .animation(.easeInOut)
        )
        .padding(.bottom, keyBoardResponder.keyboardHeight)
        .edgesIgnoringSafeArea(keyBoardResponder.keyboardShow ? .bottom : [])
    }
}
