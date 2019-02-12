//
//  JoinVC.swift
//  MyMemory
//
//  Created by 이동영 on 11/02/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class JoinVC : UIViewController,UITableViewDelegate{
  
    
    var isCall = false // API 호출 상태값
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var profile: UIImageView!
    
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
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
        
        self.view.bringSubviewToFront(self.indicatorView)
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

/**======================================================================
                        - Note: Join API
 API 도메인      : http://swiftapi.rubypaper.co.kr:2029/
 API PATH      : userAccount/join
 HTTP Method   : "POST"
 REQ Format    : JSON / "account","passwd","name","profile_image"
 RES Format    : JSON / "result_code","result","error_msg","user_info"
======================================================================== */

// - MARK: - 서버 API 연동 로직
extension JoinVC{
    
    
    
    
    @IBAction func submit(_ sender: Any) {
        
        
        // 진행 중에  재요청 방지 로직
        if self.isCall == true {
            self.alert("진행 중입니다. 잠시만 기다려주세요")
            return
        }else{
            self.isCall = true
        }
    
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        // 인디케이터뷰 애니메이셔션 시작
        self.indicatorView.startAnimating()
        
        
        ///=============================  1. 전달값 준비 =====================================
        //String 으로 변환 - 이미지를 Base64 로 인코딩
        let profile = UIImage.pngData(self.profile.image!)()?.base64EncodedString()
        
        // 파라미터 객체
        let param: Parameters = [
            "account":self.fieldAccount.text!,
            "name":self.fieldName.text!,
            "passwd":self.fieldPassword.text!,
            "profile_image":profile!
        ]
        ///=============================  2. API 호출 =====================================
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/join"
        
     
        let alamo = Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
        
        ///=============================  3. 서버 응답값 처리 =====================================
        
        alamo.responseJSON(){
            res in
            
            
            // 인디케이터 뷰 애니메이션 종료
            self.indicatorView.stopAnimating()
            
            
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            // JSON 인지 확인 하는 가드구문 
            guard let jsonObject = res.result.value as? [String:Any] else {
                self.alert("서버 호출 과정에서 오류 발생")
                self.isCall = false
                return
            }
            
            ///=============================  3-2. 응답코드 분기 =====================================
            let resultCode = jsonObject["result_code"] as! Int
            if resultCode == 0{
                self.alert("가입 완료"){
                    
                    // 가입완료후 이전페이지로 UNWIND
                    self.performSegue(withIdentifier: "backProfileVC", sender: self)
                    
                }
              
            }else{
                // 결과코드가 0(정상) 아니면 error msg
                let errorMSG = jsonObject["error_msg"] as! String
                self.alert("오류발생 : \(errorMSG)")
                self.isCall = false
            }
            
        }
        
    }

}
