//
//  NetworkRequest.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/24.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

enum RequestMethod {
    case GET,POST,DELETE
}

class NetworkRequest: NSObject {

    typealias reqeustProgressBlcok = (_ progress:Progress?)->()
    public typealias requestSuccessBlock = (_ responseData:Any?)->()
    public  typealias requestFailBlock = (_ error:Error)->()
    
    var successBlock:requestSuccessBlock!
    var failBlock:requestFailBlock!
    var progressBlock:reqeustProgressBlcok!
    
    
    private var method:RequestMethod!
    private let requestManager:AFHTTPSessionManager! = AFHTTPSessionManager.init()
    private var reqeustUrl:String!
    private var parameterDic:Dictionary<String,Any>
    
    private init(url:String,parameter:Dictionary<String, Any>,method:RequestMethod) {
        
        self.reqeustUrl = HostUrl + url
        self.method = method
        self.parameterDic = parameter
        self.requestManager.requestSerializer = AFHTTPRequestSerializer.init()
        self.requestManager.responseSerializer = AFHTTPResponseSerializer.init()
        self.requestManager.requestSerializer.timeoutInterval = 30

    }
    
    class func reqeustGET(url:String) -> NetworkRequest {
        return NetworkRequest.init(url: url, parameter: [:], method: .GET)
    }
    
    class func reqestGET(url:String,parameter:Dictionary<String,Any>) -> NetworkRequest {
        return NetworkRequest.init(url: url, parameter: parameter, method: .GET)
    }
    
    class func reqeustPOST(url:String) -> NetworkRequest {
        return NetworkRequest.init(url: url, parameter: [:], method: .POST)
    }
    
    class func reqestPOST(url:String,parameter:Dictionary<String,Any>) -> NetworkRequest {
        return NetworkRequest.init(url: url, parameter: parameter, method: .POST)
    }
    
//    func start() -> Void {
//
//        var m = RequestMethod.GET
//        m = self.method
//
//        switch m {
//        case .GET:
//            self.requestManager.get(self.reqeustUrl, parameters: self.parameterDic, progress: { (args) in
//
//            }, success: { (task, response) in
//                self.dealSuccess(task: task, response: response)
//            }) { (task, error) in
//                self.dealFailure(task: task, error: error)
//            }
//        case .POST:
//            self.requestManager.post(self.reqeustUrl, parameters: self.parameterDic, progress: { (pro) in
//
//            }, success: { (task, response) in
//                self.dealSuccess(task: task, response: response)
//            }) { (task, error) in
//                self.dealFailure(task: task, error: error)
//            }
//        default:
//            print("other requests")
//        }
//
//    }
//    func dealSuccess(task:URLSessionDataTask,response:Any?) -> Void {
//
//        print("请求成功 \n")
//
//        if self.successBlock != nil {
//            self.successBlock(response)
//        }
//
//    }
    
    func start<T:Decodable>(type:T.Type) -> Void {
        
        var m = RequestMethod.GET
        m = self.method
        switch m {
        case .GET:
         
            self.requestManager.get(self.reqeustUrl, parameters: self.parameterDic, progress: { (args) in
                
            }, success: { (task, response) in

                self.dealSuccess(type, task: task, response: response)
          
            }) { (task, error) in
               
                self.dealFailure(task: task, error: error)
          
            }
      
        case .POST:
           
            self.requestManager.post(self.reqeustUrl, parameters: self.parameterDic, progress: { (pro) in
                
            }, success: { (task, response) in
              
                self.dealSuccess(type, task: task, response: response)
           
            }) { (task, error) in
           
                self.dealFailure(task: task, error: error)
         
            }
     
        default:
            print("other requests")
        }
        
    }
    
    func dealSuccess<T:Decodable>(_ type: T.Type,task:URLSessionDataTask,response:Any?) -> Void {
        
        print("㊗️请求成功 :----->" + self.reqeustUrl)
        let jsonData = try! JSONDecoder().decode(type, from: response as! Data)
        if self.successBlock != nil {
            self.successBlock(jsonData)
        }
       
    }
    
    func dealFailure(task:URLSessionDataTask?,error:Error) -> Void {

        print("❌请求失败 :----->" + self.reqeustUrl)
        if self.failBlock != nil {
            self.failBlock(error)
        }
        
    }
    
}
