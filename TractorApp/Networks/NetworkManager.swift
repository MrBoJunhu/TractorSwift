//
//  NetworkManager.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/24.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {

    static let manager = NetworkManager()
    
//    func sendRequest(request:NetworkRequest,success:@escaping ((Any)->Void),faile:@escaping ((Error)->Void)) -> Void{
//        request.successBlock = success
//        request.failBlock = faile
//        request.start()
//
//    }
    
    func sendRequest<T:Decodable>(type: T.Type,request:NetworkRequest,success:@escaping ((Any)->Void),faile:@escaping ((Error)->Void)) -> Void{
        request.successBlock = success
        request.failBlock = faile
        request.start(type: type)
        
    }
}
