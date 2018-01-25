//
//  AppWindow.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/11.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

public final class AppWindow {
    
    static let shared = AppWindow()
    var window: UIWindow
    
    private init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
    }
    
    func prepare() {
        window.rootViewController = MainTabBarController()
        window.makeKeyAndVisible()
    }
}
