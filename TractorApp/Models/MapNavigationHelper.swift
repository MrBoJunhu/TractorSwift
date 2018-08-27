//
//  MapNavigationHelper.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/27.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit
import MapKit
class MapNavigationHelper: NSObject {

    class func naviagion(startAdd:String,startLocation:CLLocationCoordinate2D, endLocation:CLLocationCoordinate2D, endAdd:String)->Void {
        
        let maps = MapDataManager.manager.getNaviagtionsList(startAddress: startAdd, startLocation: startLocation, endAddress: endAdd, endLocation: endLocation)
        
        let titles = NSMutableArray.init()
        let urls = NSMutableArray.init()
        
        for dic in maps {
            
            if dic["title"] != nil && dic["url"] != nil {
                
                titles.add(dic["title"] ?? "")
                urls.add(dic["url"] ?? "")
            }
        }
        
        let navV = BBHandleCustomView.init(title: "", actionTitles: titles as! [String], normalColor: UIColor.bj_colorWithHex(hex: WordColor), specialTitles: [], specialColor: UIColor.clear) { (index) in
            
            let urlString:String = urls[index] as! String
            
            if urlString == "ios"{
                
                let currentL = MKMapItem.forCurrentLocation()
                let toL = MKMapItem.init(placemark: MKPlacemark.init(coordinate: endLocation, addressDictionary: [ : ]))
                MKMapItem.openMaps(with: [currentL,toL], launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                                                         MKLaunchOptionsShowsTrafficKey:NSNumber.init(booleanLiteral: true)])
                
                
                
            }else {
                
                let url = URL.init(string: urlString)
                
                if UIApplication.shared.canOpenURL(url!) {
                    
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url!, options: [:], completionHandler: { (f) in
                            
                        })
                    } else {
                        UIApplication.shared.openURL(url!)
                    }
                }
                
            }
            
        }
        
        navV.show()
        
    }
    
}
