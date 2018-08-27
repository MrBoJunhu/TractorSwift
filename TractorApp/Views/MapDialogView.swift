//
//  MapDialogView.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/27.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class MapDialogView: UIView {
    
    var data:Any?

    @IBOutlet weak var tempBackView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    
    //隐藏回调
    typealias hiddenComplete = (_ finished:Bool)->()
    //点击按钮回调
    typealias clickMapDialogView = (_ obj:Any)->()
    
    private var complete:hiddenComplete?
    
    private var work:clickMapDialogView?
    private var navigation:clickMapDialogView?
    private var config:clickMapDialogView?
    private var collect:clickMapDialogView?
    private var close:clickMapDialogView?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.messageTextView.isEditable = false
        let test = "苏N008\n当前状态: 通讯中断    高度:  76m \n经度: 120.2707678 纬度:  98.2313423 \n方向:  正东  速度:  0Km/h  \n期望角度: 0 度     实际角度:  1 度 \n航行\n横行偏差 \n作业面积:  \n系统状态: \n最后记录位置:江苏省无锡市滨湖区 XXXXX \n最后记录时间 : 2018-08-13 17:23:09"
        self.messageTextView.text = test
        
    }
    
    override func draw(_ rect: CGRect) {
        self.bottomView.borderStyle(width: 0, borderColor: .clear, cornerRadius: 5)
        
    }
    
    class func view() -> MapDialogView {
        return Bundle.main.loadNibNamed("MapDialogView", owner: self, options: nil)?.first as! MapDialogView
    }

    func show() -> Void {
        
        self.tempBackView.alpha = 0
        self.alpha = 0
        self.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        UIApplication.shared.keyWindow?.addSubview(self)
       
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1
     
            self.tempBackView.alpha = 0.5
     
        }) { (result) in
            
        }
    }
    
    func dismiss() -> Void {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            self.tempBackView.alpha = 0.1
            self.bottomView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            
        }) { (result) in
           
            if result {
                self.bottomView.removeFromSuperview()
                
                UIView.animate(withDuration: 0.1, animations: {
                    
                    self.tempBackView.alpha = 0
                    
                }, completion: { (f) in
                    
                    if f {
                        
                        self.removeFromSuperview()
                       
                        if self.complete != nil {
                            
                            self.complete!(f)
                            
                        }
                    }
                    
                })
                
            }
        }
    }
    
    func dismiss(finished:@escaping (Bool)->()) -> Void {
        self.complete = finished
        self.dismiss()
    }
    
    func click(workF:@escaping clickMapDialogView, nav:@escaping clickMapDialogView,config:@escaping clickMapDialogView,collect:@escaping clickMapDialogView,close:@escaping clickMapDialogView) -> Void {
        self.work = workF
        self.navigation = nav
        self.config = config
        self.collect = collect
        self.close = close
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
        
        switch sender.tag {
        case 801:
            self.dismiss()
            if self.work != nil {
                self.work!(self.data as Any)
            }
        case 802:
            self.dismiss()
            if self.navigation != nil {
                self.navigation!(self.data)
            }
        case 803:
            self.dismiss()
            if self.config != nil {
                self.config!(self.data)
            }
        case 804:

            if self.collect != nil {
                self.collect!(self.data)
            }
        case 805:
            self.dismiss()
            if self.close != nil {
                self.close!(self.data)
            }
        default:
            print("nothing")
        }
        
        
    }
    
}
