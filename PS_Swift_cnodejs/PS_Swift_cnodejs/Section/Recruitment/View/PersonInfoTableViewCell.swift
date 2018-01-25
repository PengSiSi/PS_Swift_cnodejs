//
//  PersonInfoTableViewCell.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/9/2.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class PersonInfoTableViewCell: UITableViewCell {

    var titleLabel: UILabel?
    var subTitleLabel: UILabel?
    var textField: UITextField?
    
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
//        titleLabel?.isHidden = true
        contentView.addSubview(titleLabel!)
        
        subTitleLabel = UILabel()
        subTitleLabel?.font = UIFont.systemFont(ofSize: 15)
        subTitleLabel?.textColor = UIColor.gray
        subTitleLabel?.isHidden = true
        contentView.addSubview(subTitleLabel!)
        
        textField = UITextField()
        textField?.delegate = self
        contentView.addSubview(textField!)
    }
    
    func layOut() {
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.centerY.equalTo(contentView)
        })
        subTitleLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(contentView)
        })
        textField?.snp.makeConstraints({ (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(contentView)
        })

    }
    
    // 配置cell
    func configureCell(title: String?, subTitle: String?) {
        titleLabel?.text = title
        subTitleLabel?.text = subTitle
    }
}

extension PersonInfoTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
