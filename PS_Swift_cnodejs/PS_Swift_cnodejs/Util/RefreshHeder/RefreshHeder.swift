//
//  RefreshHeder.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/28.
//  Copyright © 2017年 思 彭. All rights reserved.

// 自定义 MJRefreshGifHeader

import MJRefresh

class RefreshHeder: MJRefreshGifHeader {

    override func prepare() {
        // 设置普通状态图片
        var normalImages = [UIImage]()
        for index in 0..<16 {
            let image = UIImage(named: "dropdown_loading_0\(index)")
            normalImages.append(image!)
        }
        setImages(normalImages, for: .idle)
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        var refreshingImages = [UIImage]()
        for index in 0..<16 {
            let image = UIImage(named: "dropdown_loading_0\(index)")
            refreshingImages.append(image!)
        }
        // 设置正在刷新状态的动画图片
        setImages(refreshingImages, for: .refreshing)
        /// 设置state状态下的文字
        setTitle("下拉推荐", for: .idle)
        setTitle("松开推荐", for: .pulling)
        setTitle("推荐中", for: .refreshing)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        gifView.contentMode = .center
        gifView.frame = CGRect(x: 0, y: 4, width: mj_w, height: 25)
        stateLabel.font = UIFont.systemFont(ofSize: 12)
        stateLabel.frame = CGRect(x: 0, y: 35, width: mj_w, height: 14)
    }
}
