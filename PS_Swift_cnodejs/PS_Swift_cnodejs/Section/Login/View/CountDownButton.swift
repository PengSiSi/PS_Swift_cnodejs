//
//  CountDownButton.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/25.
//  Copyright © 2017年 思 彭. All rights reserved.
// 获取验证码,倒计时的Button

import UIKit


class CountDownButton: UIButton {
    
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.layer.cornerRadius = 15
        self.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didClickButton() {
        self.remainingSeconds = 59
        self.isCounting = !self.isCounting
    }
    
    open var isCounting: Bool = false {//是否开始计时
        willSet(newValue) {
            if newValue {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    // 当前倒计时剩余的秒数
    private var remainingSeconds: Int = 0 {//remainingSeconds数值改变时 江将会调用willSet方法
        willSet(newSeconds) {
            let seconds = newSeconds % 60
            self.setTitle(NSString(format: "%02ds", seconds) as String, for: .normal)
        }
    }
    
    func updateTimer(timer: Timer) {// 更新时间
        if remainingSeconds > 0 {
            self.isEnabled = false
            remainingSeconds -= 1
        }
        
        if remainingSeconds == 0 {
            self.setTitle("获取验证码", for: .normal)
            self.isEnabled = true
            isCounting = !isCounting
            timer.invalidate()
        }
    }
}
