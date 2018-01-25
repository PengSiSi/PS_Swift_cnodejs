//
//  AppTheme.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/17.
//  Copyright © 2018年 思 彭. All rights reserved.

// 主题设置

import UIKit
import RxSwift
import RxCocoa

enum Theme {
    case day
    case night
    
    var globalColor: UIColor {
        switch self {
        case .day: return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)
        case .night: return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)
        }
    }
    
    var navColor: UIColor {
        switch self {
        case .day: return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case .night: return #colorLiteral(red: 0.1450980392, green: 0.1490196078, blue: 0.1450980392, alpha: 1)
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .day: return #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        case .night: return #colorLiteral(red: 0.09803921569, green: 0.1019607843, blue: 0.09803921569, alpha: 1)
        }
    }
    
    var cellBackgroundColor: UIColor {
        switch self {
        case .day: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .night: return #colorLiteral(red: 0.1411764706, green: 0.1450980392, blue: 0.1411764706, alpha: 1)
        }
    }
    
    var bgColor: UIColor {
        switch self {
        case .day: return #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        case .night: return #colorLiteral(red: 0.09803921569, green: 0.1019607843, blue: 0.09803921569, alpha: 1)
        }
    }
    
    var whiteColor: UIColor {
        switch self {
        case .day: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .night: return #colorLiteral(red: 0.09803921569, green: 0.1019607843, blue: 0.09803921569, alpha: 1)
        }
    }
    
    var disableColor: UIColor {
        switch self {
        case .day: return #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)
        case .night: return #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)
        }
    }
    
    var somberColor: UIColor {
        switch self {
        case .day: return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)
        case .night: return #colorLiteral(red: 0.5058823529, green: 0.5098039216, blue: 0.5058823529, alpha: 1)
        }
    }
    
    var linkColor: UIColor {
        switch self {
        case .day: return #colorLiteral(red: 0.4666666667, green: 0.5019607843, blue: 0.5294117647, alpha: 1)
        case .night: return #colorLiteral(red: 0.1137254902, green: 0.631372549, blue: 0.9490196078, alpha: 0.698391967)
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .day: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .night: return #colorLiteral(red: 0.5058823529, green: 0.5098039216, blue: 0.5058823529, alpha: 1)
        }
    }
    
    var dateColor: UIColor {
        switch self {
        case .day: return #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        case .night: return #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
        }
    }
    
    var statusBarStyle: UIStatusBarStyle {
        //        return .lightContent
        switch self {
        case .day: return .default
        case .night: return .lightContent
        }
    }
    
    var barStyle: UIBarStyle {
        switch self {
        case .day: return .default
        case .night: return .black
        }
    }
    
    struct Color {
        static let globalColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1) // 全局色
        static let borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        static let bgColor = #colorLiteral(red: 0.9366690335, green: 0.9459429843, blue: 0.9459429843, alpha: 1) // 背景颜色
        static let disableColor = #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)
        static let grayColor = #colorLiteral(red: 0.1450980392, green: 0.1450980392, blue: 0.1764705882, alpha: 0.4964415668)
        static let linkColor = #colorLiteral(red: 0.4666666667, green: 0.5019607843, blue: 0.5294117647, alpha: 1)
    }
}

public struct ThemeStyle {
    static var style = Variable<Theme>(.day)
    static func update(style: Theme) {
        self.style.value = style
        UserDefaults.save(at: style != .day, forKey: Constants.Keys.themeStyle)
    }
}
