//
//  BBScrollButtonView.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/24.
//  Copyright © 2018年 BillBo. All rights reserved.
//  

import UIKit

typealias clickBtnBlock = (_ index: NSInteger)->()

class BBScrollButtonView: UIView {
    
    let scrollLB_Height = 2
    
    
    var clickBlock:clickBtnBlock!
    
    var buttonWidth:Int?
  
    var bottomLineHeight:CGFloat?
    var buttonTag:NSInteger?
    
    var buttons:[String]?
    var normalColor:UIColor?
   
    var selectedColor:UIColor?
    var selectedIndex:NSInteger?
   
    var normalFont:UIFont?
    var selectedFont:UIFont?
  
    var separtorLineColor:UIColor?
    var separtorLineHeight:CGFloat?
    
    var bottomSCV:UIScrollView?
    var scvLB:UILabel?
    
    var  bottomLineAnimatedTime:TimeInterval?
    

    
    convenience init(frame: CGRect, buttonWidth:Int, buttonTitles:[String], buttonTitleNormalColor:UIColor, buttonNormalFont:UIFont, selectedColor:UIColor, selectedFont:UIFont, selectedIndex:NSInteger, bottomLineHeight:CGFloat, bottomLineAnimated:Bool, separtorLineColor:UIColor, separterLineHeight:CGFloat, clickButton:@escaping clickBtnBlock) {
        self.init(frame: frame)
        
        self.buttonWidth = buttonWidth
        self.bottomLineHeight = bottomLineHeight
        self.buttonTag = 200
        self.buttons = buttonTitles
        self.normalColor = buttonTitleNormalColor
        self.selectedColor = selectedColor
        self.selectedIndex = selectedIndex
        self.normalFont = buttonNormalFont
        self.selectedFont = selectedFont
        self.separtorLineColor = separtorLineColor
        self.separtorLineHeight = separterLineHeight
        
        self.clickBlock = clickButton
        
        self.bottomLineAnimatedTime = bottomLineAnimated ? 0.2 : 0

        self.createUI(frame: frame)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createUI(frame:CGRect) -> Void {
        
        let v:UIView! = UIView.init(frame: CGRect.init(x: 0, y: frame.size.height - self.separtorLineHeight!, width: frame.size.width, height: separtorLineHeight!))
        v.backgroundColor = self.separtorLineColor
        self.addSubview(v)
        
        self.bottomSCV = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.bottomSCV?.showsVerticalScrollIndicator = false
        self.bottomSCV?.showsHorizontalScrollIndicator = false
        let count:Int = (self.buttons?.count)!
        self.bottomSCV?.contentSize = CGSize(width:CGFloat(count*self.buttonWidth!), height: (self.bottomSCV?.frame.size.height)!)
        self.addSubview(self.bottomSCV!)
        
        for i in 0..<count {
            
            let btn:UIButton = UIButton(type: .custom)
            btn.frame = CGRect.init(x: self.buttonWidth! * i, y: 0, width: self.buttonWidth!, height:Int(frame.size.height - bottomLineHeight!))
            btn.tag = i + self.buttonTag!
            let title:String = self.buttons![i]
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(self.normalColor, for: .normal)
            btn.titleLabel?.font = self.normalFont
            if i == self.selectedIndex {
                btn.setTitleColor(self.selectedColor, for: .normal)
                btn.titleLabel?.font = self.selectedFont
            }
            btn.addTarget(self, action: #selector(clickBtn(sender:)), for: .touchUpInside)
            self.bottomSCV?.addSubview(btn)
            
            
        }
        
        let bottomV:UIView = UIView.init(frame: CGRect.init(x: 0, y: frame.size.height - self.bottomLineHeight!, width: (self.bottomSCV?.contentSize.width)!, height: self.bottomLineHeight!))
        self.bottomSCV?.addSubview(bottomV)
        
        self.scvLB = UILabel.init(frame: CGRect.init(x: self.buttonWidth!*self.selectedIndex!, y: 0, width: self.buttonWidth!, height: scrollLB_Height))
        
        self.scvLB?.backgroundColor = self.selectedColor
        bottomV.addSubview(self.scvLB!)
        
        if self.selectedIndex! < 2 {
      
            self.bottomSCV?.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
      
        }else {
          
            self.bottomSCV?.setContentOffset(CGPoint(x: (self.scvLB?.frame.origin.x)! - CGFloat(2 * self.buttonWidth!), y: 0), animated: false)
      
        }
        
        
        
    }
    
    @objc func clickBtn(sender:UIButton)->Void {
        
        let tag = sender.tag
        
        self.reloadUI(tag: tag)
        
        if (self.clickBlock != nil) {
            self.clickBlock(tag)
        }
        
    }
    
    func reloadUI(tag :NSInteger) -> Void {
        
        for view:UIView in (self.bottomSCV?.subviews)! {
            
            if view.isKind(of: UIButton.classForCoder()){
               
                let btn:UIButton! = view as! UIButton
                
                if (btn.tag == tag){
                    btn.setTitleColor(self.selectedColor, for: .normal)
                    btn.titleLabel?.font = self.selectedFont
                }else {
                    btn.setTitleColor(self.normalColor, for: .normal)
                    btn.titleLabel?.font = self.normalFont

                }
                
            }
            
        }
        
        self.selectedIndex = tag - self.buttonTag!
       
        UIView.animate(withDuration: self.bottomLineAnimatedTime!) {
        
            self.scvLB?.frame = CGRect(x: CGFloat(self.buttonWidth! * (tag - self.buttonTag!)), y: (self.scvLB?.frame.origin.y)!, width: (self.scvLB?.frame.size.width)!, height: (self.scvLB?.frame.size.height)!)
            
            if (self.selectedIndex! > 0 && self.selectedIndex! < (self.buttons?.count)! - 1){
               
                let w :CGFloat = CGFloat(self.buttonWidth!)
                let offsetY:CGFloat = (self.scvLB?.frame.origin.x)! - w
                self.bottomSCV?.setContentOffset(CGPoint.init(x:offsetY , y: 0), animated: false)
                
            }
            
        }
        
    }
    
    func selectButton(index:NSInteger) -> Void {
        self.reloadUI(tag: index+self.buttonTag!)
    }
    
}
