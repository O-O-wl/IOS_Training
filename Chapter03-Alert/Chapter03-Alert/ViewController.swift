//
//  ViewController.swift
//  Chapter03-Alert
//
//  Created by 이동영 on 27/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController{

    var defaultButton : UIButton?
    
    override func viewDidLoad() {
        
        defaultButton = UIButton(type: .system)
        defaultButton?.frame = CGRect(x: 0, y: 50, width: 50, height: 50)
        defaultButton?.center = CGPoint(x: self.view.frame.size.width/2, y: 300)
       defaultButton?.setTitle("알림창", for: .normal)
        
        
       // defaultButton?.addTarget(self, action: #selector(popMapAlert(sender:)), for: .touchUpInside)
      //  defaultButton?.addTarget(self, action: #selector(popImageAlert(sender:)), for: .touchUpInside)
         defaultButton?.addTarget(self, action: #selector(popControlAlert(sender:)), for: .touchUpInside)
        self.view.addSubview(defaultButton!)
       
     
        // Do any additional setup after loading the view, typically from a nib.
    }

    /** =====================================================
        - Note: forKey: "contentViewController" 은 프라이빗 API
                    콘텐츠 뷰 영역 확인용 메소드
     +=======================================================*/
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
    /** =====================================================
     - Note: forKey: "contentViewController" 은 프라이빗 API
                맵뷰가 콘텐츠뷰에 위치한 custom alert
     +=======================================================*/
    @objc func popMapAlert(sender:Any){
        let alert = UIAlertController(title: nil, message: "여기에 계신가요?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        let mapViewController = MapContentView()
        
        self.present(alert, animated: false)
        alert.setValue(mapViewController, forKey: "contentViewController")
    }
    /** =====================================================
     - Note: forKey: "contentViewController" 은 프라이빗 API
            이미지 뷰가 콘텐츠뷰에 위치한 custom alert
     +=======================================================*/
    @objc func popImageAlert(sender: Any){
        let alert = UIAlertController(title: nil, message:"어떠셨나요? ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        let imageContentView = ImageContentView()
        
        self.present(alert, animated: false)
        alert.setValue(imageContentView, forKey: "contentViewController")
    }
    /** =====================================================
     - Note: forKey: "contentViewController" 은 프라이빗 API
             슬라이더 가 콘텐츠뷰에 위치한 custom alert
     +=======================================================*/
    @objc func popControlAlert(sender: Any){
        let alert = UIAlertController(title: nil, message:"어떠셨나요? ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        let controlContentView = ControlContentView()
                alert.setValue(controlContentView, forKey: "contentViewController")
        print(" >>> \(String(describing: controlContentView.sliderValue))")
        
         self.present(alert, animated: false)
       

    }
}

