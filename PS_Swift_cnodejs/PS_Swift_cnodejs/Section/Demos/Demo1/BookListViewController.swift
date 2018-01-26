//
//  BookListViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/12/21.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

// 用Swift 将协议（protocol）中的部分方法设计成可选（optional），该怎样实现？
// 参考链接： http://www.cocoachina.com/ios/20171117/21214.html
@objc  protocol BookListViewControllerProtocol {
    func func1()
    @objc optional func func2()
}

class BookListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
