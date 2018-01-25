//
//  UIViewController+Extension.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/17.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// SO: http://stackoverflow.com/questions/24825123/get-the-current-view-controller-from-the-app-delegate
    public func currentViewController() -> UIViewController {
        func findBestViewController(_ controller: UIViewController?) -> UIViewController? {
            if let presented = controller?.presentedViewController { // Presented界面
                return findBestViewController(presented)
            } else {
                switch controller {
                case is UISplitViewController: // Return right hand side
                    let split = controller as? UISplitViewController
                    guard split?.viewControllers.isEmpty ?? true else {
                        return findBestViewController(split?.viewControllers.last)
                    }
                case is UINavigationController: // Return top view
                    let navigation = controller as? UINavigationController
                    guard navigation?.viewControllers.isEmpty ?? true else {
                        return findBestViewController(navigation?.topViewController)
                    }
                case is UITabBarController: // Return visible view
                    let tab = controller as? UITabBarController
                    guard tab?.viewControllers?.isEmpty ?? true else {
                        return findBestViewController(tab?.selectedViewController)
                    }
                default: break
                }
            }
            return controller
        }
        return findBestViewController(UIApplication.shared.keyWindow?.rootViewController)! // 假定永远有
    }
}
