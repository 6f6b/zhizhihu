//
//  ZZHUserController.swift
//  zhizhihu
//
//  Created by dev.liufeng on 2017/4/11.
//  Copyright © 2017年 dev.liufeng. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import ObjectMapper

class ZZHUserController: ZZHCoreViewController {
    var dataArray = [UserModel]()
    var pageIndex = 1
    var pageSize = 20
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame: SCREEN_RECT, style: .plain)
        self.view.addSubview(tableView)
        self.tableView = tableView
        self.tableView.register(UINib.init(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [unowned self] in
            self.pageIndex = 1
            self.requestData()
        })
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [unowned self] in
            self.pageIndex += 1
            self.requestData()
        })
        self.tableView.mj_header.beginRefreshing()
    }
    
    func requestData(){
        let url = "http://114.215.221.131/client/get/users"
        let parameters = ["pageindex":pageIndex,"pagesize":pageSize,"keyword":self.searchBar.text!] as [String : Any]
        Alamofire.request(URL.init(string: url)!, method:  .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if self.pageIndex == 1{self.dataArray.removeAll()}
            if let dic = response.result.value as? [String:Any]{
                if dic["state_code"] as! Int == 1{
                    if let value = dic["data"]{
                        let imageModels = Mapper<UserModel>().mapArray(JSONObject: value)!
                        for element in imageModels{
                            self.dataArray.append(element)
                        }
                        self.tableView.reloadData()
                    }
                }
            }
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ZZHUserController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.resignFirstResponder()
        let zZHImgListController = ZZHImgListController()
        zZHImgListController.userModel = dataArray[indexPath.row]
        self.navigationController?.pushViewController(zZHImgListController, animated: true)
    }
}

extension ZZHUserController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.searchBar.resignFirstResponder()
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.configWith(model: self.dataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GET_DISTANCE(ratio: 0.25)
        }
}
