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
    }

    
    

