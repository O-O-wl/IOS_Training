//
//  ProfileVC.swift
//  MyMemory
//
//  Created by 이동영 on 30/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import LocalAuthentication


class ProfileVC : UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    let profileImage = UIImageView()
    let tvUserInfo = UITableView()
    let uinfo = UserInfoManager()
    
    
    // 로그인 API 요청상태
    var isCalling = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tokenValidate()
    }
    
    
    
    override func viewDidLoad() {
        
        /// ============================= 이미지뷰에 탭 이벤트 추가 ===============================
        let tap = UITapGestureRecognizer(target: self, action: #selector(profile(_:))) // 제스처 오브젝트
        self.profileImage.addGestureRecognizer(tap)        // 제스처를 해당 이미지뷰에 등록
        self.profileImage.isUserInteractionEnabled = true // 상호작용하는 뷰 라는 표시
        
        /// =================================================================================
        
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
        
        
        
        
        // 프로필 화면 띄울시 인증토큰 콘솔 로그
        
        let token = TokenUtils()
        
        if let accessToken = token.load("kr.co.rubypaper.MyMemory", account: "accessToken"){
            NSLog("엑세스 토큰 : \(accessToken)")
        }else{
              NSLog("엑세스 토큰 : nil")
        }
        
        
        
        if let refreshToken = token.load("kr.co.rubypaper.MyMemory", account: "refreshToken"){
            NSLog("리프레쉬 토큰 : \(refreshToken)")
        }
        else{
            NSLog("리프레쉬 토큰 : nil")
        }
        
        
        
        
    }
    
    
    
    
    
    //================================
    // dismiss  계층이 아닌 개별 뷰 엿음
    //[=================================3
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
        
        if self.isCalling{
            self.alert("로그인 요청중입니다.\n잠시만 기다려주세요.")
            return
        }else{
            self.isCalling = true
        }
        
        let loginAlert = UIAlertController(title: "LOG IN", message: nil, preferredStyle: .alert)
        
       
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel){(_) in self.isCalling = false})// 하려다 말았으므로 , 다시 로그인 요청상태 false
        loginAlert.addAction(UIAlertAction(title: "Login", style: .default ){
            (_) in
            
            // 로그인 버튼 액션 메소드 클로저
            print("로그인 요청")
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            let account = loginAlert.textFields?.first!.text ?? ""
            let passwd = loginAlert.textFields?.last!.text ?? ""
            
            
            ///===================================
            /// - Note: 비동기 메소드 login 실행 로직
            ///===================================
            self.uinfo.login(account: account, password: passwd, success: {
                DispatchQueue.main.async {
                    
                
                /// - Note: 비동기 처리 이후 실행될 로직 담당하는 클로저
                print("로그인 성공")
                self.isCalling = false
                self.tvUserInfo.reloadData()
                self.profileImage.image = self.uinfo.profile // 프로필 이미지 갱신
                self.drawBtn() // 로그아웃 버튼으로 변환
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.alert("로그인 성공")
                }
            }, fail: {
                msg in
                DispatchQueue.main.async {
                  
                
                self.alert(msg)
                self.isCalling = false
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                self.alert("로그인 실패")
               // self.present(loginAlert,animated: false)
                }
            })
            
            
            /*
            if self.uinfo.login(account: alert.textFields?.first!.text ?? "", password: alert.textFields?.last!.text ?? ""){
                self.tvUserInfo.reloadData()
                self.drawBtn()
                self.profileImage.image = self.uinfo.profile
            }else{
                let msg = "로그인 실패"
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert,animated: false)
                
            }*/
            
            
        })
        
        loginAlert.addTextField(){
            $0.placeholder = "Your Account"
        }
        loginAlert.addTextField(){
            $0.placeholder = "Password"
            $0.isSecureTextEntry = true
        }
        
        self.present(loginAlert,animated: false)
    }
    
    
    @objc func doLogout(_ sender:Any) {
        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let logoutAlert = UIAlertController(title: nil , message: "로그아웃을 하시겠습니까?", preferredStyle: .alert)
        logoutAlert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        logoutAlert.addAction(UIAlertAction(title: "확인", style: .destructive){
            (_) in
            self.uinfo.logout(){
                
                self.tvUserInfo.reloadData()
                self.drawBtn()
                self.profileImage.image = self.uinfo.profile
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        })
      
        
        self.present(logoutAlert,animated: false)
    }
    
    // 로그인 / 로그아웃버튼 생성
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
// - MARK: - 이미지피커 구현부 -- 프로필사진
extension ProfileVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    // 이미지피커 실행 메소드
    @objc func imgPicker(_ source : UIImagePickerController.SourceType){
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = source
        imgPicker.delegate = self
        imgPicker.isEditing = true
        self.present(imgPicker,animated: true)
    }
    
    // 선택후의 로직
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
       if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
        
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.uinfo.newProfile(img,success: {
            //self.alert("프로필 사진이 변경되었습니다.")
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
        }){
            msg in
            self.alert(msg)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
            self.profileImage.image = img
        
        
        print("==============================\(img)=====================")
        }
        picker.dismiss(animated: true)
        
    }
    
    // 이미지피커 실행이전에 리소스 정하는 액션
    @objc func profile(_ sender:UIButton){
        if(self.uinfo.account == nil ){
            self.doLogin(self)
        }else{
        let selectResource = UIAlertController(title: nil, message: "사진을 가져올 곳을 선택하세요", preferredStyle: .actionSheet)
        selectResource.addAction(UIAlertAction(title: "취소", style: .cancel))
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            selectResource.addAction(UIAlertAction(title: "카메라", style: .default){
                (_) in
                self.imgPicker(.camera)
            })
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            selectResource.addAction(UIAlertAction(title: "포토 라이브러리", style: .default){
                (_) in
                self.imgPicker(.photoLibrary)
            })
        }
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            selectResource.addAction(UIAlertAction(title: "사용자 앨범", style: .default){
                (_) in
                self.imgPicker(.savedPhotosAlbum)
                
            })
        }
        self.present(selectResource,animated: false)
    }
    }
    
    @IBAction func backProfileVC(_ segue:UIStoryboardSegue){
        
    }
    
}
// - MARK: - 로컬인증 - 인증토큰 갱신 - 터치아이디인증
extension ProfileVC{
    
