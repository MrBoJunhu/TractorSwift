//
//  CollectViewController.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/23.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class CollectViewController: BaseViewController {

    var tractorListVC:TractorListViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "收藏"
        tractorListVC = TractorListViewController.init(type: .Collect)
        tractorListVC.getCellClick {[weak self] args in
            self?.view.backgroundColor = .white
        }
        self.addChildViewController(tractorListVC)
        self.view.addSubview(tractorListVC.view)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tractorListVC.view.frame = self.view.bounds
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
