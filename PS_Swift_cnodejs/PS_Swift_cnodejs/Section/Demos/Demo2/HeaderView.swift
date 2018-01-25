//
//  HeaderView.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/12/21.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    private lazy var bgView: UIImageView = {
        let bw = UIImageView()
        bw.contentMode = .scaleAspectFill
        bw.image = UIImage(named: "mine_bg_for_boy")
        return bw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        addSubview(bgView)
        bgView.snp.makeConstraints {$0.edges.equalToSuperview() }
    }
}
