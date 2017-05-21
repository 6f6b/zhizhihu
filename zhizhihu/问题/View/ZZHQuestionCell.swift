//
//  ZZHQuestionCell.swift
//  zhizhihu
//
//  Created by dev.liufeng on 2017/4/11.
//  Copyright © 2017年 dev.liufeng. All rights reserved.
//

import UIKit

class ZZHQuestionCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentLabel.font = FONT(size: 15)
    }
    
    func configWith(model:QuestionModel?){
        if let title = model?.question_title{
            self.contentLabel.text = title
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
