//
//  UserInfoModel.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/17.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

class UserInfoModel: Mappable {
    
    var loginname: String?
    var avatar_url: String?
    var githubUsername: String?
    var create_at: String?
    var score: String?
    var recent_topics: [[String: Any]]?
    var recent_replies: [[String: Any]]?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        loginname <- map["loginname"]
        avatar_url <- map["avatar_url"]
        githubUsername <- map["githubUsername"]
        create_at <- map["create_at"]
        score <- map["score"]
        recent_topics <- map["recent_topics"]
        recent_replies <- map["recent_replies"]
    }
}

