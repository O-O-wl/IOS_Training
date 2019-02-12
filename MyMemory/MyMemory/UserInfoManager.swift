//
//  UserInfoManager.swift
//  MyMemory
//
//  Created by 이동영 on 09/02/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


/// - Note: 사용자 정보 관리 클래스
class UserInfoManager{
    
    
    
    
    /// 연산프로퍼티
    
    var account : String? {
        get{
            let ud  = UserDefaults.standard
            return ud.string(forKey: UserInfoKey.account)
        }
        set(v){
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.account)
            ud.synchronize()
        }
    }

    var loginId : Int {
        get{
            // uid 는 Int
            return UserDefaults.standard.integer(forKey: UserInfoKey.loginId)
        }
        set(v){
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.loginId )
            ud.synchronize()
        }
    }
    
    var name : String? {
        get{
            let ud = UserDefaults.standard
            return ud.string(forKey: UserInfoKey.name)
        }
        set(v){
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.name)
            ud.synchronize()
        }
    }
    
    
    var isLogin : Bool {
        get{
            if(self.loginId == 0 || self.account == nil){
                return false
            }else{
                return true
            }
        }
        
      
        
    }
    
    
    /** ===============================================================
                                - Note:
                 UserDefaults 에는 UIImage타입 저장 불가능
                    NSData 타입으로 저장하고 읽어온다
     =================================================================*/
    var profile : UIImage?{
        get{
            let ud = UserDefaults.standard
            
            if let _profile = ud.data(forKey: UserInfoKey.profile) {
                return UIImage(data: _profile)
            }else{
              return  UIImage(named: "account.jpg")
            }
        }
        set(v){
            if v != nil{
                let ud = UserDefaults.standard
                ud.set(v!.pngData(), forKey: UserInfoKey.profile)
                ud.synchronize()
            }
        }
    }
    
    
    
    /** ====================================================
                            - Note:
                    성공/실패 시 후처리 콜백메소드
                비동기 처리기 때문에 처리완료후 실행할 로직을 정의
        후처리 메소드는 옵셔널 , 필요하지않을떄 처리안하기위해 기본 nil
     =======================================================*/
    func login(account : String , password :String, success:(()->Void)? = nil, fail: ((String)->Void)? = nil )  {
        
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/join"
        
        let param = ["account":account , "passwd":password ]
        
        
        let alamo = Alamofire.request(url, method: .post
            , parameters: param, encoding: JSONEncoding.default)
        
        alamo.responseJSON(){
            res in
            
            guard let json = res.result.value as? NSDictionary
            else{
                fail?("잘못된 응답형식입니다.: \(res.result.value)")
                return
            }
            
            let resultCode = json.value(forKey: "result_code") as! Int
            
            /// - Note:    로그인 성공
            if resultCode == 0 {
                
                let user = json["user_info"] as!  NSDictionary
                self.loginId = user["user_id"] as! Int
                self.account = user["account"] as? String
                self.name = (user["name"] as? String)

                // JSON 에서 PATH 문자열 추출
                if let path = user["profile_path"] as? String{
                    // PATH 문자열을 URL로 변환후 Data 불러오기
                    if let imageData = try? Data(contentsOf: URL(string: path)!){
                        // 데이터로 UIImage 생성
                        self.profile = UIImage(data: imageData)
                    }
                }
                
                /// - Note: 인증토큰 저장로직
                
                // 1. 로그인 API 에서 반환받은 토큰값을 키체인에 저장
                let accessToken = json.value(forKey: "access_token") as! String
                let refreshToken = json["refresh_token"] as! String
                
                let tk = TokenUtils()
                
                tk.save("kr.co.rubypaper.MyMemory", account: "accessToken", value: accessToken)
                tk.save("kr.co.rubypaper.MyMemory", account: "refreshToken", value: refreshToken)
                
                
                
                
                success?()
            }else{
                    /// - Note:    로그인 실패
                let msg = (json.value(forKey: "error_msg") as? String) ?? "로그인이 실패했습니다."
                fail?(msg)
            }
        
            
        }
        
        
        
        
        /***************************************************************************
                                    - Note: 로그인 API
         
         -  API 명         :    Login API
         -  설명            :    계정/비밀번호를 입력받아 사용자인증토큰 발급-기존 갱신토근과 접속토큰 모두 삭제됨
         -  API Domain     :    http://swiftapi.rubypaper.co.kr:2029/userAccount/join
         -  전송메소드        :    POST
         -  인증헤더 유뮤      :      X
         -  REQ Format      :    {"account":"ldcpaul@hanmail.net","passwd":"1234"}
         -  RES Format(S)   :
                user_info { name , account , user_id , profile_path, result_code }
                result , token_type , expires_in , refresh_token , access_token,error_msg
         -  RES Format(F)   : result_code , result , error_msg
        *****************************************************************************/
        
        
        
        
       //============================================================================
        /**
         ===================================================
         - Note: 동기처리 - 서버가 아닌 하드코딩 되어있는 데이터 처리였음
         
            비동기 처리를 위해 트레쉬
         ====================================================
         
        // 프로퍼티리스트  저장 여부를 통해 ,  로그인여부 확인 -- 실패시 저장이 안되므로 isLogin -> false가 됨
        if(account.elementsEqual("devOOwl@apple.com")  && password.elementsEqual("1234")){
            let ud = UserDefaults.standard
            ud.set(100,forKey:UserInfoKey.loginId)
            ud.set(account,forKey:UserInfoKey.account)
            ud.set("부엉이", forKey: UserInfoKey.name)
            ud.synchronize()
            
            return true
        }else{
            return false
        }*/
    }
    
    

    func logout() -> Bool{
        let ud = UserDefaults.standard
        ud.removeObject(forKey: UserInfoKey.account)
        ud.removeObject(forKey: UserInfoKey.loginId)
        ud.removeObject(forKey: UserInfoKey.name)
        ud.removeObject(forKey: UserInfoKey.profile)
        ud.synchronize()
        return true
    }
    
    
    
    
    
    
}

// plist 에 저장할 키
struct UserInfoKey {
    static let loginId = "LOGINID"
    static let account = "ACCOUNT"
    static let name = "NAME"
    static let profile = "PROFILE"
    static let tutorial = "TUTORIAL"
}
