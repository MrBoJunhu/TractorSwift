//
//  KnowledgeViewController.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/21.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class KnowledgeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mtbv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "知识库"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NormalTableViewCell = NormalTableViewCell.xibCell(tableView: tableView, identifier: NormalTableViewCell_ID) as! NormalTableViewCell
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 30
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let knowledgeDetailVC:KnowledgeDetailViewController = KnowledgeDetailViewController.init(urlString: "https://baidu.com", title: "百度首页")
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(knowledgeDetailVC, animated: true)
        self.hidesBottomBarWhenPushed = false
        
    }
}
