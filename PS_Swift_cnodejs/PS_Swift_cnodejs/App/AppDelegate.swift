//
//  AppDelegate.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/11/28.
//  Copyright © 2017年 思 彭. All rights reserved.

// Swift新特性： https://github.com/ReverseScale/Swift4.0NewFeature

import UIKit
import Alamofire
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var orientation: UIInterfaceOrientationMask = .portrait

    // 检测网络状态
    lazy var reachability: NetworkReachabilityManager? = {
        return NetworkReachabilityManager(host: "http://app.u17.com")
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AppWindow.shared.prepare()
        AppSetup.prepare()
        // 基础配置
        configureBase()
        
//        // Override point for customization after application launch.
//        window = UIWindow(frame: UIScreen.main.bounds)
////        // 检测第一次启动
////        if !UserDefaults.standard.bool(forKey: kFirstLaunch) {
////            // 不是第一次启动
////            UserDefaults.standard.set(true, forKey: kFirstLaunch)
////            window?.rootViewController = IntroduceViewController()
////        } else {
//
//        let mainTabBarVc = MainTabBarController()
////            mainTabBarVc.delegate = self
//            window?.rootViewController = mainTabBarVc
////        }
//        window?.makeKeyAndVisible()
        return true
    }
    
    func configureBase() {
        
        // 进入程序存储默认性别类型
        let defaults = UserDefaults.standard
        if defaults.value(forKey: String.sexTypeKey) == nil{
            defaults.set(1, forKey: String.sexTypeKey)
            defaults.synchronize()
        }
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        // 监听网络
        reachability?.listener = { status in
            switch status {
            case .reachable(.ethernetOrWiFi):
                UNoticeBar(config: UNoticeBarConfig(title: "主人,检测到您正在使用WIfi哟")).show(duration: 2)
            default: break
            }
        }
        reachability?.startListening()
    }
    
    // 只允许竖屏
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientation
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// 横竖屏切换
extension UIApplication {
    class func changeOrientationTo(landscapeRight: Bool) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        if landscapeRight == true {
            delegate.orientation = .landscapeRight
            UIApplication.shared.supportedInterfaceOrientations(for: delegate.window)
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        } else {
            delegate.orientation = .portrait
            UIApplication.shared.supportedInterfaceOrientations(for: delegate.window)
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
    }
}


