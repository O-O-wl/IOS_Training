//
//  EmployeeListVC.swift
//  Chapter06-HR
//
//  Created by 이동영 on 01/02/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class EmployeeListVC: UITableViewController {
    
    
    var employeeList : [EmployeeVO]!
    
    var empDAO = EmployeeDAO()
    
    var loadingImg : UIImageView!
    
    // 스크롤이 임계점 도달 나타나는 배경 뷰
    var bgCycle : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.employeeList = self.empDAO.find()
        print(self.employeeList.count)
        self.initUI()
        // 기본으로 테이블뷰컨트롤러에 정의된 컨트롤
        self.refreshControl = UIRefreshControl()
        
        self.bgCycle = UIView()
        self.bgCycle.backgroundColor = .yellow
        self.bgCycle.center.x = (self.refreshControl?.frame.width)! / 2
        
        self.loadingImg = UIImageView( image: UIImage( named:"refresh"))
        self.loadingImg.center.x = ((self.refreshControl?.frame.width)! / 2 )
        self.refreshControl?.addSubview(loadingImg)
        self.refreshControl?.addSubview(bgCycle)
        self.refreshControl?.bringSubviewToFront(self.loadingImg)
        
 
        
        
        
        // self.refreshControl?.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        self.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        self.refreshControl?.tintColor = UIColor.clear
        
        
    }
    
    func initUI(){
        
        let naviTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        
        naviTitle.numberOfLines = 2
        naviTitle.font = UIFont.systemFont(ofSize: 14)
        naviTitle.textAlignment = .center
        naviTitle.text = "사원 목록\n"+"총\(self.employeeList.count)명"
        
        self.navigationItem.titleView = naviTitle
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.employeeList.count
    }
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "사원등록", message: "등록할 사원 정보를 입력해 주세요", preferredStyle: .alert)
        alert.addTextField(){
            $0.placeholder = "사원이름"
        }
        let pickerVC = DepartPickerVC()
        // 알림창에 피커뷰 달기
        alert.setValue(pickerVC, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .default){
            (_) in
            var employee = EmployeeVO()
            
            employee.empName = (alert.textFields?[0].text!)!
            
            employee.departCd = pickerVC.selectedDepartCd
            
            print(employee.departCd)
            
            let df = DateFormatter()
            
            df.dateFormat = "yyyy-MM-dd"
            
            employee.joinDate = df.string(from: Date())
            
            employee.stateCd = EmpStateType.ING
            
            if self.empDAO.create(param: employee){
                self.employeeList = self.empDAO.find()
                self.tableView.reloadData()
                print("sql OK")
                
            }
            
            if let naviTitle = self.navigationItem.titleView as? UILabel{
                naviTitle.text = "사원 목록\n"+"총\(self.employeeList.count)명"
            }
            
            
            }
            
        )
        self.present(alert,animated: false)
    }
    
    
    @IBAction func editing(_ sender: Any) {
        if(self.isEditing == false){
            // 수정상태 아니면 수정상태로
            self.setEditing(true, animated: true)
            // 버튼 text 는 Done으로
            (sender as? UIBarButtonItem)?.title = "Done"
        }
        else{
            self.setEditing(false, animated: true)
            (sender as? UIBarButtonItem)?.title = "Edit"
        }
        
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EMP_CELL", for: indexPath)
        
        let rowData = self.employeeList[indexPath.row]
        
        cell.textLabel?.text = "\(rowData.empName)"+"(\(rowData.stateCd.desc()))"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.text = rowData.departTitle
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        
        // Configure the cell...
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let empCd = self.employeeList[indexPath.row].empCd
        if(self.empDAO.remove(empCd: empCd)){
            self.employeeList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)}
        
    }
    
    /** ===================================================================
     - Note:
     당겨서 새로고침 액션메소드
     =====================================================================*/
    @objc func pullToRefresh( _ sender:UIRefreshControl){
        // 갱신
        self.employeeList = self.empDAO.find()
        self.tableView.reloadData()
        
        let distance = max(0.0 , -(self.refreshControl?.frame.origin.y)!)
        
        // 노란원이 이미지를 중심으로 커지는 애니메이쎤
        UIView.animate(withDuration: 0.5){
            self.bgCycle.frame.size.width = 80
            self.bgCycle.frame.size.height = 80
            self.bgCycle.center.x = (self.refreshControl?.frame.width)! / 2
            self.bgCycle.center.y = distance/2
            self.bgCycle.layer.cornerRadius = self.bgCycle.frame.size.width/2
            
        }
        //  당겨서 새로고침 종료
        sender.endRefreshing()
        
    }
    
    
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
    /** ==================================================
     - Note:
     테이블 뷰 의 상위 컨트롤러인 스크롤 뷰 컨트롤러에 정의된 메소드
     델리게이트 메소드 , 스크롤되는 동안 반복적 호출
     ==================================================== */
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 스크롤 된 거리   - 상위뷰 (테이블뷰)의 bound가 내려감에 따라 사위뷰인 리프레시뷰의 frame이 내려감
        print("바운스 : \(self.tableView.bounds.origin.y)")
        print("오리진 : \(self.refreshControl?.frame.origin.y)")
        let distance = max(0.0, -(self.refreshControl?.frame.origin.y)!)
        
        let ts = CGAffineTransform(rotationAngle: CGFloat(distance/20))
        self.loadingImg.transform = ts
        
        // 배경 뷰의 중심 좌표 설정
        self.bgCycle.center.y  = distance/2
        
        self.loadingImg.center.y = distance/2
    }
    /** ===========================================================================
             - Note:     드래그가 끝났을 떄 호출되는 델리게이트 메소드
     ============================================================================*/
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.bgCycle.frame.size.width = 0
        self.bgCycle.frame.size.height = 0
    }
}
