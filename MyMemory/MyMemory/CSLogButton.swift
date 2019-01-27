//
//  CSLogButton.swift
//  MyMemory
//
//  Created by 이동영 on 27/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class CSLogButton: UIButton {
    
    public var logType: CSLogType = .title
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setBackgroundImage(UIImage(named: "button-bg"), for: .normal)
        self.tintColor = .white
        self.addTarget(self, action: #selector(logging), for: .touchUpInside)
    }
    
    @objc func logging(sender:UIButton){
        switch self.logType {
        case .basic:
            NSLog("버튼이 클릭되었습니다.")
        case .title:
            let btnTitle = self.titleLabel!.text ?? "타이틀이 없는"
            NSLog("\(btnTitle) 버튼이 클릭되었습니다.")
        case .tag:
            NSLog("\(sender.tag) 버튼이 클릭되었습니다.")
        }
    }
    
}
// MARK: - 버튼 로그타입 열거형
public enum CSLogType{
    case basic
    case title
    case tag
}

