//
//  TopicListModel.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/18.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

class Author: Mappable {
    var loginname: String?
    var avatar_url: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        loginname <- map["loginname"]
        avatar_url <- map["avatar_url"]
    }
}

class Reply: Mappable {
    var id: String?
    var author: Author?
    var content: String?
    var ups: [[String: Any]]?
    var create_at: String?
    var reply_id: String?
    var is_uped: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        author <- map["author"]
        content <- map["content"]
        ups <- map["ups"]
        create_at <- map["create_at"]
        reply_id <- map["reply_id"]
        is_uped <- map["is_uped"]
    }
}

class TopicListModel: Mappable {

    var id: String?
    var author_id: String?
    var tab: String?
    var content: String?
    var title: String?
    var last_reply_at: String?
    var good: Bool?
    var top: Bool?
    var reply_count: Int?
    var visit_count: Int?
    var create_at: String?
    var author: Author?
    var replies: [Reply]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        author_id <- map["author_id"]
        tab <- map["tab"]
        content <- map["content"]
        title <- map["title"]
        last_reply_at <- map["last_reply_at"]
        good <- map["good"]
        top <- map["top"]
        reply_count <- map["reply_count"]
        visit_count <- map["visit_count"]
        create_at <- map["create_at"]
        author <- map["author"]
        replies <- map["replies"]
    }
}
