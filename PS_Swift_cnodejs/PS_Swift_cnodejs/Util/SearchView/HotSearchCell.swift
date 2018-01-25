//
//  HotSearchCell.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/19.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

class HotSearchCell: UITableViewCell {

    private var searchView: SearchView?
    
    private var hotSearchArr: [String] = [] {
        didSet {
            searchView = SearchView(frame: self.bounds, titleLabelText: "", btnTexts: hotSearchArr, btnCallBackBlock: { (button) in
                log.info("点击了按钮")
            })
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        self.contentView.addSubview(searchView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
