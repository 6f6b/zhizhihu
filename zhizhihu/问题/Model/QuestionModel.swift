//
//  IncomeModel.swift
//  KWallet
//
//  Created by Min on 2016/12/4.
//  Copyright © 2016年 cdu.com. All rights reserved.
//

import UIKit
import ObjectMapper

struct QuestionModel: Mappable {
    var question_id: String?
    var question_link: String?
    var question_title: String?
    var user_id: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        question_id <- map["question_id"]
        question_link <- map["question_link"]
        question_title <- map["question_title"]
        user_id <- map["user_id"]
    }
}

