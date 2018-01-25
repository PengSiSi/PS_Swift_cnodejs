//
//  SearchResultViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/12.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

class SearchResultViewController: BaseViewController {

    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        self.view.addSubview(tableView)
        return tableView
    }()

    private var query: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        self.definesPresentationContext = false
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        cell?.textLabel?.text = "思思swsw"
        if let `query` = query {
            // 对搜索结果进行红色渲染
            cell?.textLabel?.makeSubstringColor(query, color: UIColor.red)
        }
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

extension SearchResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text
//        guard let query = searchController.searchBar.text?.trimmed,
//            query.isNotEmpty,
//            let `originData` = originData else {
//                return
//        }
        self.query = query
//        searchResults = originData.filter { $0.title.lowercased().contains(query.lowercased()) }
    }
}
