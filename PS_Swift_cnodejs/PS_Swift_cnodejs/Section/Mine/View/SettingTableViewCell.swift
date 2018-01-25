//
//  SettingTableViewCell.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/26.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel?
    var subTitleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var title: String? {
        didSet {
            titleLabel?.text = title
        }
    }
    
    var subTitle: String? {
        didSet {
            subTitleLabel?.text = subTitle
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubViews()
        layOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        titleLabel?.textColor = UIColor.black
        contentView.addSubview(titleLabel!)
        
        subTitleLabel = UILabel()
        subTitleLabel?.font = UIFont.systemFont(ofSize: 15)
        subTitleLabel?.textColor = UIColor.gray
        contentView.addSubview(subTitleLabel!)
    }
    
    func layOut() {
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(contentView)
        })
        subTitleLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(-10)
            make.centerY.equalTo(contentView)
        })
    }
    
    // 配置cell
    func configureCell(title: String?, subTitle: String?) {
        titleLabel?.text = title
        subTitleLabel?.text = subTitle
    }
}
