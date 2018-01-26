//
//  ReadHistoryViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/26.
//  Copyright © 2018年 思 彭. All rights reserved.

// 参考链接： http://www.hangge.com/blog/cache/detail_1578.html
// http://www.hangge.com/blog/cache/detail_645.html

import UIKit

class ReadHistoryViewController: BaseViewController {

    lazy private var tableView: UITableView = {
        let tw = UITableView(frame: CGRect.zero, style: .plain)
        tw.dataSource = self
        tw.delegate = self
        tw.register(BaseTableViewCell.self, forCellReuseIdentifier: mineCellID)
        tw.tableFooterView = footerView
        return tw
    }()
    
    lazy private var footerView: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 20))
        label.text = ""
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    // 数据源
    private var dataArray: [ItemModel]? = [ItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension ReadHistoryViewController {
    private func initialData() {
        for index in 0...10 {
            let itemModel = ItemModel(itemID: String(index), title: "思思")
            dataArray?.append(itemModel)
        }
    }
}

// MARK: - 设置界面
extension ReadHistoryViewController {
    
    private func setupUI() {
        self.view.addSubview(self.tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK： - UITableViewDelegate && UITableViewDataSource
extension ReadHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: mineCellID, for: indexPath)
//        cell.selectionStyle = .none  // 取消选中效果
        // 取得数据
        let model = self.dataArray![indexPath.row] as ItemModel
        cell.textLabel?.text = model.title
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
        return 44
    }
    
    // 选中单元格
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取得数据
        let model = self.dataArray![indexPath.row] as ItemModel
        // 添加到数据库
        GCDUtil.runOnBackgroundThread {
            SQLiteDatabase.instance?.addHistory(tid: Int(model.itemID!)!, title: model.title!)
        }
        // 查看数据库记录
        log.info(SQLiteDatabase.instance?.loadReadHistory(count: 2000) ?? [].count)
    }
}

