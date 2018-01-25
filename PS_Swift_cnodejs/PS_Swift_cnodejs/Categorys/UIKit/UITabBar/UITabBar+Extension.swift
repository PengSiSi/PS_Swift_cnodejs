
//
//  UITabBar+Extension.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/11.
//  Copyright © 2018年 思 彭. All rights reserved.
// 参考链接： http://www.hangge.com/blog/cache/detail_1900.html

import Foundation
import UIKit

// 解决ipad在iOS11下TabBarItem文字和图片出现左右显示

extension UITabBar {
    //让图片和文字在iOS11下仍然保持上下排列
    open override var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UITraitCollection(horizontalSizeClass: .compact)
        }
        return super.traitCollection
    }
}
