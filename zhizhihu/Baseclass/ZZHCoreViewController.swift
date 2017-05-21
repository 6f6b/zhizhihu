//
//  ZZHCoreViewController.swift
//  zhizhihu
//
//  Created by dev.liufeng on 2017/4/5.
//  Copyright © 2017年 dev.liufeng. All rights reserved.
//

import UIKit

import ObjectMapper
class ZZHCoreViewController: ZZHViewController {
    var searchBar:UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let searchBar = UISearchBar(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        self.navigationItem.titleView = searchBar
        self.searchBar = searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
