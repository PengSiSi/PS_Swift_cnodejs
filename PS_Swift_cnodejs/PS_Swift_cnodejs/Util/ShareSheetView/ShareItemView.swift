//
//  ShareItemView.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/16.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

class ShareItemView: UIView {

    private struct Metric {
        // title距离顶部的距离
        static let titlePadding: CGFloat = 5.0
        // item距离顶部的距离
        static let itemPadding:CGFloat = 9.0
        // item的宽高
        static let itemWidth:CGFloat = 60.0
    }
    
    private var item: ShareItem?
    
    public var callBack: shareSheetDidSelectedHandle?
    
    convenience public init(frame: CGRect, item: ShareItem, callback: @escaping shareSheetDidSelectedHandle) {
        self.init(frame: frame)
        self.item = item
        self.callBack = callback
        
        setupUI()
    }
    
    func setupUI() {
        
        guard let `item` = item else { return }
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: (width - Metric.itemWidth) / 2, y: Metric.itemPadding, width: Metric.itemWidth, height: Metric.itemWidth)
        button.setBackgroundImage(item.icon, for: .normal)
        button.addTarget(self, action: #selector(self.itemClick), for: .touchUpInside)
        
        let titlelabel = UILabel(frame: CGRect(x: 0, y: Metric.itemWidth + Metric.itemPadding + Metric.titlePadding, width: width, height: 20))
        titlelabel.text = item.title
        titlelabel.textAlignment = .center
        titlelabel.textColor = UIColor(red: 0.365, green: 0.361, blue: 0.357, alpha: 1.00)
        titlelabel.font = UIFont.systemFont(ofSize: 12)
        titlelabel.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.00)
        titlelabel.adjustsFontSizeToFitWidth = true
        addSubview(button)
        addSubview(titlelabel)
    }
    
    @objc func itemClick() {
        guard let type = item?.type else { return }
        callBack?(type)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90).withAlphaComponent(0.0)
    }
}

