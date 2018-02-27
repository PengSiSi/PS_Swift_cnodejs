//
//  SettingViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/12/21.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

let settingCellID = "MineCell"
//let kMargin = 10.0

class SettingViewController: UITableViewController {
    
    /// 数据源
    var dataArray: [String]?
    var cacheSize: Int = FileManager.fileSizeOfCache()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Demos"
        dataArray = ["Demo1", "Demo2", "下拉放大", "Moya Demo", "跳转到webView", "清除缓存", "给我评分", "意见反馈", "Node Demo", "CommentInputDemo", "RxSwift使用", "夜间模式", "SQLite使用", "根据数据源创建按钮", "架构Demo", "TableViewCell添加动效，当前页面", "RxSwift控件扩展"]
        setupUI()
    }
    
    // 一进入该页面就横屏展示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIApplication.changeOrientationTo(landscapeRight: true)
        // tableView的动效
        self.animateTable()
    }
}

// MARK: - 设置界面
extension SettingViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: settingCellID)
        tableView.rowHeight = 44
//        tableView.separatorStyle = .none
    }
}

// MARK: - 加载数据
extension SettingViewController {
    
    func loadData() {
        
    }
}

extension SettingViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dataArray?.count)!;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: settingCellID, for: indexPath)
        cell.selectionStyle = .none  // 取消选中效果
//        if indexPath.row == (dataArray?.count)! - 1 {
//            cell.textLabel?.text = (dataArray?[indexPath.row])! + String(cacheSize) + "M";
//        } else {
            cell.textLabel?.text = dataArray?[indexPath.row];
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat(kMargin)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let Demo1Vc = Demo1ViewController(titles: ["收藏",
                                                       "书单",
                                                       "下载"],
                                              vcs: [CollectViewController(),
                                                    BookListViewController(),
                                                    DownloadViewController()],
                                              pageStyle: .navgationBarSegment)
            self.navigationController?.pushViewController(Demo1Vc, animated: true)
        }
        if indexPath.row == 1 {
        let vc = Demo2ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2 {
            self.navigationController?.pushViewController(PullDownExpandViewController(), animated: true)
        }
        if indexPath.row == 3 {
            self.navigationController?.pushViewController(MoyaDemoViewController(), animated: true)
        }
        if indexPath.row == 4 {
           
            let webViewVc = UWebViewController.init(url: "http://www.baidu.com"); self.navigationController?.pushViewController(webViewVc, animated: true)
        }
        if indexPath.row == 5 {
            // 清除缓存
            FileManager.clearCache(complete: { size in
                print("清除缓存成功")
            })
        }
        if indexPath.row == 6 {
            // 评分
            openAppStore()
        }
        if indexPath.row == 7 {
            // 意见反馈
            sendEmail()
        }
        if indexPath.row == 8 {
        self.navigationController?.pushViewController(NodeViewController(), animated: true)
        }
        if indexPath.row == 9 {
            self.navigationController?.pushViewController(CommentInputViewController(), animated: true)
        }
        if indexPath.row == 10 {
            self.navigationController?.pushViewController(RxSwiftDemoViewController(), animated: true)
        }
        if indexPath.row == 11 {
            self.navigationController?.pushViewController(NightThemeViewController(), animated: true)
        }
        if indexPath.row == 12 {
            self.navigationController?.pushViewController(ReadHistoryViewController(), animated: true)
        }
        if indexPath.row == 13 {
            self.navigationController?.pushViewController(ButtonsDemoViewController(), animated: true)
        }
        if indexPath.row == 14 {
          
      self.navigationController?.pushViewController(ArchitectureDemoVC(), animated: true)
        }
        if indexPath.row == 16 {
            self.navigationController?.pushViewController(RxSwiftDemo1VC(), animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2) //设置动画时间
        cell?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.commitAnimations()
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2) //设置动画时间
        cell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        UIView.commitAnimations()
    }
}

// MARK: - SKStoreProductViewControllerDelegate

extension SettingViewController: SKStoreProductViewControllerDelegate {
    
    private func openAppStore() {
        let storeProductVC = SKStoreProductViewController()
        storeProductVC.delegate = self
        storeProductVC.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: Constants.Config.AppID]) { [weak self] result, error in
            guard result else {
                if let _ = error {
                   print("失败")
                }
                return
            }
            self?.present(storeProductVC, animated: true, completion: nil)
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension SettingViewController: MFMailComposeViewControllerDelegate {
    private func sendEmail() {
        
        guard MFMailComposeViewController.canSendMail() else {
//            HUD.showError("操作失败，请先在系统邮件中设置个人邮箱账号。\n或直接通过邮箱向我反馈 email: \(Constants.Config.receiverEmail)", duration: 3)
            return
        }
        
        let mailVC = MFMailComposeViewController()
        mailVC.setSubject("\(UIApplication.appDisplayName()) iOS 反馈")
        mailVC.setToRecipients([Constants.Config.receiverEmail])
        mailVC.setMessageBody("\n\n\n\n[运行环境] \(UIDevice.phoneModel)(\(UIDevice.current.systemVersion))-\(UIApplication.appVersion())(\(UIApplication.appBuild()))", isHTML: false)
        mailVC.mailComposeDelegate = self
        present(mailVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
        
        switch result {
        case .sent:
            print("感谢您的反馈，我会尽量给您答复。")
        case .failed:
            print("邮件发送失败: \(error?.localizedDescription ?? "Unkown")")
        default:
            break
        }
    }
}

extension SettingViewController {
    
    // TableView的动效
    func animateTable() {
        let cells = self.tableView.visibleCells
        let tableViewHeight = self.tableView.bounds.height
        for (index, cell) in cells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
    
    
}
