//
//  BBHandleCustomView.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/24.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class BBHandleCustomView: UIView,UITableViewDelegate,UITableViewDataSource {


    typealias clickActionHandleBlock = (_ index:NSInteger)->()
    typealias dismissBlock = (_ complete:Bool)->()

    private let title_Height:Int = 60
    private let row_H:Int = 50
    private let footer_H:Int = 8
    private var tableView_H:Int?
    
    private var actionTitles:[String]?
    private var specialTitles:[String]?
    
    private var normalColor:UIColor?
    private var specialColor:UIColor?
    var tbv:UITableView!
    
    private var title:String?
    private var clickHandle:clickActionHandleBlock?
    
    
    convenience init(title:String,actionTitles:[String],normalColor:UIColor,specialTitles:[String], specialColor:UIColor, clickAction:@escaping clickActionHandleBlock){
        self.init(frame: (UIApplication.shared.keyWindow?.bounds)!)

        self.backgroundColor = .black
        self.alpha = 0
        self.title = title
        self.actionTitles = actionTitles
        self.specialTitles = specialTitles
        self.clickHandle = clickAction
        self.normalColor = normalColor
        self.specialColor = specialColor
        
        let h = (self.title?.count)! > 0 ? title_Height : 0
        let width :Int = Int(UIScreen.main.bounds.size.width)
        let height:Int = Int(UIScreen.main.bounds.size.height)
        
        self.tableView_H = h + ((self.actionTitles?.count)! + 1) * self.row_H + self.footer_H
        self.tbv = UITableView.init(frame: CGRect.init(x: 0, y: height, width: width, height: self.tableView_H!), style: .plain)
        self.tbv.register(HandleCell.classForCoder(), forCellReuseIdentifier: "HandleCell")
        self.tbv?.backgroundColor = UIColor.init(red: 231/255.0, green: 232/255.0, blue: 234/255.0, alpha: 1)
        self.tbv?.isScrollEnabled = false
        self.tbv?.separatorColor = .clear
        self.tbv?.delegate = self
        self.tbv?.dataSource = self
        
    }
    
  
    
    //MARK:-show
    func show() -> Void {
        
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        window?.addSubview(self.tbv!)
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.4
            self.tbv?.frame = CGRect.init(x: 0, y: self.frame.size.height - (self.tbv?.frame.size.height)!, width: (self.tbv?.frame.size.width)!, height: (self.tbv?.frame.size.height)!)
        }
        
    }
    
    private func dismiss() -> Void {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.alpha = 0
            self.tbv?.frame = CGRect(x: 0, y: self.frame.size.height + (self.tbv?.frame.size.height)!, width: (self.tbv?.frame.size.width)!, height: (self.tbv?.frame.size.height)!)
            
        }) { [weak self] result in
            
            self?.tbv?.removeFromSuperview()
            self?.removeFromSuperview()
            
        }
        
    }
    
    //MARK:-UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return (self.actionTitles?.count)!

        }else {
            
            return 1
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:HandleCell = tableView.dequeueReusableCell(withIdentifier: "HandleCell", for: indexPath) as! HandleCell
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            
            let actionT = self.actionTitles![row]
          
            var isSpecial:Bool = false
            
            if (self.specialTitles?.contains(actionT))! {
                isSpecial = true
            }
            
            let color:UIColor = isSpecial ? self.specialColor! : self.normalColor!
            
            cell.reloadCell(title: actionT, titleColor: color, hiddenSepV: false)
            
        }else {
            
            cell.reloadCell(title: "取消", titleColor: self.normalColor!, hiddenSepV: true)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        
        if section == 0 {
            
            if self.clickHandle != nil {
                self.clickHandle!(indexPath.row)
            }
        }
        self.dismiss()
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            let v:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Int(self.frame.size.width), height: self.footer_H))
            v.backgroundColor = UIColor.lightText
            v.alpha = 0.3
            return v
        }else {
            
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            
            return CGFloat(self.footer_H)
        }else {
            
            return 0.01
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            let titleLB:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: Int(tableView.frame.size.width), height: self.title_Height))
            titleLB.font = UIFont.systemFont(ofSize: 16)
            titleLB.textAlignment = .center
            titleLB.text = self.title
            titleLB.backgroundColor = .white
            titleLB.textColor = .gray
            titleLB.numberOfLines = 0
            titleLB.lineBreakMode = .byWordWrapping
            
            return titleLB
            
        }else {
            
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return (self.title?.count)! > 0 ? CGFloat(self.title_Height) : 0.001
            
        }else{
            
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(row_H)
    }
    
    
    //MARK:-
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view === self {
            self.dismiss()
        }
    }
    
}

//MARK:----CELL
class HandleCell: UITableViewCell {
    
    private var cellTopSevLineH:CGFloat?
    private var sepV:UIView?
    private var lb:UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.cellTopSevLineH = 0.5
        self.backgroundColor = .white
        let width = UIScreen.main.bounds.size.width
        self.sepV = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: self.cellTopSevLineH!))
        self.sepV?.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(self.sepV!)
        
        self.lb = UILabel.init(frame: CGRect(x: 0, y: (self.sepV?.frame.maxY)!, width: width, height: self.contentView.frame.size.height - (self.sepV?.frame.size.height)!))
        self.lb?.textAlignment = .center
        self.lb?.font = UIFont.systemFont(ofSize: 18)
        self.lb?.backgroundColor = .white
        self.contentView.addSubview(self.lb!)
        
        
    }
    
    func reloadCell(title:String, titleColor:UIColor, hiddenSepV:Bool) -> Void {
        self.sepV?.isHidden = hiddenSepV
        self.lb?.text = title
        self.lb?.textColor = titleColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
