//
//  ZZHTabBarController.swift
//  zhizhihu
//
//  Created by dev.liufeng on 2017/4/5.
//  Copyright © 2017年 dev.liufeng. All rights reserved.
//

import UIKit

class ZZHTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubController(controller: ZZHImageController(), title: "图片")
        addSubController(controller: ZZHUserController(),title: "用户")
        addSubController(controller: ZZHQuestionController(), title: "问题")
    }

    func addSubController(controller:UIViewController,title:String){
        controller.title = title
        let nav = ZZHNavigationController(rootViewController: controller)
        self.addChildViewController(nav)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
