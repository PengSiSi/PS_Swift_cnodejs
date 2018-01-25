//
//  UserDefaultsUtil.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/12.
//  Copyright © 2018年 思 彭. All rights reserved.

// 定义一些本地保存的值

import Foundation

class UserDefaultsUtil {
    
    public static let shared: UserDefaultsUtil = UserDefaultsUtil()
    
    // 值1
    var value1: Bool {
        set {
            save(at: newValue, forKey: Constants.Keys.loginAccount)
        }
        get {
            return (get(forKey: Constants.Keys.loginAccount) as! Bool) 
        }
    }
    
    func save(at value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func get(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    static func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}
