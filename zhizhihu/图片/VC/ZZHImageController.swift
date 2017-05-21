//
//  ZZHImageController.swift
//  zhizhihu
//
//  Created by dev.liufeng on 2017/4/5.
//  Copyright © 2017年 dev.liufeng. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import ObjectMapper

class ZZHImageController: ZZHCoreViewController {
    var pageIndex = 1
    var pageSize = 20
    var collectionView:UICollectionView!
    var dataArray = [ImageModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        let margin:CGFloat = 4
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        let itemWH = (SCREEN_WIDTH-12)/3
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        let collectionView = UICollectionView(frame: SCREEN_RECT, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        self.collectionView = collectionView
        collectionView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceHorizontal = false
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
        
        self.collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [unowned self] in
            self.pageIndex = 1
            self.requestData()
        })
        
        self.collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [unowned self] in
            self.pageIndex += 1
            self.requestData()
        })
        self.collectionView.mj_header.beginRefreshing()
    }
    
    func requestData(){
        let url = "http://114.215.221.131/client/get/imgs"
        let parameters = ["pageindex":pageIndex,"pagesize":pageSize,"keyword":self.searchBar.text!] as [String : Any]
        Alamofire.request(URL.init(string: url)!, method:  .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if self.pageIndex == 1{self.dataArray.removeAll()}
            if let dic = response.result.value as? [String:Any]{
                if dic["state_code"] as! Int == 1{
                    if let value = dic["data"]{
                        let imageModels = Mapper<ImageModel>().mapArray(JSONObject: value)!
                        for element in imageModels{
                            self.dataArray.append(element)
                        }
                        self.collectionView.reloadData()
                    }
                }
            }
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.mj_footer.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ZZHImageController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.pageIndex = 1
        self.requestData()
        self.searchBar.resignFirstResponder()
    }
}

extension ZZHImageController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.configWith(model: self.dataArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchBar.resignFirstResponder()
        let zZHAnswerDetailController = ZZHAnswerDetailController()
        zZHAnswerDetailController.imgModel = self.dataArray[indexPath.row]
        self.navigationController?.pushViewController(zZHAnswerDetailController, animated: true)
    }
    
}
