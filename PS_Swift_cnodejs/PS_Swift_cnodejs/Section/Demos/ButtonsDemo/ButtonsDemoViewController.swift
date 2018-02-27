//
//  ButtonsDemoViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/31.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

class ButtonsDemoViewController: BaseViewController {

    // 数据源
    var dataArray = ["思思1", "思思2", "思思3", "思思4", "思思5", "思思6", "思思7"]
    var containerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "数据源创建按钮"
        setupUI()
        // 创建按钮
        createButtons(dataArray)
    }
    
    fileprivate func setupUI() {
        containerView = UIView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: 10))
        containerView?.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(containerView!)
    }
        
    fileprivate func createButtons(_ dataArray: [String]) {
        
        let maxCols: CGFloat = 4
        let buttonW = screenWidth / maxCols
        let buttonH = buttonW
        
        for i in 0..<dataArray.count {
            
            let button = UIButton()
            button.setTitle(dataArray[i], for: .normal)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.backgroundColor = UIColor.white
            button.titleLabel?.textAlignment = .center
            // 行
            let row = i / Int(maxCols)
            // 列
            let col = CGFloat(i).truncatingRemainder(dividingBy: maxCols)
            // 注意类型的转换
            let x = col * buttonW + CGFloat((col * 5))
            let y = CGFloat(row) * buttonH + CGFloat((row * 5))
            button.frame = CGRect(x: x, y: y, width: buttonW, height: buttonH)
            containerView?.addSubview(button)
        }
        
        // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
        let rows = (CGFloat(dataArray.count) + maxCols - 1) / maxCols
        containerView?.frame = CGRect(x: 0, y: 64, width: screenWidth, height: rows * buttonH)
    }
}
