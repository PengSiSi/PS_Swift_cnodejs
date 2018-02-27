
//
//  ArchitectureDemoVC.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/2/7.
//  Copyright © 2018年 思 彭. All rights reserved.

// 参考链接： http://www.cocoachina.com/ios/20180206/22156.html

import UIKit


/// 这是一个结构体
struct MyStruct {
    
}

class ArchitectureDemoVC: BaseViewController {

    
    lazy private var tableView: UITableView = {
        let tw = UITableView(frame: CGRect.zero, style: .plain)
        tw.dataSource = self
        tw.delegate = self
        tw.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tw
    }()
    
    
    /// 数据源
    var dataArray: [String] = ["MVC", "MVP", "MVVM"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ArchitectureDemoVC {
    private func setupUI() {
        title = "架构Demo"
        self.view.addSubview(self.tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ArchitectureDemoVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none  // 取消选中效果
        // 取得数据
        let item = dataArray[indexPath.row]
        cell.textLabel?.text = item
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // MVC
            self.navigationController?.pushViewController(MVCViewController(), animated: true)
        } else if indexPath.row == 1 {
            // MVP
            self.navigationController?.pushViewController(MVPViewController(), animated: true)
        } else {
            // MVVM
            self.navigationController?.pushViewController(MVVMViewController(), animated: true)
        }
    }
    
    
}
