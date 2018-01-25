//
//  Constants.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/12.
//  Copyright © 2018年 思 彭. All rights reserved.

// 定义一些常量

import Foundation
import UIKit

struct Closure {
    typealias Completion = () -> Void
    typealias Failure = (NSError?) -> Void
}

struct Constants {
    struct Config {
        // App
        static var baseURL = "https://www.v2ex.com"
        static var AppID = "1308118507"
        static var receiverEmail = "1299625033@qq.com"
    }
    struct Keys {
        // User登录时的用户名
        static let loginAccount = "loginAccount"
        
        // User持久化
        static let username = "usernameKey"
        static let avatarSrc = "avatarSrcKey"
        static let accountAvatar = "accountAvatar"
        // 是否使用 App 内置浏览器打开
        static let openWithSafariBrowser = "openWithSafariBrowser"
        // 主题
        static let themeStyle = "themeStyle"
        // 是否登录
        static let isLoggin = "loggin"
    }
}

extension Notification.Name {
    
    // 自定义的通知
    struct Cnode{
        // 登录成功通知
        static let LoginSuccessName = Notification.Name("LoginSuccessName")
        
        /// 选择了 Home TabbarItem
        static let DidSelectedHomeTabbarItemName = Notification.Name("DidSelectedHomeTabbarItemName")
    }
}
