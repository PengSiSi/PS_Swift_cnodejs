//
//  PullDownExpandViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/12/21.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import Reusable
import Moya

class PullDownExpandViewController: BaseViewController {

    private var hotItems: [SearchItemModel]?
    private var currentRequest: Cancellable?
    
    // 取出本地存的数据   存的是数组，没数据则创建一个空数组
    private lazy var searchHistory: [String]?  = {
        return UserDefaults.standard.value(forKey: String.searchHistoryKey) as? [String] ?? [String]()
    }()
    
    private lazy var head: HeaderView = {
        return HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
    }()
    
    private lazy var navigationBarY: CGFloat = {
        return navigationController?.navigationBar.frame.maxY ?? 0
    }()
    
    
    lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .grouped)
        tw.backgroundColor = UIColor.white
        tw.delegate = self
        tw.dataSource = self
        tw.register(cellType: PullDownTableViewCell.self)
        return tw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .top
        configUI()
    }
    
    func configUI() {
        view.addSubview(tableView)
        title = "下拉放大"
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
            $0.top.equalToSuperview()
        }
        
        tableView.parallaxHeader.view = head
        tableView.parallaxHeader.height = 200
        tableView.parallaxHeader.minimumHeight = navigationBarY
        tableView.parallaxHeader.mode = .fill
        
        navigationController?.barStyle(.clear)
        tableView.contentOffset = CGPoint(x: 0, y: -tableView.parallaxHeader.height)
        // 下拉刷新
        tableView.uHead = URefreshHeader { [weak self] in self?.loadData() }
        tableView.uFoot = URefreshFooter { [weak self] in self?.loadData() }
        tableView.uempty = UEmptyView { [weak self] in self?.loadData() }
    }
    
    func loadData() {
        // 数据请求之前先取消之前的请求
        currentRequest?.cancel()
        
        ApiLoadingProvider.request(API.searchHot, model: HotItemsModel.self) { (returnData) in
            // block里记得使用self
            self.hotItems = returnData?.hotItems
            // 结束刷新
            self.tableView.uHead.endRefreshing()
            self.self.tableView.uFoot.endRefreshing()
        }
    }
}

extension PullDownExpandViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -(scrollView.parallaxHeader.minimumHeight) {
            navigationController?.barStyle(.theme)
            navigationItem.title = "我的"
        } else {
            navigationController?.barStyle(.clear)
            navigationItem.title = ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PullDownTableViewCell.self)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .default
        cell.textLabel?.text = "思思"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
