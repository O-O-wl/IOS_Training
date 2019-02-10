//
//  MemoData.swift
//  MyMemory
//
//  Created by 이동영 on 18/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//
import UIKit
import Foundation
import CoreData


class MemoData{
    
    var memoIdx : Int?
    var title : String?
    var contents : String?
    var image : UIImage?
    var regdate : Date?
    
    // 코어데이터 컨텍스트의 MemoMO 객체를 참조하기위해
    var objectId : NSManagedObjectID?
}

