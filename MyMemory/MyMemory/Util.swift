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



