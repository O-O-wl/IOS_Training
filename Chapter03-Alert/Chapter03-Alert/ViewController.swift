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
        
        
        defaultButton?.addTarget(self, action: #selector(popMapAlert(sender:))
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
    
    @objc func popMapAlert(sender:Any){
        let alert = UIAlertController(title: nil, message: "여기에 계신가요?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        let mapViewController  = UIViewController()
        let map = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
        let location = CLLocationCoordinate2D(latitude: 37.487432, longitude: 126.825966)
        let distance : CLLocationDistance = 200
        
        let region  = MKCoordinateRegion.init(center: location, latitudinalMeters: distance, longitudinalMeters: distance)
        let pin = MKPointAnnotation()
        
        pin.coordinate = location
        pin.title = "성공회대학교"
        map.region = region
        
        map.addAnnotation(pin)
        
        mapViewController.view = map
        alert.setValue(mapViewController, forKey: "contentViewController")
        self.present(alert, animated: false)
    }
}

