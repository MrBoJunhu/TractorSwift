//
//  UIView+Category.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/22.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import Foundation

extension UIView {
    
    func borderStyle(width:CGFloat, borderColor:UIColor, cornerRadius:CGFloat) -> Void {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = width
        
    }
    
}
