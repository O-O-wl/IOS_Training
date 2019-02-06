//
//  DepartmentListVC.swift
//  Chapter06-HR
//
//  Created by 이동영 on 01/02/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class DepartmentListVC: UITableViewController {
    
    typealias dataSource = (departCd:Int,departTitle:String,departAddr:String)
    var departList : [dataSource]! // 데이터소스 -- 테이블뷰의 데이터소스
    
    let departDAO = DepartmentDAO() // SQLite 처리 담당 객체

    override func viewDidLoad() {
        //super.viewDidLoad()
      
        self.departList = self.departDAO.find()
          self.initUI()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func initUI(){
        
        // 총인원 나타내는 네비바
        let naviTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        naviTitle.numberOfLines = 2
        naviTitle.textAlignment = .center
        naviTitle.font = UIFont.systemFont(ofSize: 14)
        naviTitle.text = "부서목록\n"+"총\(self.departList.count)개"
        
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        // 편집버튼 추가  -- 네비바에서
        // 프로그래밍 방식에서만 가능
        /*  @objc editing(_sender : Any){
         self.tableView.setEditing(true , animated : true)
                    or
         self.tableView.isEditing = true
         }
         */
        
        
        self.navigationItem.titleView = naviTitle
        // 셀을 스와이프 했을때 편집머모드 설정
        self.tableView.allowsSelectionDuringEditing = true
    }

    
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.departList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEPART_CELL", for: indexPath)

        let rowData = self.departList[indexPath.row]
        cell.textLabel?.text = rowData.departTitle
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.text = rowData.departAddr
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)

        return cell
    }
    
    
    @IBAction func add(_ sender: Any) {
        print("확인")
        let alert = UIAlertController(title: "신규 부서 등록", message: "신규 부서를 등록해주세요", preferredStyle: .alert)
        alert.addTextField(){
            $0.placeholder = "부서명"
        }
        alert.addTextField(){
            $0.placeholder = "주소"
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .default){
           (_) in
            if self.departDAO.create(title: (alert.textFields?[0].text)!, addr: (alert.textFields?[1].text)!){
                self.departList =  self.departDAO.find()
                self.tableView.reloadData()
            }
          let naviTitle = self.navigationItem.titleView as! UILabel
          naviTitle.text = "부서 목록\n"+"총 \(self.departList.count)개"
            
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert,animated: false)
        
        
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /// - Note: 목록 편집 형식을 결정하는 메소드 (삭제/수정)
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
        //UITableViewCell.EditingStyle - 열거형 .insert , .delete ,  .none
    }
    
    
    
    // Override to support editing the table view.
    /// - Note: 편집모드에서 delete 클릭시 호출되는 메소드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        let departCd = self.departList[indexPath.row].departCd
        
        //DB에서 삭제성공시
        if departDAO.remove(depart_cd: departCd){
            // 데이터소스 에서도 삭제
            self.departList.remove(at: indexPath.row)
            // 테이블목록에서도 
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
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

}
