//
//  ViewController.swift
//  Chapter03-TabBar
//
//  Created by 이동영 on 25/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.textColor = UIColor.green
        title.text = "1번째 탭 뷰 컨트롤러입니다."
        title.textAlignment = .center
        title.sizeToFit()
        title.center.x = self.view.frame.width/2
        
        self.view.addSubview(title)
        
        
        
    }
    
    //===========================================================================
    //
    //      touchesEnded()는 UIResonder 에 구현되어있는 터치이벤트 담당메소드
    //
    //===========================================================================
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = self.tabBarController?.tabBar

        
        // 트레일링 클로저 animation: 에는 실행후 목표상태를 작성
        UIView.animate(withDuration: TimeInterval(0.35)){
           // tabBar?.isHidden = !(tabBar?.isHidden)!
        
            tabBar?.frame.origin.y = ( (tabBar?.frame.origin.y)! <= self.view.frame.height) ? (tabBar?.frame.origin.y)! + 250 : (tabBar?.frame.origin.y)! - 250  }
        
        
        
    }/**=========================================================
     
     - Note: 탭바 투명해지게 구현
     UIView.animate(withDuration: TimeInterval(0.35)){
     // tabBar?.isHidden = !(tabBar?.isHidden)!
 
     tabBar?alpha = (tabBar?alpha == 1) ? 0 : 1

     }
     ===========================================================*/
    
    
    
}

