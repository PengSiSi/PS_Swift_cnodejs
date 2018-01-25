
//
//  AppSetup.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/11.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

struct AppSetup {
    static func prepare() {
//        setupKeyboardManager()
        setupCrashlytics()
        setupTheme()
        setupLog()
    }
}

extension AppSetup {
    /// 键盘自处理
    private static func setupKeyboardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 70
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
//        IQKeyboardManager.sharedManager().disabledDistanceHandlingClasses = [
//            CreateTopicViewController.self
//        ]
//        IQKeyboardManager.sharedManager().disabledToolbarClasses = [
//            TopicDetailViewController.self,
//            CreateTopicViewController.self
//        ]
//        IQKeyboardManager.sharedManager().disabledTouchResignedClasses = [
//            TopicDetailViewController.self
//        ]
    }
    
    // FPS
    private static func setupFPS() {
        #if DEBUG
            DispatchQueue.main.async {
                let label = FPSLabel(frame: CGRect(x: AppWindow.shared.window.bounds.width - 55 - 8, y: 20, width: 55, height: 20))
                label.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
                AppWindow.shared.window.addSubview(label)
            }
        #endif
    }
    
    // 崩溃日志统计
    private static func setupCrashlytics() {
        
    }
    
    // 主题设置
    private static func setupTheme() {
        
    }
    
    // Logger输出
    private static func setupLog() {
        #if DEBUG
//            Logger.logLevel = .debug
        #else
//            Logger.logLevel = .warning
        #endif
    }
}
