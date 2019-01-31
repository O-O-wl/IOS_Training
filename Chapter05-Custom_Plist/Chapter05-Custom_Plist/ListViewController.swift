//
//  ViewController.swift
//  Chapter05-Custom_Plist
//
//  Created by 이동영 on 31/01/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit


class ListViewController: UITableViewController {

    var accountlist = [String]()
    
    
    
    
    override func viewDidLoad() {
       
        
        let picker = UIPickerView()
        
        let plist = UserDefaults.standard
        
        // ==============================================
        //  유저계정 목록은 UserDefault에 저장하고 마스터데이터로서
        //  각각의 해당 유저 계정으로 customPlist 의 시드데이터로 사용
        //===================================================
        
        self.accountlist = (plist.array(forKey: "accountlist") as? [String] ) ?? [String]()
//        print(accountlist[0])
        if let account = plist.string(forKey: "selectedAccount"){
             self.account.text = account
        }
        
        fillUserInfo()
        picker.delegate = self
        
        /// - Note: 텍스트필드의 입력방식을 키보드가 아닌 PickerView로 설정
        self.account.inputView = picker
        
        
        //=========================== 툴바 정의 ==================================
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.barTintColor = UIColor.lightGray
        
        /// - Note: 텍스트뷰의 엑세사리뷰로 툴바 표시
        self.account.inputAccessoryView = toolbar
        
        
        
        /// - Note: 툴바에 바버튼아이템 등록
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        done.action = #selector(pickerDone)
        done.tintColor = UIColor.gray
        
        /// - Note: 툴바에 새 계정 추가 버튼아이템 등록
        let new = UIBarButtonItem(title: "New", style: UIBarButtonItem.Style.plain , target: self, action: #selector(addAccount))
        new.tintColor = .gray
        
        // 가변 툴바 공간 버튼
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //toolbar.setItems(, animated: <#T##Bool#>)
        //gittoolbar.setItems([flexibleSpaceButton], animated: true)
        toolbar.setItems([new,flexibleSpaceButton,done], animated: true)
        
        
        
        
        //=====================================================================
        
        
        
    }
    
    @IBOutlet var account: UITextField!
    
    @IBOutlet var name: UILabel!
    
    
    @IBOutlet var gender: UISegmentedControl!
    
    
    @IBOutlet var married: UISwitch!
    
    
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let gender = self.gender.selectedSegmentIndex
        // 읽어올 파일명  계정명.plist
        let customPlist = "\(self.account.text!).plist"     //
        
        // 현재 샌드박스 디렉터리 영역
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // 타입캐스팅
        let path = paths[0] as NSString
        
        // 완전한 커스텀파일 경로 생성
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        
        // 커스텀파일 읽어와서 딕셔너리로 or 새 딕셔너리 생성
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
        
        // 딕셔너리에 이름 추가 or 덮어쓰기
        data.setValue(gender, forKey: "gender")
        
        // 실제파일에 딕셔너리 덮어쓰기 or 생성
        data.write(toFile: plist, atomically: true)
        
    }
    
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        let married = self.married.isOn
        // 읽어올 파일명  계정명.plist
        let customPlist = "\(self.account.text!).plist"     //
        
        // 현재 샌드박스 디렉터리 영역
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // 타입캐스팅
        let path = paths[0] as NSString
        
        // 완전한 커스텀파일 경로 생성
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
       print(path)
        print(customPlist)
        print(plist)
        // 커스텀파일 읽어와서 딕셔너리로 or 새 딕셔너리 생성
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
        
        // 딕셔너리에 이름 추가 or 덮어쓰기
        data.setValue(married, forKey: "married")
        
