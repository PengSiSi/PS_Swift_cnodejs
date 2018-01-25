//
//  NightThemeViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/17.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

class NightThemeViewController: BaseViewController {

    private lazy var mySwitch: UISwitch = {
        let view = UISwitch()
        view.sizeToFit()
//        view.isUserInteractionEnabled = false
        view.onTintColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)
        view.addTarget(self, action: #selector(switchAction(_:)), for: .valueChanged)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "夜间模式Demo"
        mySwitch.frame = CGRect(x: 100, y: 100, width: 100, height: 44)
        self.view.addSubview(mySwitch)
    }
    
    override func setupTheme() {
       
    }
    
    @objc private func switchAction(_ sender: UISwitch) {
        log.info(sender.isOn)
        // 设置点击时震动效果
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.prepare()
            generator.impactOccurred()
        }
        // 设置全局的模式
        Preference.shared.nightModel = sender.isOn
        // 更改样式
        self.view.backgroundColor = ThemeStyle.style.value.bgColor
        print(ThemeStyle.style.value)  // night
    }
}
