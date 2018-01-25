//
//  BaseCollectionViewCell.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/12/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import Reusable

class BaseCollectionViewCell: UICollectionViewCell, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}
