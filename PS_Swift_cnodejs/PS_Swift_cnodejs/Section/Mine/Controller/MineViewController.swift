//
//  MineViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/11/28.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

let mineCellID = "MineCell"
let kMargin = 10.0

enum MineItemType {
    case mine1
    case mine2
    case mine3, mine4
    case mine5
}

// 数据源model
struct MineItem {
    var title: String
    var imageName: String
    var rightType: RightType
}

private var sections: [[MineItem]] = [
    [
        MineItem(title: "未登录", imageName: "header", rightType: .none),
        MineItem(title: "最近回复", imageName: "concern", rightType: .arrow),
        MineItem(title: "最新发布", imageName: "concern", rightType: .arrow),
        MineItem(title: "话题收藏", imageName: "concern", rightType: .arrow),
    ],
    [
        MineItem(title: "设置", imageName: "setting", rightType: .arrow)
    ]
]

// 是否登录
private let isLoggin: Bool = Preference.shared.isLoggin

private var userModel: UserInfoModel?

class MineViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 不可以旋转
        isAllowAutorotate = false
        loadData()
    }
}

// MARK: - 设置界面
extension MineViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: mineCellID)
        tableView.rowHeight = 44
    }
}

// MARK: - 加载数据
extension MineViewController {
    
    func loadData() {
        log.info("是登录模式啦")
        HTTPTool.shareInstance.requestData(.GET, URLString: "https://cnodejs.org/api/v1/user/Pengsisi", success: { (response) in
            log.info(response)
            userModel = Mapper<UserInfoModel>().map(JSON: response["data"] as! [String : Any])
        }) { (error) in
            log.error(error)
        }
    }
}

extension MineViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionArray: [ Any] = sections[section]
        return sectionArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: mineCellID, for: indexPath) as! BaseTableViewCell
        cell.selectionStyle = .none  // 取消选中效果
        // 取得数据
        let sectionArray: [ Any] = sections[indexPath.section]
        let item = sectionArray[indexPath.row] as! MineItem
        cell.textLabel?.text = item.title
        cell.imageView?.image = UIImage(named: item.imageName)
        cell.rightType = item.rightType
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(kMargin)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        footer.backgroundColor = #colorLiteral(red: 0.8480219245, green: 0.8480219245, blue: 0.8480219245, alpha: 1)
        return footer
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  indexPath.section == 0 && indexPath.row == 0 {
            return 80
        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
                // 登录
            case 0:
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
            default:
                break
            }
        } else {
            switch indexPath.row  {
            case 0:
                self.navigationController?.pushViewController(SettingViewController(), animated: true)
            default:
                break
            }
        }
    }
}
