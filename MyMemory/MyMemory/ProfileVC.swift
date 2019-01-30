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
       
    }
    
    // dismiss  계층이 아닌 개별 뷰 엿음
    @objc func close(_ sender :Any){
        self.presentingViewController?.dismiss(animated: true)
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
            cell.detailTextLabel?.text = "개발자 부엉이"
        case 1:
            cell.textLabel?.text = "계정"
            cell.detailTextLabel?.text = "devOOwl@apple.com"
        default :
            ()
        }
        return cell
    }
    
    
}
