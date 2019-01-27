//
//  ControlContentView.swift
//  Chapter03-Alert
//
//  Created by 이동영 on 27/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit

class ControlContentView : UIViewController{
    var slider : UISlider?
    
    var sliderValue : Float  {
        
        return (self.slider?.value)!
        
        
    }
    override func viewDidLoad() {
        self.slider = UISlider()
        self.slider?.value = 50
        self.slider!.maximumValue = 100
        self.slider!.minimumValue = 0
        self.slider!.center.x = self.view.frame.width/3
        
        self.view.addSubview(slider!)
    }
    
}
