//
//  BaseTableViewCell.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/11.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

// 使用关键字则使用``包含即可
enum RightType {
    case none, arrow, `switch`
}

class BaseTableViewCell: UITableViewCell {
    
    public lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.sizeToFit()
        switchView.isUserInteractionEnabled = true
        switchView.onTintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return switchView
    }()
    
    public var rightType: RightType = .arrow {
        didSet {
            switch rightType {
            case .arrow:
                accessoryType = .disclosureIndicator
            case .switch:
                accessoryView = switchView
            default:
                accessoryType = .none
            }
        }
    }
    
    func initialize() {
        
    }
    
    func setupConstraints() {
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
