//
//  AppSetting.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/24.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class AppSetting: NSObject {
    
    private let TOKEN_KEY:String! = "token"

    static let setting = AppSetting.init()
    
    func getToken() -> Any {
        return UserDefaults.standard.value(forKey: TOKEN_KEY) ?? ""
    }
    
    func setToken(token:String) -> Void {
        UserDefaults.standard.set(token, forKey: TOKEN_KEY)
        UserDefaults.standard.synchronize()
    }
    
    func getObj(key:String?) -> String? {
        return UserDefaults.standard.object(forKey:key!) as? String
    }
    
    func setBoolValue(boolValue:Bool ,key:String){
        UserDefaults.standard.set(boolValue, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}
