//
//  ColorCategory.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/21.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    
  
    class func bj_colorWithHexString(hex:NSString,alpha:CGFloat) -> UIColor {
        
        var cString:NSString = hex.trimmingCharacters(in: NSCharacterSet.whitespaces).uppercased() as NSString;
        
        if cString.length < 6 {
            return UIColor.clear
        }
        
        if cString.hasPrefix("0X") {
            cString = cString.substring(from: 2) as NSString
        }
        
        if cString.hasPrefix("#") {
            cString = cString.substring(from: 1) as NSString
        }
        if cString.length != 6 {
            return UIColor.clear
        }
        
        var range:NSRange = NSRange.init(location: 0, length: 2);
        
        let rString :NSString = cString.substring(with: range) as NSString;
        
        range.location = 2
        let gString:NSString = cString.substring(with: range) as NSString
        
        range.location = 4
        let bString:NSString = cString.substring(with: range) as NSString
        
        
        var r:CUnsignedInt = 0,g:CUnsignedInt = 0,b:CUnsignedInt = 0
        Scanner(string: rString as String).scanHexInt32(&r)
        Scanner(string: gString as String).scanHexInt32(&g)
        Scanner(string: bString as String).scanHexInt32(&b)
        
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)

    
    }
    
  
    class func bj_colorWithHexString(hex:NSString) -> UIColor {
        
        return UIColor.bj_colorWithHexString(hex: hex, alpha: 1)
    
    }
    
 
    class  func bj_colorWithHex(hex:NSInteger , alpha:CGFloat) -> UIColor {
    
    return UIColor.init(red: CGFloat(((Float)((hex & 0xFF0000) >> 16))/255.0), green: CGFloat(((Float)((hex & 0x00FF00) >> 8))/255.0), blue: CGFloat(((Float)((hex & 0x0000FF)))/255.0), alpha: 1)
   
    }
    
 
    class func bj_colorWithHex(hex:NSInteger) -> UIColor {
        
        return UIColor.bj_colorWithHex(hex: hex, alpha: 1)
   
    }
    
}
