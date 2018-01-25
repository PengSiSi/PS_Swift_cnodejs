//
//  Demo2ViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/12/21.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class Demo2ViewController: BaseViewController {

    var leftItem: UIBarButtonItem? = nil
    
    private lazy var mainScrollView: UIScrollView = {
        let sw = UIScrollView()
        sw.delegate = self
        return sw
    }()
    
    private lazy var navigationBarY: CGFloat = {
        return navigationController?.navigationBar.frame.maxY ?? 0
    }()
    
    private lazy var pageVC: UPageViewController = {
        return UPageViewController(titles: ["详情", "目录", "评论"],
                                   vcs: [Demo2DetailViewController(), UIViewController(), UIViewController()],
                                   pageStyle: .topTabBar)
    }()
    
    private lazy var headView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: navigationBarY + 150))
        headerView.backgroundColor = UIColor.orange
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        edgesForExtendedLayout = .top
        navigationItem.hidesBackButton = true
        self.leftItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(backAction))
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureUI() {
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
            $0.top.equalToSuperview()
        }
        
        let contentView = UIView()
        mainScrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().offset(-navigationBarY)
        }
        
        addChildViewController(pageVC)
        contentView.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { $0.edges.equalToSuperview() }
        mainScrollView.parallaxHeader.view = headView
        mainScrollView.parallaxHeader.height = navigationBarY + 150
        mainScrollView.parallaxHeader.minimumHeight = navigationBarY
        mainScrollView.parallaxHeader.mode = .fill
        mainScrollView.contentOffset = CGPoint(x: 0, y: -mainScrollView.parallaxHeader.height)
    }
}

extension Demo2ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -scrollView.parallaxHeader.minimumHeight {
            navigationController?.barStyle(.theme)
            navigationItem.title = "Demo2"
            navigationItem.leftBarButtonItem = self.leftItem
        } else {
            navigationController?.barStyle(.clear)
            navigationItem.leftBarButtonItem = nil
            navigationItem.title = ""
        }
    }
}


extension Demo2ViewController {
    @objc func backAction() {
        navigationItem.hidesBackButton = false
        self.navigationController?.popViewController(animated: true)
    }
}
