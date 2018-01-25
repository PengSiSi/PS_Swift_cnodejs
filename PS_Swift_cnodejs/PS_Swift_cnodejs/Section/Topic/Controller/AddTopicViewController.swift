//
//  AddTopicViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/18.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit
import YYText

class AddTopicViewController: BaseViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "标题:"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    lazy var titleTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入标题"
        textField.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.delegate = self
        textField.backgroundColor = UIColor.white
        return textField
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "内容:"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    public lazy var textView: UITextView = {
        let view = UITextView()
        view.text = "请输入内容"
        view.clipRectCorner(direction: .allCorners, cornerRadius: 17.5)
        view.font = UIFont.systemFont(ofSize: 15)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        view.scrollsToTop = false
        view.delegate = self
        view.textContainerInset = UIEdgeInsets(top: 8, left: 14, bottom: 5, right: 14)
        view.backgroundColor = UIColor.white
        view.textColor = UIColor.red
        view.tintColor = UIColor.black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "新增话题"
        setupUI()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: .plain, action: {
            log.info("提交")
            self.addTopicRequest()
        })
    }
    
    // 设置界面
    private func setupUI() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(titleTF)
        self.view.addSubview(contentLabel)
        self.view.addSubview(textView)
        titleLabel.snp.makeConstraints {
            $0.left.top.equalTo(10)
        }
        titleTF.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.equalTo(titleLabel.snp.left)
            $0.right.equalTo(-10)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleTF.snp.bottom).offset(20)
            $0.left.equalTo(titleLabel.snp.left)
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(10)
            $0.left.equalTo(titleLabel.snp.left)
            $0.width.equalTo(screenWidth - 40)
            $0.height.equalTo(200)
            $0.centerX.equalToSuperview()
        }
        
    }
}

extension AddTopicViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 输入回车收起键盘
        if textView.text.subString(start: textView.text.count - 1, length: 1) == "\n" {
            textView.resignFirstResponder()
        }
    }
}

extension AddTopicViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// 数据提交
extension AddTopicViewController {
    
    private func addTopicRequest() {
        self.navigationController?.popViewController(animated: true)
    }
}
