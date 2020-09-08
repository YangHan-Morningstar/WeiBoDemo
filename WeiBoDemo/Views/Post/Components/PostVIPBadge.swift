//
//  PostVIPBadge.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/7.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct PostVIPBadge: View {
    
    let isVIP: Bool
    
    var body: some View {
        Group {
            if isVIP {
                Text("V")
                    .bold()
                    .font(.system(size: 11))
                    .frame(width: 15, height: 15)
                    .foregroundColor(.yellow)
                    .background(Color.red)
                    .clipShape(Circle())
                    .overlay (
                        RoundedRectangle(cornerRadius: 7.5)
                            .stroke(Color.white, lineWidth: 1)
                )
            }
        }
    }
}

struct PostVIPBadge_Previews: PreviewProvider {
    static var previews: some View {
        PostVIPBadge(isVIP: true)
    }
}
