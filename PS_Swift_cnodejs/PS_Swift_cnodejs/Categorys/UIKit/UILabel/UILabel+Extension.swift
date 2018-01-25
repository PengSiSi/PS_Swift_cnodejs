//
//  UILabel+Extension.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/12.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit
import ObjectiveC

extension UILabel {
    
    var fontSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    @IBInspectable
    var underline: Bool {
        get {
            return self.underline
        }
        set {
            guard let text = text else { return }
            let textAttributes = NSMutableAttributedString(string: text)
            let value: NSUnderlineStyle = newValue ? .styleSingle : .styleNone
            textAttributes.addAttribute(
                NSAttributedStringKey.underlineStyle,
                value: value.rawValue,
                range: NSRange(location: 0, length: text.count)
            )
            self.attributedText = textAttributes
        }
    }
    
    /// 设置指定文字[]大小
    func makeSubstringsBold(text: [String], size: CGFloat) {
        text.forEach { self.makeSubstringBold($0, size: size) }
    }
    
    /// 设置指定文字大小
    func makeSubstringBold(_ boldText: String, size: CGFloat) {
        let attributedText = self.attributedText!.mutableCopy() as? NSMutableAttributedString
        
        let range = ((self.text ?? "") as NSString).range(of: boldText)
        if range.location != NSNotFound {
            attributedText?.setAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: size)], range: range)
        }
        
        self.attributedText = attributedText
    }
    
    func makeSubstringWeight(_ text: String) {
        let attributedText = self.attributedText!.mutableCopy() as? NSMutableAttributedString
        let range = ((self.text ?? "") as NSString).range(of: text)
        if range.location != NSNotFound {
            attributedText?.setAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: fontSize)], range: range)
        }
        self.attributedText = attributedText
    }
    
    /// 设置指定文字颜色
    func makeSubstringColor(_ text: String, color: UIColor) {
        let attributedText = self.attributedText!.mutableCopy() as? NSMutableAttributedString
        
        let range = ((self.text?.lowercased() ?? "") as NSString).range(of: text.lowercased())
        if range.location != NSNotFound {
            attributedText?.setAttributes([NSAttributedStringKey.foregroundColor: color], range: range)
        }
        
        self.attributedText = attributedText
    }
    
    /// 使指定文字添加删除线
    func strikethrough(text: String) {
        self.attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue])
    }
    
    /// 设置行高
    func setLineHeight(_ lineHeight: Int) {
        let displayText = text ?? ""
        let attributedString = self.attributedText!.mutableCopy() as? NSMutableAttributedString
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(lineHeight)
        paragraphStyle.alignment = textAlignment
        
        attributedString?.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: displayText.count))
        
        attributedText = attributedString
    }
}

extension UILabel {
    
    private struct AssociatedKeys {
        static var copyable = "copyable"
        static var longPressGestureRecognizer = "longPressGestureRecognizer"
        static var clickCopyable = "clickCopyable"
        static var tapGestureRecognizer = "tapGestureRecognizer"
    }
    
    @IBInspectable public var copyable: Bool {
        get {
            guard let number = objc_getAssociatedObject(self, &AssociatedKeys.copyable) as? NSNumber else {
                return true
            }
            
            return number.boolValue
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.copyable, NSNumber(value: newValue),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            newValue ? enableCopying() : disableCopying()
        }
    }
    
    @IBInspectable public var clickCopyable: Bool {
        get {
            guard let number = objc_getAssociatedObject(self, &AssociatedKeys.copyable) as? NSNumber else {
                return true
            }
            
            return number.boolValue
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.clickCopyable, NSNumber(value: newValue),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            newValue ? enableClickCopying() : enableClickCopying()
        }
    }
    
    private var longPressGestureRecognizer: UILongPressGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.longPressGestureRecognizer) as?
            UILongPressGestureRecognizer
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.longPressGestureRecognizer, newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var tapGestureRecognizer: UITapGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tapGestureRecognizer) as?
            UITapGestureRecognizer
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tapGestureRecognizer, newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func enableCopying() {
        isUserInteractionEnabled = true
        
        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showCopyMenu))
        addGestureRecognizer(longPressGestureRecognizer!)
    }
    
    private func disableCopying() {
        isUserInteractionEnabled = false
        
        if let gestureRecognizer = longPressGestureRecognizer {
            removeGestureRecognizer(gestureRecognizer)
            longPressGestureRecognizer = nil
        }
    }
    
    private func enableClickCopying() {
        isUserInteractionEnabled = true
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showCopyMenu))
        addGestureRecognizer(tapGestureRecognizer!)
    }
    
    private func disableClickCopying() {
        isUserInteractionEnabled = false
        
        if let gestureRecognizer = tapGestureRecognizer {
            removeGestureRecognizer(gestureRecognizer)
            tapGestureRecognizer = nil
        }
    }
    
    @objc private func showCopyMenu() {
        let copyMenu = UIMenuController.shared
        
        guard !copyMenu.isMenuVisible else { return }
        
        becomeFirstResponder()
        
        copyMenu.setTargetRect(bounds, in: self)
        copyMenu.setMenuVisible(true, animated: true)
    }
    
    override open var canBecomeFirstResponder: Bool {
        return copyable || clickCopyable
    }
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        guard copyable || clickCopyable else { return false }
        
        if action == #selector(copy(_:)) {
            return true
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
    
    override open func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
    }
    
}

