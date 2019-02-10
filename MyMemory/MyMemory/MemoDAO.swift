//
//  MemoDAO.swift
//  MyMemory
//
//  Created by 이동영 on 10/02/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import CoreData

class MemoDAO{
    
    lazy var context : NSManagedObjectContext = {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }()
    
    /**========================================
     - Note:     context에서 데이터 추출
    ==========================================*/
    func fetch(keyword text: String? = nil) -> [MemoData]{
        
        var memoList = [MemoData]()
        
        let fetchRequest : NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "regdate", ascending: false)]
        
        // 입력받은 검색조건의 유뮤 확인
        if let t = text , text?.isEmpty == false{
            // 코어데이터에서 특정조건으로만 데이터 추출을 하기위한객체
        let condition = NSPredicate(format: "contents CONTAINS[c] %@", t)
            fetchRequest.predicate = condition
        }
        
        //  let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.f
        do{
            
            let resultSet =  try context.fetch(fetchRequest)
            
            for memoMO in resultSet{
                let memo = MemoData()
                memo.objectId = memoMO.objectID
                memo.title = memoMO.title
                if let image = memoMO.image as? Data{
                    memo.image = UIImage(data: image)
                }
                memo.contents = memoMO.contents
                memo.regdate = memoMO.regdate
                
                
                
                memoList.append(memo)
            }
        }catch let error as NSError{
            print("에러발생 : \(error.localizedDescription)")
        }
        
        return memoList
    }
    

    
    
    
    
    /**========================================
     - Note:     context에서 데이터 삽입
     ==========================================*/
    func insert(_ data:MemoData){
        
        
       // var memo = MemoMO()
        let memo = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: self.context) as! MemoMO
        
        memo.title = data.title
        memo.regdate = data.regdate
        memo.contents = data.contents
        
        if let image = data.image{
        memo.image = image.pngData()
        }
        
       // context.insert(memo)
        do{ try self.context.save()
        }catch let error as NSError{
           // context.rollback()
            print("에러발생 : \(error.localizedDescription)")
        }
    }
    
    
    /**========================================
     - Note:     context에서 데이터 삭제
     ==========================================*/
     func delete(_ objectID: NSManagedObjectID)->Bool{
        
        
        let object  = self.context.object(with: objectID) as! MemoMO
         self.context.delete(object)
        
        do {
           
           try self.context.save()
            return true
        
        }catch let error as NSError{
            //self.context.rollback()
            print("에러발생 : \(error.localizedDescription)")
            return false
        }
        
    }
    
    
    
    
    
}
