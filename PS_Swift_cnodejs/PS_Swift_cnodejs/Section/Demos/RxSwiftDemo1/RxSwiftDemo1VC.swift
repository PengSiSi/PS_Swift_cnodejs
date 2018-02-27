//
//  RxSwiftDemo1VC.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/2/27.
//  Copyright © 2018年 思 彭. All rights reserved.

// http://www.hangge.com/blog/cache/detail_1963.html

import UIKit
import RxSwift
import RxCocoa

class RxSwiftDemo1VC: BaseViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mySwitch = UISwitch(frame: CGRect(x: 100, y: 100, width: 100, height: 44))
        mySwitch.isOn = true
        
        self.view.addSubview(mySwitch)
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 100, y: 200, width: 50, height: 50))
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        let btn = UIButton(frame: CGRect(x: 100, y: 280, width: 100, height: 44))
        btn.backgroundColor = UIColor.red
        btn.setTitle("点击按钮", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        self.view.addSubview(btn)
        
        let textField = UITextField(frame: CGRect(x: 100, y: 350, width: 100, height: 44))
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.lightGray
        self.view.addSubview(textField)
        
        // RxCocoa值绑定切换
        mySwitch.rx.value
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        mySwitch.rx.value.bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        // 监听属性值变化
        mySwitch.rx.isOn.asObservable()
            .subscribe(onNext: {
                print("当前开关状态：\($0)")
            })
            .disposed(by: disposeBag)
        
        // 按钮点击(两种写法)
//        btn.rx.tap
//            .subscribe(onNext: { [weak self] in
//                self?.showMessage("按钮被点击")
//            })
//            .disposed(by: disposeBag)
        btn.rx.tap
            .bind{ [weak self] in
                self?.showMessage("点击")
        }
        .disposed(by: disposeBag)
        
        // 文本框内容的改变(两种写法)
//        textField.rx.text.orEmpty.asObservable()
//            .subscribe(onNext: {
//              print("内容是：\($0)")
//            })
//        .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty.changed
            .subscribe(onNext: {
                print("您输入的是：\($0)")
            })
            .disposed(by: disposeBag)
    }
    
    func showMessage(_ text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
