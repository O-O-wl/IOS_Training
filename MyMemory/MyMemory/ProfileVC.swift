//
//  ProfileVC.swift
//  MyMemory
//
//  Created by 이동영 on 30/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit

class ProfileVC : UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    let profileImage = UIImageView()
    let tvUserInfo = UITableView()
    let uinfo = UserInfoManager()
    
    
    
    override func viewDidLoad() {
        
        // 네비바 타이틀 설정
        self.navigationItem.title = "프로필"
        
        // 백버튼
        let btnBack = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)))
        self.navigationItem.leftBarButtonItem = btnBack

        ///===========================  프로필 이미지 설정부 ==========================
        let image = UIImage(named: "account.jpg")
        self.profileImage.image = image
        self.profileImage.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.profileImage.center = CGPoint(x: self.view.frame.width/2, y: 270)
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2
        self.profileImage.layer.masksToBounds = true
        self.profileImage.layer.borderWidth = 0
        
        self.profileImage.image = self.uinfo.profile
        self.view.addSubview(self.profileImage)
        ///======================================================================
        
        //============================ 데이터 소스 설정 부 ==========================
        self.tvUserInfo.frame = CGRect(x: 0, y: self.profileImage.frame.origin.y + 20 + self.profileImage.frame.height, width: self.view.frame.width, height: 100)
//        self.tvUserInfo.backgroundColor = UIColor.orange
        
        // self VC 에서 테이블뷰 이벤트 처리 가능하게 위임
        self.tvUserInfo.delegate = self
        self.tvUserInfo.dataSource = self
        
        self.view.addSubview(tvUserInfo)
        //========================================================================
        
        /// ========================= 프로필 커버 사진 ================================
        let bg = UIImage(named: "profile-bg")
        let bgImg = UIImageView(image: bg)
        bgImg.frame = CGRect(x:0 , y: 0, width:  bgImg.frame.size.width, height: bgImg.frame.size.height)

        bgImg.center = CGPoint(x: self.view.frame.width/2, y: 40)
        
        bgImg.layer.cornerRadius = bgImg.frame.width/2
        bgImg.layer.masksToBounds = true
        bgImg.layer.borderWidth = 0
        self.view.addSubview(bgImg)
        
        /// ===================================================================
        
        // 최상단에 커버사진이므로 다시 앞으로 프로필 사진과 , 유저 정보를 포어그라운드로 위치
        self.view.bringSubviewToFront(self.tvUserInfo)
        self.view.bringSubviewToFront(self.profileImage)
        
        self.navigationController?.navigationBar.isHidden = true
       self.drawBtn()
    }
    
    // dismiss  계층이 아닌 개별 뷰 엿음
    @objc func close(_ sender :Any){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !uinfo.isLogin {
            self.doLogin(self)
              self.tvUserInfo.reloadData()
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 이름과 이메일 설정 테이블
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
            
        case 0:
            cell.textLabel?.text = "이름"
           // cell.detailTextLabel?.text = "개발자 부엉이"
            cell.detailTextLabel?.text = self.uinfo.name ?? "Login Please"
        case 1:
            cell.textLabel?.text = "계정"
           cell.detailTextLabel?.text = self.uinfo.account ?? "Login Please"
        default :
            ()
        }
        return cell
    }
    
    
}
// - MARK: - 로그인 메소드
extension ProfileVC{
    @objc func doLogin(_ sender : Any){
        let alert = UIAlertController(title: "LOG IN", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Login", style: .destructive ){
            (_) in
            if self.uinfo.login(account: alert.textFields?.first!.text ?? "", password: alert.textFields?.last!.text ?? ""){
                self.tvUserInfo.reloadData()
                self.drawBtn()
                self.profileImage.image = self.uinfo.profile
            }else{
                let msg = "로그인 실패"
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert,animated: false)
                
            }
            
            
        })
        
        alert.addTextField(){
            $0.placeholder = "Your Account"
        }
        alert.addTextField(){
            $0.placeholder = "Password"
            $0.isSecureTextEntry = true
        }
        
        self.present(alert,animated: false)
    }
    
    
    @objc func doLogout(_ sender:Any) {
        let logoutAlert = UIAlertController(title: nil , message: "로그아웃을 하시겠습니까?", preferredStyle: .alert)
        logoutAlert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        logoutAlert.addAction(UIAlertAction(title: "확인", style: .default){
            (_) in
            if( self.uinfo.logout()){
                
                self.tvUserInfo.reloadData()
                self.drawBtn()
                self.profileImage.image = self.uinfo.profile
                
            }
        })
      
        
        self.present(logoutAlert,animated: false)
    }
    
    // 로그아웃버튼 생성
    func drawBtn(){
        let v = UIView()
        v.frame.size.width = self.view.frame.width
        v.frame.size.height = 40
        v.frame.origin.x = 0
        v.frame.origin.y = self.tvUserInfo.frame.height + self.tvUserInfo.frame.origin.y
        v.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        let btn = UIButton(type: .system)
        btn.frame.size.width = 100
        btn.frame.size.height = 30
        btn.center.x = v.frame.width/2
        btn.center.y = v.frame.height/2
        
        
        if self.uinfo.isLogin {
            btn.setTitle("로그아웃", for: .normal)
            btn.addTarget(self, action: #selector(doLogout(_:)), for: .touchUpInside)
        }else{
            btn.setTitle("로그인", for: .normal)
            btn.addTarget(self, action: #selector(doLogin(_:)), for: .touchUpInside)
            
        }

        
        v.addSubview(btn)
        self.view.addSubview(v)
    }
}
