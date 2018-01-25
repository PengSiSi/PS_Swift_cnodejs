//
//  CommentInputView.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/15.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit
import SnapKit
import YYText


public typealias Action = () -> Void

let KcommentInputViewHeight: CGFloat = 55

class CommentInputView: UIView {
    
    public lazy var textView: YYTextView = {
        let view = YYTextView()
        view.placeholderAttributedText = NSAttributedString(string: "添加一条新回复", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
        view.clipRectCorner(direction: .allCorners, cornerRadius: 17.5)
        view.font = UIFont.systemFont(ofSize: 15)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        view.scrollsToTop = false
        view.textContainerInset = UIEdgeInsets(top: 8, left: 14, bottom: 5, right: 14)
        view.backgroundColor = UIColor.lightGray
        view.delegate = self
        view.textColor = UIColor.red
//        view.textParser = MentionedParser()
        view.tintColor = UIColor.black
        var contentInset = view.contentInset
        contentInset.right = -35
        view.contentInset = contentInset
        self.addSubview(view)
        return view
    }()
    
    private lazy var uploadPictureBtn: UIButton = {
       let view = UIButton()
        view.setImage(#imageLiteral(resourceName: "image"), for: .normal)
        view.setImage(#imageLiteral(resourceName: "image"), for: .selected)
        self.addSubview(view)
        return view
    }()
    
    private lazy var sendBtn: UIButton = {
        let view = UIButton()
        view.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        view.setImage(#imageLiteral(resourceName: "send"), for: .selected)
        self.addSubview(view)
        return view
    }()
    
    public var inputViewHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return KcommentInputViewHeight + AppWindow.shared.window.safeAreaInsets.bottom
        } else {
            return KcommentInputViewHeight
        }
    }
    
    private struct Misc {
        static let maxHeight = (UIScreen.main.bounds.height / 5).rounded(.down)// 200
        static let textViewContentHeight: CGFloat = KcommentInputViewHeight - 22
    }
    
    // Closure回调
    public var sendHandle: Action?
    public var atUserHandle: Action?
    public var uploadPictureHandle: Action?
    public var updateHeightHandle: ((CGFloat) -> Void)?
    
    private var uploadPictureRightConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        clipsToBounds = true
        backgroundColor = .white
        // 布局
        textView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10).priority(.high)
            $0.right.equalToSuperview().inset(15).priority(.high)
            $0.left.equalTo(uploadPictureBtn.snp.right).inset(-15)
            
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
            } else {
                $0.bottom.equalToSuperview().inset(10)
            }
        }
        sendBtn.snp.makeConstraints {
            $0.centerY.size.equalTo(uploadPictureBtn)
            $0.right.equalTo(textView.snp.right).inset(5)
        }
        
        uploadPictureBtn.snp.makeConstraints {
            uploadPictureRightConstraint = $0.right.equalTo(snp.left).constraint
            //            $0.bottom.equalTo(textView.bottom).offset(5)
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(12.5)
            } else {
                $0.bottom.equalToSuperview().inset(12.5)
            }
            $0.size.equalTo(30)
        }
        // 事件响应
        uploadPictureBtn.addTarget(self, action: #selector(uploadPictureAction), for: .touchUpInside)
        sendBtn.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
    }
}

extension CommentInputView: YYTextViewDelegate {
    func textViewShouldBeginEditing(_ textView: YYTextView) -> Bool {
        
        calculateHeight()
        
        UIView.animate(withDuration: 1) {
            self.uploadPictureRightConstraint?.update(offset: 45)
            self.uploadPictureBtn.layoutIfNeeded()
        }
        
        return true
    }
    
    // 结束编辑图片左移动
    func textViewShouldEndEditing(_ textView: YYTextView) -> Bool {
        calculateHeight(defaultHeight: inputViewHeight)
        uploadPictureRightConstraint?.update(offset: 0)
        return true
    }
    
    func textViewDidChange(_ textView: YYTextView) {
        // 输入回车收起键盘
        if textView.text.subString(start: textView.text.count - 1, length: 1) == "\n" {
            textView.resignFirstResponder()
        }
        calculateHeight()
    }
    
    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "@" {
            GCDUtil.delay(0.2, block: {
                self.atUserHandle?()
            })
        }
        return true
    }
}

extension CommentInputView {
     @objc private func uploadPictureAction() {
        self.uploadPictureHandle!()
    }
    
    @objc private func sendAction() {
        self.sendHandle!()
        self.calculateHeight(defaultHeight: self.inputViewHeight)
    }
    
    // 计算文字高度
    private func calculateHeight(defaultHeight: CGFloat = KcommentInputViewHeight) {
        let maxTextViewSize = CGSize(width: textView.bounds.width, height: .greatestFiniteMagnitude)
        var height = textView.sizeThatFits(maxTextViewSize).height.rounded(.down)
        height = height + textView.textContainerInset.top + textView.textContainerInset.bottom + 8
        height = height < defaultHeight ? defaultHeight : height
        height = height > Misc.maxHeight ? Misc.maxHeight : height
        updateHeightHandle?(height)
    }
}
