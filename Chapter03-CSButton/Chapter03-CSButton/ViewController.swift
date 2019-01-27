//
//  ViewController.swift
//  Chapter03-CSButton
//
//  Created by 이동영 on 27/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var csBtn  : UIButton?
    var csBtn2 : UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.csBtn = CSButton(type: .rect)
        csBtn?.frame = CGRect(x: 0, y: 100, width: 200, height: 50)
        self.csBtn!.center.x = self.view.frame.width/2
        self.csBtn?.addTarget(self, action: #selector(buttonChange(sender:)), for: .touchUpInside)
        self.view.addSubview(self.csBtn!)
        
        self.csBtn2 = CSButton(type: .circle)
        self.csBtn2!.center.x = self.view.frame.width/2
        self.csBtn2?.frame = CGRect(x: 0, y: 200, width: 200, height: 50)
        self.csBtn2!.center.x = self.view.frame.width/2
         self.csBtn2?.addTarget(self, action: #selector(buttonChange(sender:)), for: .touchUpInside)
        self.view.addSubview(self.csBtn2!)
    }
    
    @objc func buttonChange(sender:CSButton){
        
        /// - Note: 옵저버 프로퍼티를 통해 실시간으로 토글방식으로 이미지 변경
        sender.style = sender.style == CSButtonType.circle ? .rect : .circle
        
        /// - Note: tag는 클래스단에 정의된 프로퍼티 속성은 Int
        sender.tag = sender.tag+1
        sender.setTitle("\(sender.tag)번 클릭", for: .normal)
    }


}

