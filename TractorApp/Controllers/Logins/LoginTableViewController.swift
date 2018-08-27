//
//  LoginTableViewController.swift
//  TractorApp
//
//  Created by BillBo on 2018/8/24.
//  Copyright © 2018年 BillBo. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController ,UITextFieldDelegate{

    @IBOutlet weak var cardTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var isPresent:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginBtn.borderStyle(width: 0, borderColor: .clear, cornerRadius: 5)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setButtonStyle()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let row:NSInteger = indexPath.row
        let first :CGFloat = 70
        let second:CGFloat  = 10
        let third:CGFloat  = 90
        let forth:CGFloat  = 40
        let zero:CGFloat  = (tableView.frame.size.height - first - second - third - forth)/5*4
        
        if row == 0 {
            return zero
        }else if row == 1 {
            return first
        }else if row == 2 {
            return second
        }else if row == 3{
            return third
        }else {
            return forth
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }

    @IBAction func clickLoginButton(_ sender: Any) {
        
        AppSetting.setting.setToken(token: self.cardTF.text!)
        
        let homepageTabVC:HomeTabBarController! = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBarController") as! HomeTabBarController
  
        if self.isPresent {
            
            self.dismiss(animated: true) {
               
                UIApplication.shared.keyWindow?.rootViewController = homepageTabVC

            }
        }else {
            
            UIApplication.shared.keyWindow?.rootViewController = homepageTabVC

        }
        
    }
    
    //MARK:- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.setButtonStyle()
        return true
    }
    
    func checkSubmit() -> Bool {
        return (self.cardTF.text?.count)! > 0 && (self.passwordTF.text?.count)! > 0
    }
  
    func setButtonStyle() -> Void {
       
        self.loginBtn.isEnabled = self.checkSubmit()
        self.loginBtn.buttonStyle(enableBgColor: UIColor.bj_colorWithHex(hex: HomeColor), enableTitleColor: .white, disableBgColor: UIColor.bj_colorWithHex(hex: SepatorLineColor), disableTitleColor: UIColor.bj_colorWithHex(hex: LightGrayColor))
  
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}
