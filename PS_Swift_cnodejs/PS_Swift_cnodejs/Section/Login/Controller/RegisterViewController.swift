//
//  RegisterViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/25.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "注册";
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = GlobalColor()
        setupUI()
//        setupCountDownButton()
    }
    
    func setupUI() {
        let mobileTextField = UITextField(frame: CGRect(x: 10, y: 10, width: k_ScreenWidth - 20, height: 44))
        mobileTextField.backgroundColor = UIColor.white
        mobileTextField.placeholder = "手机号"
        mobileTextField.font = UIFont.systemFont(ofSize: 14)
        mobileTextField.borderStyle = .roundedRect
        mobileTextField.leftView = createTextFieldLeftView(imageName: "icon_phone")
        mobileTextField.leftViewMode = .always; //此处用来设置leftview现实时机

        self.view.addSubview(mobileTextField)
        
        let verifyCodeTextField = UITextField(frame: CGRect(x: 10, y: mobileTextField.bottom + 10, width: k_ScreenWidth - 20, height: 44))
        verifyCodeTextField.placeholder = "验证码"
        verifyCodeTextField.font = UIFont.systemFont(ofSize: 14)
        verifyCodeTextField.borderStyle = .roundedRect
        verifyCodeTextField.leftView = createTextFieldLeftView(imageName: "icon_password")
        verifyCodeTextField.backgroundColor = UIColor.white
        verifyCodeTextField.leftViewMode = .always; //此处用来设置leftview现实时机
        verifyCodeTextField.rightView = createTextFieldRightView()
        verifyCodeTextField.rightViewMode = .always
        self.view.addSubview(verifyCodeTextField)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: verifyCodeTextField.bottom + 30, width: k_ScreenWidth, height: 30))
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.text = "仅支持中国大陆手机号注册,港,澳,台及海外用户请使用邮箱"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(titleLabel)
        
        let nextStepButton = UIButton(type: .custom)
        nextStepButton.frame = CGRect(x: 20, y: titleLabel.bottom + 10, width: k_ScreenWidth - 40, height: 44)
        nextStepButton.layer.cornerRadius = 10
        nextStepButton.backgroundColor = RegisterButtonColor()
//        nextStepButton.titleLabel?.text = "下一步";
//        nextStepButton.titleLabel?.textColor = UIColor.white
        nextStepButton.setTitle("下一步", for: .normal)
        nextStepButton.addTarget(self, action: #selector(nextStepAction), for: .touchUpInside)
        nextStepButton.setTitleColor(UIColor.white, for: .normal)
        self.view.addSubview(nextStepButton)

    }
    
    func setupCountDownButton() {
        //调用方法
        let countDown: CountDownButton = CountDownButton()//实例化
        self.view.addSubview(countDown)
        countDown.frame = CGRect(x: 0, y: k_ScreenHeight - 100, width: 100, height: 30)
        countDown.backgroundColor = CountDownColor()
        countDown.isCounting = true  //开启倒计时
        
    }
    
    // 下一步
    @objc func nextStepAction() {
        
    }
    
    // textField的leftView
    func createTextFieldLeftView(imageName: String) -> UIView {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imgView = UIImageView(frame: CGRect(x: 10, y: 0, width:20 , height: 20))
        imgView.image = UIImage(named: imageName)
        leftView.addSubview(imgView)
        return leftView
    }
    
    // textField的leftView
    func createTextFieldRightView() -> UIView {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        let countDown: CountDownButton = CountDownButton()//实例化
        countDown.frame = CGRect(x: 5, y: 5, width:90 , height: 34)
        countDown.backgroundColor = CountDownColor()
        countDown.isCounting = true  //开启倒计时
        rightView.addSubview(countDown)
        return rightView
    }
}
