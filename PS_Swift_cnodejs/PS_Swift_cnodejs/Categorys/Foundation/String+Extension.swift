//
//  String+Extension.swift
//  SwiftTools
//
//  Created by 思 彭 on 2017/5/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // 获取字符串长度
    var length: Int {
        return count
    }
    
    /// 转为 NSString
    var NSString: NSString {
        return self as NSString
    }
    
    // Base64解密
    public var base64Decoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }
    
    // Base64加密
    public var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = self.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    
    ///去掉自己前后空格
    public mutating func trim() {
        self = self.trimmed()
    }
    
    //／返回去掉前后空格的字符串
    public func trimmed() -> String {
        let set : CharacterSet = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: set)
    }
    
    // 是否包含此字符串
    public func contains(_ string:String) -> Bool {
        if (self.range(of: string) != nil) {
            return true
        } else {
            return false
        }
    }
    
    public func contains(_ string:String, withCompareOptions compareOptions: NSString.CompareOptions) -> Bool {
        if ((self.range(of:string, options: compareOptions)) != nil) {
            return true
        } else {
            return false
        }
    }
    
    // 字符串反转,逆序
    public func reversed() -> String {
        return String(self.characters.reversed())
    }

    /// 获取图片大小
    func getImageSizeWithURL() -> CGSize {
        // 获取 _ 的位置
        let firstIndex : NSRange = (self as NSString).range(of: "_")
        let imgType : [String] = [".JPG",".jpg",".JPEG",".jpeg",".PNG",".png","gif",""]
        
        var currType = imgType.last
        var typeRange : NSRange!
        for type in imgType {
            typeRange = (self as NSString).range(of: type)
            if typeRange.location < 100 {
                currType = type
                break;
            }
        }
        var sizeString = self
        guard currType != "" else {
            print ("图片类型错误:\(self)")
            return CGSize.zero
        }
        
        sizeString = (self as NSString).substring(with: NSMakeRange(firstIndex.location+1, typeRange.location - firstIndex.location-1))
        let size = sizeString.components(separatedBy: "x")
        let widthFormatter = NumberFormatter().number(from: size.first!)
        let heightFormatter = NumberFormatter().number(from: size.last!)
        
        guard let _ = widthFormatter else {
            return CGSize.zero
        }
        guard let _ = heightFormatter else {
            return CGSize.zero
        }
        
        var width = CFloat(truncating: widthFormatter!)
        var height = Float(truncating: heightFormatter!)
        if width > CFloat(screenWidth - 20) {
            width = CFloat(screenWidth - 20)
            height = width * height / Float(truncating: widthFormatter!)
        }
        
        return CGSize(width: CGFloat(width), height: CGFloat(height))
        
    }
    
    //根据开始位置和长度截取字符串
    // 注意：这个方法最后我们会将 Substring 显式地转成 String 再返回。
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
}

extension String {
    public func appendingPathComponent(_ path: String) -> String {
        return self.NSString.appendingPathComponent(path)
    }
    
    public func appendingPathExtension(_ text: String) -> String? {
        return self.NSString.appendingPathExtension(text)
    }
    
    public var deletingPathExtension: String {
        return self.NSString.deletingPathExtension
    }
    
    public var lastPathComponent: String {
        return self.NSString.lastPathComponent
    }
    
    public var deletingLastPathComponent: String {
        return self.deletingLastPathComponent
    }
    
    public var pathExtension: String {
        return self.NSString.pathExtension
    }
}

extension String {
    /// 字符串大小
    public func toSize(size: CGSize, fontSize: CGFloat, maximumNumberOfLines: Int = 0) -> CGSize {
        let font = UIFont.systemFont(ofSize: fontSize)
        var size = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes:[NSAttributedStringKey.font: font], context: nil).size
        if maximumNumberOfLines > 0 {
            size.height = min(size.height, CGFloat(maximumNumberOfLines) * font.lineHeight)
        }
        return size
    }
    
    /// 字符串宽度
    public func toWidth(fontSize: CGFloat, maximumNumberOfLines: Int = 0) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        return toSize(size: size, fontSize: fontSize, maximumNumberOfLines: maximumNumberOfLines).width
    }
    
    /// 字符串高度
    public func toHeight(width: CGFloat, fontSize: CGFloat, maximumNumberOfLines: Int = 0) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return toSize(size: size, fontSize: fontSize, maximumNumberOfLines: maximumNumberOfLines).height
    }
    
    /// 计算字符串的高度，并限制宽度
    public func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedStringKey.font: font],
            context: nil)
        return boundingBox.height
    }
    
    /// 下划线
    public func underline() -> NSAttributedString {
        let underlineString = NSAttributedString(string: self, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        return underlineString
    }
    
    // 斜体
    public func italic() -> NSAttributedString {
        let italicString = NSMutableAttributedString(
            string: self,
            attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)]
        )
        return italicString
    }
    
    /// 设置指定文字颜色
    public func makeSubstringColor(_ text: String, color: UIColor) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: self)
        
        let range = (self as NSString).range(of: text)
        if range.location != NSNotFound {
            attributedText.setAttributes([NSAttributedStringKey.foregroundColor: color], range: range)
        }
        
        return attributedText
    }
}
