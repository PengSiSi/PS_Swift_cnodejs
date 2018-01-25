//
//  NoticeViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/11/28.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

// 数据源
private var sections: [MineItem] = [
    MineItem(title: "系统消息", imageName: "collection", rightType: .none),
    MineItem(title: "已读消息", imageName: "comment", rightType: .none)
]

class NoticeViewController: BaseViewController {
    
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
        label.text = "暂无消息"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - 设置界面
extension NoticeViewController {
    
    private func setupUI() {
        self.view.addSubview(self.tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK： - UITableViewDelegate && UITableViewDataSource
extension NoticeViewController: UITableViewDelegate, UITableViewDataSource {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: mineCellID, for: indexPath) as! BaseTableViewCell
        cell.selectionStyle = .none  // 取消选中效果
        // 取得数据
        let item = sections[indexPath.row]
        cell.textLabel?.text = item.title
        cell.imageView?.image = UIImage(named: item.imageName)
        cell.rightType = item.rightType
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
}
