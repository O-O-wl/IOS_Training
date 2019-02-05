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
        super.viewDidLoad()
        initUI()

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
        self.navigationItem.leftBarButtonItem = self.editButtonItem // 편집버튼 추가
        // 셀을 스와이프 했을때 편집머모드 설정
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

}
