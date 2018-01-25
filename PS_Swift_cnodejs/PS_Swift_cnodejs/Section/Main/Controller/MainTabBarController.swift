//
//  MainTabBarController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.delegate = self
        addChildViewControllers()
        
        // 接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification(noti:)), name: NSNotification.Name(rawValue: "settingNoti"), object: nil)
    }
    
    func initialize() {
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor.darkGray
    }
    
    // 这里是不会调用销毁的
    deinit {
        print("销毁了")
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    }
}

extension MainTabBarController {
    
    /// 添加子控制器
    func addChildViewControllers() {
        addChildViewController(childController: TopicViewController(), title: "话题", imageName: "home_icon_normal", selectedImageName: "home_icon_normal")
        addChildViewController(childController: RecruitmentViewController (), title: "招聘", imageName: "easy-learning_icon_normal", selectedImageName: "easy-learning_icon_normal")
        addChildViewController(childController: NoticeViewController(), title: "通知", imageName: "easy-teach_icon_normal", selectedImageName: "easy-teach_icon_normal")
        addChildViewController(childController: MineViewController(), title: "我的", imageName: "easy-teach_icon_normal", selectedImageName: "easy-teach_icon_normal")
    }
    
    // 注意设置 withRenderingMode
    func addChildViewController(childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        let nav = BaseNavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
    
    // 监听TabBar的点击，这里不走
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("点击了。。。")
    }
    
    // 监听TabBar的点击
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print("点击了。。。")
//        self.soundEffect.play()
//    }
    
    @objc func receiveNotification(noti: Notification) {
        print("接收通知")
        // 移除通知
        NotificationCenter.default.removeObserver(self)
        print("移除通知了。。。")
    }
}
