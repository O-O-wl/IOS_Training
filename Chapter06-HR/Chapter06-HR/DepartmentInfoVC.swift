//
//  DepartmentInfoVC.swift
//  Chapter06-HR
//
//  Created by 이동영 on 06/02/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class DepartmentInfoVC: UITableViewController {
    
    typealias DepartRecord = (departCd:Int , departTitle:String , departAddr:String)
    
    var departCd : Int! // 넘겨받을  주소
    
    let empDAO = EmployeeDAO()
    let departDAO = DepartmentDAO()
    
    var departInfo : DepartRecord!
    var empList : [EmployeeVO]!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.departInfo = self.departDAO.get(depart_cd: self.departCd)
        self.empList = self.empDAO.find(departCd: self.departCd)

      
        
        self.navigationItem.title = "\(self.departInfo.departTitle)"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEPART_CELL")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
            
            switch indexPath.row{
            case 0:
                cell?.textLabel?.text = "부서코드"
                cell?.detailTextLabel?.text = "\(self.departInfo.departCd)"
            case 1:
                cell?.textLabel?.text = "부서명"
                cell?.detailTextLabel?.text = self.departInfo.departTitle
            case 2:
                cell?.textLabel!.text = "부서주소"
                cell?.detailTextLabel!.text = self.departInfo.departAddr
            default: break
                
            }
            
            return cell!
            
        }
        else{
            
            let row = self.empList[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "EMP_CELL")
            for emp in self.empList{
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
                cell?.textLabel!.text = "\(emp.empName)(입사일: \(emp.joinDate))"
                
                let state = UISegmentedControl(items: ["재직중","휴직","퇴사"])
                state.tag = row.empCd  // 액션 메소드에서 참조 가능하게 끔 코드 저장
                
                state.addTarget(self, action: #selector(self.changeState(_:)), for: .valueChanged)
                
                state.frame.origin.x = self.view.frame.width - state.frame.width - 10
                state.frame.origin.y = 10
                state.selectedSegmentIndex = row.stateCd.rawValue // 0 , 1 , 2
                cell?.contentView.addSubview(state)
            }
              return cell!
        }

      
    }
    /** ===================================================================
                                    - Note:
                            세그먼트 컨트롤에 액션메소드
     =====================================================================*/
    @objc func changeState(_ sender: UISegmentedControl){
    
        let empCd = sender.tag
        
        let stateCd : EmpStateType = EmpStateType(rawValue: sender.selectedSegmentIndex)!
        
        if self.empDAO.editState(empCd: empCd, stateCd: stateCd)
        {
            let alert = UIAlertController(title: nil, message: "재직 상태가 변경되었습니다", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            
            self.present(alert,animated: false)
        }
        
    }
   
}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


// - MARK: - 테이블 섹션메소드 Override
extension DepartmentInfoVC{
    
    /// - Note: 색션의 수를 결정하는 메소드 default = 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /// - Note: 색션 헤더에 들어갈 뷰를 정의 하는 메소드
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let textHeader = UILabel(frame: CGRect(x: 35, y: 5, width: 200, height: 30  ))
        textHeader.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 2.5))
        textHeader.textColor = UIColor(red: 0.03 ,green: 0.28, blue: 0.71, alpha: 1.0)
        
        let icon = UIImageView()
        icon.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        
        
        if section == 0 {
            textHeader.text = "부서 정보"
            icon.image = UIImage(imageLiteralResourceName: "department")
        }else{
            textHeader.text = "소속 사원"
            icon.image = UIImage(imageLiteralResourceName: "employee")
            
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        view.backgroundColor = UIColor(red: 0.93, green: 0.96, blue: 0.99, alpha: 1.0)
        view.addSubview(icon)
        view.addSubview(textHeader)
        return view
    }
    
    /// - Note: 섹션별 헤더의 높이 설정 메소드  -헤더의  뷰의 크기
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
        
    }
    
    /// - Note: 섹션별 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else{
            return self.empList.count
        }
    }
    
    
    
    
}




