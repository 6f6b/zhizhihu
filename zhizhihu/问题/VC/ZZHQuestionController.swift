//
//  ZZHQuestionController.swift
//  zhizhihu
//
//  Created by dev.liufeng on 2017/4/11.
//  Copyright © 2017年 dev.liufeng. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import ObjectMapper

class ZZHQuestionController: ZZHCoreViewController {
    var dataArray = [QuestionModel]()
    var pageIndex = 1
    var pageSize = 20
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame: SCREEN_RECT, style: .plain)
        self.view.addSubview(tableView)
        self.tableView = tableView
        self.tableView.register(UINib.init(nibName: "ZZHQuestionCell", bundle: nil), forCellReuseIdentifier: "ZZHQuestionCell")
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
        let url = "http://114.215.221.131/client/get/questions"
        let parameters = ["pageindex":pageIndex,"pagesize":pageSize,"keyword":self.searchBar.text!] as [String : Any]
        Alamofire.request(URL.init(string: url)!, method:  .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if self.pageIndex == 1{self.dataArray.removeAll()}
            if let dic = response.result.value as? [String:Any]{
                if dic["state_code"] as! Int == 1{
                    if let value = dic["data"]{
                        let imageModels = Mapper<QuestionModel>().mapArray(JSONObject: value)!
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

extension ZZHQuestionController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.resignFirstResponder()
        let zZHImgListController = ZZHImgListController()
        zZHImgListController.questionModel = dataArray[indexPath.row]
        self.navigationController?.pushViewController(zZHImgListController, animated: true)
    }
}

extension ZZHQuestionController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.searchBar.resignFirstResponder()
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZZHQuestionCell", for: indexPath) as! ZZHQuestionCell
        cell.configWith(model: self.dataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let str = self.dataArray[indexPath.row].question_title{
            let size = str.getRectSize(font: FONT(sizePlus: 15), width: SCREEN_WIDTH-20)
            print(SCREEN_WIDTH-20)
            print(size)
            return size.height + 30
//            return size.height<SCREEN_WIDTH*0.15-10 ? SCREEN_WIDTH*0.15:size.height+10
        }
        return GET_DISTANCE(ratio: 0.15)
    }
}
