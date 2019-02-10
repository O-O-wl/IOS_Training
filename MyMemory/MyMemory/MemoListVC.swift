//
//  MemoListVC.swift
//  MyMemory
//
//  Created by 이동영 on 18/01/2019.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class MemoListVC: UITableViewController {


   
    //var memos = [MemoData]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let memoDAO = MemoDAO()
   
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    searhB
        
        self.searchBar.enablesReturnKeyAutomatically = false
        /// - Note:  사이드 바 구현부
        if let revealVC = self.revealViewController()
        {
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu")
            btn.target = revealVC
            btn.action = #selector(revealVC.revealToggle(_:))
            self.navigationItem.leftBarButtonItem = btn 
            
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
        //let tutorial = TutorialMasterVC()
       // self.present(tutorial,animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.memos = appDelegate.memoList
        let ud = UserDefaults.standard
        // 튜토리얼키가 존재하지않는다면
        if ud.bool(forKey: UserInfoKey.tutorial) == false {
            let vc = self.instanceTutorialVC(name: "MasterVC")
            self.present(vc,animated: false)
            return
        }
        
        self.appDelegate.memoList = self.memoDAO.fetch()
        
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      //  print("self.memos.count")
        return self.appDelegate.memoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = self.appDelegate.memoList[indexPath.row].image == nil ? "memoCell" : "memoCellWithImage"
        let data = self.appDelegate.memoList[indexPath.row]
        print(cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        cell.subject?.text = data.title
        cell.contents?.text = data.contents
        cell.img?.image = data.image
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regDate?.text = formatter.string(from: data.regdate!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "read_sg", sender: tableView.cellForRow(at: indexPath))
        print("세그웨이 행")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "read_sg"){
            let selectedMemo = sender as! MemoCell
            (segue.destination as! MemoReadVC).memo = self.appDelegate.memoList[(tableView.indexPath(for: selectedMemo))!.row]
            
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

}


// - MARK: - 메모 삭제 로직
extension MemoListVC{
    
     // 스와이프로 삭제
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //==============================================
    // 코어데이터삭제 , 배열데이터소스 에서 삭제 , 테이블셀 삭제
    //==============================================
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if  self.memoDAO.delete(self.appDelegate.memoList[indexPath.row].objectId!){
        self.appDelegate.memoList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
}
extension MemoListVC : UISearchBarDelegate{
    
    /** ========================================================
     - Note: 검색 버튼이 클릭되었을 때 실행
     ==========================================================*/
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("클릭")
        let keyword = searchBar.text
        self.appDelegate.memoList = self.memoDAO.fetch(keyword: keyword )
        self.tableView.reloadData()
    }
   
}
