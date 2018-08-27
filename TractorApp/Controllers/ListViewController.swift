//
//  ListViewController.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/21.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController,UISearchBarDelegate {
    
    var tractorListVC:TractorListViewController!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "拖拉机列表"

        tractorListVC = TractorListViewController.init(type: .ListType)
        tractorListVC.getCellClick {[weak self] args in
            print(args)
            self?.searchBar.endEditing(true)
        }
        self.addChildViewController(tractorListVC)
        self.view.addSubview(tractorListVC.view)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tractorListVC.view.frame = CGRect.init(x: 0, y: self.searchBar.frame.maxY, width: self.view.frame.size.width, height: self.view.frame.size.height - self.searchBar.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    //TODO:UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)

        return true
    }

}
