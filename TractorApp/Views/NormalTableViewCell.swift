//
//  NormalTableViewCell.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/23.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

let NormalTableViewCell_ID:NSString! = "NormalTableViewCell"

class NormalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftLB: UILabel!
    @IBOutlet weak var rightLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
