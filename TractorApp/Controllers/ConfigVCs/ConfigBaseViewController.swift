//
//  ConfigBaseViewController.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/23.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class ConfigBaseViewController: BaseViewController {

    private var topView:BBScrollButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "配置"
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.topView != nil {
            self.topView.removeFromSuperview()
        }
        
        let width = self.view.frame.size.width
        self.topView = BBScrollButtonView.init(frame: CGRect.init(x: 0, y: 0, width:width , height: 40), buttonWidth: Int(width/3), buttonTitles: ["基本信息","系统设置","安装配置","调试"], buttonTitleNormalColor: UIColor.bj_colorWithHex(hex: WordColor), buttonNormalFont: UIFont.systemFont(ofSize: 15), selectedColor: UIColor.bj_colorWithHex(hex: HomeColor), selectedFont: UIFont.systemFont(ofSize: 17), selectedIndex: 0, bottomLineHeight: 2, bottomLineAnimated: true, separtorLineColor: UIColor.bj_colorWithHex(hex: SepatorLineColor), separterLineHeight: 1, clickButton: { (index) in
            
            print(index)
            
        })
        
        self.view.addSubview(self.topView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
