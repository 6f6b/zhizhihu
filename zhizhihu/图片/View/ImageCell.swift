//
//  ImageCell.swift
//  zhizhihu
//
//  Created by dev.liufeng on 2017/4/10.
//  Copyright © 2017年 dev.liufeng. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageV: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configWith(model:ImageModel?){
        if let img_link = model?.img_link{
            self.imageV.kf.setImage(with: URL.init(string: img_link))
        }
    }
}
