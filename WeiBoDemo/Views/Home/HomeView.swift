//
//  HomeView.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/12.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var leftPercent: CGFloat = 0
    
    init() {
        // 隐藏UITableView默认分割线
        UITableView.appearance().separatorStyle = .none
        // 取消点击每个UITableView的Cell时瞬间变暗效果
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                HScrollViewController(leftPercent: self.$leftPercent, pageWidth: geo.size.width, contentSize: CGSize(width: geo.size.width * 2, height: geo.size.height)) {
                    HStack(spacing: 0) {
                        PostListView(postListCategory: .recommand)
                            .frame(width: UIScreen.main.bounds.width)
                        PostListView(postListCategory: .hot)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(leading: HomeNavigationBar(leftPercent: $leftPercent))
            .navigationBarTitle("首页", displayMode: .inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
