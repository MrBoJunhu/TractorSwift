//
//  UIView+ProgressHUD.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/23.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import Foundation

private var progressKey = "progressHUD"

extension UIView {
    
    var progressHUD:MBProgressHUD! {
       
        get{
            return objc_getAssociatedObject(self, &progressKey) as? MBProgressHUD
        }
      
        set(hud){
            objc_setAssociatedObject(self, &progressKey, hud, objc_AssociationPolicy(rawValue: objc_AssociationPolicy.RawValue(OS_OBJECT_USE_OBJC_RETAIN_RELEASE))!)
        }
        
    }
    
    public class func initializeMethod(){
        
        let originalSelector = #selector(UIView.didAddSubview(_:))
        let swizzledSelector = #selector(UIView.swizzeMethod(_:))
        
        let originalMethod:Method = class_getInstanceMethod(self, originalSelector)!
        let swizzledMethod:Method = class_getInstanceMethod(self, swizzledSelector)!
        
        //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
        let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        }else{
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }

    }
    
    @objc dynamic func swizzeMethod(_ subView:UIView)->Void {
        self.swizzeMethod(subView)
        if self.progressHUD != nil {
            self.bringSubview(toFront: self.progressHUD!)
        }
    }
    
    func setUpHud() -> Void {
     
        if progressHUD != nil {
            return
        }
        self.progressHUD = MBProgressHUD.showAdded(to: self, animated: true)
        self.progressHUD?.backgroundColor = .clear
        self.progressHUD?.detailsLabel.textColor = .black
        let type:UIAppearanceContainer.Type = MBProgressHUD.classForCoder() as! UIAppearanceContainer.Type
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [type]).color = .black
        self.progressHUD?.removeFromSuperViewOnHide = false
        
    }
    
}
