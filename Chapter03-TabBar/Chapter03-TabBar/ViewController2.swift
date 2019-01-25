//
//  ViewController2.swift
//  Chapter03-TabBar
//
//  Created by 이동영 on 25/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit

class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.textColor = UIColor.red
        title.text = "2번째 탭 뷰 컨트롤러입니다."
        title.textAlignment = .center
        title.sizeToFit()
        title.center.x = self.view.frame.width/2
        
        self.view.addSubview(title)
    }
    
    
    
    
}
