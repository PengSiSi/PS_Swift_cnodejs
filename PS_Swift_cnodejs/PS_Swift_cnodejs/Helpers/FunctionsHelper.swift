//
//  FunctionsHelper.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/17.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import Foundation
import UIKit
import SKPhotoBrowser
import SafariServices

public typealias JSONArray = [[String : Any]]
public typealias JSONDictionary = [String : Any]

// 1.登录
func presentLoginVC() {
    // 1、删除本地存储的用户信息
    
    // 2.有Cookie删除Cookie信息
    HTTPCookieStorage.shared.cookies?.forEach { HTTPCookieStorage.shared.deleteCookie($0) }
    let nav = BaseNavigationController(rootViewController: LoginViewController())
    AppWindow.shared.window.rootViewController?.present(nav, animated: true, completion: nil)
}

// 2.预览图片
enum PhotoBrowserType {
    case image(UIImage)
    case imageURL(String)
}

/// 预览图片
func showImageBrowser(imageType: PhotoBrowserType) {
    
    var photo: SKPhoto?
    switch imageType {
    case .image(let image):
        photo = SKPhoto.photoWithImage(image)
    case .imageURL(let url):
        photo = SKPhoto.photoWithImageURL(url)
        photo?.shouldCachePhotoURLImage = true
    }
    guard let photoItem = photo else { return }
    SKPhotoBrowserOptions.bounceAnimation = true
    SKPhotoBrowserOptions.enableSingleTapDismiss = true
    //    SKPhotoBrowserOptions.displayCloseButton = false
    SKPhotoBrowserOptions.displayStatusbar = false
    
    let photoBrowser = SKPhotoBrowser(photos: [photoItem])
    photoBrowser.initializePageIndex(0)
    //    photoBrowser.showToolbar(bool: true)
    var currentVC = AppWindow.shared.window.rootViewController?.currentViewController()
    if currentVC == nil {
        currentVC = AppWindow.shared.window.rootViewController
    }
    currentVC?.present(photoBrowser, animated: true, completion: nil)
}

// 3.设置状态栏背景颜色
/// 需要设置的页面需要重载此方法
/// - Parameter color: 颜色
func setStatusBarBackground(_ color: UIColor, borderColor: UIColor = .clear) {
    
    guard let statusBarWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? UIView,
        let statusBar = statusBarWindow.value(forKey: "statusBar") as? UIView,
        statusBar.responds(to:#selector(setter: UIView.backgroundColor)) else { return }
    
    if statusBar.backgroundColor == color { return }
    
    statusBar.backgroundColor = color
    statusBar.layer.borderColor = borderColor.cgColor
    statusBar.layer.borderWidth = 0.5
    //    statusBar.borderBottom = Border(color: borderColor)
    
    //    DispatchQueue.once(token: "com.v2er.statusBar") {
    //        statusBar.layer.shadowColor = UIColor.black.cgColor
    //        statusBar.layer.shadowOpacity = 0.09
    //        statusBar.layer.shadowRadius = 3
    //        // 阴影向下偏移 6
    //        statusBar.layer.shadowOffset = CGSize(width: 0, height: 6)
    //        statusBar.clipsToBounds = false
    //    }
}

// 4.打开浏览器 （内置 或 Safari）
func openWebView(url: URL?) {
    guard let `url` = url else { return }
    
    var currentVC = AppWindow.shared.window.rootViewController?.currentViewController()
    if currentVC == nil {
        currentVC = AppWindow.shared.window.rootViewController
    }
    
    if Preference.shared.useSafariBrowser {
        let safariVC = SFHandoffSafariViewController(url: url, entersReaderIfAvailable: true)
        if #available(iOS 10.0, *) {
            safariVC.preferredControlTintColor = UIColor.white
        } else {
            safariVC.navigationController?.navigationBar.tintColor = UIColor.white
        }
        currentVC?.present(safariVC, animated: true, completion: nil)
        return
    }
    if let nav = currentVC?.navigationController {
        let webView = SweetWebViewController()
        webView.url = url
        nav.pushViewController(webView, animated: true)
    } else {
        let safariVC = SFHandoffSafariViewController(url: url)
        currentVC?.present(safariVC, animated: true, completion: nil)
    }
}

func openWebView(url: String) {
    guard let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let `url` = URL(string: urlString) else { return }
    openWebView(url: url)
}


