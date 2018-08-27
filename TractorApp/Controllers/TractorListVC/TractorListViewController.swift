//
//  TractorListViewController.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/23.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class TractorListViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,InforListTableViewCellDelegate {
 
    //定义枚举区分列表类型
    enum  TractorListType{
        case SearchType,ListType,Collect
    }
    
    //TODO:利用闭包实现cell点击回调 ⤵️
    typealias cellClickBlock = (_ args:Any)->()
    var cellBlock:cellClickBlock?
    func getCellClick(block:cellClickBlock?) -> Void {
        cellBlock = block
    }
    //TODO:利用闭包实现cell点击回调 ⤴️
    @IBOutlet weak var mTbv: UITableView!
    private var listType:TractorListType!
    
    init(type:TractorListType) {
        super.init(nibName: nil, bundle: nil)
        self.listType = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mTbv.mj_header = MJRefreshStateHeader.init(refreshingTarget: self, refreshingAction: #selector(refresh))
        self.mTbv.mj_header.beginRefreshing()

    }
    
    @objc func refresh()->Void {
       
        self.showHUD()
        let reqeust = NetworkRequest.reqeustForTop250List(start: 0, count: 20)
        
        NetworkManager.manager.sendRequest(type: Top250Model.self, request: reqeust, success: { [weak self] data in
            
            let top250:Top250Model = data as! Top250Model
            print(top250.title)
            self?.hideHUD()
            self?.mTbv.mj_header.endRefreshing()

        }) { (error) in
            
            self.mTbv.mj_header.endRefreshing()
            self.showTextHUD(message: "请求失败", hideAfterDelay: 2)

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:InforListTableViewCell = InforListTableViewCell.xibCell(tableView: tableView, identifier: InforListTableViewCell_ID) as! InforListTableViewCell
        cell.delegate = (self as InforListTableViewCellDelegate)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        //点击cell ,调用闭包实现回调
        if let block = self.cellBlock {
            block("点击cell 闭包回调 - dosomething")
        }
        
    }
    
    //TODO:InforListTableViewCellDelegate
    func phone(args: Any?) {
        if args == nil {
            return
        }
        let phoe:String = args as! String
        let telphone:String = "telprompt://" + phoe
        let url:URL! = URL.init(string: telphone)
        if UIApplication.shared.canOpenURL(url) {
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:]) { (result) in
                    
                }
            } else {
                UIApplication.shared.openURL(url)
            }
            
        }
    }
    
    func work(args: Any?) {
        
    }
    
    func navigation(args: Any?) {

        MapNavigationHelper.naviagion(startAdd: "起点", startLocation: MapDataManager.manager.userLocation!, endLocation: CLLocationCoordinate2DMake(31.469746,120.270756), endAdd: "终点")
        
    }
    
    func map(args: Any?) {
        
        let mapDetailVC:MapDetailViewController! = MapDetailViewController(nibName: nil, bundle: nil)
        self.parent?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(mapDetailVC, animated: true)
        self.parent?.hidesBottomBarWhenPushed = self.listType == TractorListType.ListType ? false : true

    }
    
    func config(args: Any?) {
        
        let configVC:ConfigBaseViewController! = ConfigBaseViewController(nibName: nil, bundle: nil)
        self.parent?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(configVC, animated: true)
        self.parent?.hidesBottomBarWhenPushed = self.listType == TractorListType.ListType ? false : true
        
    }
    
    func collect(args: Any?, cell: UITableViewCell) {
        let indexP:IndexPath! = self.mTbv.indexPath(for: cell)
        print(indexP.row)
        
    }
    
}
