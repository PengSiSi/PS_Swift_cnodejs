//
//  ShareSheetView.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/16.
//  Copyright © 2018年 思 彭. All rights reserved.

// 分享组件

import UIKit
import RxOptional

public enum ShareItemType {
    case floor
    case favorite, thank, ignore, report
    case copyLink, safari, refresh, share
    case cancel
    
    public var needAuth: Bool {
        return [ShareItemType.favorite, ShareItemType.thank, ShareItemType.ignore].contains(self)
    }
}

public struct ShareItem {
    var icon: UIImage
    var title: String
    var type: ShareItemType
}

public typealias shareSheetDidSelectedHandle = (ShareItemType) -> Void

public class ShareSheetView: UIView {
    
    private struct Metric {
        /// 按钮与按钮之间的分割线高度
        static let divideLineHeight: CGFloat = 1
        /// button高度
        static let buttonHeight: CGFloat = 48.0
        /// 标题的高度
        static let titleHeight: CGFloat = 35.0
        /// 取消按钮与其他按钮之间的间距
        static let btnPadding: CGFloat = 0
        /// 动画持续时间
        static let defaultDuration: TimeInterval = 0.3
        /// 单行card的高度
        static let cardHeight: CGFloat = 120.0
        /// 单个item的高度
        static let itemHeight: CGFloat = 100.0
        /// 单个item的宽度
        static let itemwidth: CGFloat = 93.75
    }
    
    private var title: String = ""     //标题
    private var sections: [[ShareItem]] = []    //按钮组
    private var cancelTitle: String = ""     //取消按钮
    private var cancelButton: UIButton?
    
    var shareSheetHeight: CGFloat = 0
    public var shareSheetView: UIView = UIView()
    
    public var shareSheetDidSelectedHandle: shareSheetDidSelectedHandle?
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - buttons: 按钮数组
    ///   - cancel: 是否需要取消按钮
    convenience public init(title: String = "", sections: [[ShareItem]], cancelTitle: String = "取消") {
        
        self.init(frame: AppWindow.shared.window.bounds)
        
        self.sections = sections
        self.title = title
        self.cancelTitle = cancelTitle
        //添加单击事件，隐藏sheet
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.singleTapDismiss))
        singleTap.delegate = self
        self.addGestureRecognizer(singleTap)
        
        setupUI()
    }
    
    private func initShareSheet() {
        let btnCount = sections.count
        var tHeight:CGFloat = 0.0
        if title.isNotEmpty {
            tHeight = Metric.titleHeight
        }
        
        var cancelHeight:CGFloat = 0.0
        if cancelTitle.isNotEmpty {
            cancelHeight = Metric.buttonHeight + Metric.btnPadding
        }
        
        shareSheetHeight = CGFloat(btnCount) * Metric.cardHeight + tHeight + cancelHeight + CGFloat(btnCount) * Metric.divideLineHeight
        let aFrame = CGRect(x: 0, y: screenHeight, width: width, height: shareSheetHeight)
        shareSheetView.frame = aFrame
        addSubview(shareSheetView)
    }
    
    private func setupUI() {
        initShareSheet()
        
        //标题不为空，则添加标题
        if title.isNotEmpty {
            let titlelabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: Metric.titleHeight))
            titlelabel.text = title
            titlelabel.textAlignment = .center
            titlelabel.textColor = UIColor(red: 0.361, green: 0.361, blue: 0.361, alpha: 1.00)
            titlelabel.font = UIFont.systemFont(ofSize: 12)
            titlelabel.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90)
            titlelabel.adjustsFontSizeToFitWidth = true
            self.shareSheetView.addSubview(titlelabel)
        }
        
        //事件按钮组
        for index in 0..<sections.count {
            if index > 3 {break}
            let section = sections[index]
            
            var tHeight:CGFloat = 0.0
            if title.isNotEmpty   {
                tHeight = Metric.titleHeight
            }
            
            let origin_y = tHeight + Metric.cardHeight * CGFloat(index) + Metric.divideLineHeight * CGFloat(index)
            
            let scroller = UIScrollView(frame: CGRect(x: 0.0, y: origin_y, width: width, height: Metric.cardHeight))
            scroller.backgroundColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.80)
            scroller.showsHorizontalScrollIndicator = false
            scroller.showsVerticalScrollIndicator = false
            let contentSizeWidth = CGFloat(section.count) * Metric.itemwidth > width ? CGFloat(section.count) * Metric.itemwidth : (width + 1.0)
            scroller.contentSize = CGSize.init(width: contentSizeWidth, height: Metric.cardHeight)
            let itemsCount = section.count
            for subIdx in 0..<itemsCount {
                let origin_x = Metric.itemwidth * CGFloat(subIdx)
                let frame = CGRect.init(x: origin_x, y: (Metric.cardHeight - Metric.itemHeight)/2 , width: Metric.itemwidth, height: Metric.itemHeight)
                let item = ShareItemView(frame: frame, item: section[subIdx], callback: { type in
                    self.dismiss()
                    self.shareSheetDidSelectedHandle?(type)
                })
                scroller.addSubview(item)
            }
            self.shareSheetView.addSubview(scroller)
        }
        
        guard cancelTitle.isNotEmpty else { return }
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: Int(self.shareSheetView.bounds.size.height - Metric.buttonHeight), width: Int(width), height: Int(Metric.buttonHeight))
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle(cancelTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(itemClick), for: .touchUpInside)
        cancelButton = button
        shareSheetView.addSubview(button)
    }
    
    @objc func itemClick() {
        self.dismiss()
        shareSheetDidSelectedHandle?(.cancel)
    }
    
    @objc func singleTapDismiss() {
        itemClick()
    }
    
    /// 显示
    public func present() {
        UIView.animate(withDuration: 0.1, animations: {
            UIApplication.shared.keyWindow?.addSubview(self)
            self.shareSheetView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.20)
        }) { _ in
            UIView.animate(withDuration: Metric.defaultDuration) {
                self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                
                if #available(iOS 11, *) {
                    let margin = AppWindow.shared.window.safeAreaInsets.bottom
                    self.shareSheetView.y = screenHeight - self.shareSheetHeight - margin
                    self.cancelButton?.borderBottom = Border(size: margin, color: .white)
                    self.cancelButton?.height += margin
                    self.cancelButton?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: margin, right: 0)
                } else {
                    self.shareSheetView.y = screenHeight - self.shareSheetHeight
                }
            }
        }
    }
    
    /// 隐藏
    public func dismiss() {
        UIView.animate(withDuration: Metric.defaultDuration, animations: {
            self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            self.shareSheetView.y = screenHeight
        }) { (finished:Bool) in
            self.removeFromSuperview()
        }
    }
    
    /// 修改样式
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        shareSheetView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90).withAlphaComponent(0.6)
    }
    
    func imageWithColor(color:UIColor,size:CGSize) ->UIImage{
        let rect = CGRect(x:0, y:0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension ShareSheetView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self
    }
}

