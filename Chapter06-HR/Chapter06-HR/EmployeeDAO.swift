//
//  EmployeeDAO.swift
//  Chapter06-HR
//
//  Created by 이동영 on 05/02/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import Foundation

class EmployeeDAO{
    
    // 열거형 재직상태 코드타입

    
    // 생성자
    init() {
        self.fmdb.open()
    }
    // 소멸자
    deinit {
        self.fmdb.close()
    }
    
    // DepartmentDAO  와 중복되는 코드 -- 상속구조 추천
    lazy var fmdb : FMDatabase! =  {
        
        let fileMgr = FileManager.default
        
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
            
        }
        
        let db = FMDatabase(path: dbPath)
        return db
        
    }()
    
    
    
/**=======================================================
                    - Note: VO패턴
            VO 패턴은 3경우를 제외하고는 구조체로 한다
     
                1. VO객체를 여러 곳에 전달할 때
                2. VO객체 내부에 클래스 기반 변수를 사용할떄
                3. 상속구조를 이용할 때
 ========================================================*/

}
// - MARK: - SELECT 구문
extension EmployeeDAO{
    func find() ->[EmployeeVO]{
        print("SELECT")
        var empList = [EmployeeVO]()
        do{
        let sql = """
        SELECT emp_cd,emp_name,join_date,state_cd,department.depart_title FROM employee JOIN department  ON department.depart_cd = employee.depart_cd ORDER BY employee.depart_cd ASC
        """
        let rs = try self.fmdb.executeQuery(sql, values: nil)
        while  rs.next(){
            
            var employee = EmployeeVO()
            employee.empCd = Int(rs.int(forColumn: "emp_cd"))
            employee.empName = rs.string(forColumn: "emp_name")!
            employee.joinDate = rs.string(forColumn: "join_date")!
            employee.departTitle = rs.string(forColumn: "depart_title")!
            
            print(employee.empName)
            //DB에서 읽어와서 Int32 ->Int
            let cd = Int(rs.int(forColumn: "state_cd"))
            // 열거형 변환
            employee.stateCd = EmpStateType(rawValue: cd)!
            empList.append(employee)
        }
        
        }catch let error as NSError{
            print("에러 : \(error.localizedDescription)")
            
        }
        return empList
        
    }
  //  func findByDepartment(departCd:Int) -> [EmployeeVO]{
        
  //  }
    func findById(empCd:Int)->EmployeeVO? {
        let sql = """
SELECT emp_cd,emp_name,join_date,state_cd,d.depart_title FROM employee e  JOIN department d ON e.depart_cd = d.depart_cd WHERE e.emp_cd = ? ORDER BY e.depart_cd ASC
"""
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [empCd])
       if let _rs = rs{
             _rs.next()
        var employee  = EmployeeVO()
        
        employee.empCd = Int(_rs.int(forColumn: "emp_cd"))
        employee.empName = _rs.string(forColumn: "emp_name")!
        employee.joinDate = _rs.string(forColumn: "join_date")!
        employee.departTitle = _rs.string(forColumn: "depart_title")!
        
        let cd = Int(_rs.int(forColumn: "state_cd"))
        employee.stateCd = EmpStateType(rawValue: cd)!
        
          return employee
       }else{
        return nil
        }
        
      
    }
    
}
// - MARK: - INSERT 구문
extension EmployeeDAO{
    func create(param:EmployeeVO) -> Bool{
        let sql = "INSERT INTO employee (emp_name,join_date,state_cd,depart_cd)  VALUES (?,?,?,?)"
        do{
            var params = [Any]()
            params.append(param.empName)
            params.append(param.joinDate)
            params.append(param.stateCd.rawValue)  //DB는 열거형 객체 저장 불가 -- 연관값으로 변경
            params.append(param.departCd)
            
            try self.fmdb.executeUpdate(sql, values: [param.empName,param.joinDate,param.stateCd.rawValue,param.departCd])
            
            return true
            
        }catch let error as NSError{
            print("에러 : \(error.localizedDescription)")
            return false
        }
        
    }
}
// - MARK: - DELETE 구문
extension EmployeeDAO{
    func remove(empCd:Int)->Bool{
        let sql = """
DELETE FROM employee WHERE emp_cd = ?
"""
        do{
            try self.fmdb.executeUpdate(sql, values: [empCd])
            return true
        }catch let error as NSError{
            print("에러:\(error.localizedDescription)")
            return false
        }

    }
}
public enum EmpStateType : Int {
    case ING = 0 , STOP, OUT // 재직중(0),휴직(1),퇴사(2)
    
    func desc() -> String{
        switch self {
        case .ING:
            return "재직중"
        case .STOP:
            return "휴직중"
        case .OUT:
            return "퇴사"
        }
    }
}
public struct EmployeeVO {
    var empCd = 0;                  // 직원 코드
    var empName=""                  // 직원 이름
    var joinDate = ""               // 입사일
    var stateCd = EmpStateType.ING  // 재직상태
    var departCd = 0                // 부서코드
    var departTitle = ""            // 부서 이름
    
}
