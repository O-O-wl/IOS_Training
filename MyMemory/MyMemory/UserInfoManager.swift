//
//  UserInfoManager.swift
//  MyMemory
//
//  Created by 이동영 on 09/02/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit

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
    
    
    func login(account : String , password :String) -> Bool{
        
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
        }
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
}