        // 실제파일에 딕셔너리 덮어쓰기 or 생성
        data.write(toFile: plist, atomically: true)
        print(plist)
    }
    
    
    @objc func pickerDone(){
        fillUserInfo()
         //print(self.account.text)
         self.view.endEditing(true)
    }
    
    
    @objc func addAccount(){
        let alert = UIAlertController(title: "새 계정을 입력해주세요", message: nil, preferredStyle: .alert)
        alert.addTextField(){
            $0.placeholder = "ex)abc@gmail.com"
            
        }
       
        let ok = UIAlertAction(title: "OK", style: .default){
            (_) in
                self.accountlist.append(alert.textFields![0].text!)
                self.account.text = alert.textFields![0].text!
               // self.view.endEditing(true)
                self.name.text = ""
                self.married.isOn = false
                self.gender.selectedSegmentIndex = 0
            
                let plist = UserDefaults.standard
                plist.set(self.accountlist, forKey: "accountlist")
                plist.synchronize()
            
        
        }
        alert.addAction(ok)
        self.present(alert,animated: false)
    }
    
    func fillUserInfo()
    {
        
        // 현재 샌드박스 디렉터리 영역
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // 타입캐스팅
        let path = paths[0] as NSString
        
        // 완전한 커스텀파일 경로 생성
        let customplist = path.strings(byAppendingPaths: ["\(self.account.text!).plist"]).first!
        
        // 커스텀파일 읽어와서 딕셔너리로 or 새 딕셔너리 생성
        let userInfo = NSMutableDictionary(contentsOfFile: customplist) ?? NSMutableDictionary()
        
        
        
        
        self.name.text = userInfo.value(forKey: "name") as? String
        
        self.married.isOn = userInfo.value(forKey: "married") as? Bool ?? false
        
        self.gender.selectedSegmentIndex = userInfo.value(forKey: "gender") as? Int ?? 0
        
    }
    
    
    
    @IBAction func editName(_ sender: Any) {
        let alert = UIAlertController(title: "이름을 입력해주세요", message: nil, preferredStyle: .alert)
        alert.addTextField(){
            $0.placeholder = "ex)부엉이"
        }
        
        let ok = UIAlertAction(title: "OK", style: .default){
            (_) in
            let value = alert.textFields![0].text
            self.name.text = value
            
            // 읽어올 파일명  계정명.plist
            let customPlist = "\(self.account.text!).plist"     //
            
            // 현재 샌드박스 디렉터리 영역
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            // 타입캐스팅
            let path = paths[0] as NSString
            
            // 완전한 커스텀파일 경로 생성
            let plist = path.strings(byAppendingPaths: [customPlist]).first!
            
            // 커스텀파일 읽어와서 딕셔너리로 or 새 딕셔너리 생성
            let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
            
            // 딕셔너리에 이름 추가 or 덮어쓰기
            data.setValue(value, forKey: "name")
            
            // 실제파일에 딕셔너리 덮어쓰기 or 생성.  atomically : 트랜잭션 여부 -- 임시파일생성후 완료후 대치
            data.write(toFile: plist, atomically: true)
            
            
            //  let plist = UserDefaults.standard
          //  plist.set(alert.textFields![0].text,forKey:"name")
          //  plist.synchronize()
            self.view.endEditing(true)
            
            
        }
        alert.addAction(ok)
        self.present(alert,animated: false)
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1{
            editName(tableView)
            //print("테이블아이템 선택2")
            
        }
        
    }
    
    
}

// MARK: - UIPickerViewDelegate 구현 : 피커 뷰에서 발생하는 액션 처리
extension ListViewController : UIPickerViewDelegate{
    
  
    /// - Note: 컴포넌트가 가질 목록의 길이 -> 컴포넌트 그룹이 가질 목록의 갯수 - ex) 월 - 12
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountlist.count
    }
    
    /// - Note: 컴포넌트 출력내용 정의
    // row - 컴포넌트내의 인덱스 ,
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.accountlist[row]
    }
    
    /// - Note: 컴포넌트 클릭시 실행
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      //  print("=============================================")
      //  print(self.view.inputView)
      //  print("=============================================")
        let account = self.accountlist[row]
        
        let plist = UserDefaults.standard
        plist.set(account, forKey: "selectedAccount")
        print(account)
        
        plist.synchronize()
        self.account.text = account
      //  self.account.sizeToFit()
        
      
        // 입력뷰 - 피커뷰 종료 -- 텍스트뷰의 편집이 끝났음을 알려주어 입력뷰 종료
       //
        
    }
    
}
// MARK: - UIPickerViewDataSource 구현 : 피커 뷰에서 화면에 출력하기 위해서 구현˚
extension ListViewController : UIPickerViewDataSource{
    /// - Note: 생성할 컴포넌트 갯수 반환 - 피커뷰가 가지는 목록의 갯수  - 그룹 (년)(월)(일) -> 3컴포넌트
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
}
