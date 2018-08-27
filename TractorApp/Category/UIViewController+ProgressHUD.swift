//
//  UIViewController+ProgressHUD.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/23.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import Foundation
extension UIViewController {
        
    func progressHUD() -> MBProgressHUD {
        if self.view.progressHUD == nil {
            self.view.setUpHud()
        }
        return self.view.progressHUD!
    }
    
    func showTextHUD(message msg:String, progressModel model:MBProgressHUDMode) -> Void {
        self.progressHUD().mode = model
        self.progressHUD().detailsLabel.text = msg
        self.progressHUD().show(animated: true)
    }
    
    func showTextHUD(message msg:String , hideAfterDelay times:TimeInterval) -> Void {
        if msg.count == 0 {
            self.progressHUD().hide(animated: true, afterDelay: 0)
            return
        }
        self.progressHUD().mode = MBProgressHUDMode.text
        self.progressHUD().detailsLabel.text = msg
        self.progressHUD().show(animated: true)
        self.hideHUD(afterDelay: times)
    }
    
    
    func showHUD() -> Void {
        self.showTextHUD(msg: "")
    }
    
    func showTextHUD(msg:String) -> Void {
        self.showTextHUD(message: msg, progressModel: MBProgressHUDMode.indeterminate)
    }
    
    func hideHUD() -> Void {
        self.hideHUD(afterDelay: 0)
    }
    
    func hideHUD(afterDelay times:TimeInterval) -> Void {
        self.progressHUD().hide(animated: true, afterDelay: times)
    }
    
}
