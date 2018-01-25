//
//  TopicDetailHeaderView.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/18.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class TopicDetailHeaderView: UIView {
    
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.scrollView.isScrollEnabled = false
        view.isOpaque = false
        view.navigationDelegate = self
        return view
    }()
    
    private lazy var replyLabel: UILabel = {
        let view = UILabel()
        view.text = "全部回复"
        view.font = UIFont.systemFont(ofSize: 13)
        view.backgroundColor = ThemeStyle.style.value.bgColor
        view.textColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
        return view
    }()
    
    // 计算html高度
    private var htmlHeight: CGFloat = 0 {
        didSet {
            updateWebViewHeight()
        }
    }
    // 约束
    private var webViewConstraint: Constraint?
    public var webLoadComplete: Action?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 130))
        backgroundColor = UIColor.white
        addSubview(webView)
        addSubview(replyLabel)
        setupConstraints()
    }
    
    // 添加约束
    func setupConstraints() {
        webView.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.right.equalToSuperview()
            webViewConstraint = $0.height.equalTo(0).constraint
        }
        
        replyLabel.snp.makeConstraints {
            $0.top.equalTo(webView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(45)
        }
    }
    
    var replyTitle: String = "全部回复" {
        didSet {
            replyLabel.text = replyTitle
        }
    }
    
    var topicDetailModel: TopicListModel? {
        didSet {
            guard topicDetailModel != nil else {
                return
            }
            webView.loadHTMLString((topicDetailModel?.content)!, baseURL: nil)
//            webView.load(URLRequest(url: URL(string: "https://www.baidu.com")!))
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    // 更新webView高度
    private func updateWebViewHeight() {
        webViewConstraint?.update(offset: htmlHeight)
        height = htmlHeight + 45
        webLoadComplete?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopicDetailHeaderView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        webView.evaluateJavaScript("document.body.scrollHeight") { [weak self] result, error in
            guard let htmlHeight = result as? CGFloat else { return }
            self?.htmlHeight = htmlHeight
        }
    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//
//    }
}
