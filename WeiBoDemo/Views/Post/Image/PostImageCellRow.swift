//
//  PostImageCellRow.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/8.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct PostImageCellRow: View {
    
    let images: [String]
    let width: CGFloat
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(images, id: \.self) { imageName in
                self.loadImage(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: (self.width - CGFloat(6 * (self.images.count - 1))) / CGFloat(self.images.count), height: (self.width - CGFloat(6 * (self.images.count - 1))) / CGFloat(self.images.count))
                    .clipped()
            }
        }
    }
    
    func loadImage(_ name: String) -> Image {
        return Image(uiImage: UIImage(named: name)!)
    }
}

