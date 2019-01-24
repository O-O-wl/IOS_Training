//
//  ViewController.swift
//  chap02-CodeLayout-Button
//
//  Created by 이동영 on 24/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(type: .system)
        
        
        let btnLoc = CGRect(x: 50, y: 100, width: 100, height: 50)
        
        /// - Note: frame은 슈퍼뷰 의 CGRect
        btn.frame = btnLoc
        btn.setTitle("코드 버튼", for: .normal)
        
        /// - Note: bounds 는 자신의 CGRect
        // center 와 btn의 origin은 충돌하기때문에 뒤에 실행된 코드에 맞게 정의된다.
        btn.center = CGPoint(x: self.view.bounds.width/2, y: 100)
        
        
        // 이 메소드의  메소드 시그니처  :  메소드정의 컨텍스트 , 메소드셀렉터 , 이벤트타입 -> void
        btn.addTarget(self, action: #selector(btnOnClick(sender:)), for: .touchUpInside)
        self.view.addSubview(btn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func btnOnClick(sender:Any){
        var btn = sender as? UIButton
        print("실행됨")
        btn?.setTitle("클릭되었습니다.", for: .normal)
        
        
        
    }


}

