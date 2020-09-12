//
//  HScrollViewController.swift
//  WeiBoDemo
//
//  Created by Tony Young on 2020/9/12.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct HScrollViewController<Content: View>: UIViewControllerRepresentable {
    
    @Binding var leftPercent: CGFloat
    
    let pageWidth: CGFloat
    let contentSize: CGSize
    let content: Content // SwiftUI中的View
    
    init(leftPercent: Binding<CGFloat>, pageWidth: CGFloat, contentSize: CGSize, @ViewBuilder content: () -> Content) {
        self.pageWidth = pageWidth
        self.contentSize = contentSize
        self.content = content()
        self._leftPercent = leftPercent
    }
    
    func makeUIViewController(context: Context) ->  UIViewController {
        let scrollView = UIScrollView()
        scrollView.bounces = false // 取消回弹
        scrollView.isPagingEnabled = true // 开启分页效果
        scrollView.showsVerticalScrollIndicator = false // 取消纵向滑动条
        scrollView.showsHorizontalScrollIndicator = false // 取消横向滑动条
        scrollView.delegate = context.coordinator // 设置代理
        context.coordinator.scrollView = scrollView
        
        let viewController = UIViewController()
        viewController.view.addSubview(scrollView)
        
        let host = UIHostingController(rootView: content) // 将SwiftUI的View封装为UIKit的View
        viewController.addChild(host)
        scrollView.addSubview(host.view)
        host.didMove(toParent: viewController)
        context.coordinator.host = host
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let scrollView = context.coordinator.scrollView!
        scrollView.frame = CGRect(x: 0, y: 0, width: pageWidth, height: contentSize.height)
        scrollView.contentSize = contentSize
        scrollView.setContentOffset(CGPoint(x: leftPercent * (contentSize.width - pageWidth), y: 0), animated: true)
        context.coordinator.host.view.frame = CGRect(origin: .zero, size: contentSize)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: HScrollViewController
        var scrollView: UIScrollView!
        var host: UIHostingController<Content>!
        
        init(_ parent: HScrollViewController) {
            self.parent = parent
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            withAnimation {
                parent.leftPercent = scrollView.contentOffset.x < parent.pageWidth * 0.5 ? 0 : 1
            }
        }
    }
}
