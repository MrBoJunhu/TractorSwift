//
//  NetworkReqeust+Extension.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/24.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import Foundation
extension NetworkRequest {
    
    class func reqeustForTop250List(start:Int, count:Int)->NetworkRequest{
        
        let requset = NetworkRequest.reqeustGET(url:String.init(format: "%@?start=%d&count=%d", Top250Url,start,count))
        return requset
        
    }
    
}
