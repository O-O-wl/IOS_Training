//
//  CSButton.swift
//  Chapter03-CSButton
//
//  Created by 이동영 on 27/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class CSButton: UIButton {
    
    var style : CSButtonType = .rect{
        didSet{
            switch style {
            case .rect:
                self.backgroundColor = .black
                self.layer.borderWidth = 2
                self.layer.borderColor = UIColor.black.cgColor
                self.layer.cornerRadius = 0
                self.setTitleColor(.white, for: .normal)
                self.setTitle("Rect Button", for: .normal)
            case .circle:
                self.backgroundColor = .red
                self.layer.borderWidth = 2
                self.layer.borderColor = UIColor.red.cgColor
                self.layer.cornerRadius = 50
                self.setTitleColor(.white, for: .normal)
                self.setTitle("circle Button", for: .normal)
                
        }
    }
    }
    convenience init(type: CSButtonType){
        self.init()
        switch type {
        case .rect:
            self.backgroundColor = .black
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.cornerRadius = 0
            self.setTitleColor(.white, for: .normal)
            self.setTitle("Rect Button", for: .normal)
        case .circle:
            self.backgroundColor = .red
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.cornerRadius = 50
            self.setTitleColor(.white, for: .normal)
            self.setTitle("circle Button", for: .normal)
      
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.backgroundColor = .green
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.tintColor = .red
        self.setTitle("커스텀버튼", for: .normal)
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .red
        self.layer.cornerRadius = 5
        self.tintColor = .blue
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.setTitle("코드버튼", for: .normal)
        //super.init(frame: frame)
    }
    
    init() {
        /// - Note: 부모클래스의 지정초기화 메소드 호출해야함
        /// - Note: 따라서 init() 이 아닌 init(frame:)
        super.init(frame: CGRect.zero)
        self.backgroundColor = .blue
        self.layer.cornerRadius = 5
        self.tintColor = .blue
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.setTitle("코드버튼2", for: .normal)
    }
}
//  MARK: - 열거형 버튼 타입 추가
public enum CSButtonType{
    case rect
    case circle
}

