//
//  ViewController.swift
//  Chapter03-Alert
//
//  Created by 이동영 on 27/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    var defaultButton : UIButton?
    
    override func viewDidLoad() {
        
        defaultButton = UIButton(type: .system)
        defaultButton?.frame = CGRect(x: 0, y: 50, width: 50, height: 50)
        defaultButton?.center = CGPoint(x: self.view.frame.size.width/2, y: 300)
       defaultButton?.setTitle("알림창", for: .normal)
        
        
        defaultButton?.addTarget(self, action: #selector(popAlert(sender:))
            , for: .touchUpInside)
        self.view.addSubview(defaultButton!)
       
     
        // Do any additional setup after loading the view, typically from a nib.
    }


    @objc func popAlert(sender:Any){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let contentView = UIViewController()
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        contentView.view.backgroundColor = .red
        
        alert.setValue(contentView, forKey: "contentViewController")
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: false)
    }
}

