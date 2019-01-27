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
        self.csBtn = CSButton(frame: CGRect(x: 0, y: 100, width: 200, height: 50))
        self.csBtn!.center.x = self.view.frame.width/2
        self.view.addSubview(self.csBtn!)
        
        self.csBtn2 = CSButton()
        self.csBtn2!.center.x = self.view.frame.width/2
        self.csBtn2?.frame = CGRect(x: 0, y: 200, width: 200, height: 50)
        self.csBtn2!.center.x = self.view.frame.width/2
        self.view.addSubview(self.csBtn2!)
    }
    


}

