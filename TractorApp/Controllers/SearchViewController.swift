//
//  SearchViewController.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/23.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var tractorListVC:TractorListViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "搜索"
        tractorListVC = TractorListViewController.init(type: .SearchType)
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
