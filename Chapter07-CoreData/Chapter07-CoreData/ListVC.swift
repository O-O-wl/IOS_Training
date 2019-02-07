//
//  ListVC.swift
//  Chapter07-CoreData
//
//  Created by 이동영 on 07/02/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

import CoreData


class ListVC: UITableViewController {
    
    
    // 데이터 소스
    lazy var list: [NSManagedObject] = {
        return self.fetch()
    }()
    
    
    /** =================================================
     
                         - Note:
                    데이터를 읽어오는 메소드
     ====================================================*/
    func fetch() -> [NSManagedObject]{
        
        //  앱델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 앱델리게이트객체를 이용한 관리객체컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 요청 객체 생성  - SELECT 구문과 유사 -- 어디서(엔터티 - FROM) 어떤(검색조건 - WHERE) 어떻게 ( 정렬 - ORDER)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"Board")
        
        // 데이터 가져오기  -- 반환은 MO의 배열
        let result = try! context.fetch(fetchRequest)
        
        
        
        return result
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let appDelegate = UIApplication.shared.dele

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.list.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let record = self.list[indexPath.row]
        
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = contents
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

}
