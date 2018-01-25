//
//  BaseViewController.swift
//  SwiftTools
//
//  Created by 思 彭 on 2017/5/4.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    private var ss: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
        setupTheme()
    }
    
    // 设置样式
    func setupTheme() {
        
        ThemeStyle.style.asObservable()
            .subscribeNext { (theme) in
                self.view.backgroundColor = theme.bgColor
        }
        
    }
}

extension BaseViewController {
    func test() {
        
    }
}
