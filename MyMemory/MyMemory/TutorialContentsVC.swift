//
//  TutorialContentsVC.swift
//  MyMemory
//
//  Created by 이동영 on 10/02/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

class TutorialContentsVC: UIViewController{
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bgImageView: UIImageView!
    
    
    var pageIndex : Int!
    var titleText : String!
    var imgFile : String!
    
    
    override func viewDidLoad() {
        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
        
        self.bgImageView.image = UIImage(named: self.imgFile)
    }
    
    
}
