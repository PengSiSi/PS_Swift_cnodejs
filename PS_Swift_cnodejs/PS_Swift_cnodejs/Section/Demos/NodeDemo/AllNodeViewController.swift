//
//  AllNodeViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/12.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

class AllNodeViewController: BaseViewController {

    private let dataArray: [String] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
//        self.searchController.isActive = true
//        GCDUtil.delay(0.8) {
//            self.searchController.searchBar.becomeFirstResponder()
//        }
        return tableView
    }()
    
    private lazy var footerLabel: UILabel = {
        let footerLabel = UILabel()
        footerLabel.text = "22个数据"
        footerLabel.sizeToFit()
        footerLabel.textColor = .gray
        footerLabel.textAlignment = .center
        footerLabel.height = 44
        return footerLabel
    }()
    
    private lazy var searchResultVC: SearchResultViewController = {
       let searchVc = SearchResultViewController()
        return searchVc
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: searchResultVC)
        searchController.searchBar.placeholder = "搜索节点"
        searchController.searchBar.tintColor = UIColor.gray
        searchController.searchBar.barTintColor = UIColor.lightGray
        // 结果页需要实现协议，否则这里报错崩溃
        searchController.searchResultsUpdater = searchResultVC
        // SearchBar 边框颜色
        searchController.searchBar.layer.borderWidth = 0.5
        searchController.searchBar.layer.borderColor = UIColor.lightGray.cgColor
//        searchController.searchBar.isUserInteractionEnabled = false
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.definesPresentationContext = false
        setupSubViews()
        tableView.tableFooterView = footerLabel
        tableView.tableHeaderView = searchController.searchBar
        setupConstraints()
    }
    
    func setupSubViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancleAction))
        self.view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
extension AllNodeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "node")
        if cell == nil {
            cell = BaseTableViewCell(style: .default, reuseIdentifier: "node")
        }
        cell?.textLabel?.text = "思思"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "sisi"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension AllNodeViewController {
    @objc func cancleAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
