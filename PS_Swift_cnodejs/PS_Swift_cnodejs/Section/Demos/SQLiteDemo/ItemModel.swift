//
//  ItemModel.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/26.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import Foundation
import UIKit

struct ItemModel {
    var itemID: String?
    var title: String?
    var isRead: Bool = false
    
    init(itemID: String?, title: String?) {
        self.itemID = itemID
        self.title = title
    }
}
