//
//  SideBarVC.swift
//  MyMemory
//
//  Created by 이동영 on 28/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit

class SideBarVC : UITableViewController{
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()
    
    
    
    
    let titles = ["새글작성하기","친구 새글","달력으로 보기","공지사항","통계","계정 관리"]
    let icons = [
        UIImage(named: "icon01"),
        UIImage(named: "icon02"),
        UIImage(named: "icon03"),
        UIImage(named: "icon04"),
        UIImage(named: "icon05"),
        UIImage(named: "icon06"),
        ]
    
    
    
    
    
    let uinfo = UserInfoManager()
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = self.uinfo.name ?? "로그인을 해주세요"
        self.emailLabel.text = self.uinfo.account
         self.profileImage.image = self.uinfo.profile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = .brown
        //self.nameLabel.text = "개발자 부엉이"
        self.nameLabel.text = self.uinfo.name ?? "로그인을 해주세요"
        self.nameLabel.textColor = .white
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 150, height: 30)
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        
       // self.emailLabel.text = "devOOwl@apple.com"
        self.emailLabel.text = self.uinfo.account
        self.emailLabel.textColor = .white
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 150, height: 30)
        self.emailLabel.font = UIFont.systemFont(ofSize: 11)
        self.emailLabel.backgroundColor = .clear
        //self.emailLabel.sizeToFit()
        
        self.profileImage.image = self.uinfo.profile
      //  self.profileImage.image = UIImage(named: "account.jpg")
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.width/2)
        self.profileImage.layer.masksToBounds = true // 마스크효과
        self.profileImage.layer.borderWidth = 0
        headerView.addSubview(nameLabel)
        headerView.addSubview(emailLabel)
        headerView.addSubview(profileImage)
        self.tableView.tableHeaderView = headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.icons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "menuCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        cell.imageView?.image = self.icons[indexPath.row]
        cell.textLabel?.text = self.titles[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 클릭한 테이블 레이블인덱스 -  새글작성
        if indexPath.row == 0 {
            // 작성폼 인스턴스 생성
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
            // revealVC 에서 naviVC 가져오기
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            
            // naviVC에 memoFornVC push
            target.pushViewController(uv!, animated: true)
            
            //사이드바 종료
           self.revealViewController()?.revealToggle(self)
            
        }else if (indexPath.row == 5){
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "_Profile")
            self.present(uv!, animated: true){
                self.revealViewController()?.revealToggle(self)
            }
        }
        
    }
    
}

