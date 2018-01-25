//
//  AdvertiseViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/27.
//  Copyright © 2017年 思 彭. All rights reserved.

// 注意：iOS之用NSTimer定时刷新按钮的文字，避免按钮闪烁的办法？
// 将UIButton的类型由system改为custom就OK

import UIKit

class AdvertiseViewController: BaseViewController {

    @IBOutlet weak var timeButton: UIButton!
    private var time: TimeInterval = 5.0
    private var countDownTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        timeButton.setTitle(String(format: "%.0f s 跳过", time), for: .normal)
        // 开启定时器
        countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    // 点击跳转
    @IBAction func jumoOutAction(_ sender: Any) {
            //停止定时器
            countDownTimer?.invalidate()
            // 进入主界面
            let mainTabBarVc = MainTabBarController()
            UIApplication.shared.keyWindow?.rootViewController = mainTabBarVc
    }
    
    @objc fileprivate func updateTime() {
        if time == 0 {
            //停止定时器
            countDownTimer?.invalidate()
            // 进入主界面
            let mainTabBarVc = MainTabBarController()
            UIApplication.shared.keyWindow?.rootViewController = mainTabBarVc
        } else {
            time = time - 1
            timeButton.setTitle(String(format: "%.0f s 跳过", time), for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
