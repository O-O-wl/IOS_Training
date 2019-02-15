//
//  DataSync.swift
//  MyMemory
//
//  Created by 이동영 on 15/02/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import CoreData


class DataSync{
    
    lazy var context : NSManagedObjectContext = {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
}
// - MARK: - DataSync 유틸메소드
extension DataSync{
    //=====================
    //   String -> Date
    //=====================
    func stringToDate( _ value:String) -> Date{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.date(from: value)!
    }
    
    //=====================
    //   Date -> String
    //=====================
    func dateToString(_ value:Date) -> String{
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: value as Date)
    }
    
}
