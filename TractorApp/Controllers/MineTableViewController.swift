//
//  MineTableViewController.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/21.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class MineTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的"
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return section == 0 ? 3 :(section == 1 ? 1 : 2)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0  {
            return 20
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        
        let row = indexPath.row
        let section = indexPath.section
        
        if section == 1 {
            
            let collectVC:CollectViewController = CollectViewController(nibName: nil, bundle: nil)
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(collectVC, animated: true)
            self.hidesBottomBarWhenPushed = false
            
        }
        
        if section == 2 {
            
            if row == 0 {
                
                let resetVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResetPasswordTableViewController")
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(resetVC, animated: true)
                self.hidesBottomBarWhenPushed = false
                
            }else if row == 1{
                
                let loginVC:LoginTableViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginTableViewController") as! LoginTableViewController
                loginVC.isPresent = true
                self.present(loginVC, animated: true) {
                    self.tabBarController?.selectedIndex = 0
                }
            }
            
        }
    }
    
}
