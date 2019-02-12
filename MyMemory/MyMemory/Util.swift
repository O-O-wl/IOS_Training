//
//  Util.swift
//  MyMemory
//
//  Created by 이동영 on 10/02/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

// - MARK: - 스토리보드 읽어오는 유틸
/// - Note: 스토리보드 읽어오는 유틸
import Foundation
import Security
import Alamofire

extension UIViewController{
    
    // 연산프로퍼티로 사용 -- 익스텐션에선 저장 프로퍼티 불가능
    var tutorialSB : UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    
    
    // 튜토리얼스토리보드에서 VC 인스턴스 생성반환 메소드
    func instanceTutorialVC( name: String) -> UIViewController{
        return self.tutorialSB.instantiateViewController(withIdentifier: name)
    }
}
// - MARK: - 네트워크 처리 알림
/// - Note: 알림창 실행 -- message 와 후처리 클로저를 매개변수로 받음
extension UIViewController{
    func alert(_ message : String , completion: (()->Void)? = nil ){
        DispatchQueue.main.async {
        
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .cancel){
                
                // completion 매개변수가 존재하면 실행
                (_) in completion?()
            })
            
            self.present(alert,animated: false)
            
            
        }
    }
}


/** ============================================================
                    - Note: 키체인 래핑클래스
 ============================================================== */
// - MARK: - 키체인 래핑
class TokenUtils{
    
    
    
     /** ============================================================
                                - Note:
                            키체인 값 저장 메소드
     ============================================================== */
    func save(_ service:String, account : String , value: String){
        
        
        // 1.키체인 쿼리 생성
        let keyChainQuery : NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : account,
            kSecAttrService : service,
            kSecValueData : value.data(using: .utf8, allowLossyConversion: false)!
        ]
        
        // 2.키체인 기존 데이터 삭제
        SecItemDelete(keyChainQuery)
        
        // 저장하고 상태 반환
        let status = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr,"토큰 값 저장에 실패했습니다")
        NSLog("status : \(status)")
    
    }
    
    
    /** ==================================================================
                        - Note: 키체인에 저장된 값 읽어오는 메소드
     ===================================================================*/
    func load(_ service:String,account:String) -> String?{
        // 1.키체인 쿼리 생성
        let keyChainQuery : NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : account,
            kSecAttrService : service,
            kSecReturnData : kCFBooleanTrue,
            kSecMatchLimit : kSecMatchLimitOne  //중복될시 읽어올 것 설정
        ]
        var dataTypeRef : AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        
        
        
        if status == errSecSuccess {
            
            let retrievedData  = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: .utf8)
            return value
            
        }else{
            print("status : \(status)")
            return nil
        }
    }
    
    
    /** ==================================================================
                        - Note: 키체인에 삭제하는 메소드
     ===================================================================*/
    func delete(_ service : String, account : String ){
        
        let keyChainQuery : NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : account,
            kSecAttrService : service,
           // kSecValueData : value.data(using: .utf8, allowLossyConversion: false)!
        ]
        
        let status = SecItemDelete(keyChainQuery)
        
        assert(status == noErr, "토큰 값 삭제에 실패했습니다")
        
    }

    
    /** ==================================================================
                     - Note:  엑세스토큰으로 인증헤더 구성하는 메소드
     ===================================================================*/
    func getAuthorizationHeader() -> HTTPHeaders? {
        
        
            let serviceID = "kr.co.rubypaper.MyMemory"
            
            if let accessToken = self.load(serviceID, account: "accessToken"){
                return ["Authorization":"Bearer \(accessToken)"] as HTTPHeaders
                
            }
            return nil
        
    }
    
    // 연산프로퍼티
    var getAuthorizationHeader2 : HTTPHeaders? {
        
        get{
            let serviceID = "kr.co.rubypaper.MyMemory"
        
            if let accessToken = self.load(serviceID, account: "accessToken"){
                return ["Authorization":"Bearer \(accessToken)"] as HTTPHeaders
            
            }
            return nil
        }
    }
    


}
