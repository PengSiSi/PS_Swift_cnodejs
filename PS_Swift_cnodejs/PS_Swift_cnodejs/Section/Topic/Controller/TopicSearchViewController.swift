//
//  TopicSearchViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/15.
//  Copyright © 2018年 思 彭. All rights reserved.

// 点击热门搜索视图的按钮会发生四件事: 1.将按钮文字显示到搜索框 2.将按钮文字写入到偏好设置 3.在历史记录中显示按钮 4.更新清空历史按钮的状态
// 参考链接： http://blog.csdn.net/Dr_Enhart/article/details/72844586

import UIKit

class TopicSearchViewController: BaseViewController {

    // 搜索框
    lazy private var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.7, height: 30))
        searchBar.placeholder = "输入主题"
        searchBar.barTintColor = UIColor.white
        searchBar.keyboardType = .default
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy private var searchView: SearchView = {
        let arr = ["年货大集", "酸奶", "水", "车厘子", "洽洽瓜子", "维他", "香烟", "周黑鸭", "草莓", "星巴克", "卤味"]
        
        let view = SearchView(frame: CGRect(x: 10, y: 20, width: screenWidth - 29, height: 200), titleLabelText: "热门搜索", btnTexts: arr, btnCallBackBlock: { (button) in
            let str = button.title(for: .normal)
            //将按钮文字显示到搜索框
            self.searchBar.text = str
            //将按钮文字写入到偏好设置
            self.writeHistorySearchToUserDefaults(str: str!)
            self.tableView.reloadData()
        })
        return view
    }()
    
    lazy private var tableView: UITableView = {
        let tw = UITableView(frame: CGRect.zero, style: .plain)
        tw.dataSource = self
        tw.delegate = self
        tw.register(HotSearchCell.self, forCellReuseIdentifier: "HotSearchCell")
        tw.register(UINib(nibName: "HistorySearchCell", bundle: nil), forCellReuseIdentifier: "HistorySearchCell")
        tw.tableFooterView = UIView()
        return tw
    }()
    
    // 历史搜索数据
    private var historySearchArr: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, action: {
            self.backAction()
        })
        initialData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - InitialData
extension TopicSearchViewController {
    // 初始化数据
    private func initialData() {
        // 本地取得历史搜索数据
        historySearchArr = UserDefaults.get(forKey: "historySearch") as? [String]
        if historySearchArr == nil {
            historySearchArr = [String]()
            UserDefaults.save(at: historySearchArr, forKey: "historySearch")
        }
    }
}

// MARK: - 设置界面
extension TopicSearchViewController {
    private func setupUI() {
        setupTilteView()
        self.view.addSubview(tableView)
        tableView.tableHeaderView = searchView
        // 修改searchView的高度
        searchView.bounds.size.height = (searchView.searchViewHeight)
        setupContraints()
    }
    
    private func setupTilteView() {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        bgView.backgroundColor = UIColor.white
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 6
        bgView.layer.borderColor = UIColor(red: 100 / 255.0, green: 100 / 255.0, blue: 100 / 255.0, alpha: 1).cgColor
        bgView.layer.borderWidth = 0.2
        UIGraphicsBeginImageContext(bgView.bounds.size)
        bgView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let bgImage = UIGraphicsGetImageFromCurrentImageContext()
        searchBar.setSearchFieldBackgroundImage(bgImage, for: .normal)
        navigationItem.titleView = searchBar
    }
    
    private func setupContraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //将历史搜索写入偏好设置
    private func writeHistorySearchToUserDefaults(str: String) {
        //从偏好设置中读取
        let historySearch = UserDefaults.get(forKey: "historySearch") as? [String]
        // 如果存在就不重复写入
        for text in historySearch! {
            if text == str {
                return
            }
        }
        historySearchArr?.append(str)
        UserDefaults.save(at: historySearchArr, forKey: "historySearch")
        // 刷新表视图
        tableView.reloadData()
    }
}

extension TopicSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (historySearchArr?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "HotSearchCell", for: indexPath) as! HotSearchCell
//            cell.selectionStyle = .none  // 取消选中效果
//            // 取得数据
//            return cell
//        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistorySearchCell", for: indexPath) as! HistorySearchCell
            cell.selectionStyle = .none  // 取消选中效果
            // 取得数据
        cell.titlelabel.text = historySearchArr?[indexPath.row]
            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 20))
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth - 20, height: 20))
        label.text = "历史搜索"
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

// MARK: - UISearchBarDelegate
extension TopicSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text?.count)! > 0 {
            searchBar.resignFirstResponder()
            //将搜索框文字写入到偏好设置
            writeHistorySearchToUserDefaults(str: searchBar.text!)
        }
    }
}

// MARK: - Private Method
extension TopicSearchViewController {
    @objc private func backAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
