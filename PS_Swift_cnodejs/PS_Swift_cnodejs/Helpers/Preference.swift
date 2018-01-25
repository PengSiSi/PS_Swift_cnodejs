//
//  Preference.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/17.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import Foundation

class Preference {
    
    // 单例
    public static let shared: Preference = Preference()
    
    // 1.是否使用 Safari 浏览网页， 默认 true
    var useSafariBrowser: Bool {
        set {
            UserDefaults.save(at: newValue, forKey: Constants.Keys.openWithSafariBrowser)
        }
        get {
            return (UserDefaults.get(forKey: Constants.Keys.openWithSafariBrowser) as? Bool) ?? true
        }
    }
    
    // 2.夜间模式
    var nightModel: Bool {
        set {
            ThemeStyle.update(style: newValue ? .night : .day)
        }
        get {
            return ThemeStyle.style.value == .night
        }
    }
    
    // 3.是否登录，默认是未登录
    var isLoggin: Bool {
        set {
            UserDefaults.save(at: newValue, forKey: Constants.Keys.isLoggin)
        }
        get {
            return (UserDefaults.get(forKey: Constants.Keys.isLoggin) as? Bool) ?? false
        }
    }
}
