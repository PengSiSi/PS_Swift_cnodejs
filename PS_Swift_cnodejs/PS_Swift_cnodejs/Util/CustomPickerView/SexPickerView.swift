//
//  SexPickerView.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/9/9.
//  Copyright © 2017年 思 彭. All rights reserved.

// 性别选择弹出view

import UIKit

protocol SexPickerViewDelegate {
    
    func chooseSex(sexPickerView: SexPickerView, sexStr: String)
}

class SexPickerView: UIView {
    
    var sexPickerDelegate : SexPickerViewDelegate?
    private var backgroundBtn: UIButton = UIButton()
    var selectedButton: UIButton?
    
    private let picker_height:CGFloat! = 260
    
    init(delegate: SexPickerViewDelegate) {
        
        sexPickerDelegate = delegate
        let v_frame = CGRect(x: 0, y: k_ScreenHeight, width: k_ScreenWidth, height: picker_height)
        super.init(frame: v_frame)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 44))
        view.backgroundColor = UIColor.RGBA(230, 230, 230, 1)
        self.addSubview(view)
        
        let cancelBtn = UIButton(type: UIButtonType.system)
        cancelBtn.frame = CGRect(x: 0, y:  0, width: 60, height: 44)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.setTitle("取 消", for: UIControlState.normal)
        cancelBtn.setTitleColor(UIColor.RGBA(18, 93, 255, 1), for: UIControlState.normal)
        cancelBtn.addTarget(self, action: #selector(cancelButtonClick(btn:)), for: .touchUpInside)
        self.addSubview(cancelBtn)
        
        let doneBtn = UIButton(type: UIButtonType.system)
        doneBtn.frame = CGRect(x: k_ScreenWidth - 60, y: 0, width: 60, height: 44)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        doneBtn.setTitle("确 定", for: UIControlState.normal)
        doneBtn.setTitleColor(UIColor.RGBA(18, 93, 255, 1), for: UIControlState.normal)
        doneBtn.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        self.addSubview(doneBtn)
        
        backgroundBtn = UIButton(type: UIButtonType.system)
        backgroundBtn.frame = CGRect(x: 0, y: 0, width: k_ScreenWidth, height: k_ScreenHeight)
        backgroundBtn.backgroundColor = UIColor.RGBA(0, 0, 0, 0.0)
        backgroundBtn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
        let viewContainer = UIView(frame: CGRect(x: 0, y: 44, width: k_ScreenWidth, height: picker_height - 44))
        self.addSubview(viewContainer)
        let titleArr = ["女性", "男性"]
        for index in 0..<2 {
            let button = UIButton(type: .custom)
            button.backgroundColor = UIColor.white
            button.frame = CGRect(x: CGFloat( index) * (k_ScreenWidth / 2), y: 0, width: k_ScreenWidth / 2, height: picker_height - 44)
            button.addTarget(self, action: #selector(selectButtonDidClick(button:)), for: .touchUpInside)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(UIColor.red, for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.set(image: UIImage(named: "ic_filter_selected"), title: titleArr[index], titlePosition: .bottom,
                     additionalSpacing: 10.0, state: .normal)
            viewContainer.addSubview(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 选择操作
    func selectButtonDidClick(button: UIButton) {
        
        // 实现两个单选操作
        if !button.isSelected {
            self.selectedButton?.isSelected = !(self.selectedButton?.isSelected)!
            button.isSelected = !button.isSelected
            self.selectedButton = button
        }
        if self.sexPickerDelegate != nil {
            self.sexPickerDelegate?.chooseSex(sexPickerView: self, sexStr: button.currentTitle!)
        }
    }
    
    func doneButtonClick() {
        self.hiddenPicker()
    }
    
    func cancelButtonClick(btn:UIButton) {
        self.hiddenPicker()
    }
    
    public func show() {
        
        UIApplication.shared.keyWindow?.addSubview(self.backgroundBtn)
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.35, animations: {
            self.backgroundBtn.backgroundColor = UIColor.RGBA(0, 0, 0, 0.3)
            self.top = k_ScreenHeight - self.picker_height
        }) { (finished: Bool) in
        }
    }
    
    private func hiddenPicker() {
        
        UIView.animate(withDuration: 0.35, animations: {
            self.backgroundBtn.backgroundColor = UIColor.RGBA(0, 0, 0, 0.0)
            self.top = k_ScreenHeight
        }) { (finished: Bool) in
            for view in self.subviews {
                view.removeFromSuperview()
            }
            self.removeFromSuperview()
            self.backgroundBtn.removeFromSuperview()
        }
    }

    func dismiss() {
        self.hiddenPicker()
    }

}

extension SexPickerViewDelegate {
    
}
