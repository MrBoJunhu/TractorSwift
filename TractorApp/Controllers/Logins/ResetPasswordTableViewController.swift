//
//  ResetPasswordTableViewController.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/24.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class ResetPasswordTableViewController: UITableViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var oldTF: UITextField!
    @IBOutlet weak var checkTF: UITextField!
    @IBOutlet weak var otherTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改密码"
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 3
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        let height:CGFloat = (row == 0) ? (tableView.frame.size.height - 150)/3 :(row == 1 ? 150 : (tableView.frame.size.height - 150)/3*2);
        return height
    }
    
    //MARK:-UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.reloadButton()
        return true
    }
    
    func checkSubmit() -> Bool {
        return ((self.oldTF.text?.count)! > 0 ) && ((self.otherTF.text?.count)! > 0 ) && ((self.checkTF.text?.count)! > 0 )
    }
    
    func reloadButton() -> Void {
        
        self.submitBtn.isEnabled = self.checkSubmit()
        
        self.submitBtn.buttonStyle(enableBgColor: UIColor.bj_colorWithHex(hex: HomeColor), enableTitleColor: .white, disableBgColor: UIColor.bj_colorWithHex(hex: SepatorLineColor), disableTitleColor: UIColor.bj_colorWithHex(hex: LightGrayColor))
    }
    
    @IBAction func clcikSubmitButton(_ sender: UIButton) {
        
        self.view.endEditing(true)
     
        if self.otherTF.text != self.checkTF.text {
            self.showTextHUD(message: "密码不一致,请重新输入", hideAfterDelay: 2)
            return
        }
        
        let loginVC:LoginTableViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginTableViewController") as! LoginTableViewController
        loginVC.isPresent = true
        self.present(loginVC, animated: true) {
            self.tabBarController?.selectedIndex = 0
        }

        
    }
    
}
