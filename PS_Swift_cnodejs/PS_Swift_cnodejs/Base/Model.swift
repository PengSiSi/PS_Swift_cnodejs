//
//  Model.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/12/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import HandyJSON

extension Array: HandyJSON{}

struct SearchItemModel: HandyJSON {
    var comic_id: Int = 0
    var name: String?
    var bgColor: String?
}

struct HotItemsModel: HandyJSON {
    var hotItems: [SearchItemModel]?
    var defaultSearch: String?
}

struct ReturnData<T: HandyJSON>: HandyJSON {
    var message:String?
    var returnData: T?
    var stateCode: Int = 0
}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var data: ReturnData<T>?
}
