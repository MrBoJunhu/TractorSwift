//
//  AppDelegate+Exensions.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/21.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    
    func designAppStyle() -> Void {
        
    
        let navigationBar = UINavigationBar.appearance()
       
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.bj_colorWithHex(hex: HomeColor)
        
        var textAttributes: [NSAttributedStringKey: AnyObject] = [:]
        textAttributes[.foregroundColor] = UIColor.white
        textAttributes[.font] = UIFont.boldSystemFont(ofSize: 18);
        navigationBar.titleTextAttributes = textAttributes
        
    }
    
    func configMapKey() -> Void {
        
        AMapServices.shared().apiKey = MAP_KEY
        
    }
    
}