    /**===========================================
     - Note: 토큰 인증 메소드 -- 토큰 유효성 검증
     ============================================*/
    func tokenValidate(){
        
        
        // 0. 응답캐시를 사용하지 않게 설정 -- 서버와 디바이스간의 데이터 불일치 발생가능성 억제
        URLCache.shared.removeAllCachedResponses()
        
        
        // 1. 키 체인에 엑세스 토큰이 없을 경우 유효성 검증 진행하지않음
        let tk = TokenUtils()
        /// - Note: 엑세스 토큰 유효성 확인
       guard let header = tk.getAuthorizationHeader2 else {
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        
        // 2. tokenVaildate API 호출
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/tokenValidate"
        let alamo = Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header)
        
        // 3. 호출 API 후처리 클로저
        alamo.responseJSON(){
            
            res in
            
            
             UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            print(res.result.value!)
            
            guard let jsonObject = res.result.value as? NSDictionary
                else{
                self.alert("잘못된 RES 포맷입니다.")
                return
            }
            
            let resultCode = jsonObject["result_code"] as! Int
            
            if resultCode != 0 {
                self.touchID()
                
            }
    
        } // 클로저 - end
        
    } // tokenVaildate() end
    
    
    /**===========================================
     - Note:  터치아이디 로컬인증 -- 사용자 확인
     ============================================*/
    func touchID(){
        
        // 1. LA컨텍스트 생성
        let context = LAContext()
        
        // 2. 인증에 필요한 변수 정의
        var error : NSError?
        let msg = "인증이 필요합니다."
        
        /// - Note: 인증정책 - 터치아이디인증
        let deviceAuth = LAPolicy.deviceOwnerAuthenticationWithBiometrics
        
        // 3. 로컬 인증 (터치아이디 인증 정책 - deviceOwnerAuthenticationWithBiometrics )의 가능 유무 확인
        if context.canEvaluatePolicy(deviceAuth, error: &error){ /// - Note: 인증창 생성 성공/실패
            
            // 4. 인증 실행
            context.evaluatePolicy(deviceAuth, localizedReason: msg){ /// - Note: 인증 성공 실패
                (success , error) in
                // 5 . 인증 성공 : success 가 nil 이 아닐시
                if success{
                    /// - Note: 토큰 갱신 실행
                    self.refresh()
                }
                    /// - Note: 인증실패
                else{
                    // 인증 실패 원인 대응 로직
                    print((error?.localizedDescription)!)
                    switch(error!._code){
                        
                    case LAError.systemCancel.rawValue:
                        self.alert("시스템에 의해 인증이 취소되었습니다.")
                        
                        // 취소버튼
                    case LAError.userCancel.rawValue:
                        self.alert("사용자에 의해 인증이 취소되었습니다."){
                            self.commonLogout(true)
                        }
                        
                        // 암호로 로그인 버튼
                    case LAError.userFallback.rawValue:
                        /// - Note: 인증창 과 경고창사이의 충돌 발생 --> 큐에 들어온 작업을 순차적으로 처리하게하는 메소드
                        OperationQueue.main.addOperation {
                            self.commonLogout(true)
                        }
                    default:
                        OperationQueue.main.addOperation {
                            self.commonLogout(true)
                        }
                    }
                    
                }
            
                
            }// 인증 구문 - end -
         
            
        } // 인증 확인 메소드 end
        else{
        /// - Note: 터치아이디 인증사용불가능
        print(error!.localizedDescription)
            switch(error!.code){
            case LAError.touchIDNotEnrolled.rawValue:
                print("터치아이디 미등록")
                
            case LAError.passcodeNotSet.rawValue:
                print("패스코드 미등록")
            default:
                print("터치아이디 사용불가")
            }
            
            self.commonLogout(true)
    }
        
    }
    
    
    /**===========================================
     - Note: 인증 토큰 갱신 메소드 -- 토큰 갱신
     ============================================*/
    func refresh(){
        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // 1. 인증헤더 생성
        let tk = TokenUtils()
        let header = tk.getAuthorizationHeader2
        
        
        // 2. 리프레시 토큰 전달 준비
        /// - Note: 리프레시 토큰 꺼내오기 - 엑세스토큰 재발급 요청준비
        let refreshToken = tk.load("kr.co.rubypaper.MyMemory", account: "refreshToken")
        
        let param : Parameters = ["refresh_token":refreshToken!]
        
        // 3. 호출 및 응답
        
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/refresh"
        let alamo = Alamofire.request(url, method: .post, parameters: param
            , encoding: JSONEncoding.default , headers: header)
        
        alamo.responseJSON(){
            res in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            guard let json = res.result.value as? NSDictionary
            else{
                self.alert("올바른 포맷이 아닙니다.")
                return
            }
            
            // 4. 응답 결과 처리
            let resultCode = json["result_code"] as! Int
            
            
            /// - Note: 리프레시토큰 재발급 성공실패
            
            if resultCode == 0 { /// - Note: 성공. - 서버에서 리프레시 토큰을 이용한 엑세스 토큰 재발급
                
                let accessToken = json["access_token"] as! String
                
                // 키체인에서 엑세스 토큰 교체
                let tk = TokenUtils()
                tk.save("kr.co.rubypaper.MyMemory", account: "accessToken", value: accessToken)
        
                
            }else{  /// - Note: 실패
                self.alert("인증이 만료되었으므로 , 다시 로그인해야 합니다.")
                OperationQueue.main.addOperation {
                    self.commonLogout(true)
                }
            }
        }
    }
    
    
    
