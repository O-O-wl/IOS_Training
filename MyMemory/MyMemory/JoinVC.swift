//
//  JoinVC.swift
//  MyMemory
//
//  Created by 이동영 on 11/02/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit
import Foundation

class JoinVC : UIViewController,UITableViewDelegate{
  
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var profile: UIImageView!
    
    @IBOutlet var submit: UIBarButtonItem!
    
    var fieldAccount: UITextField!
    
    var fieldName: UITextField!
    
    var fieldPassword: UITextField!
    
    override func viewDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.profile.layer.cornerRadius = self.profile.frame.width/2
        self.profile.layer.masksToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedProfile(_:)))
        
        self.profile.addGestureRecognizer(gesture)
        
        self.view.bringSubviewToFront(self.profile)
    }
    
    
    @objc func tappedProfile(_ sender:Any){
    
        print("이미지파일")
       
     //   let picker = UIImagePickerController()
        
        let msg = "프로필 이미지를 읽어올 곳을 선택하세요"
        
        let actionSheet = UIAlertController(title: msg, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "저장된 앨범", style: .default){
            (_) in
            selectLibrary(src:.savedPhotosAlbum)
        })
        
        actionSheet.addAction(UIAlertAction(title: "포토 라이브러리", style: .default){
            (_) in
            selectLibrary(src:.photoLibrary)
        })
        
        
        actionSheet.addAction(UIAlertAction(title: "카메라", style: .default){
            (_) in
            selectLibrary(src:.camera)
        })
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        
        self.present(actionSheet,animated: false)
        
        func selectLibrary(src:UIImagePickerController.SourceType){
            if(UIImagePickerController.isSourceTypeAvailable(src)){
                let picker = UIImagePickerController()
                picker.delegate  = self
                picker.allowsEditing = true
                picker.sourceType  = src
                self.present(picker,animated: true)
            }else{
                self.alert("사용할 수 없는 타입입니다.")
            }
            
        }
    }
}
// - MARK: - 테이블 뷰 데이터소스
extension JoinVC : UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        // 가입창 텍스트뷰 frame - 공통
        let tfFrame = CGRect(x: 20, y: 0, width: cell.bounds.width - 20, height: 37)
        
        switch indexPath.row {
        case 0:
            self.fieldAccount = UITextField(frame: tfFrame)
            self.fieldAccount.placeholder = "계정(이메일)"
            self.fieldAccount.borderStyle = .none
            self.fieldAccount.autocapitalizationType = .none
            self.fieldAccount.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldAccount)
        case 1:
             self.fieldPassword = UITextField(frame: tfFrame)
             self.fieldPassword.placeholder = "비밀번호"
             self.fieldPassword.borderStyle = .none
             self.fieldPassword.isSecureTextEntry = true
             //self.fieldPassword.autocapitalizationType = .none
             self.fieldPassword.font = UIFont.systemFont(ofSize: 14)
             cell.addSubview(self.fieldPassword)
        case 2:
             self.fieldName = UITextField(frame: tfFrame)
             self.fieldName.placeholder = "이름"
             self.fieldName.borderStyle = .none
             //self.fieldName.autocapitalizationType = .none
             self.fieldName.font = UIFont.systemFont(ofSize: 14)
             cell.addSubview(self.fieldName)
        default:
            ()
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

// - MARK: - 이미지피커 델리게이트
extension JoinVC: UINavigationControllerDelegate , UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let img = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        self.profile.image = img
        picker.dismiss(animated: false)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false)}
}
