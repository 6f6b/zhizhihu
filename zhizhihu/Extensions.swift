//
//  Extensions.swift
//  YONews
//
//  Created by dev.liufeng on 2017/2/5.
//  Copyright © 2017年 YONEWS. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
extension UITextField{
    //判断textField中的内容是否为空
    func isEmpty()->Bool{
        if let text = self.text{
            if text.characters.count>0{return false}
            return true
        }
        return true
    }
}

extension UITextView{
    //判断textField中的内容是否为空
    func isEmpty()->Bool{
        if let text = self.text{
            if text.characters.count>0{return false}
            return true
        }
        return true
    }
}


struct KFResource:Resource {
    /// The key used in cache.
    var cacheKey: String = ""
    
    /// The target image URL.
    var downloadURL: URL = URL.init(string: "")!
}
extension UIImageView{
//    func setImageWith(url:String){
//        let resource = KFResource.init(cacheKey: url, downloadURL: URL.init(string: serviceUrl+url)!)
//        kf.setImage(with: resource, placeholder: UIImage.init(named: "loading1"), options: nil, progressBlock: nil, completionHandler: nil)
//    }
}

extension UITableViewCell{
    func configWith(data:Any){}
}

extension UIBarButtonItem {
    //拓展UIBarButtonItem 实现选中item时显示不同的状态图片
    class func itemWithTarget(target:AnyObject,action:Selector, image:String,highImage:String) -> UIBarButtonItem{
        let btn = UIButton(type: UIButtonType.custom);
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside);
        btn.setBackgroundImage(UIImage(named: image), for: UIControlState.normal);
        btn.setBackgroundImage(UIImage(named: highImage), for: UIControlState.highlighted);
        btn.frame.size = (btn.currentBackgroundImage?.size)!;
        return UIBarButtonItem(customView: btn);
    }
}

extension String{
    func getRectSize(font:UIFont,width:CGFloat)->CGRect{
        let attributes = [NSFontAttributeName:font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let nsString = NSString.init(string: self)
        let size = CGSize(width: width, height: 0)
        let rect = nsString.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect
    }
    
    func doubleValue()->Double?{
        let nsString = NSString.init(string: self)
        return nsString.doubleValue
    }
}

extension Double{
    func stringValue()->String{
        let string = String.init(format: "%f", self)
        return string
    }
}

extension Float{
    func stringValue()->String{
        let string = String.init(format: "%f", self)
        return string
    }
}

extension Int{
    func stringValue()->String{
        let string = String.init(format: "%d", self)
        return string
    }
}
