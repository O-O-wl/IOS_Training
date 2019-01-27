//
//  CSButton.swift
//  Chapter03-CSButton
//
//  Created by 이동영 on 27/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class CSButton: UIButton {

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
        super.init(frame: CGRect.zero)
        self.backgroundColor = .blue
        self.layer.cornerRadius = 5
        self.tintColor = .blue
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.setTitle("코드버튼2", for: .normal)
    }
}
