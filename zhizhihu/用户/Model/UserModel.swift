//
//  IncomeModel.swift
//  KWallet
//
//  Created by Min on 2016/12/4.
//  Copyright © 2016年 cdu.com. All rights reserved.
//

import UIKit
import ObjectMapper

struct UserModel: Mappable {
    var checked_answers: Int?
    var checked_following: Int?
    var head_line:String?
    var order: Int?
    var user_answer_num: Int?
    var user_followers_num:Int?
    var user_following_num: Int?
    var user_head: String?
    var user_id: String?
    var user_link: String?
    var user_name: String?
    var user_sex: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        checked_answers <- map["checked_answers"]
        checked_following <- map["checked_following"]
        head_line <- map["head_line"]
        order <- map["order"]
        user_answer_num <- map["user_answer_num"]
        user_followers_num <- map["user_followers_num"]
        user_following_num <- map["user_following_num"]
        user_head <- map["user_head"]
        user_id <- map["user_id"]
        user_link <- map["user_link"]
        user_name <- map["user_name"]
        user_sex <- map["user_sex"]
    }
}

