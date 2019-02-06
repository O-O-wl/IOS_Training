//
//  DepartmentDAO.swift
//  Chapter06-HR
//
//  Created by 이동영 on 01/02/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import Foundation

class DepartmentDAO{
    
    // 부서 테이블 레코드 타입 선언  부서번호 , 부서이름 , 주소
    typealias DepartmentRecord = (Int,String,String)
    
    lazy var fmdb : FMDatabase! = {
        
        // 파일매니저 객체 생성
        let fileMgr = FileManager.default
        
        // 파일매니저 객체로 경로 url 가져온다
        var docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        
        // 경로 URL에 hr.sqlite 경로 합성 -- 샌드박스 내의   hr.sqlite
        var dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        print(dbPath)
        
        // 경로가 존재하지않으면 DB탬플릿 복사 -- 번들경로의 hr.sqlite
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
            // atPath 의 파일을 toPath 위치로 복사
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
            
        }
        
        let db = FMDatabase(path: dbPath)
        return db
    }()
    
    
    init(){
        self.fmdb.open()
    }
    
    deinit {
        self.fmdb.close()
    }
    
}
// - MARK: - SELECT 처리
extension DepartmentDAO{
    
    /** ================================================
     - Note:
     FindAll
     //================================================*/
    func find() -> [DepartmentRecord]{
        // 사실상 테이블과 같은 역할
        var departmentList = [DepartmentRecord]()
        
        do{
            let sql = """
            SELECT * FROM department ORDER BY depart_cd ASC
            """
            // 결과추출
            let rs = try self.fmdb.executeQuery(sql,values:nil)
            
            //
            while rs.next(){
                // 32bit 타입 정수로 반환
                let departCd = rs.int(forColumn: "depart_cd")
                let departTitle = rs.string(forColumn: "depart_title")
                let departAddr = rs.string(forColumn: "depart_addr")
                
                departmentList.append((Int(departCd),departTitle!,departAddr!))
            }
        }catch let error as NSError{
            print("failed:\(error.localizedDescription)")
        }
        return departmentList
    }
    
    /** ================================================
     - Note:
     FindById
     //================================================*/
    func get (depart_cd : Int) -> DepartmentRecord? {
        let sql = "SELECT * FROM department WHERE depart_cd = ?"
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [depart_cd])
        
        /// _rs  에 rs 를 넣고 실행
        if let _rs = rs{
            _rs.next()
            let departCd = _rs.int(forColumn: "depart_cd")
            let departTitle = _rs.string(forColumn: "depart_title")
            let departAddr = _rs.string(forColumn: "depart_addr")
            
            return (Int(departCd),departTitle!,departAddr!)
            
        }else{
            return nil
        }
    }
}
// - MARK: - INSERT 처리
extension DepartmentDAO{
    
    func create(title:String , addr : String) ->Bool{
        
        
        /// - Note: 입력값 체크
        guard title != nil && title.isEmpty == false else{
            return false
        }
        guard addr != nil && addr.isEmpty == false else{
            return false
            
        }
        
        
        do{
            let sql = """
INSERT INTO department (depart_title,depart_addr) VALUES (?,?)
"""
            try self.fmdb.executeUpdate(sql, values: [title,addr])
            return true
        }catch let error as NSError {
            print("에러 : \(error.localizedDescription)")
            return false
        }
    }
}
// - MARK: - DELETE 처리
extension DepartmentDAO{
    func remove(depart_cd : Int) -> Bool{
        let sql = """
DELETE FROM department WHERE depart_cd = ?
"""
        do{
            try self.fmdb.executeUpdate(sql, values: [depart_cd])
                return true
            }
        catch let error as NSError {
            print("에러 : \(error) ")
            return false
        }
        
    }
    
}

