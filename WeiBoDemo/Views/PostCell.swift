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
    
    var body: some View {
        VStack(alignment: .leading) {
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
                        print("Click follow button")
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
                    print("Click the comment button.")
                }
                
                Spacer()
                
                PostCellToolBarButton(image: "heart", text: post.likeCountText, color: .black) {
                    print("Click the like button.")
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
