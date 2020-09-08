//
//  PostCellToolBarButton.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/8.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct PostCellToolBarButton: View {
    
    let image: String
    let text: String
    let color: Color
    let action: () -> Void //closure
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                
                Text(text)
                    .font(.system(size: 15))
            }
        }
        .foregroundColor(color)
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct PostCellToolBarButton_Previews: PreviewProvider {
    static var previews: some View {
        PostCellToolBarButton(image: "heart", text: "点赞", color: .red) {
            print("点赞")
        }
    }
}
