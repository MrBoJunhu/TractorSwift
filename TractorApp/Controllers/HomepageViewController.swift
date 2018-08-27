//
//  HomepageViewController.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/21.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class HomepageViewController: BaseViewController {

    var mapVC : MapBaseViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.mapVC = MapBaseViewController.init(mapType: .Homepage)
        self.mapVC.view.frame = self.view.bounds
        self.addChildViewController(self.mapVC)
        self.view.addSubview((self.mapVC?.view)!)
        
        
        let point:MAPointAnnotation = MAPointAnnotation()
        point.coordinate = CLLocationCoordinate2D.init(latitude: 31.483741, longitude: 120.277757)
        point.title = "江南大学(东门)"
        point.subtitle = "蠡湖大道与吴都路交叉口(地铁一号线附近)"
        
        var arr = [point] as [MAAnnotation]
        self.mapVC.addAnnotations(annotations: &arr)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.mapVC.view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }

    @IBAction func clickSearch(_ sender: UIBarButtonItem) {
        
        let searchVC:SearchViewController! = SearchViewController(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchVC, animated: true)
        self.hidesBottomBarWhenPushed = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
