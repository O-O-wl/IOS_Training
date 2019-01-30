//
//  ViewController.swift
//  Chapter05-Custom_Plist
//
//  Created by 이동영 on 31/01/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit


class ListViewController: UITableViewController {

    var accountlist = ["PyCharm@naver.com",
                       "IntelliJ@hanmail.net",
                       "WebStorm@gmail.com",
                       "PhpStorm@yahoo.com",
                       "RubyMine@netion.com"
                      ]
    
    override func viewDidLoad() {
       
        let picker = UIPickerView()
        
       
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
        
        // 가변 툴바 공간 버튼
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //toolbar.setItems(, animated: <#T##Bool#>)
        //gittoolbar.setItems([flexibleSpaceButton], animated: true)
        toolbar.setItems([flexibleSpaceButton,done], animated: true)
        
        
        //=====================================================================
        
        
        
    }
    
    @IBOutlet var account: UITextField!
    
    @IBOutlet var name: UILabel!
    
    
    @IBOutlet var gender: UISegmentedControl!
    
    
    @IBOutlet var married: UISwitch!
    
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
    }
    
    @IBAction func changeMarried(_ sender: UISwitch) {
    }
    
    @objc func pickerDone(){
         self.view.endEditing(true)
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
