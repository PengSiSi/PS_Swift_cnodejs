//
//  UIView+Extension.swift
//  SwiftTools
//
//  Created by 思 彭 on 2017/5/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// 返回view依赖的viewController
    public var viewController: UIViewController? {
        get {
            var responder = self as UIResponder
            while let nextResponder = responder.next {
                if (responder is UIViewController) {
                    return (responder as! UIViewController)
                }
                responder = nextResponder
            }
            return nil
        }
    }
    
    /// 查找aClass类型的subview（没递归）
    ///
    /// - Parameter aClass: 类的类型
    /// - Returns: 查找aClass类型的subview
    public func findSubView(aClass: AnyClass) -> UIView? {
        for subView in self.subviews {
            if (type(of: subView) === aClass) {
                return subView
            }
        }
        return nil
    }
    
    
    /// 查找aClass类型的superview
    ///
    /// - Parameter aClass: 类的类型
    /// - Returns: 查找aClass类型的superview
    public func  findSuperView(aClass: AnyClass) -> UIView? {
        guard let parentView = self.superview else {
            return nil
        }
        if (type(of: parentView) === aClass) {
            return parentView
        }
        
        return self.findSuperView(aClass: aClass)
    }
    
    // 判断View是不是第一响应者
    public func  findAndResignFirstResponder() -> Bool {
        if self.isFirstResponder {
            self.resignFirstResponder()
            return true
        }
        for v in self.subviews {
            if v.findAndResignFirstResponder() {
                return true
            }
        }
        return false
    }
    
    // 找到当前view的第一响应者
    public func  findFirstResponder() -> UIView? {
        if (self is UITextField || self is UITextView) && self.isFirstResponder{
            return self
        }
        for v: UIView in self.subviews {
            let fv = v.findFirstResponder()
            if fv != nil {
                return fv
            }
        }
        return nil
    }

    // 裁剪 view 的圆角
    func clipRectCorner(direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    /// 扩展UIView增加抖动方法
    ///
    /// - Parameters:
    ///   - direction: 抖动方向（默认是水平方向）
    ///   - times: 抖动次数（默认6次）
    ///   - interval: 每次抖动时间（默认0.2秒）
    ///   - delta: 抖动偏移量（默认4）
    ///   - completion: 抖动动画结束后的回调
    
    public enum ShakeDirection {
        case horizontal // 水平
        case vertical // 垂直
    }
    
    public func shake(direction: ShakeDirection = .horizontal, times: Int = 6, interval: TimeInterval = 0.2, delta: CGFloat = 4, completion: (() -> Void)? = nil) {
        //播放动画
        UIView.animate(withDuration: interval, animations: { () -> Void in
            switch direction {
            case .horizontal:
                self.layer.setAffineTransform( CGAffineTransform(translationX: delta, y: 0))
                break
            case .vertical:
                self.layer.setAffineTransform( CGAffineTransform(translationX: 0, y: delta))
                break
            }
        }) { (complete) -> Void in
            //如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) -> Void in
                    completion?()
                })
            }
                //如果当前不是最后一次抖动，则继续播放动画（总次数减1，偏移位置变成相反的）
            else {
                self.shake(direction: direction, times: times - 1,  interval: interval, delta: delta * -1, completion:completion)
            }
        }
    }

    // 加载动画-往右扫描
    public func startShimmering() {
        let light = UIColor.white.withAlphaComponent(0.3).cgColor
        let dark = UIColor.black.cgColor
        
        let gradient: CAGradientLayer = CAGradientLayer.init(layer: (Any).self)
        gradient.colors = [dark, light, dark]
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3*self.bounds.size.width, height: self.bounds.size.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.locations = [0.0, 0.5, 1.0]
        self.layer.mask = gradient
        
        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue   = [0.8, 0.9, 1.0]
        
        
        animation.duration = 2
        animation.repeatCount = Float.infinity
        
        gradient.add(animation, forKey: "shimmer")
    }
    
    /**
     添加点击事件
     
     - parameter target: 对象
     - parameter action: 动作
     */
    public func viewAddTarget(target : AnyObject,action : Selector) {
        
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    /// 使用视图的alpha创建一个淡出动画
    public func fadeOut(_ duration: TimeInterval = 0.4, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    /// 使用视图的alpha创建一个淡入动画
    public func fadeIn(_ duration: TimeInterval = 0.4, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
}
