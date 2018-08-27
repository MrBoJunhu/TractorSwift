//
//  InforListTableViewCell.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/22.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

//可选协议的书写样式
//@objc protocol InforListTableViewCellDelegate:NSObjectProtocol {
//    @objc optional func work()->Void
//    @objc optional func naviagtion()->Void
//}

protocol InforListTableViewCellDelegate {
    
    func phone(args:Any?)->Void
    func work(args:Any?) -> Void
    func navigation(args:Any?)->Void
    func map(args:Any?)->Void
    func config(args:Any?)->Void
    func collect(args:Any?,cell:UITableViewCell)->Void
    
}

let InforListTableViewCell_ID:NSString! = "InforListTableViewCell"

class InforListTableViewCell: UITableViewCell {

    
//    代理声明
    var delegate:InforListTableViewCellDelegate?
    var model:Any!
    
    @IBOutlet weak var deviceID: UILabel!
    @IBOutlet weak var tractorModuleLB: UILabel!
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var lastTimeLB: UILabel!
    @IBOutlet weak var lastLocationLB: UILabel!
    
    @IBOutlet weak var logoImageV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerRadius:CGFloat! = self.logoImageV.frame.size.width > self.logoImageV.frame.size.height ? self.logoImageV.frame.size.height/2 : self.logoImageV.frame.size.width/2
        
        self.logoImageV.borderStyle(width: 0, borderColor: .clear, cornerRadius: cornerRadius)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickCellButtonAction(_ sender: UIButton) {
        
        let tag:NSInteger = sender.tag
        
        switch tag {
      
        case 800:
            self.delegate?.phone(args: "15137737387")
        case 801:
            self.delegate?.work(args: self.model)
          
        case 802:
            self.delegate?.navigation(args: self.model)
          
        case 803:
            self.delegate?.map(args: self.model)
          
        case 804:
            self.delegate?.config(args: self.model)
          
        case 805:
            
            self.delegate?.collect(args: self.model,cell:self)
        default:
            break
        }
        
        
    }
    
    
    
}
