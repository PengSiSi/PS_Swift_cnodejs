//
//  GuideViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/9/4.
//  Copyright © 2017年 思 彭. All rights reserved.
// 第一次进入欢迎页
// 参考博客: http://www.cnblogs.com/mantgh/p/4604129.html

import UIKit

typealias TapImageViewBlock = () -> Void

class GuideViewController: UIViewController {

    fileprivate var scrollView: UIScrollView!
    fileprivate var pageControl: UIPageControl!
    fileprivate var startButton: UIButton!
    var tapBlock: TapImageViewBlock?
    
    let imageArray = ["img_intro_1", "img_intro_2", "img_intro_3", "img_intro_4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = self.view.bounds
        
        scrollView = UIScrollView(frame: frame)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPoint.zero
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(imageArray.count), height: frame.size.height)
        
        scrollView.delegate = self
        
        for index  in 0..<imageArray.count {
            let imageView = UIImageView(image: UIImage(named: imageArray[index]))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            scrollView.addSubview(imageView)
            imageView.isUserInteractionEnabled = true
            if index == imageArray.count - 1 {
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapImageView))
                imageView.addGestureRecognizer(tap)
            }
        }
        
        self.view.insertSubview(scrollView, at: 0)
        
        // pageControl
        pageControl = UIPageControl(frame: CGRect(x: (k_ScreenWidth - 100) / 2, y: k_ScreenHeight - 130, width: 100, height: 40))
        pageControl.currentPage = 0
        pageControl.backgroundColor = UIColor.red
//        self.view.addSubview(pageControl)
        
        startButton = UIButton(type: .custom)
        startButton.frame = CGRect(x: (k_ScreenWidth - 100) / 2, y: k_ScreenHeight - 64, width: 100, height: 44)
        startButton.backgroundColor = UIColor.red
        startButton.setTitle("开始体验", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
//        self.view.addSubview(startButton)
        
        // 给开始按钮设置圆角
        startButton.layer.cornerRadius = 15.0
        // 隐藏开始按钮
//        startButton.alpha = 0.0
    }
    
    func startButtonClick() {
        
        print("开始体验")
    }
    
    @objc func tapImageView() {
        if tapBlock != nil {
            tapBlock!()
        }
    }
    
    // 隐藏状态栏
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

extension GuideViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        
        // 因为currentPage是从0开始，所以numOfPages减1
        if pageControl.currentPage == imageArray.count - 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.startButton.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.startButton.alpha = 0.0
            })
        }
    }
}
