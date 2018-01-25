//
//  TopicListViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/18.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

class TopicListViewController: BaseViewController {

    lazy private var tableView: UITableView = {
        let tw = UITableView(frame: CGRect.zero, style: .plain)
        tw.dataSource = self
        tw.delegate = self
        tw.register(UINib(nibName: "TopicListCell", bundle: nil), forCellReuseIdentifier: "TopicListCell")
        tw.tableFooterView = UIView()
        tw.tableHeaderView = UIView()
        tw.estimatedSectionFooterHeight = 0
        tw.estimatedSectionHeaderHeight = 0
        tw.estimatedRowHeight = 0
        return tw
    }()
    
    lazy private var addButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        btn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        return btn
    }()
    
    private var dataArray: [TopicListModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAddButton()
        loadData()
    }
}

// MARK: - 设置界面
extension TopicListViewController {
    
    private func setupUI() {
        self.view.addSubview(self.tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupAddButton() {
        self.view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.bottom.equalTo(-20)
            make.width.height.equalTo(30)
        }
    }
}

// MARK: - 数据请求
extension TopicListViewController {
    private func loadData() {
        let params: [String: Any] = ["page": 1, "tab": "share", "limit": 10, "mdrender": false]
        HTTPTool.shareInstance.requestData(.GET, URLString: "https://cnodejs.org/api/v1/topics", parameters: params, success: { (response) in
            log.info(response)
            self.dataArray = Mapper<TopicListModel>().mapArray(JSONArray: response["data"] as! [[String : Any]])
        }) { (error) in
            log.error(error)
        }
    }
}

// MARK： - UITableViewDelegate && UITableViewDataSource
extension TopicListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicListCell", for: indexPath) as! TopicListCell
        cell.selectionStyle = .none  // 取消选中效果
        // 取得数据
        cell.toplicList = self.dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        footer.backgroundColor = #colorLiteral(red: 0.8480219245, green: 0.8480219245, blue: 0.8480219245, alpha: 1)
        return footer
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

       let topDetailVc = TopicDetailViewController()
        let toplicList: TopicListModel = self.dataArray[indexPath.row]
        topDetailVc.topicId = toplicList.id; self.navigationController?.pushViewController(topDetailVc, animated: true)
    }
}

extension TopicListViewController {
    
    // 新增话题
    @objc private func addAction() {
        self.navigationController?.pushViewController(AddTopicViewController(), animated: true)
    }
}

