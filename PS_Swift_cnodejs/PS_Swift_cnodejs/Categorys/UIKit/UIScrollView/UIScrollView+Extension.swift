
//
//  UIScrollView+Extension.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/16.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func scrollToTop(animated: Bool = true) {
        let topInset: CGFloat
        if #available(iOS 11.0, *) {
            topInset = adjustedContentInset.top
        } else {
            topInset = contentInset.top
        }
        setContentOffset(CGPoint(x: 0, y: -topInset), animated: animated)
    }
    
    var isOverflowVertical: Bool {
        return self.contentSize.height > self.height && self.height > 0
    }
    
    func isReachedBottom(withTolerance tolerance: CGFloat = 0) -> Bool {
        guard self.isOverflowVertical else { return false }
        let contentOffsetBottom = self.contentOffset.y + self.height
        return contentOffsetBottom >= self.contentSize.height - tolerance
    }
    
    func scrollToBottom(_ animated: Bool = true) {
        guard self.isOverflowVertical else { return }
        let insetEdge: UIEdgeInsets
        if #available(iOS 11.0, *) {
            insetEdge = adjustedContentInset
        } else {
            insetEdge = contentInset
        }
        let targetY = contentSize.height + insetEdge.bottom - height
        let targetOffset = CGPoint(x: 0, y: targetY)
        setContentOffset(targetOffset, animated: animated)
    }
}

