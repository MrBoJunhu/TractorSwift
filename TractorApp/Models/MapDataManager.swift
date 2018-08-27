//
//  MapDataManager.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/27.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class MapDataManager: NSObject {

    let TENCENT_MPA_URL_API_KEY = "PW6BZ-LGF6U-FNHVN-2LU27-5HCVT-67BSO"
    
    static let manager = MapDataManager()
    
    var userLocation:CLLocationCoordinate2D?
    
    func getNaviagtionsList(startAddress:String, startLocation:CLLocationCoordinate2D, endAddress:String, endLocation:CLLocationCoordinate2D) -> [Dictionary<String, Any>] {
        
        var list : [Dictionary<String,Any>] = NSMutableArray.init() as! [Dictionary<String, Any>]
        
        let appleDic = NSMutableDictionary.init()
        appleDic["title"] = "苹果地图"
        appleDic["url"] = "ios"
        list.append(appleDic as! Dictionary<String, Any>)
        
        if UIApplication.shared.canOpenURL(URL.init(string: "baidumap://")!) {
            
            let baiduMapDic  = NSMutableDictionary.init()
            
            let urlString = NSMutableString.init(string: "baidumap://map/direction?")
            urlString.appendFormat("origin=%f,%f&destination=%f,%f&mode=driving&src=%@", startLocation.latitude,startLocation.longitude,endLocation.latitude,endLocation.longitude,"农机支持")
            baiduMapDic["title"] = "百度地图"
            baiduMapDic["url"] = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            list.append(baiduMapDic as! Dictionary<String, Any>)

        }
        
        if UIApplication.shared.canOpenURL(URL.init(string: "iosamap://")!) {
          
            let gaodeMapDic = NSMutableDictionary.init()
            gaodeMapDic["title"] = "高德地图"
            let urlString = String.init(format: "iosamap://path?sourceApplication=%@&sid=BGVIS1&slat=%f&slon=%f&sname=[我的位置]&did=BGVIS2&dlat=%f&dlon=%f&dname=[目的地]&dev=0&t=0", "农机技术",startLocation.latitude, startLocation.longitude, endLocation.latitude, endLocation.longitude)

            gaodeMapDic["url"] = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            list.append(gaodeMapDic as! Dictionary<String, Any>)
     
        }
        
        if UIApplication.shared.canOpenURL(URL.init(string: "comgooglemaps://")!) {
         
            let googleMapDic = NSMutableDictionary.init()
            googleMapDic["title"] = "谷歌地图"
            let urlString = String.init(format: "comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving","导航测试","nav123456",endLocation.latitude, endLocation.longitude)
            googleMapDic["url"] = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            list.append(googleMapDic as! Dictionary<String, Any>)

            
        }
        
        if UIApplication.shared.canOpenURL(URL.init(string: "qqmap://")!) {
            let qqMapDic = NSMutableDictionary.init()
            qqMapDic["title"] = "腾讯地图"
            let urlString = String.init(format: "qqmap://map/routeplan?type=drive&from=[我的位置]&fromcoord=%f,%f&to=[目的地]&tocoord=%f,%f&referer=%@", startLocation.latitude, startLocation.longitude, endLocation.latitude, endLocation.longitude, TENCENT_MPA_URL_API_KEY)
            qqMapDic["url"] = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            list.append(qqMapDic as! Dictionary<String, Any>)

            
        }
        
        return list
        
    }
    
}
