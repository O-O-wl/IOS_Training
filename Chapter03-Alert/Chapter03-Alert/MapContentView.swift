//
//  MapContentView.swift
//  Chapter03-Alert
//
//  Created by 이동영 on 27/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapContentView : UIViewController{
    override func viewDidLoad() {
      
        let map = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let location = CLLocationCoordinate2D(latitude: 37.487432, longitude: 126.825966)
        let distance : CLLocationDistance = 200
        
        let region  = MKCoordinateRegion.init(center: location, latitudinalMeters: distance, longitudinalMeters: distance)
        let pin = MKPointAnnotation()
        
        pin.coordinate = location
        pin.title = "성공회대학교"
        pin.subtitle = "부엉이 개발자가 다니는 학교"
        map.region = region
        
        map.addAnnotation(pin)
        
        self.view = map
        //self.setValue(mapViewController, forKey: "contentViewController")
    }
}
