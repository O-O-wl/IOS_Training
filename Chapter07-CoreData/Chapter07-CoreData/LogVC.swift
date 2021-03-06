//
//  LogVC.swift
//  Chapter07-CoreData
//
//  Created by 이동영 on 08/02/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class LogVC: UITableViewController {
    
    
    var board : BoardMO!
    
    lazy var list : [LogMO]! = {
        
        // LogMO 객체는 따로 fetch 해올 필요가 없다 - Board 를 fetch 해올때 릴레이션으로 인해 자동으로 fetch
        // 보드에서 어트리뷰트(릴레이션) 의 속성을 [LogMO] 로 반환할뿐 --      1 : M 
        return self.board.logs?.array as! [LogMO]
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.board.title
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logcell", for: indexPath)

        let row = self.list[indexPath.row]
        cell.textLabel?.text = "\(row.regdate!)에 \(row.type.toLogType())되었습니다 "
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
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
    
    /*
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let logVC = self.storyboard?.instantiateViewController(withIdentifier: "LogVC") as! LogVC
        logVC.board = self.list[indexPath.row]
    
    
    }
*/
}
// - MARK: - 로그타입 열거형
public enum LogType : Int16 {
    case create = 0
    case edit = 1
    case delete = 2
}

// Int16 구조채에 메소드 추가. -  LogType 에서 어소세이션베류인 0 , 1 ,2 에 의미를 부여해주는 메소드
extension Int16{
    func toLogType() -> String{
        switch self {
        case 0:
            return "생성"
        case 1:
            return "수정"
        case 2:
            return "삭제"
        default:
            return ""
        }
    }
    
}

