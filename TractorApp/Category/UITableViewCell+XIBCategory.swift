//
//  UITableViewCell+XIBCategory.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/23.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import Foundation

extension UITableViewCell {
   
    class func xibCell(tableView:UITableView, identifier:NSString) -> UITableViewCell! {
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: (identifier as String?)!)
        if cell == nil{
            cell = Bundle.main.loadNibNamed(identifier as String, owner: self, options: nil)?.first as? UITableViewCell
            tableView.register(UINib.init(nibName: identifier as String, bundle: nil), forCellReuseIdentifier: identifier as String)
        }
        return cell
   
    }
}
