//
//  NodeHeaderView.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/12.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

class NodeHeaderView: UICollectionReusableView {
    private lazy var textLabel: UILabel = {
       let label = UILabel()
        label.text = "我是Header"
        label.textColor = UIColor.black
        return label
    }()
    
    public var title: String? {
        didSet {
            textLabel.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(textLabel)
        textLabel.snp.makeConstraints{
            $0.left.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
