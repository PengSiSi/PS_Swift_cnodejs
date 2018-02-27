//
//  TopicViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/11/28.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import HMSegmentedControl

class TopicViewController: BaseViewController {
    
    lazy private var addButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        btn.backgroundColor = UIColor.red
        btn.frame = CGRect(x: screenWidth - 40, y: screenHeight - 40, width: 30, height: 30)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchAction))
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "搜索", titleColor: UIColor.white, titleFont: UIFont.systemFont(ofSize: 16), titleEdgeInsets: UIEdgeInsets.zero, target: self, action: #selector(searchAction))
        setupUI()
        setupAddButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 可以旋转
        isAllowAutorotate = true
        if isAllowAutorotate {
        }
    }
    
    // 设置界面
    private func setupUI() {
        let titles = ["全部", "精华", "分享", "问答", "测试"]
        var childsVc: [UIViewController] = [UIViewController]()
        for _ in 0..<titles.count {
            let contentVc = TopicListViewController()
            childsVc.append(contentVc)
        }
        let pageStyle = PageStyle()
        pageStyle.labelLayout = .divide
        let pageView = PageContentView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - tabBarHeight - navigationBarHeight), titles: titles, childControllers: childsVc, parentController: self, style: pageStyle)
        view.addSubview(pageView)
    }
    
    private func setupAddButton() {
        self.view.addSubview(addButton)
    }
}

extension TopicViewController {
    // 实现添加搜索的view效果
    @objc private func searchAction() {
        let searchVC = TopicSearchViewController()
        let nav = UINavigationController(rootViewController: searchVC)
        nav.modalTransitionStyle = .crossDissolve
        self.present(nav, animated: true, completion: nil)
    }
}

extension TopicViewController {
    
}
