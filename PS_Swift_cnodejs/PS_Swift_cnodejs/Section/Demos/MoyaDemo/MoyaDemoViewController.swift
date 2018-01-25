//
//  MoyaDemoViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/12/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class MoyaDemoViewController: BaseViewController {

    private var hotItems: [SearchItemModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Moya数据请求Demo"
        // 颜色
//        view.backgroundColor = #colorLiteral(red: 1, green: 0.4212399895, blue: 0.3826281974, alpha: 1)
        let img = UIImageView.init()
//        img.image = #imageLiteral(resourceName: "interaction_icon_normal")
        loadData()
    }
    
    func loadData() {
        ApiLoadingProvider.request(API.searchHot, model: HotItemsModel.self) { (returnData) in
            self.hotItems = returnData?.hotItems
        }
    }
}
