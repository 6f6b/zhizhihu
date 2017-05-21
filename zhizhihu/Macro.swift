//
//  Macro.swift
//  KWallet
//
//  Created by dev.liufeng on 2016/12/2.
//  Copyright © 2016年 cdu.com. All rights reserved.
//

import Foundation
import UIKit

//APP版本
let APP_VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

//屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

//屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let SCREEN_RECT = UIScreen.main.bounds

let PLACEHOLD_IMAGE = UIImage(named: "Loading")

let APP_PRIVATE_KEY = ""
let APP_PUBLIC_KEY = ""
let ALIPAY_PUBLIC_KEY = ""
let ALIPAY_APP_ID = ""
let WECHAT_APP_ID = ""
let QQ_APP_ID = ""

//设置颜色
func RGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)->UIColor {return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)}

let APP_TITLE_COLOR = RGBA(r: 20, g: 255, b: 255, a: 1)

//设置字体大小
func FONT(size:CGFloat,isBold: Bool=false)->UIFont {
//    return UIFont.init(name: "Heiti SC", size: size)!
    if isBold{
        return UIFont.boldSystemFont(ofSize: size)
    }else{
       return UIFont.systemFont(ofSize: size)
    }
}

//设置字体大小、字体名称
func FONT(size:CGFloat,name:String)->UIFont{
    return UIFont(name: name, size: size)!
}

//根据机型设置字体大小
func FONT(size1:CGFloat,size2:CGFloat,size3:CGFloat)->UIFont {
    if SCREEN_WIDTH == 320{return FONT(size: size1)}
    if SCREEN_WIDTH == 375{return FONT(size: size2)}
    if SCREEN_WIDTH == 414{return FONT(size: size3)}
    return FONT(size: 17)
}

//设置Plus的字号，字体名称，其他机型自适应
func FONT(sizePlus:CGFloat,isBold: Bool=false)->UIFont{
    if SCREEN_WIDTH == 375{return FONT(size: CGFloat((375.0/414))*sizePlus,isBold: isBold)}
    if SCREEN_WIDTH == 320{return FONT(size: CGFloat((320.0/414))*sizePlus,isBold: isBold)}
    return FONT(size: sizePlus)
}

//根据机型设置字体大小、字体名称
func FONT(size1:CGFloat,size2:CGFloat,size3:CGFloat,name:String)->UIFont{
    if SCREEN_WIDTH == 320{return FONT(size: size1, name: name)}
    if SCREEN_WIDTH == 375{return FONT(size: size2, name: name)}
    if SCREEN_WIDTH == 414{return FONT(size: size3, name: name)}
    return FONT(size: 17)
}

//输入跟屏宽的比，得到对应的距离
func GET_DISTANCE(ratio:Float)->CGFloat{
    let distance = SCREEN_WIDTH*CGFloat(ratio)
    return distance
}

//加载xib
func GET_XIB_VIEW(nibName:String)->UIView?{
    return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.last as? UIView
}

//cell 高度跟屏幕宽度比例
let CELL_HEIGHT = GET_DISTANCE(ratio: Float(87.0/640))

//cell 左侧文本字体大小
let CELL_LEFT_FONT = FONT(sizePlus: 19)

//cell 右侧文本字体大小
let CELL_RIGHT_FONT = FONT(sizePlus: 16)

// 根据屏幕尺寸自动调整约束
func AutoLayoutConstraint(constraintPlus: CGFloat)->CGFloat{
    if SCREEN_HEIGHT == 667{
        return constraintPlus*667/736
    }else if SCREEN_HEIGHT <= 568{
        return 568/736*constraintPlus
    }else{
        return constraintPlus
    }
}

//创建一个时间单例
class KTimer {
    static let sharedInstance = KTimer()
    var time:Int = 0
    var timeChangeBlock:((_ time:Int)->Void)?
    private var timer:Timer?
    
    func start(){
        if let _ = self.timer{
            return
        }
        self.time = 60
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerGo), userInfo: nil, repeats: true)
    }
    
    @objc func timerGo(){
            self.time -= 1
            //处理timeChangeBlock中的事件
            if let timeChangeBlock = self.timeChangeBlock{
                timeChangeBlock(self.time)
            }
            if self.time <= 0{
                killKTimer()
            }
    }
    
    func killKTimer(){
        self.timer?.invalidate()
        self.timer = nil
    }
}


// 是否重新登录
var isAgain: Bool = true

func GetStringSize(str: NSString,font: UIFont)->CGSize{
    let attributes = [NSFontAttributeName: font]
    let size = str.size(attributes: attributes)
    return size
}

