//
//  PostCell.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/8/18.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct PostCell: View {
    
    let post: Post
    var bindingPost: Post {
        return userData.getPost(forId: post.id)!
    }
    
    @State var presentComment: Bool = false
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        var post = bindingPost
        return VStack(alignment: .leading) {
            HStack(spacing: 5) {
                loadImage(post.avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width:50, height: 50)
                    .clipShape(Circle())
                    .overlay(
                        PostVIPBadge(isVIP: post.vip)
                            .offset(x: 16, y: 16)
                )
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(post.name)
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 242 / 255, green: 99 / 255, blue: 4 / 255))
                        .lineLimit(1)
                    
                    Text(post.date)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)
                
                Spacer()
                
                if !post.isFollowed {
                    Button(action: {
                        post.isFollowed = true
                        
                        self.userData.updatePost(post)
                    }) {
                        Text("关注")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)
                            .frame(width: 50, height: 26)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color.orange, lineWidth: 1)
                        )
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            
            Text(post.text)
                .font(.system(size: 17))
            
            if !post.images.isEmpty {
                PostImageCell(images: post.images, width: UIScreen.main.bounds.size.width - 30)
            }
            
            Divider()
            
            HStack (spacing: 0) {
                Spacer()
                
                PostCellToolBarButton(image: "message", text: post.commentCountText, color: .black) {
                    self.presentComment.toggle()
                }
                .sheet(isPresented: $presentComment) {
                    CommentInputView(post: post).environmentObject(self.userData) // 模态推出中的View并不会像其他的子View那样能够使用父View的EnvironmentObject,需要自行指定该View的父View的EnvironmentObject（因为不在同级关系中）
                }
                
                Spacer()
                
                PostCellToolBarButton(image: post.isLiked ? "heart.fill" : "heart", text: post.likeCountText, color: post.isLiked ? .red : .black) {
                    if post.isLiked {
                        post.isLiked = false
                        post.likeCount -= 1
                    } else {
                        post.isLiked = true
                        post.likeCount += 1
                    }
                    
                    self.userData.updatePost(post)
                }
                
                Spacer()
            }
            
            Rectangle()
                .padding(.horizontal, -15)
                .frame(height: 10)
                .foregroundColor(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
        }
        .padding(.horizontal, 15)
        .padding(.top, 15)
    }
    
    func loadImage(_ name: String) -> Image {
        return Image(uiImage: UIImage(named: name)!)
    }
}

