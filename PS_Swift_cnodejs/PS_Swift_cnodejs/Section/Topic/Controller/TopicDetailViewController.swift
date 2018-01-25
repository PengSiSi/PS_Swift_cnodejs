//
//  TopicDetailViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/18.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

class TopicDetailViewController: BaseViewController {

    public var topicId: String? = "" {
        didSet {
            self.loadDetailData()
        }
    }
    
    /// MARK: - UI
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = UITableViewAutomaticDimension
        view.estimatedRowHeight = 80
        view.estimatedSectionHeaderHeight = 0
        view.estimatedSectionFooterHeight = 0
        view.backgroundColor = .clear
        //        view.keyboardDismissMode = .onDrag
        view.register(UINib(nibName: "TopicDetailReplyCell", bundle: nil), forCellReuseIdentifier: "TopicDetailReplyCell")
        var inset = view.contentInset
        inset.top = navigationController?.navigationBar.height ?? 64
        view.contentInset = inset
        inset.bottom = 0
        view.scrollIndicatorInsets = inset
        return view
    }()
    
    private lazy var headerView: TopicDetailHeaderView = {
        let view = TopicDetailHeaderView()
        view.isHidden = true
        return view
    }()
    
    // 数据源
    private var dataModel: TopicListModel? {
        didSet {
            // 赋值headerView
            tableView.tableHeaderView = headerView
            headerView.topicDetailModel = dataModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "话题"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "nodeCollect"), style: .plain, action: {
            log.info("收藏")
        })
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        // headerView的webView加载完成
        // 注意要在这里刷新tabeleView,否则tableView不显示
        headerView.webLoadComplete = { [ weak self ] in
            self?.headerView.isHidden = false
            self?.tableView.reloadData()
        }
    }
}

// MARK: - 数据请求
extension TopicDetailViewController {
    private func loadDetailData() {
        let url = "https://cnodejs.org/api/v1/topic/" + topicId!
        HTTPTool.shareInstance.requestData(.GET, URLString: url, parameters: nil, success: { (response) in
            self.dataModel = Mapper<TopicListModel>().map(JSON: response["data"] as! [String : Any])
        }) { (error) in
            log.error(error)
        }
    }
}

// MARK: - UITableViewDelegate && UITableViewDataSource
extension TopicDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicDetailReplyCell", for: indexPath)
        cell.selectionStyle = .none  // 取消选中效果
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
        return 96
    }
}

