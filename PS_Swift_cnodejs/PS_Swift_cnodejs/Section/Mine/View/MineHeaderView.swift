//
//  MineHeaderView.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/17.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

protocol MineHeaderViewDelegate: NSObjectProtocol {
    
    func loginButtonDidClick()
    func settingButtonDidClick()
}

class MineHeaderView: UIView {
    
    @IBOutlet weak var avaterImgView: UIImageView!
    @IBOutlet weak var logginButton: UIButton!
    // 代理
    weak var delegate: MineHeaderViewDelegate?
    
    @IBAction func settingAction(_ sender: Any) {
        self.delegate?.settingButtonDidClick()
    }
    
    @IBAction func logginAction(_ sender: Any) {
        self.delegate?.loginButtonDidClick()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avaterImgView.layer.cornerRadius = 40.0
        logginButton.layer.borderColor = UIColor.white.cgColor
        logginButton.layer.borderWidth = 0.5
    }
}
