//
//  LoginViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/25.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    private var bgView: UIView?
    private var imgView: UIImageView?
    private var inputTF: UITextField?
    private var logginBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登录";
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.white
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        bgView = UIView()
        bgView?.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
//        bgView?.clipRectCorner(direction: .allCorners, cornerRadius: 5)
        self.view.addSubview(bgView!)
        
        imgView = UIImageView(image: UIImage(named: "logo"))
        imgView?.contentMode = .scaleAspectFit
        bgView?.addSubview(imgView!)
        
        inputTF = UITextField()
        inputTF?.placeholder = "输入AccessToken"
        inputTF?.borderStyle = .roundedRect
        self.view.addSubview(inputTF!)
    
        logginBtn = UIButton(type: .custom)
        logginBtn?.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
//        logginBtn?.clipRectCorner(direction: .allCorners, cornerRadius: 5)
        logginBtn?.setTitle("登录", for: .normal)
        logginBtn?.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        _ = logginBtn?.rx.controlEvent(UIControlEvents.touchUpInside)
            .subscribeNext({ [ unowned self ] in
            log.info("登录")
            self.logginAction()
        })
        self.view.addSubview(logginBtn!)
    }
    
    func setupConstraints() {
        bgView?.snp.makeConstraints {
            $0.left.top.equalTo(10)
            $0.right.equalTo(-10)
            $0.height.equalTo(200)
        }
        imgView?.snp.makeConstraints {
            $0.center.equalTo(bgView!)
            $0.height.equalTo(50)
            $0.width.equalTo(screenWidth - 40)
        }
        inputTF?.snp.makeConstraints {
            $0.top.equalTo((bgView?.snp.bottom)!).offset(20)
            $0.right.equalTo(-20)
            $0.left.equalTo(20)
            $0.height.equalTo(44)
        }
        logginBtn?.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(44)
            $0.centerX.equalToSuperview()
            $0.top.equalTo((inputTF?.snp.bottom)!).offset(30)
        }
    }

    // 登录
     @objc func logginAction() {
        Preference.shared.isLoggin = true
        self.navigationController?.popViewController(animated: true)
    }
}
