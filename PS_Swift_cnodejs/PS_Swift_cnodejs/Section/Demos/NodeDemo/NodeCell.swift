//
//  NodeCell.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/12.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

class NodeCell: UICollectionViewCell {
    
    private lazy var textLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.font = .preferredFont(forTextStyle: .body)
        if #available(iOS 10, *) {
            label.adjustsFontForContentSizeCategory = true
        }
        return label
    }()
    
    public var node: String? {
        didSet {
            guard let `node` = node else {
                return
            }
            textLabel.text = node
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
