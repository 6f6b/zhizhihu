//
//  IncomeModel.swift
//  KWallet
//
//  Created by Min on 2016/12/4.
//  Copyright © 2016年 cdu.com. All rights reserved.
//

import UIKit
import ObjectMapper

struct ImageModel: Mappable {
    var answer_id: String?
    var img_link: String?
    var question_id: String?
    var user_id: String?
    var clicked_num:Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        answer_id <- map["answer_id"]
        img_link <- map["img_link"]
        question_id <- map["question_id"]
        user_id <- map["user_id"]
        clicked_num <- map["clicked_num"]
    }
}

