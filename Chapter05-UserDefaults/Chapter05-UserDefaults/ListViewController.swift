//
//  ListViewController.swift
//  Chapter05-UserDefaults
//
//  Created by 이동영 on 31/01/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import Foundation
import UIKit

class ListViewController : UITableViewController{
    
    //=================================================
    //          일반 뷰에서 제스처 처리 하고싶다면
    //      User Interaction Enabled  체크
    //=================================================
    @IBAction func edit(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title:"이름을 입력하세요", message: nil, preferredStyle: .alert)
        
        // 텍스트필드 기본값 셋팅 클로저
        alert.addTextField(){
            $0.text = self.name.text
            
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default ){
            (_) in
            let value = alert.textFields![0].text
            let plist = UserDefaults.standard
            plist.set(value, forKey: "name")
            
            // 인 메모리 캐싱 동기화. -- 프로퍼티리스트 변경시 실행 - 필수
            plist.synchronize()
            
            self.name.text = value
        })
        
        self.present(alert,animated: false)
    }
    
    /** ================================================================
                - Note: 왜 viewWillApper 에 안해도 될까?
     
            컨트롤의 value는 지속적으로 유지된다. 변화시 자동으로 value 변화
        뷰가 메모리에서 지워졋다가 다시 로드될때 plist에서 저정한 값 가져오면 된다
     ==================================================================*/
    override func viewDidLoad() {
        let plist  = UserDefaults.standard
        
        self.name.text = plist.string(forKey: "name")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        self.married.isOn = plist.bool(forKey: "married")
    }
    

    // 이름 라벨
    @IBOutlet var name: UILabel!
    // 성별 세그먼티드 컨트롤
    @IBOutlet var gender: UISegmentedControl!
    // 결혼여부 스위치
    @IBOutlet var married: UISwitch!
    
    // 성별 onChange
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        
        let value = sender.selectedSegmentIndex
        let plist = UserDefaults.standard
        
        plist.set(value, forKey: "gender")
        plist.synchronize()
        
    }
    // 결혼여부 onChange
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn
        
        let plist = UserDefaults.standard
        
        plist.set(value, forKey: "married")
        plist.synchronize()
    }
    
    
    
}
// MARK: - 테이블 뷰 메소드
extension ListViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       /* if(indexPath.row == 0){
            let alert = UIAlertController(title:"이름을 입력하세요", message: nil, preferredStyle: .alert)
            
            // 텍스트필드 기본값 셋팅 클로저
            alert.addTextField(){
                $0.text = self.name.text
                
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default ){
                (_) in
                let value = alert.textFields![0].text
                let plist = UserDefaults.standard
                plist.set(value, forKey: "name")
                
                // 인 메모리 캐싱 동기화. -- 프로퍼티리스트 변경시 실행 - 필수
                plist.synchronize()
                
                self.name.text = value
            })
            
            self.present(alert,animated: false)
            
         }
          */
        
    }
}
// MARK: - 열거형 추가
extension ListViewController{
   public  enum GenderType : Int {
        case male = 0
        case female = 1
        
        func getGenderValue(value : Int) -> GenderType? {
            switch value {
            case 0:
                return .male
            case 1:
                return .female
            default:
                return nil
            }
        }
        
        func getGenderCode(value : GenderType) -> Int{
            // 해당 값 반환
            return value.rawValue
        }
    }
}
