//
//  UIButton+Extension.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/24.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import Foundation
extension UIButton {
  
    func buttonStyle(enableBgColor:UIColor,enableTitleColor:UIColor, disableBgColor:UIColor, disableTitleColor:UIColor) -> Void {
        
        if self.isEnabled {
            self.backgroundColor = enableBgColor
            self.setTitleColor(enableTitleColor, for: .normal)
        }else {
            self.backgroundColor = disableBgColor
            self.setTitleColor(disableTitleColor, for: .normal)
        }
    }
    
}
