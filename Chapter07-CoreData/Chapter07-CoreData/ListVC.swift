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
                        화면 및 로직 초기화 메소드
     ====================================================*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(add(_:)))
        
        self.navigationItem.rightBarButtonItem = addBtn
        //let appDelegate = UIApplication.shared.dele

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
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
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let object = self.list[indexPath.row]
        
        if self.delete(object: object) == true {
            self.list.remove(at: indexPath.row)
            
            ///  둘다 가능하나 리로드하는 것과 / 특정행만 지우면 애니메이션을 하는 차이가있다
            //self.tableView.reloadData()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = self.list[indexPath.row]
        
        let title = object.value(forKey: "title") as! String
        let contents = object.value(forKey: "contents") as! String
        let regdate = object.value(forKey: "regdate") as! Date
        let alert = UIAlertController(title: "게시글 수정", message: "\(regdate)", preferredStyle: .alert)
        
        
        
        
        alert.addTextField(){
            $0.text = title
        }
        alert.addTextField(){
            $0.text = contents
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default){
            (_) in
                let title = alert.textFields?.first?.text
            let contents = alert.textFields?.last!.text
            if self.edit(object: object, title: title!, contents: contents!) == true{
               
                /**===========================================================
                                            - Note:
                            수정에 성공하면 edit메소드에서 fetch 메소드가 실행된다
                        그 이후 테이블을 모두 리로드하는거 보다는 한 셀만 위로 이동시키는게
                                            더 좋은 선택이다.
                 ================================================================*/
                // self.tableView.reloadData()
            
                // 테이블을 리로드하지않으니 배열이수정되도 테이블셀내용이 수정되지않으므로
                let cell  = self.tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = title
                cell?.detailTextLabel?.text = contents
                
                // 첫번째 indexPath 객체 생성
                let firstPath = IndexPath(item: 0, section: 0)
                
                // 셀 이동
                self.tableView.moveRow(at: indexPath, to: firstPath)
            }
                
            })
        
        self.present(alert , animated: false)
        
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
// - MARK: - ORM 데이터 핸들링
extension ListVC{
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
        
        // 정렬 조건 객체 생성.
        let sort = NSSortDescriptor(key: "regdate", ascending: false)
        
        // sortDescriptors  은 배열 -- 두개이상의 조건 적용가능하기떄문
        fetchRequest.sortDescriptors = [sort]
        
        // 데이터 가져오기  -- 반환은 MO의 배열
        let result = try! context.fetch(fetchRequest)
        
        
        
        return result
        
    }
    /** =================================================
     
                            - Note:
                수정된 데이터를 영구저장소에 반영하는 메소드
     ====================================================*/
    func save(title: String , contents:String) -> Bool{
        
        // 앱델리게이트 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 관리 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 관리 객체 생성 - 등록
        let object = NSEntityDescription.insertNewObject(forEntityName: "Board", into: context)
        
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        do{
            // commit
             try context.save()
            
            // 새로만든 객체를 맨 위로 저장
            self.list.insert(object, at: 0)
            
            
            self.tableView.reloadData() // 테이블이 재정렬 되지 않는 이유 - 배열만 바뀌엇따 하지만 테이블셀은 배열이 아닌 MO를 참조하고있다.
            
            return true
        }catch let error as NSError{
            print(" 저장 에러 : \(error.localizedDescription)")
            
            // 에러시 roll back - 마지막 동기화 시점으로 되돌리는 역할  - 이전 save 성공시점
            /// - Note: 커밋을 실패하면 영구저장소에는 반영이 안되지만 context에는 있으므로 롤백
            context.rollback()
            return false
        }
        
    }
    
    
    
    
    /** =================================================
     
                            - Note:
                    데이터 저장 버튼에 대한 액션 메소드
     ====================================================*/
    @objc func add(_ sender:Any){
        let alert = UIAlertController(title: "게시글 등록", message: nil, preferredStyle: .alert)
        
        alert.addTextField(){
            $0.placeholder = "제목"
        }
        alert.addTextField(){
            $0.placeholder = "내용"
        }
    
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
        alert.addAction(UIAlertAction(title: "Save", style: .default){
            (_) in
            guard let title = alert.textFields?.first?.text , let contents = alert.textFields?.last?.text else {return }
            
            if self.save(title: title , contents: contents ) == true {
                print("배열 크기 : \(self.list.count)")
                
                
                self.tableView.reloadData()
            }
        })
        
        self.present(alert,animated: false)
    }
    
    
    /** =================================================
     
                        - Note:
                컨텍스트에서 데이터 삭제 메소드
                이후 save 메소드로 영구저장소에 반영
     ====================================================*/
    func delete(object: NSManagedObject) -> Bool{
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        context.delete(object)
        do{
          try context.save()
            return true
        }catch{
            context.rollback()
            return false
        }
        
        
    }
    
    

    
    
    
    /** =================================================
     
                            - Note:
                    컨텍스트에서 데이터 수정 메소드
                이후 save 메소드로 영구저장소에 반영
     ====================================================*/
    func edit(object:NSManagedObject , title:String , contents:String) ->Bool{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        do{
            try context.save()
            
            // 데이터 수정시 배열 다시 컨텍스트와 동기화
            self.list = self.fetch()
            
            
            return true
        }catch{
            context.rollback()
            return false
        }
        
    }
}
