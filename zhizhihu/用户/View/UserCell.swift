//
//  UserCell.swift
//  zhizhihu
//
//  Created by dev.liufeng on 2017/4/11.
//  Copyright © 2017年 dev.liufeng. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var headLine: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var sexImg: UIImageView!
    @IBOutlet weak var answerNum: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.headLine.font = FONT(sizePlus: 16)
        self.userName.font = FONT(sizePlus: 18)
        self.answerNum.font = FONT(sizePlus: 14)
    }

    func configWith(model:UserModel?){
        if let headImage = model?.user_head{
            var headImageLink = headImage.components(separatedBy: "{size}")[0]
            headImageLink = headImageLink+"l.jpg"
            self.headImage.kf.setImage(with: URL.init(string: headImageLink))
        }
        if let sex = model?.user_sex{
            let imgName = sex=="女" ? "woman":"man"
            self.sexImg.image = UIImage.init(named: imgName)
        }
        if let headLine = model?.head_line{
            self.headLine.text = headLine
        }
        if let userName = model?.user_name{
            self.userName.text = userName
        }
        if let answerNum = model?.user_answer_num{
            self.answerNum.text = "答案数："+answerNum.stringValue()
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