    /***************************************************************************
     - Note:  토근 유효성 검증 API
     
     -  API 명           :   TokenValidate API
     -  설명             :    토큰의 유효성 여부를 검증합니다
     -  API Domain      :    http://swiftapi.rubypaper.co.kr:2029/userAccount/tokenValidate
     -  전송메소드         :    POST
     -  인증헤더 유뮤       :    O
     -  REQ Format      :     -
     -  RES Format(S,F) :    result_code , result , error_msg
     *****************************************************************************/

    
    

}
// - MARK: - 토큰 갱신실패 , 인증실패 예외처리
extension ProfileVC{
    
    /**=======================================================
     - Note: 토큰 갱신과정 에서 발생할 실패나 오류에서 사용할 로그아웃 메소드
     ========================================================*/
    func commonLogout(_ isLogin: Bool = false){
        
        // 1. 저장된 개인정보 , 키체인데이터 삭제 후 로그아웃상태로 전환  :  데이터상 로그아윳
        let userInfo = UserInfoManager()
        userInfo.localLogout()
        
        
        // 2. 현재화면 UI갱신 : 화면상 로그아웃
        self.tvUserInfo.reloadData()
        self.profileImage.image  = userInfo.profile
        self.drawBtn()
        
        
        // 3. 로그인창을 띄워주는 트리거 코드
        if isLogin{
            self.doLogin(self)
        }
    }
    /// commonLogout end
    
    
    /**=======================================================
     - Note: 토큰 갱신과정 에서 발생할 실패나 오류에서 사용할 로그아웃 메소드
     ========================================================*/
    
    
}

