//
//  ViewController.swift
//  chap2-InputForm
//
//  Created by 이동영 on 24/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var tfEmail : UITextField!
    var swhUpdate : UISwitch!
    var stprInterval : UIStepper!
    var txtUpdate  : UILabel!
    var txtInterval : UILabel!
    override func viewDidLoad() {
        
        self.navigationItem.title = "설정"
        
        
        /** -------------------------
        //     이메일 - UILabel
        ----------------------------*/
        let lblEmail  = UILabel()
        lblEmail.frame = CGRect(x: 30, y: 100, width: 100, height: 30)
        lblEmail.text = "이메일"
        lblEmail.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lblEmail)
        
        /** --------------------------------
        //      Email 입력폼 - UITextField
        ----------------------------------*/
        self.tfEmail = UITextField()
        self.tfEmail.frame = CGRect(x: 120, y: 100, width: 220, height: 30)
        self.tfEmail.font = UIFont.systemFont(ofSize: 13)
        self.tfEmail.borderStyle = UITextField.BorderStyle.roundedRect
        self.tfEmail.placeholder = "예)ldcpaul@hanmail.net"
        self.tfEmail.autocapitalizationType = .none // 대소문자 처리
        self.view.addSubview(self.tfEmail)
        
        
        //============================== 1번째 라인 끝 =====================================//
        

        /** -------------------------
        //     자동갱신 - UILabel
        ----------------------------*/
        let lblUpdate  = UILabel()
        lblUpdate.frame = CGRect(x: 30, y: 150, width: 100, height: 30)
        lblUpdate.text = "자동갱신"
        lblUpdate.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lblUpdate)
        /** -------------------------
         //     자동갱신 - UISwitch
         ----------------------------*/
        self.swhUpdate   = UISwitch()
        self.swhUpdate.frame = CGRect(x: 120, y: 150, width: 50, height: 30)
        self.swhUpdate.setOn( true, animated: true)
        self.view.addSubview(swhUpdate)
        self.swhUpdate.addTarget(self, action: #selector(onChangeSwhUpdate(sender:)), for: .valueChanged)
        
        /** -------------------------
         //     자동갱신 - UILabel
         ----------------------------*/
        self.txtUpdate  = UILabel()
        self.txtUpdate.frame = CGRect(x: 250, y: 150, width: 100, height: 30)
        
        self.txtUpdate.text = "갱신함"
        self.txtUpdate.font = UIFont.systemFont(ofSize: 14)
        self.txtUpdate.textColor = UIColor.red
        self.view.addSubview(txtUpdate)
        
        
        //================================ 2번째 라인 끝=====================================//
        /** -------------------------
        //     갱신주기 - UILabel
        ----------------------------*/
        let lblInterval  = UILabel()
        lblInterval.frame = CGRect(x: 30, y: 200, width: 100, height: 30)
        lblInterval.text = "갱신주기"
        lblInterval.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lblInterval)
        /** -------------------------
         //     갱신주기 - UIStepper
         ----------------------------*/
        self.stprInterval   = UIStepper()
        self.stprInterval.frame = CGRect(x: 120, y: 200, width: 50, height: 30)
        self.stprInterval.minimumValue = 0;
        self.stprInterval.maximumValue = 100
        self.stprInterval.stepValue = 1
        self.stprInterval.value = 0
        self.stprInterval.addTarget(self, action: #selector(onChangeStprInterval(sender:)), for: .valueChanged)
        self.view.addSubview(stprInterval)
        /** -------------------------
         //     갱신주기 - UILabel
         ----------------------------*/
        self.txtInterval  = UILabel()
        self.txtInterval.frame = CGRect(x: 250, y: 200, width: 100, height: 30)
        self.txtInterval.text = "0분마다"
        self.txtInterval.font = UIFont.systemFont(ofSize: 14)
        self.txtInterval.textColor = UIColor.blue
        self.view.addSubview(txtInterval)
        //================================ 3번째 라인 =====================================//
        
        
        
        
    }

    @objc func onChangeSwhUpdate(sender : UISwitch){
        
        self.txtUpdate.text = sender.isOn ? "갱신함":"갱신하지않음"
        
    }
    @objc func onChangeStprInterval(sender : UIStepper){
        
         self.txtInterval.text = "\(Int(sender.value))분마다"
        
    }

}

