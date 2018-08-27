//
//  KnowledgeDetailViewController.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/23.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit
import WebKit
class KnowledgeDetailViewController: BaseViewController,WKNavigationDelegate {

    var wkWebView:WKWebView!
    var progressView:UIProgressView!
    var url:String! = ""
    var detailTitle:String! = "详情"
    
    
    
    init(urlString:String?,title:String?) {
        super.init(nibName: nil, bundle: nil)
        self.url = urlString
        self.detailTitle = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.detailTitle
        wkWebView = WKWebView(frame: .init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(wkWebView)

        wkWebView.navigationDelegate = self
        let url:URL! =  URL.init(string: self.url)
        let request:URLRequest! = URLRequest.init(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        wkWebView.load(request)
        
        progressView = UIProgressView.init(frame: .init(x: 0, y: 0, width: self.view.frame.size.width, height: 2))
        progressView.backgroundColor = .red
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
        self.view.addSubview(progressView)
        
        wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    //TODO:WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        self.showTextHUD(msg: "加载中......")
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        self.showTextHUD(message: "加载失败", hideAfterDelay: 2)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideHUD()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            
            progressView.progress = Float(wkWebView.estimatedProgress)
            
            if progressView.progress == 1 {
                
                UIView.animate(withDuration: 0.2, animations: {
                    
                    self.progressView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.4)
                    
                }) { (result) in
                
                    if result {
                        
                        self.progressView.isHidden = true

                    }
                
                }
                
            }
            
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        wkWebView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}
