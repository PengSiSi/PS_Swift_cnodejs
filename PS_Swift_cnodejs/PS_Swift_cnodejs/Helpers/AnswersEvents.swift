//
//  AnswersEvents.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/17.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import Crashlytics
import UIKit

enum LoginType: String {
    case app = "App"
    case google = "Google"
}

struct AnswersEvents {
    
    static func logError(_ error: String) {
        Answers.logCustomEvent(withName: "Error Log", customAttributes: [
            "Error Info": error,
            "App Info": "\(UIDevice.phoneModel)(\(UIDevice.current.systemVersion))-\(UIApplication.appVersion())(\(UIApplication.appBuild()))"])
    }
    static func logWarning(_ info: String) {
        Answers.logCustomEvent(withName: "Warning Log", customAttributes: [
            "Warning Info": info,
            "App Info": "\(UIDevice.phoneModel)(\(UIDevice.current.systemVersion))-\(UIApplication.appVersion())(\(UIApplication.appBuild()))"])
    }
}

