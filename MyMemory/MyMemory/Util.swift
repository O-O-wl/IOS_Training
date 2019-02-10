//
//  Util.swift
//  MyMemory
//
//  Created by 이동영 on 10/02/2019.
//  Copyright © 2019 이동영. All rights reserved.
//


/// - Note: 스토리보드 읽어오는 유틸
import Foundation

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
