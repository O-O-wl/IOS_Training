//
//  ViewController.swift
//  Chapter06-SQLite3
//
//  Created by 이동영 on 01/02/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /** ======================================================
     - Note: X-code 가 지원하는 sqlite3 라이브러리 프로젝트 설정에서 추가
            obj-c 라이브러리이므로 bridging-header 추가
            build - setting 에 해당 브릿징헤더 설정
     ========================================================= */

    override func viewDidLoad() {
        let dbPath = self.getDBPath()
        self.dbExcute(Path: dbPath)
        
    }

    func alertDB(_ message :String){
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(OK)
        
        self.present(alert,animated: false)
        
    }
    
    func getDBPath()->String{
        // 파일 매니저 객체 생성
        let fileMgr = FileManager()
        
        // 파일매니저 객체로 앱 내의 디렉터리 경로를 찾고 결과를 url 배열로 반환
        //NSSearchPathForDirectoriesInDomains 랑 동일하나  URL로 반환
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        //디렉터리 경로에 db.sqlite 를 추가 하여 완벽한 db경로를 갱체를 만든다
        let dbPath = try! docPathURL.appendingPathComponent("db.sqlite").path
        
        /// - Note: dbPath에 해당하는 파일이 있는지 확인
        if fileMgr.fileExists(atPath: dbPath) == false{
            // 없으면 앱번들에 있는 db.sqlite 파일경로 읽어옵니다 -- 탬플릿 객체
            let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")
            //  번들 파일경로 파일을 복사
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        
        return dbPath
    }
    
    func dbExcute(Path:String){
        /** ======================================================
         - Note: Swift 언어라서 Objective-C 호환이 완벽히는 안됨
         각각 sqlite3 , sqlite3_stmt 객체
         ========================================================= */
        var db: OpaquePointer? = nil     // SQLite 연결정보를 담을 객체
       
        
        let dbPath = Path
        
    
        
        
        // dbPath에 넣고 디비 오픈후 db에 저장    - DB 객체 생성 return 값은 성공여부
        /// - Note: &db 인 이유 OpaquePointer 는 구조체라서 값을 복사한다 하지만 이건 레퍼런스로 처리해야한다.
        guard sqlite3_open(dbPath,&db) == SQLITE_OK else {
            
            print("데이터베이스 연결 실패")
            return
        }
        
        defer {
            print("커넥션 종료")
                  sqlite3_close(db) // 자원해제 -- OPEN 과 1:1로 묶여야하는 메소드 이므로 밖으로 뺸다.
        }
        
        // 테이블 생성 SQL
        let sql = "CREATE TABLE IF NOT EXISTS sequence (num INTEGER)"
        var stmt : OpaquePointer? = nil // 컴파일된 SQL 을 담을 객체
        
        //sql 구문 전달을 준비 - SQL구문객체 생성
        guard (sqlite3_prepare(db,sql,-1,&stmt,nil) == SQLITE_OK) else {
            print("SQL 객체 생성 실패")
            return
        }
        // stmt 객체를 DB에 전달
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("SQL 실행 성공")
        }
        
        
        defer{
            // 지연 블록은 밑에 있는거 먼저 실행
            print("SQL Statment 자원 해제")
            sqlite3_finalize(stmt) //   SQL구문 객체 자원해제
      
        }
    }

}

